Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AF7C0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 02:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAB620674
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 02:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuyWjXf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgCQCBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 22:01:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42889 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgCQCBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 22:01:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id t3so8877542plz.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 19:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LKP/nhYw4uugvnnRsKDRbjjHYrWkREfbKj6MAzU7nnE=;
        b=LuyWjXf7whSRVDAtg/cdhXwUfWsoCCF1aoBEdVZX5CwBN2eiNyXPfdvtacMhI1jghk
         vq6LvmLqkTJLW6e78XmE+NxLJTZpgmwBW//0jj+iMnxRvHR+LKahhEOMulVx1bSJkfAG
         4qVikYJrq0Bxtv2lBFVuPi6JqWZ46vYPWu88baNCfhzO25Hm/huLPpTv4EGe1YmbtE/z
         c4Czlvu2p3mCXkp6DqdX18gUW8c6UhvYYAzq8PvYYnSnbMUzl7cIwjHn0dl4KvrWV7oK
         tNLDawISj+N10nWO6kColCRCZhLxB4UEiQctag0/uBrMLidZqa9pgRXym3T8u4N7UM0O
         x2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LKP/nhYw4uugvnnRsKDRbjjHYrWkREfbKj6MAzU7nnE=;
        b=ae+jKzKGUrukL/YWJhTJUK+ornfmSsi3e9l1iaqqu1YNMVKRb4Uds9yiVjHuTAWpU9
         bkgIRf0QT4KrfN8K90tx5e9SwlGckKIYkoSJCdOiqFPMNVRYRqsrDPO5xqMpCLZbyddT
         UOsNtfeGp3Pvggp3i+Gq7Sy8NG7aKc/r9IBDowYmTjFN0MJcFWwVC3nC+gtVYYnBFiIc
         NG5FpG6W7yeH782iB2HXMkORzg0IDz6iYVwPCjzgWC4XIPXG1ONIgIjfc1bWdbja3y8w
         gRwjZvZurZEtpAoRR35/Q9vZhxDBw/BOb24GHKhW0oNuHMiG4Wk9Xtmk45ocDCj6CT47
         5Cfw==
X-Gm-Message-State: ANhLgQ1/8DOucJJnxlOGVFQ9m+0FwyMjaND3RHkj4KqEgpY+q0jXrVK7
        h6u1qYOqhbmCgJqsuOBjVWE=
X-Google-Smtp-Source: ADFU+vtxSJWPCxuN0Fmp7tC3u8qVmTnsUs3UTNHhzNkan3XAjCELg45zfyz3bm6cteKI2tVb8vQ0HA==
X-Received: by 2002:a17:90a:c08f:: with SMTP id o15mr2608257pjs.155.1584410507537;
        Mon, 16 Mar 2020 19:01:47 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id g4sm1064519pfb.169.2020.03.16.19.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 19:01:46 -0700 (PDT)
Date:   Tue, 17 Mar 2020 11:01:44 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shreyas Joshi <Shreyas.Joshi@biamp.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "shreyasjoshi15@gmail.com" <shreyasjoshi15@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20200317020144.GB219881@google.com>
References: <20200309052915.858-1-shreyas.joshi@biamp.com>
 <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
 <20200316213900.6b1eb594@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316213900.6b1eb594@oasis.local.home>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/16 21:39), Steven Rostedt wrote:
[..]
> > 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c index ad4606234545..e9ad730991e0 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2165,7 +2165,10 @@ static int __init console_setup(char *str)
> >  	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
> >  	char *s, *options, *brl_options = NULL;
> >  	int idx;
> > -
> > +	if (str[0] == 0) {
> > +		console_loglevel = 0;
> > +		return 1;
> 
> Hmm, I wonder if this should produce a warning :-/

Hmm. Maybe the warning can seat in __setup() handling?
There are 300+ places that theoretically can receive blank boot param

	$ git grep "__setup(\".*=\"" | wc -l
	307

I'd assume that not all of those can handle blank params. At the same
time, do we have cases when passing blank boot params is OK? E.g.
"... root=/dev/sda1 foo= bar= ..."

	-ss
