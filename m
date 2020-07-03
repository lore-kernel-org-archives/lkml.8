Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2C0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A203D2073E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAdRtxY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgGCJkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgGCJkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:40:11 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A758AC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 02:40:10 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q7so22962942ljm.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 02:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQEqi/XO2uG9xah6H42oeX7WTpEE5TdDYMdGWzAhx0Y=;
        b=ZAdRtxY440gxqH45zPADxCc91LKS9cNz0BU27YTqxta2SBQjFSk1bLAtw3v81TKStu
         pSuhFmDZ3QRSvey/i1BgxyI/vdMf8ZO2WF56Sv4C6OOnITLXNSx7q57nQmGO0E48Mpmu
         EQqQgjbRoSUB3R2AOMmczzzgE9llYz/u5RtswXHOhTbXXAU8bJHFhEMmO8IKT6HkLuAZ
         XsglndYsnUDQ3U5+gw8pr7xbFJMxdZvATKTnmAYJ6Higw91XryarYb5RbKxeUITVcNLF
         +xbQjtLALiJtdQllvBfDsPHvm1r10t4oclMkfBS26AbVtU/qW8q2HQ7/18J5bh3qeXyE
         iPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQEqi/XO2uG9xah6H42oeX7WTpEE5TdDYMdGWzAhx0Y=;
        b=o1fiOTQiv9HFYg3ggP3ajxkMzAecnyxfuWYksA9tcWHnt9dWa8wSIo+pfvHSNiVlXC
         yBxxkxA7blv81xCf6BXhylA71jz0Q0YJfsqjWkEyWID+u2jhzAuISaJb/AUBI/8C6Dn0
         BmTIO2fOQq4zRKQuL0CLijUILj+4umE0AaHaUKJLdb6+GGhuZYAQAxRm/rLivRhn2NE1
         yRhBNX+CHbSKwchVpgE9ILDpUGHWD4USI3xW4RnpQanRoirB2WYqhYx7wCT0Z7tD8qbM
         OUapyqvDXL+6AFDcQy1WaOAlsgbyMPz2zt09UGRY0Xf5YjQiS/ilmjekMtDBp2udQVYA
         FjHQ==
X-Gm-Message-State: AOAM532XnLmT6g5sAftt6Hq9piOtezHke95+neOv5WAy9yVE7R7Z5sJC
        lYsv55/8HlWSY0EBJDt1o4BKGC6RH85DQGLXxkH9ifWo
X-Google-Smtp-Source: ABdhPJx76q21pbTAj506mPXqvJ7MR4UF8f2gfrceH5nGL/4c2TDLF1jfj3LAeyvUuZxTNyHuZUbMoWH5ath/YDlKfas=
X-Received: by 2002:a2e:a544:: with SMTP id e4mr20547523ljn.264.1593769209237;
 Fri, 03 Jul 2020 02:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <050476a0ee608046569588936394159d650ab535.1593763492.git.zong.li@sifive.com>
 <80902e5d0d5ef752e71672e9c5794d0f5f9ccd15.camel@perches.com> <CANXhq0p8S_n_yGQrrEJ5HBHcnbPZh+dNfTrtL2Kuepf8mtkn=g@mail.gmail.com>
In-Reply-To: <CANXhq0p8S_n_yGQrrEJ5HBHcnbPZh+dNfTrtL2Kuepf8mtkn=g@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 3 Jul 2020 11:39:58 +0200
Message-ID: <CANiq72k7O50uD72RoTwevfcmqO1im86SYs2ae+qF3J0Vhvf_oA@mail.gmail.com>
Subject: Re: [PATCH] scripts/Lindent: increase the maximum line length to 100
To:     Zong Li <zong.li@sifive.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 11:19 AM Zong Li <zong.li@sifive.com> wrote:
>
> Yes, as you mentioned, the reformatting tool uses up to the maximum line length,
> it seems to me that we don't go this patch if you plan to post the
> patch to delete it,
> otherwise, we could consider to change it to 100.

For reference, we discussed this for the limit in `.clang-format`, and
for the moment we will keep the limit at 80 there too.

See https://lore.kernel.org/lkml/20200610125147.2782142-1-christian.brauner@ubuntu.com/

Cheers,
Miguel
