Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1282AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90B820663
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YqqjYCS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgAVRwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:52:25 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:35039 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVRwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:52:24 -0500
Received: by mail-lj1-f178.google.com with SMTP id j1so18545lja.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 09:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Kwfb980H2zFKYYbHaFvisTOICKVRfP4l7wqRW0yzW7k=;
        b=YqqjYCS469tBGefnBZCHaLOnvCEU6RwmU1Ym07beUKu4bL09uWTNZ1nt968GsPQoOq
         hbv2BR2GZt2/EJClXZnd1ehzVW5dPVI+a/fu8bRIymQ4uovVqAAAT6xartThfhLh7E7X
         6S9Zvq6eJl2OlyLkBfi1N/AcYSjc/JsxYa8N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Kwfb980H2zFKYYbHaFvisTOICKVRfP4l7wqRW0yzW7k=;
        b=q/3slfBw3vLT4e8azNPvYXqzhGtjA+bCH+EuVJQJSQH+JkjUQUzMhoUEObCgURu8Is
         uNgeg99dVn9M97vPF59A2N9CckimtIM+o3yeOxmjC8Fgjsk1Yie3SneGNHX8ndCtKv2v
         VGS7y0w4mFOUFHLFsWmFp5xsW85ADaWSRbtm2h/ASN9QApM3R4wr/VGyP4luWmgNm7xX
         d7fn9u/ehjOb07m2W3WuVb/A6cOHX0kt/pJogMCx4d9aIAERBQxKTEHPMeEuzH31eZ8O
         TkySkgMbuSCPJNbev3Mk+QzkcCWM2ttLm26ZKUPUjMcOJjz4OZXGuZ0T/kjskmlD7cRN
         cwdA==
X-Gm-Message-State: APjAAAUQcj0kUL4DpOeqbY5jLVUe9DtCIllrtnsisv9pm2kzdO53jJCP
        tvylUtsF18vdoYsA9ye5YGV16A==
X-Google-Smtp-Source: APXvYqzjSckBf1b85YfqGd+aDBBQkbREIKg8UrhShurtzZaYsPKOvuFLad0ZOZ/cNOpPlfEgL2IiHg==
X-Received: by 2002:a2e:8595:: with SMTP id b21mr18485013lji.219.1579715542683;
        Wed, 22 Jan 2020 09:52:22 -0800 (PST)
Received: from [172.16.11.50] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f16sm20549672ljn.17.2020.01.22.09.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 09:52:22 -0800 (PST)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: vmlinux ELF header sometimes corrupt
Message-ID: <71aa76d0-a3b8-b4f3-a7c3-766cfb75412f@rasmusvillemoes.dk>
Date:   Wed, 22 Jan 2020 18:52:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm building for a ppc32 (mpc8309) target using Yocto, and I'm hitting a
very hard to debug problem that maybe someone else has encountered. This
doesn't happen always, perhaps 1 in 8 times or something like that.

The issue is that when the build gets to do "${CROSS}objcopy -O binary
... vmlinux", vmlinux is not (no longer) a proper ELF file, so naturally
that fails with

  powerpc-oe-linux-objcopy:vmlinux: file format not recognized

So I hacked link-vmlinux.sh to stash copies of vmlinux before and after
sortextable vmlinux. Both of those are proper ELF files, and comparing
the corrupted vmlinux to vmlinux.after_sort they are identical after the
first 52 bytes; in vmlinux, those first 52 bytes are all 0.

I also saved stat(1) info to see if vmlinux is being replaced or
modified in-place.

$ cat vmlinux.stat.after_sort
  File: 'vmlinux'
  Size: 8608456     Blocks: 16696      IO Block: 4096   regular file
Device: 811h/2065d  Inode: 21919132    Links: 1
Access: (0755/-rwxr-xr-x)  Uid: ( 1000/    user)   Gid: ( 1001/    user)
Access: 2020-01-22 10:52:38.946703081 +0000
Modify: 2020-01-22 10:52:38.954703105 +0000
Change: 2020-01-22 10:52:38.954703105 +0000

$ stat vmlinux
  File: 'vmlinux'
  Size: 8608456         Blocks: 16688      IO Block: 4096   regular file
Device: 811h/2065d      Inode: 21919132    Links: 1
Access: (0755/-rwxr-xr-x)  Uid: ( 1000/    user)   Gid: ( 1001/    user)
Access: 2020-01-22 17:20:00.650379057 +0000
Modify: 2020-01-22 10:52:38.954703105 +0000
Change: 2020-01-22 10:52:38.954703105 +0000

So the inode number and mtime/ctime are exactly the same, but for some
reason Blocks: has changed? This is on an ext4 filesystem, but I don't
suspect the filesystem to be broken, because it's always just vmlinux
that ends up corrupt, and always in exactly this way with the first 52
bytes having been wiped.

Any ideas?

Rasmus
