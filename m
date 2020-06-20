Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEE8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80AEB23D9C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="XZ/wFy9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgFTQAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgFTQAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:00:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A11AC06174E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:00:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f185so11702853wmf.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=lFeqIL8bo4mlGyvfD4vGNnsSeHfU+7Jkg7P09FGBgVg=;
        b=XZ/wFy9UTZB/NtxhyA7L6e7U7ful70u3itnS9SmmxsPdShFHBzpnULtsAVcVWm5HbS
         Wv8tR/XpPz/P4Oqd8SkdPe9c/po7+QUOxKC+UZqsP2gvtIYHGE2LP4Il7ICtYy/hujy7
         pYzHAbcT8/MvmfG0X8XQ7kDHmjZdeQHzK5eQuTFgrSsBDKhXudvArtHOcnMZ9w/un8iz
         J8ATrwrGcnbr+2kcscSJ4bRLcyNU1Cs6DcOI0hEhby7FODtjEMckB0WbEDVKeANqSoNO
         dIaJEDse0fC4j1XpgV/DofGpQ1t0I6G0Luai5TO/hPLVMzoYTTWDODFrPwehUgy9pjrS
         FyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lFeqIL8bo4mlGyvfD4vGNnsSeHfU+7Jkg7P09FGBgVg=;
        b=dwSzj33W2jwYL0hZqixIcoCQXUbPf8WMEYtHzuFk8U1CZzPvH40v2gDzmHN+ZPMJOV
         i7iC1B5maJHBhvdZZg6+W3pPwniVizrJqcU7D0Va+T3LtyCtalyjbFZu3LuE8/2sSGhJ
         p9EZKKAbOURYEo94B/fSE57EVxnscFn6KO9XHLOKVLGxefXgMhZ8fjKDZUkE7k89XcqO
         wJt/shPCvLPavgjBRQSTH7r6JkPlmnJ6w4drVF0IG74FeaUjvkTsxgBE/VVOw6ukSJHa
         W0PrHhtn+0MELcCgxqe4M4m5B9v/n4DtPXiHSa2L4gy4XwxXkt1WuSostglZDTsTq8Qu
         yqsQ==
X-Gm-Message-State: AOAM532rYAcACMFmsjUkIWLYy0/FrcYP9OR5SgeChgpIjOcShygm8NbH
        Qdf4ROAMCHrlXG2s9MgaR3YE6pvg3r56vvOOvAfHf/r8LCw=
X-Google-Smtp-Source: ABdhPJwxeQufihJk/rzMzyjtk/gbHIGDQ4OVmGHx3xjrbMo3qmpo8vcUMroxRpUEc63rUq72vyoPFLbNbbf8xCQDHJE=
X-Received: by 2002:a1c:4804:: with SMTP id v4mr9293060wma.21.1592668808716;
 Sat, 20 Jun 2020 09:00:08 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Sat, 20 Jun 2020 08:59:57 -0700
Message-ID: <CALCETrU_O4AxcJeBO77uXt2j8woYVtjZd18-YV0BuCKRAu00eA@mail.gmail.com>
Subject: Linux FSGSBASE testing
To:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Stas Sergeev <stsp@list.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stas-

FSGSBASE support is queued up for Linux 5.9.  Since you're one of the
more exotic users of segmentation on Linux, is there any chance you
could test it?  The code is here:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/fsgsbase

There are two interesting cases to test:

1. FSGSBASE on.  This is the default if you boot this kernel on Ivy
Bridge or newer hardware.

2. FSGSBASE off on a patched kernel.  Boot the same kernel as in #1
but either pass nofsgsbase on the kernel command line or use pre-Ivy
Bridge hardware.  You will *

You can tell you have FSGSBASE enabled for test #1 by running
tools/testing/selftests/x86/fsgsbase_64 -- the first line of output
will be :FSGSBASE instructions are enabled".  You can build it by
cd-ing to tools/testing/selftests/x86 and running make.

If anything is broken for you, I'd like to know before this makes it
into a released kernel!

Thanks,
Andy
