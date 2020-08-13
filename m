Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244B0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0013D2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYVcjVQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgHMMgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMMgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:36:18 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709F1C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 05:36:18 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o23so6007778ejr.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 05:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kuCm4CZAb14YPf3ZxgbHA1zc6jWu5IEHmKbZpdt4obQ=;
        b=gYVcjVQL2qQxtS2NN7+DIq8N0hp4WDt9ZEMnRoGkcEgAEuSZamH4d6DZOoxJy+FWVR
         xZkabl3J5gapFnqpQMwVi6KgjgI8u30BJixOhs5r1MR0V7PkOEb3mq+CnTYtOEmhlpq+
         w7MFKBm9mWEmc9urRHpqqKFXDgyVpwwzMV4FPGRO+fmhoj3ApgD6ptlFn9XrPEkaL9K3
         8YwACY6P1B629zrxGMhde2rOdRbjR3P6SwGj1XsAL3DlR4zzlLKeypOJ1MKRYX1B/4OD
         xvNfCmzFdv9bQM4wY88PZBu8dbMO1npNoseIRHXY82VXibivurURyDGgYlfTLX3tUFAW
         Oazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kuCm4CZAb14YPf3ZxgbHA1zc6jWu5IEHmKbZpdt4obQ=;
        b=tFmKq03IB/KpgIN//iCruhBLLzlsP/48+sP4kTtIkOBeSjDOk70ArcIQjTQvYwN0ra
         gxTjnMI3vkFhsg+PDMEvvJi4jqjfnS8o6QLVnCeMZ0eswT8oLb2ZF0cxeTku/tnUH6rR
         gxuUwnR+QbXKjcMyTtttoM0RevOAQYFRdoSe7x+xhuHMccYnFOaAjrpiymoAX5vWhOD3
         3htaGyAGwTUTNdTuoHFX5gzY3LS3c31kSdhaKKPuP1gS4K3F+mDu3kWW4LboFjS3p/LX
         A9D8VYj5C4E6lEy6QKt8vwkXjcDjKJO6ic7p8ZHdFvyS4FAnk6FI/s0Bx02mPt9Ip8Yn
         h98Q==
X-Gm-Message-State: AOAM5307Wgwa9QwifASZGnbdlvh8Es8MwhLomCBpXNUxC1TFzmfs1uaK
        dJ6JPD49xIkl2nnxmLnDANg=
X-Google-Smtp-Source: ABdhPJy6JfLKdz8+nqD1mLZoPQRVHbxCuwRY8jowYBh1ELTHl8GKqRbhNrFLHS93cJUcyFNlXhfmRw==
X-Received: by 2002:a17:906:ae12:: with SMTP id le18mr4573369ejb.38.1597322177189;
        Thu, 13 Aug 2020 05:36:17 -0700 (PDT)
Received: from ?IPv6:2001:a61:241a:1101:8c63:f991:aa91:da82? ([2001:a61:241a:1101:8c63:f991:aa91:da82])
        by smtp.gmail.com with ESMTPSA id a26sm3853636eju.83.2020.08.13.05.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 05:36:16 -0700 (PDT)
Cc:     mtk.manpages@gmail.com
To:     lkml <linux-kernel@vger.kernel.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: man-pages-5.08 is released
Message-ID: <881dcf85-97aa-55d5-b62d-db6f19851046@gmail.com>
Date:   Thu, 13 Aug 2020 14:36:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

The Linux man-pages maintainer proudly announces:

    man-pages-5.08 - man pages for Linux

This release resulted from patches, bug reports, reviews, and
comments from more than 30 people, with over 190 commits making
changes to more than 340 pages.

Tarball download:
    http://www.kernel.org/doc/man-pages/download.html
Git repository:
    https://git.kernel.org/cgit/docs/man-pages/man-pages.git/
Online changelog:
    http://man7.org/linux/man-pages/changelog.html#release_5.08

A short summary of the release is blogged at:
https://linux-man-pages.blogspot.com/2020/08/man-pages-508-is-released.html

The current version of the pages is browsable at:
http://man7.org/linux/man-pages/
A selection of changes in this release that may be of interest
to readers of LKML is shown below.

Cheers,

Michael

==================== Changes in man-pages-5.08 ====================

Newly documented interfaces in existing pages
---------------------------------------------

prctl.2
    Dave Martin
        Add SVE prctls (arm64)
            Add documentation for the the PR_SVE_SET_VL and PR_SVE_GET_VL
            prctls added in Linux 4.15 for arm64.
    Dave Martin  [Catalin Marinas]
        Add tagged address ABI control prctls (arm64)
            Add documentation for the the PR_SET_TAGGED_ADDR_CTRL and
            PR_GET_TAGGED_ADDR_CTRL prctls added in Linux 5.4 for arm64.

setns.2
    Michael Kerrisk
        Document the use of PID file descriptors with setns()
            Starting with Linux 5.8, setns() can take a PID file descriptor as
            an argument, and move the caller into or more of the namespaces of
            the thread referred to by that descriptor.

capabilities.7
    Michael Kerrisk
        Document CAP_BPF
    Michael Kerrisk
        Add CAP_PERFMON

symlink.7
    Aleksa Sarai
        Document magic links more completely


Changes to individual pages
---------------------------

iopl.2
    Thomas Piekarski  [victorm007@yahoo.com]
        Updating description of permissions and disabling interrupts
            Update description of permissions for port-mapped I/O set
            per-thread and not per-process. Mention that iopl() can not
            disable interrupts since Linux 5.5 anymore and is in general
            deprecated and only provided for legacy X servers.

            See https://bugzilla.kernel.org/show_bug.cgi?id=205317

pidfd_open.2
    Michael Kerrisk
        Add the setns(2) use case for PID file descriptors

prctl.2
    Michael Kerrisk
        The parent death signal is cleared on some credential changes
            See kernel/cred.c::commit_creds() in the Linux 5.6 source code.

seccomp.2
    Andy Lutomirski
        Improve x32 and nr truncation notes

sync.2
    Jeff Layton
        syncfs() now returns errors if writeback fails

capabilities.7
    Saikiran Madugula
        CAP_SYS_RESOURCE: add two more items for POSIX message queues
            CAP_SYS_RESOURCE also allows overriding /proc/sys/fs/mqueue/msg_max
            and /proc/sys/fs/mqueue/msgsize_max.
ld.so.8
    Florian Weimer  [Michael Kerrisk]
        List more places in which dynamic string tokens are expanded
            This happens for more than just DT_RPATH/DT_RUNPATH.
    Arkadiusz Drabczyk
        Explain that empty entry in LD_LIBRARY_PATH means cwd

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
