Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5143C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7F5A2065E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595421269;
	bh=0QEFoJLeBfGzFAv1ye3oNErTb7Vj/OYnW7+WOE6tzdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RkaCOc6vqB7HrYDd7ShKYd4NbSSZH+DOw2BdT/tgYW6XGRp2OZTn5WOFqfJxlmy4B
	 VwuDydWVwRd8TRNnP72/tzu0xK1YgywimxMizvKxfOnavRIVoRWw3mHZgU1jrsKkNN
	 9/iMfJXggUkwQhflkfErSGQL1FvDK9MK3HNdb0jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbgGVMe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731857AbgGVMe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:34:26 -0400
Received: from quaco.ghostprotocols.net (unknown [177.17.3.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8D2A2065E;
        Wed, 22 Jul 2020 12:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595421266;
        bh=0QEFoJLeBfGzFAv1ye3oNErTb7Vj/OYnW7+WOE6tzdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0tT+yW2ZgKBXhXrn8dztXfSrgS3VSxvDqUzFBdOfqK9TDw2dpUlRozq3Beg0ze+Vv
         FLgss7QxPlQHh6n0FflJFDzdPx+194b7x01BPHdJiCmqdXRTNAXShARbiVL0zGHTgk
         5n5JkTT0iD+jnfL75uJ7oNO3d/7lANzOITz+LJbY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E0923404B1; Wed, 22 Jul 2020 09:34:23 -0300 (-03)
Date:   Wed, 22 Jul 2020 09:34:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 05/15] perf evlist: implement control command
 handling functions
Message-ID: <20200722123423.GK77866@kernel.org>
References: <8d91c3a0-3db4-0a7a-ae13-299adb444bd6@linux.intel.com>
 <62518ceb-1cc9-2aba-593b-55408d07c1bf@linux.intel.com>
 <20200722122734.GJ77866@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722122734.GJ77866@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 22, 2020 at 09:27:34AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jul 17, 2020 at 10:01:33AM +0300, Alexey Budankov escreveu:
> > 
> > Implement functions of initialization, finalization and processing
> > of control command messages coming from control file descriptors.
> > Allocate control file descriptor as descriptor at struct pollfd
> > object of evsel_list for atomic poll() operation.
> > 
> > Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> I'm applying locally for testing, but can you answer what is the reason
> for that newline in the CMD_ACK_TAG? I tried looking at previous
> discussion but couldn't quickly find any reasoning for that
> 
> - Arnaldo
> 
> > +++ b/tools/perf/util/evlist.h
> > @@ -359,4 +359,22 @@ void perf_evlist__force_leader(struct evlist *evlist);
> >  struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
> >  						 struct evsel *evsel,
> >  						bool close);
> > +#define EVLIST_CTL_CMD_ENABLE_TAG  "enable"
> > +#define EVLIST_CTL_CMD_DISABLE_TAG "disable"
> > +#define EVLIST_CTL_CMD_ACK_TAG     "ack\n"
> 
> What for? That '\n'?

Oh, I see, this is not a _command_, it is a _response_, and the sender
expects a newline, right?

So I think this needs to be marked clearly as:

// Commands accepted by 'perf record'

#define EVLIST_CTL_CMD_ENABLE_TAG  "enable"
#define EVLIST_CTL_CMD_DISABLE_TAG "disable"


// Responses sent by 'perf record'

#define EVLIST_CTL_RSP_ACK     "ack"

And then make the response add the newline, as conceivably we could have
something like "nack", "invalid", "enoperm", etc, no?

Anyway, this can be done on top of this series, so I'm continuing
processing it locally.

- Arnaldo
