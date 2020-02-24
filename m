Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFCDC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B0F20838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O7PFY5Z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgBXRp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:45:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39781 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgBXRpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:45:51 -0500
Received: by mail-pf1-f194.google.com with SMTP id 84so5719454pfy.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 09:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rXGHoYS5rHzMbjfVGY/JpUBqXXW1TGXtdGjd+PD73bs=;
        b=O7PFY5Z2hHcOhXGAZLjeB3y7tUpYy2k3ObFMe5vCixEYE3GDmzh8mhPIaD2W3/0P/4
         6seB1vprMDl+72CeGd8VZu+iK6H0SSS6JzW1nlxq2PbwMD7OSAmNpLRLCd0kjNgq+6l5
         0eEg1hjk8XnCWFoAJvQOJs+y9byrwGcbB1IxKZodjlmjrPgt5VpkSREEBv0YMiP9yExo
         gME5WG9RsWvkKRP8C0IK+lSSKV0+r8YMGqw/Du8VchNClCyl/J7sBg8fUbV5P8mCB2YD
         A8fozg0GiiWO3gBwxPdup0wjnis+eJ+MenhdcY0jrlY+3P4iXKTi/Px9Nnw7bIBPLQoa
         BkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rXGHoYS5rHzMbjfVGY/JpUBqXXW1TGXtdGjd+PD73bs=;
        b=YxCpYZM9pX7qEbH/lN1cwRpr3lzc007JYTJx4Mk+h78Yx3vrnY+Ua73md5fU1RYr2H
         YKRSVg0SoshjDJMr8ICU5rKdGI9Tau5ZKnfFT3VqSKC1Abfob3SX5ndi9qUaI3+D/Mlx
         G+iAf77BXNODF2gHJjtgjYZyuo88Y1gUJnrU8DmEUu4D5GnP0OIDr7TxU407fyN/ISDQ
         tfCj7KFCAVjI4LwkLCAJGFVr87cCQT7JlXGtnvHZLoy2LRNlCGRhtFWs5smWdV0ik9dB
         bv0DazZ+xjVRdhuzbvgvza3+obPEh2rBFjF+MeKSX7kWvXr8PlCgxuwi0dxPYZWUtbGE
         pqvw==
X-Gm-Message-State: APjAAAWMZYCnJcuCpPqHNHCi4SsA6pmnf7LfP1zqlNuqSsyi9L6ZpXOG
        BoS0m/+gOFZqTPT5iOhKkzCkkTKWqhJXSmynXcMVdq3Bq7k=
X-Google-Smtp-Source: APXvYqwdLeze3zof/BoFqyl/nbTIrIQlmXAx5qW6Craj8deOn3p/fMRQLWtK+pK7AUq1WU97oRYAdBAv4dpog8KgDSw=
X-Received: by 2002:a65:6412:: with SMTP id a18mr28094169pgv.10.1582566349764;
 Mon, 24 Feb 2020 09:45:49 -0800 (PST)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Feb 2020 09:45:38 -0800
Message-ID: <CAKwvOdn9mpsjpAbVQbS0LC9iPtNrCZU+Pbh2Bt7kSXa4S8KQEg@mail.gmail.com>
Subject: 0-day bot testing with Clang now live
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Chen Rong <rong.a.chen@intel.com>,
        Philip Li <philip.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Kbuild Test Robot aka 0-day bot is now testing kernel patches with
Clang in addition to GCC and emailing patch authors.

Such email reports will have CC'ed our mailing list
<clang-built-linux@googlegroups.com> where we're active in triaging
the reports, and can help with steps to reproduce.  We'll likely fine
tune the implementation based on feedback, but the bot has been doing
these tests for months now (without emailing authors, just our list)
and has been pretty smooth.

I'll be sending more information (a patch to Documentation/) on
building the kernel with Clang shortly.
https://lore.kernel.org/lkml/20200224174129.2664-1-ndesaulniers@google.com/T/#u

We appreciate your help in ensuring the Linux kernel has not one but
two high quality open source toolchains, and 0-day bot should help us
catch regressions before they ever hit mainline.  Thanks to Rong,
Philip, Intel, and the rest of the folks contributing to 0-day bot.
And thanks to the team of folks submitting bug reports, fixing
warnings, implementing features, and discussing possible solutions.
Many many hands have gone in to making this possible.

To learn more about building the Linux kernel with LLVM, keep an eye
out for that Documentation/ patch, or see
https://clangbuiltlinux.github.io/.
-- 
Thanks,
~Nick Desaulniers
