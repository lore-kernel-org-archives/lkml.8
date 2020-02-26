Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B957C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4811B20656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lynomhex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgBZTOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:14:48 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54829 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgBZTOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:14:47 -0500
Received: by mail-pj1-f65.google.com with SMTP id dw13so53447pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 11:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=II+mmd4o8Thv9U8AkaEb8+H9vZCo78uQ32TXbZDWSJs=;
        b=lynomhexXn+T3hobct4dEhAkKUBooMzG46ig+lFR3nqPLY1Tcs+kYI72Bztx/AxP47
         rZ2gV/crLo1Q8v7yuzzJDCkb1eIw11IcOCNhyhp7oPNRNdnhYGiE1ZSlcEZQX7QUPXfc
         0ftFf1cnM7fFsqy3Oxmj1Jgo+NFodElHbtmfXhOe0zCrMFERtQ4IFv2OzwoZYemUXxEO
         v8fRLTqd65edidpf7lVVbSGWpVqlwMMVM3uyMn6MaYzRiG963bdh60ajgm4z9pFOiYjs
         2U8CYAYjaGFrsHneTOICUYUvwaRJkgSh57sB3zp2esinOaeqXsqo8F+3E6/UIq4tAl9B
         rLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=II+mmd4o8Thv9U8AkaEb8+H9vZCo78uQ32TXbZDWSJs=;
        b=NzlqkGUELQpUGInnO89uFVD1/4XmTwgYvvcMA0j9lG3ARpKCHKIEKKpJ0nkxNHh0eB
         0nBpe3MpUKN/qSMHApES+bHJCWvliKl/J1Ng3Gfc9ATz9Kg94K+W9AkBVecuob5Cl4dk
         IcBsP3MaIUprcdZWWYYgD7jg5uu71s+a0KaXCdsK10jwiRS+VREwpOcVIQlY9RkEFeMd
         rJM+k02Yn2BmE3XQ6Uoo+BcjOFb6Y54X8fvjNOIjc4j3i1r2VmIgYTtusN8Ye2QPBczh
         k5BW+CLl5MkEJfh9w/NcQWSweiN4WssbWYtGDua4yuYQunokbHgUE9dQVZzf6rzHzLLd
         833Q==
X-Gm-Message-State: APjAAAXO2tKz0Xl5rayL3UmlP1wLw943e40mxwPtgQDbFYnHV59bYfWo
        mF4p1Uy2Ee7f204LSQ3OMVISJg==
X-Google-Smtp-Source: APXvYqxgwE8i5lOdoCI9nD6vqdTgXjxGcDQJ2HHnuQj5ks3jysXLE7aUpKyoGIoUfgaath9Z67nAAQ==
X-Received: by 2002:a17:90a:a587:: with SMTP id b7mr643340pjq.18.1582744486510;
        Wed, 26 Feb 2020 11:14:46 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id 5sm3895584pfx.163.2020.02.26.11.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 11:14:45 -0800 (PST)
Date:   Wed, 26 Feb 2020 11:14:45 -0800 (PST)
X-Google-Original-Date: Wed, 26 Feb 2020 11:14:44 PST (-0800)
Subject:     When are my patches getting merged [Was: Re: [GIT PULL] RISC-V Fixes for 5.6-rc4]
In-Reply-To: <5226d756-e348-29d1-258d-0ab4b63c0677@ghiti.fr>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     alex@ghiti.fr
Message-ID: <mhng-75f261ed-b883-408f-84ea-6425b49abb20@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Moving Linus and linux-kernel to BCC, as it's a RISC-V thing]

On Tue, 25 Feb 2020 23:56:54 PST (-0800), alex@ghiti.fr wrote:
> Hi Palmer,
>
> On 2/25/20 6:37 PM, Palmer Dabbelt wrote:
>> The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:
>>
>>    Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)
>>
>> are available in the Git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linux-5.6-rc4
>>
>> for you to fetch changes up to 8458ca147c204e7db124e8baa8fede219006e80d:
>>
>>    riscv: adjust the indent (2020-02-24 13:12:53 -0800)
>>
>> ----------------------------------------------------------------
>> RISC-V Fixes for 5.6-rc4
>>
>> This tag contains a handful of RISC-V related fixes that I've collected and
>> would like to target for 5.6-rc4:
>>
>> * A fix to set up the PMPs on boot, which allows the kernel to access memory on
>>    systems that don't set up permissive PMPs before getting to Linux.  This only
>>    effects machine-mode kernels, which currently means only NOMMU kernels.
>> * A fix to avoid enabling supervisor-mode interrupts when running in
>>    machine-mode, also only for NOMMU kernels.
>> * A pair of fixes to our KASAN support to avoid corrupting memory.
>> * A gitignore fix.
>>
>> This boots on QEMU's virt board for me.
>>
>> ----------------------------------------------------------------
>> Anup Patel (1):
>>        RISC-V: Don't enable all interrupts in trap_init()
>>
>> Damien Le Moal (1):
>>        riscv: Fix gitignore
>>
>> Greentime Hu (1):
>>        riscv: set pmp configuration if kernel is running in M-mode
>>
>> Zong Li (2):
>>        riscv: allocate a complete page size for each page table
>>        riscv: adjust the indent
>>
>>   arch/riscv/boot/.gitignore   |  2 ++
>>   arch/riscv/include/asm/csr.h | 12 ++++++++++
>>   arch/riscv/kernel/head.S     |  6 +++++
>>   arch/riscv/kernel/traps.c    |  4 ++--
>>   arch/riscv/mm/kasan_init.c   | 53 ++++++++++++++++++++++++++------------------
>>   5 files changed, 53 insertions(+), 24 deletions(-)
>>
>
> What about this patch https://patchwork.kernel.org/patch/11395273/ from
> Vincent that fixes module loading problems described here:
>
> https://lore.kernel.org/linux-riscv/d868acf5-7242-93dc-0051-f97e64dc4387@ghiti.fr/T/
>
> Do you consider it for 5.6 ?

I haven't gotten to them yet, but at a glance it's probably a big enough change
that it should should go in during a merge window.  The module loading stuff is
a bit of a rats nest because it never really got finished, so I want to make
sure things get sufficient testing over there.

I'll try to take a look, though -- it's only ~1K messages deep in my inbox, so
there's hope :).
