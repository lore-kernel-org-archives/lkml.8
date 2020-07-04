Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02218C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C765C221FB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3r/TGwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgGDU30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 16:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgGDU3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 16:29:25 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E107DC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 13:29:24 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id a30so1728731ybj.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 13:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PttaXRzdoubqrU8NlKxK6QuJqeqDE8bW+/y2ufbhArg=;
        b=r3r/TGwpS+s9RYGIkhWfW5qLqrVwZSiXbM2rmaroosXuECbCfhfp1EAOlW9CQDP+tq
         qMYMi61B9cMxAN6vVmrjCAxx4X8Tjl3uCuoFsJdIg7l9VGdVYeCKWhKDP8FHdY1C0S+i
         z5QfR1vsa4zq6aGsHhtHsIOfsed3eAw4kfuFfVjy2HnwdhGBLVQq72gbU3J8mTbuOqVJ
         T2ZPSr8mClKnnmobkDsyhMziLi0IgttGY7hR9NGuvtsARF0o/uazE/xU1PG+77STff76
         /OtFcnEeeUnl7Fi4hEtuyrOz+0xmIssOAK1q8N4zJWxcnsQs86XTNoIoPr4eAlkGmM2A
         KebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PttaXRzdoubqrU8NlKxK6QuJqeqDE8bW+/y2ufbhArg=;
        b=bBSyUgTsQIPelu2HG8QVRfz1uXKzaDjLVkNRf8chJq6ZxwiG1a42Ky8gr2BKBFdBwF
         wHGZPdiiXqUH9QwqH/56m29yqLLYFxAFqbxad2iy5S0XkKARupcfEkk8c7cEoEzxzfQz
         nuu6PqvH624ugLKOTZERby8YpEOf88V/uhRwQ213x9PNjL1W/cK3RjYqfBRATTFWuEGz
         xSVsQDhLI/F/TmKuFcbZj0maKfaoEhe8Pwp8on61sAlK2zL+JFI36njQhynT9nhujre2
         D4KicbvqU2jv4P43b79yYheRidwl2FJqBTxvIe+E4V6Ogj2BvLK7cYVUtELtrvIcLjC4
         0Trw==
X-Gm-Message-State: AOAM532czUIeecjLtZrKv9NfdNxvShZA6RiLaTPk0vKU6vn+SuBBN48O
        2+/Rh/1X8p+UGwjBigSB9BTrS5dR727IcbHMDxMVro+hwbc=
X-Google-Smtp-Source: ABdhPJwlfur/XyYcYgjKsUXAAOPAt0Zp9AKs1CjYvRDKEFFvSIT3Q9k13JpiJ9bgparJGJD/gYx6A0Nd98W/oDa5plQ=
X-Received: by 2002:a25:23c7:: with SMTP id j190mr2855173ybj.167.1593894561632;
 Sat, 04 Jul 2020 13:29:21 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 4 Jul 2020 15:29:11 -0500
Message-ID: <CAH2r5msW7s-5dphNrvGCEqOGQ6tO=K5_aDVbw4ZS995oDk2Agw@mail.gmail.com>
Subject: 5.8-rc1 and later breaks chrome browser
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that chrome crashes immediately on startup  on my desktop
booting to 5.8-rc2 or later kernels (whether I build the kernel or
using the prebuilt weekly Ubuntu mainline kernel downloads).  Works
fine with default kernels or 5.7 or 5.7.7 stable kernel etc. - just
breaks if I boot 5.8-rc2 or later.  I even tried building with today's
mainline kernel and same thing.  Any ideas how to work around this.

Message logged to dmesg is:

[  131.366543] ThreadPoolServi[2526]: segfault at 415048 ip
00005652def3370d sp 00007fcdc3b37df0 error 6 in
chrome[5652daa7e000+785b000]
[  131.366546] Code: Bad RIP value.

-- 
Thanks,

Steve
