Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076D2C35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C5A2467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YsPuHSyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgA1IMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:12:10 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43969 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgA1IMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 03:12:09 -0500
Received: by mail-lf1-f67.google.com with SMTP id 9so8375183lfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 00:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YtcRS1L5k8wBwwPdgRKCV0zDBNlxax9vadneAgBCrDM=;
        b=YsPuHSyJhbIqoeJPTniUj3/nc9kroQ5qUmdrzSLMXulbuST72e/qK6II+7d2ypcXnL
         WQoSVOv4y9f3Ov9svBNHmkQ16+V+HhE5ezmG18N673upe2+lor6gIHHtJd3a7p1v4qA+
         Fsxg2JFNAHVGCkVHzFvd7NiYxfQgKUd9XmN1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YtcRS1L5k8wBwwPdgRKCV0zDBNlxax9vadneAgBCrDM=;
        b=SR3Zxjnv1ktN5aKm/1Fib/T5NPUtnHg5L41yN3CH4PYeas86+KAGJ4Qw3ncWwP87wI
         lCUwQnS4pw8pbmcSlEYYCgTFy0nV1C5tXnEwNyheYlCHobJfpV5oTfx3S1PPdEr89cGf
         cIubSAmLff5QdaTHaeKMJxKkjIA4P/w4WfxXXNh+Q8w1wmNRFn+t+dlUM1wSKA77JTgp
         vDtRyh9GROWCntJjx0Pm0Xba+lw6f3GQO3C0fldScxtFsZPbHgoLZtpzDxI65rGaUsMa
         6yk0YZj8EjMu97V0ohnPWCOCxhXC8xU5T1FLnYcHzYswfclYRzodu5qxxKaod4Z3Vdeo
         +Zqw==
X-Gm-Message-State: APjAAAV8rckdSeJOeubTXaQB4/0MDduDsFwBfHZaTUpYt31vh7LQLNxg
        7wRdGPUOV9ADFB+ML2ZLXAE5CQ==
X-Google-Smtp-Source: APXvYqxHAUbMIrGBLdv8Yti7EDHcHua1MWBUehPXejuLPYcnKyCX57FpmTzajDy4Sg/aAffBMQXHgA==
X-Received: by 2002:ac2:5964:: with SMTP id h4mr1665454lfp.213.1580199127298;
        Tue, 28 Jan 2020 00:12:07 -0800 (PST)
Received: from [172.16.11.50] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id i13sm9246212ljg.89.2020.01.28.00.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 00:12:06 -0800 (PST)
Subject: Re: vmlinux ELF header sometimes corrupt
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-ext4@vger.kernel.org
References: <71aa76d0-a3b8-b4f3-a7c3-766cfb75412f@rasmusvillemoes.dk>
Message-ID: <5997e9b6-95fd-405b-05f8-16f9e34d9d87@rasmusvillemoes.dk>
Date:   Tue, 28 Jan 2020 09:12:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <71aa76d0-a3b8-b4f3-a7c3-766cfb75412f@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2020 18.52, Rasmus Villemoes wrote:
> I'm building for a ppc32 (mpc8309) target using Yocto, and I'm hitting a
> very hard to debug problem that maybe someone else has encountered. This
> doesn't happen always, perhaps 1 in 8 times or something like that.
> 
> The issue is that when the build gets to do "${CROSS}objcopy -O binary
> ... vmlinux", vmlinux is not (no longer) a proper ELF file, so naturally
> that fails with
> 
>   powerpc-oe-linux-objcopy:vmlinux: file format not recognized
> 
> So I hacked link-vmlinux.sh to stash copies of vmlinux before and after
> sortextable vmlinux. Both of those are proper ELF files, and comparing
> the corrupted vmlinux to vmlinux.after_sort they are identical after the
> first 52 bytes; in vmlinux, those first 52 bytes are all 0.
> 
> I also saved stat(1) info to see if vmlinux is being replaced or
> modified in-place.
> 
> $ cat vmlinux.stat.after_sort
>   File: 'vmlinux'
>   Size: 8608456     Blocks: 16696      IO Block: 4096   regular file
> Device: 811h/2065d  Inode: 21919132    Links: 1
> Access: (0755/-rwxr-xr-x)  Uid: ( 1000/    user)   Gid: ( 1001/    user)
> Access: 2020-01-22 10:52:38.946703081 +0000
> Modify: 2020-01-22 10:52:38.954703105 +0000
> Change: 2020-01-22 10:52:38.954703105 +0000
> 
> $ stat vmlinux
>   File: 'vmlinux'
>   Size: 8608456         Blocks: 16688      IO Block: 4096   regular file
> Device: 811h/2065d      Inode: 21919132    Links: 1
> Access: (0755/-rwxr-xr-x)  Uid: ( 1000/    user)   Gid: ( 1001/    user)
> Access: 2020-01-22 17:20:00.650379057 +0000
> Modify: 2020-01-22 10:52:38.954703105 +0000
> Change: 2020-01-22 10:52:38.954703105 +0000
> 
> So the inode number and mtime/ctime are exactly the same, but for some
> reason Blocks: has changed? This is on an ext4 filesystem, but I don't
> suspect the filesystem to be broken, because it's always just vmlinux
> that ends up corrupt, and always in exactly this way with the first 52
> bytes having been wiped.

So, I think I take that last part back. I just hit a case where I built
the kernel manually, made a copy of vmlinux to vmlinux.copy, and file(1)
said both were fine (and cmp(1) agreed they were identical). Then I went
off and did work elsewhere with a lot of I/O. When I came back to the
linux build dir, vmlinux was broken, exactly as before. So I now suspect
it to be some kind of "while the file is in the pagecache, everything is
fine, but when it's read back from disk it's broken".

My ext4 fs does have inline_data enabled, which could explain why the
corruption happens in the beginning. It's just very odd that it only
ever seems to trigger for vmlinux and not other files, but perhaps the
I/O patterns that ld and/or sortextable does are exactly what are needed
to trigger the bug.

I've done a long overdue kernel update, and there are quite a few
fs/ext4/ -stable patches in there, so now I'll see if it still happens.
And if anything more comes of this, I'll remove the kbuild and ppc lists
from cc, sorry for the noise.

Rasmus
