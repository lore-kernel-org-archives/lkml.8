Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE052C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EAA120771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="m/ksBGzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHMLhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMLg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:36:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDFEC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 04:36:58 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t6so2640453pjr.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 04:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=cq63KBO13gundOWm0DnnKR0w6Etgxfdr2x+dttCqZq8=;
        b=m/ksBGzHrOcc4NZUkxtAB+W7PtLWrdjKHFGT9qrB2dB+WN3dhp7ywc2GU7e2bkI37b
         4qCaYOjM1lN52lSOUYBFrFYEH2cRBVfBD+rHbDsvUtfEu3qifAqhhkhoOSjOPXrmOZgs
         H0j1aYlcnVM0TlZLKkwS4GDmQsVRHtZccQInA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=cq63KBO13gundOWm0DnnKR0w6Etgxfdr2x+dttCqZq8=;
        b=jAFbSR5pJsQe/ixS2ozlTrrt6XKH9C4Zcg+dzbC5rD+dlfirMTIEJWFA5xK81HSiCI
         NCIX7tw2SjMW6n94m5OSdUCARTa2lYssW1l8cOdGm7j/0ruoK5dLbWhaEsmaQ7g7yq5a
         U1jmqAUGWKa/GrR4B68W8enAH4Ypumr6UjfGD4ib7VWNDA2yY3MyPA3/V/34peQURaHg
         qcLsNty2pbaLdqXptWghD2uFByk6C7VNCH5rPZLBPHvEto9QvhW88LNdfuMy8CDfK24X
         k0a9h2+xLtpsg99XhjM9TodF1WbzlazbV84fQor4rBPYLCk4Z4CIL0Bdyd6l7fJimsMg
         C7Aw==
X-Gm-Message-State: AOAM533Vxrl2XhnPIZiSUQH4MqW7s2UG93BThK1rnsRZewyK6qu2oks0
        tafNoiesWBeDlnv+53mXBuOE3w==
X-Google-Smtp-Source: ABdhPJy5+80qlcCMq9FvxHy8z+LAo9AbUMF1RvOWi5pRXnGx/+RRPk90VO5kJNou+WT43cdQiiWkDA==
X-Received: by 2002:a17:902:ed4a:: with SMTP id y10mr3578373plb.106.1597318615882;
        Thu, 13 Aug 2020 04:36:55 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-4dc5-3664-a3ed-1364.static.ipv6.internode.on.net. [2001:44b8:1113:6700:4dc5:3664:a3ed:1364])
        by smtp.gmail.com with ESMTPSA id h5sm5647204pfq.146.2020.08.13.04.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 04:36:55 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/select.c: batch user writes in do_sys_poll
In-Reply-To: <87zh6zlynh.fsf@dja-thinkpad.axtens.net>
References: <20200813071120.2113039-1-dja@axtens.net> <20200813073220.GB15436@infradead.org> <87zh6zlynh.fsf@dja-thinkpad.axtens.net>
Date:   Thu, 13 Aug 2020 21:36:52 +1000
Message-ID: <87wo22n5ez.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> Seem like this could simply use a copy_to_user to further simplify
>> things?
>
> I'll benchmark it and find out.

I tried this:

        for (walk = head; walk; walk = walk->next) {
-               struct pollfd *fds = walk->entries;
-               int j;
-
-               for (j = 0; j < walk->len; j++, ufds++)
-                       if (__put_user(fds[j].revents, &ufds->revents))
-                               goto out_fds;
+               if (copy_to_user(ufds, walk->entries,
+                                sizeof(struct pollfd) * walk->len))
+                       goto out_fds;
+               ufds += walk->len;
        }

With that approach, the poll2 microbenchmark (which polls 128 fds) is
about as fast as v1.

However, the poll1 microbenchmark, which polls just 1 fd, regresses a
touch (<1% - ~2%) compared to the current code, although it's largely
within the noise. Thoughts?

Kind regards,
Daniel

>> Also please don't pointlessly add overly long lines.
>
> Weird, I ran the commit through checkpatch and it didn't pick it
> up. I'll check the next version more carefully.
>
> Regards,
> Daniel
