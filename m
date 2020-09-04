Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37EAC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8391020737
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599185404;
	bh=F2Kzb3TuMvyrFPjT9vDPHLAxos+/ysls9XXZGWKlRGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YtRkvh8DjDsIAyU9iAIrkWVcvPT3iNAH/Zi8P8/aKj+6AjpUHCVA2qK3WKfn/aXo2
	 uyBOJP97oF5sLoMKX0VAv1PCNoRIGHXpJPNiIV6ors9qV8jY2qazaG/fAkTtywX8dg
	 pZsDe6PR5hJaxuS2mRk1YribR1/TeUl3/GIeV9bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgIDCKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 22:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729682AbgIDCJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 22:09:55 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3CB02067C;
        Fri,  4 Sep 2020 02:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599185395;
        bh=F2Kzb3TuMvyrFPjT9vDPHLAxos+/ysls9XXZGWKlRGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZppVbC3oQfsYhFiiO1Q87YZorKsEUuQUaye1es0vWIv3pt7eZp4TrilmSOzg0tJ8i
         XYRos4JspAMuGqRbsCBosik5IZGgXBsP50I19uGTQXUYuepNi19Kb6d98potQtyMw6
         POil1TEb1L3p8pv6KVHtf5Eh2FqCP3BxHxLUf/D4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E1FFC40D3D; Thu,  3 Sep 2020 23:09:52 -0300 (-03)
Date:   Thu, 3 Sep 2020 23:09:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        William Cohen <wcohen@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH] perf jevents: Fix suspicious code in fixregex()
Message-ID: <20200904020952.GQ3495158@kernel.org>
References: <20200903152510.489233-1-namhyung@kernel.org>
 <CAP-5=fULG7CbwB0vOBkStsRV5j7=XX_F0x+fzK7KHyqp-9Y0_g@mail.gmail.com>
 <20200903184123.GB3495158@kernel.org>
 <CAM9d7cg+aGuPPMp7-QjmgN5GGK+D9su2GCNRT__wPZvw4vp+HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cg+aGuPPMp7-QjmgN5GGK+D9su2GCNRT__wPZvw4vp+HA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 04, 2020 at 10:38:35AM +0900, Namhyung Kim escreveu:
> On Fri, Sep 4, 2020 at 3:41 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Thu, Sep 03, 2020 at 10:47:39AM -0700, Ian Rogers escreveu:
> > > On Thu, Sep 3, 2020 at 8:25 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > The new string should have enough space for the original string and
> > > > the back slashes IMHO.
> > > > Cc: John Garry <john.garry@huawei.com>
> > > > Cc: Kajol Jain <kjain@linux.ibm.com>
> > > > Cc: Ian Rogers <irogers@google.com>
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > Definitely looks like the right fix. I'm surprised this hasn't shown
> > > up in sanitizer testing.
 
> I guess the code didn't run on most arch (including x86) since
> they don't have backslashes.

> > Yeap, good catch! Namyung you forgot to add the Fixes tag + Cc the patch
> > author that introduced that bug, I did it:

> > Cc: William Cohen <wcohen@redhat.com>
> > Fixes: fbc2844e84038ce3 ("perf vendor events: Use more flexible pattern matching for CPU identification for mapfile.csv"

> > Please consider doing it next time :-)
 
> Oh, right!  Will do it later..

Thanks!

- Arnaldo
