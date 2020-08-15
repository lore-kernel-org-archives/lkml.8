Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E63C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB0B8206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgHOV7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbgHOVvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:54 -0400
Received: from mail-il1-x145.google.com (mail-il1-x145.google.com [IPv6:2607:f8b0:4864:20::145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AE7C0F26F7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 11:15:04 -0700 (PDT)
Received: by mail-il1-x145.google.com with SMTP id g6so8884689iln.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 11:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=4xpDMl3NeXZcwdAiC+yVFHrHRUJEIDgJ5ulLpZwqEjI=;
        b=lkfdbT/Cb6ZcrGvTcg66rPyRFwgd8TaSkjF4EFqYuhK7lnRIT3m2rGxQnWBAZZy1Bt
         Vdlp9HkD7AsDmSRcmoBADerPmgmzdly0hnlQI3oK88vhAm3u6EfxjN8BOGojIeTY4efs
         +rBzFCF1CQOsCKzS6GLVaOlnzQbINunZGLmSwy2TuDLhrLdpnVvJ/nKkrBkiqEgtohPV
         G8g6UY9QyHxiVeJk049NrBZXjUn4NFkR5TJjC5Grvo0qHBM+G/LpV+vikJuaHV51WUab
         q1gMM+NaJzJRL7drxGxRmsEduqUkQxGDgrHvF7R0J/RxD44K2sXV+Erw5F9WDZr0VkxS
         A73A==
X-Gm-Message-State: AOAM530u+zoc5YN1aaJLqXS2OFesmfcxJQluOr3yBoaz9Sq3aSrtzRZW
        AATvS2bLDGkJOlUwVNvs311W3RqIP/ZAWgKBmQp1rcWe4f/4
X-Google-Smtp-Source: ABdhPJwWbQqFhbKiJRtugfK4oKOj21an5kZquR9VFiI9RweoGgikPQvFcrcRyVgyQeEnOHoeb3Up7TqAFi6Ze2gqNRsgMi9v/td7
MIME-Version: 1.0
X-Received: by 2002:a92:85c8:: with SMTP id f191mr7591361ilh.242.1597515302467;
 Sat, 15 Aug 2020 11:15:02 -0700 (PDT)
Date:   Sat, 15 Aug 2020 11:15:02 -0700
In-Reply-To: <e3494c53-f84e-5152-42b0-f8ddd3ad4ccb@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000207e2405acee84f5@google.com>
Subject: Re: Re: possible deadlock in io_poll_double_wake
From:   syzbot <syzbot+0d56cfeec64f045baffc@syzkaller.appspotmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz dupe general protection fault in io_poll_double_wake

unknown command "dupe"

>
> -- 
> Jens Axboe
>
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/e3494c53-f84e-5152-42b0-f8ddd3ad4ccb%40kernel.dk.
