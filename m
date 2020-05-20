Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DAAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 409D02070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589989628;
	bh=RVEMDBCL04OQbznOldT6yF83HEYpiWi2l9Yt3I18qsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xohh15ukwlEDMJfVGh+bpcTjiZe8w4k/80EPobz1+JeD8mEcEuOK4AXWEz5jHL+yU
	 iN3D2r+SV7s4SX30aSEeXuNwj7Bujerad//FePG4pusu0d9FYbrLFSQg6zO0iDAPEq
	 YLyBVFghOGNSehB++snKlv+8XO81jL3ETv9wS7bM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgETPrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:47:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgETPrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:47:07 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6475B20709;
        Wed, 20 May 2020 15:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589989626;
        bh=RVEMDBCL04OQbznOldT6yF83HEYpiWi2l9Yt3I18qsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s80+r20fIdm93fdte+1ohs1iI2BcmvV8lU7OlyjUdKYXjiei3d/nA/GKeWKRHX/fn
         NQq13l+KZplmz5yTVPqQFEkFKgZpU8UrQp4MttuKQcU9m1S4nKNhxhJ7RURQMs2KQ3
         ZWecSKBFX6UjyVd1wozIvKPGemuRC2zzWH8NWDD8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 50B9C40AFD; Wed, 20 May 2020 12:47:04 -0300 (-03)
Date:   Wed, 20 May 2020 12:47:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Anand K Mistry <amistry@google.com>,
        linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf record: Use an eventfd to wakeup when done
Message-ID: <20200520154704.GL32678@kernel.org>
References: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
 <20200513122012.v3.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
 <20200513113941.GK3158213@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513113941.GK3158213@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 13, 2020 at 01:39:41PM +0200, Jiri Olsa escreveu:
> On Wed, May 13, 2020 at 12:20:23PM +1000, Anand K Mistry wrote:
> > The setting and checking of 'done' contains a rare race where the signal
> > handler setting 'done' is run after checking to break the loop, but
> > before waiting in evlist__poll(). In this case, the main loop won't wake
> > up until either another signal is sent, or the perf data fd causes a
> > wake up.
> > 
> > The following simple script can trigger this condition (but you might
> > need to run it for several hours):
> > for ((i = 0; i >= 0; i++)) ; do
> >   echo "Loop $i"
> >   delay=$(echo "scale=4; 0.1 * $RANDOM/32768" | bc)
> >   ./perf record -- sleep 30000000 >/dev/null&
> >   pid=$!
> >   sleep $delay
> >   kill -TERM $pid
> >   echo "PID $pid"
> >   wait $pid
> > done
> > 
> > At some point, the loop will stall. Adding logging, even though perf has
> > received the SIGTERM and set 'done = 1', perf will remain sleeping until
> > a second signal is sent.
> > 
> > Signed-off-by: Anand K Mistry <amistry@google.com>
> > 
> > ---
> > 
> > Changes in v3:
> > - Move done_fd creation to below session initialisation
> > - Close done_fd on exit
> > - Log errno when write(done_fd) fails
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

I've made this dependent on HAVE_EVENTFD_SUPPORT, so that it continues
building on older systems,

- Arnaldo
