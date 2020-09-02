Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F326BC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF60420767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goAr64A0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgIBPaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgIBP3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:29:36 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8CFC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 08:29:34 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e17so4830782wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 08:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jD0lwPUDPqJoqIP/rldiB6/kM7/2nzIIqQ1JR4uJSZ4=;
        b=goAr64A0/objakxStXGU102b425PEBTJb988kX+Xua1JjIPCNHoE6zdJfzJ1tH2+mY
         IwPD2wkFcpTH5K9O9OwlD0dX6b+jHW/Dz/ODpLwon6huYezoaUoFUyUC2ZT4zKNMVFQ+
         ywWe9HT0hJJPbid8kaQsSbLDP6vfcAhfjFA46+pUASi7bed38dyEVbW1PjvLglfEZZuh
         EyKrMmgIIEgZnqdu+W7XmURWrHyBPRbtVyh3GKtprzmllRSNqILIyGiUwR4U17XB7Xv5
         ogvKJkDfojETV9KV6trm7WWcIKiFtXd0lnshlQLMwlzuXSF2L+7Q5H9epocaEAizZWAM
         3miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jD0lwPUDPqJoqIP/rldiB6/kM7/2nzIIqQ1JR4uJSZ4=;
        b=JnxNqBVIs747YjaLrM+/Ig+h8tc+j4YxvTQEfTZCA6Rxv0ICdevWlR91EpVjqeiKO9
         BJlvlDkJwfwZYqkNa0rxPJ87PTldCrGlkIuu5VtTN9SVlht6aF+FTmE35glnWe6zyEo4
         vDJM7tKCcgi0IzrBYYiswzIdWNyY3Wc/ZDNUIoGTnNsSCUBbQ8Ni1YMbUM1pxdwGHoio
         JzLJPwHsUdDRB39CE6tjRNAIaJHbp26OK4cdKkTeLHJuSq6a1qjoCg4+/6YiJet8LbdK
         wYVyKH4SdRlKHAUiGuahGxahNdpVLKXoff4CRKa4ozu9DqBc3A0+oKGdJfPiYJOmip3M
         Aefg==
X-Gm-Message-State: AOAM530brOPoMZvC0GbanabyvIWUK1JMuuIbFrqYqdlIJfP+uMsCYn6g
        hZZ6bq+oRbchKMqMCSmMUes=
X-Google-Smtp-Source: ABdhPJyVn2q0JT6zajMVClpHSmIoVLXE5vflWYEgw/moF8kWA5xT9WQFQj5qPJ37jT3zOwgTZirTwg==
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr1218127wme.136.1599060573391;
        Wed, 02 Sep 2020 08:29:33 -0700 (PDT)
Received: from medion (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id c14sm66193wrv.12.2020.09.02.08.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 08:29:32 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Wed, 2 Sep 2020 16:29:30 +0100
To:     Joe Perches <joe@perches.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nayna Jain <nayna@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] simple sysfs wrappers for single values
Message-ID: <20200902152930.mniirxa4iln2fqri@medion>
References: <20200829233720.42640-1-alex.dewar90@gmail.com>
 <81c3499a5a09a82ddb4f3aa2bd9bfde1c0192b9e.camel@perches.com>
 <fbc74484451e2ef75fbb65665186035301550a1b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbc74484451e2ef75fbb65665186035301550a1b.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 06:23:13PM -0700, Joe Perches wrote:
> On Sat, 2020-08-29 at 17:28 -0700, Joe Perches wrote:
> > On Sun, 2020-08-30 at 00:37 +0100, Alex Dewar wrote:
> > > Hi all,
> > > 
> > > I've noticed there seems to have been a fair amount of discussion around
> > > the subject of possible helper methods for use in the context of sysfs
> > > show methods (which I haven't had a chance to go through in detail yet
> > > -- sorry!), so I thought I'd send out a couple of patches I've been
> > > working on for this, in case it's of any interest to anyone.
> > 
> > If you really want to do this, I suggest you get use
> > wrappers like sysfs_emit_string, sysfs_emit_int, sysfs_emit_u64
> > though I don't see _that_ much value.
> 
> Just fyi:
> 
> the treewide converted sysfs_emit uses
> end up with these integer outputs:

Thanks for looking at the code. It does look like my approach was a bit
too simplistic!

> 
> $ git grep -P -oh 'sysfs_emit\(buf, "%\d*[luixd]*\\n"' | \
>   sort | uniq -c | sort -rn
>    1482 sysfs_emit(buf, "%d\n"
>     549 sysfs_emit(buf, "%u\n"
>     118 sysfs_emit(buf, "%ld\n"
>     100 sysfs_emit(buf, "%lu\n"
>      78 sysfs_emit(buf, "%llu\n"
>      62 sysfs_emit(buf, "%i\n"
>      47 sysfs_emit(buf, "%x\n"
>      24 sysfs_emit(buf, "%lld\n"
>      12 sysfs_emit(buf, "%llx\n"
>      12 sysfs_emit(buf, "%08x\n"
>      12 sysfs_emit(buf, "%02x\n"
>      10 sysfs_emit(buf, "%016llx\n"
>       8 sysfs_emit(buf, "%04x\n"
>       6 sysfs_emit(buf, "%lx\n"
>       5 sysfs_emit(buf, "%02d\n"
>       4 sysfs_emit(buf, "%04d\n"
>       2 sysfs_emit(buf, "%08lx\n"
>       1 sysfs_emit(buf, "%li\n"
>       1 sysfs_emit(buf, "%4x\n"
>       1 sysfs_emit(buf, "%0x\n"
>       1 sysfs_emit(buf, "%06x\n"
>       1 sysfs_emit(buf, "%03x\n"
>       1 sysfs_emit(buf, "%01x\n"
> > 
> 
