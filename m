Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A18C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 00:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48952206F9
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 00:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOoFkPnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgEQAAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 20:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726670AbgEQAAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 20:00:52 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06EBC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 17:00:52 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s69so2901539pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 17:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f1+Us8/YLn1EYw/8uIhzIX+UTGyAfVgf40G32lCNbk0=;
        b=XOoFkPnS/bNFYcuVH+Aa8rz+lxoFNlh6OCdx/Ty8+0Ts35mLE2Hz+LqXcsUXylYxR0
         C8+xGDKoOy9x414nveSQDtS81vAkxgqv4/Nl/V0NZBu0Okzdg9m/f43kNFmpgnU7foBG
         a9ixxE2Q/Od0bgaLNomzofQPFbPuHetMcN+20kVNts4DIk4vdDFeghMEcAMnQRh5NFZT
         vvksYHZ/oZSvYyK3jP8pDW6Nj8vwlZ0V+iqE0hxnNZHfAwdfrmumxqOG7VdvPZFvrYHf
         KVqOQ8okAhQ4MGOA1ELu1rjnXc+hB0x1dHtGAZDAvyAKwqXLvavX6p39FKQ9GhyCimzO
         fO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f1+Us8/YLn1EYw/8uIhzIX+UTGyAfVgf40G32lCNbk0=;
        b=OfG+95IvGATA5dDvTEC0mC+4VcI98EAgKxx80O3ic7ZXgJl3w7aZVh9lRFNonfgl+j
         cIh7Kvqf6KK0Oczny9/qFQQVMzD3J72efeYj9W8vvD7PXRNawXPDQtdq/3GwYjdUJYpS
         SBKXp+Y4plYJOUyw7m3QmssBpx6S5MT1quBwPmBhw/edGLyLSMKG+nlzWYTHJKBtamSN
         F7cJdI3+gXGXU12BfIcoj32OFk2xzDcfdYlh0eq1gKbL8gPANcrOWsOYj4i/nUwNbPDC
         Os3zXqt1jRE6UJAB+E4qmEj4sLmBkz7z8lxjqLLzt2txB7ElvAeF0q1YShLoNO630sXa
         4ZQA==
X-Gm-Message-State: AOAM530zYNiRK95LuPi/gjB3UtzKB8YkiBHlrOASGoM+jRzvlUV8iZnf
        TGLaHOCxNzs6JnGbBNQ8wtsv7nx7
X-Google-Smtp-Source: ABdhPJyzuqWiKhG8xM1+tT6YskoHfpX+S+uIzSgIDIzwy81rxQthrmS6oCur2i1B9ygHVu3vOH18KA==
X-Received: by 2002:a17:90b:1103:: with SMTP id gi3mr5512703pjb.184.1589673652308;
        Sat, 16 May 2020 17:00:52 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d20sm4587363pjs.12.2020.05.16.17.00.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 May 2020 17:00:51 -0700 (PDT)
Date:   Sat, 16 May 2020 17:00:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, elver@google.com, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org, peterz@infradead.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 04/18] sparc32: mm: Reduce allocation size for PMD and
 PTE tables
Message-ID: <20200517000050.GA87467@roeck-us.net>
References: <20200511204150.27858-1-will@kernel.org>
 <20200511204150.27858-5-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511204150.27858-5-will@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 09:41:36PM +0100, Will Deacon wrote:
> Now that the page table allocator can free page table allocations
> smaller than PAGE_SIZE, reduce the size of the PMD and PTE allocations
> to avoid needlessly wasting memory.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will@kernel.org>

Something in the sparc32 patches in linux-next causes all my sparc32 emulations
to crash. bisect points to this patch, but reverting it doesn't help, and neither
does reverting the rest of the series.

Guenter

---
Bisect log:

# bad: [bdecf38f228bcca73b31ada98b5b7ba1215eb9c9] Add linux-next specific files for 20200515
# good: [2ef96a5bb12be62ef75b5828c0aab838ebb29cb8] Linux 5.7-rc5
git bisect start 'HEAD' 'v5.7-rc5'
# bad: [3674d7aa7a8e61d993886c2fb7c896c5ef85e988] Merge remote-tracking branch 'crypto/master'
git bisect bad 3674d7aa7a8e61d993886c2fb7c896c5ef85e988
# bad: [1ab4d6ff0a3ee4b29441d8b0076bc8d4734bd16e] Merge remote-tracking branch 'hwmon-staging/hwmon-next'
git bisect bad 1ab4d6ff0a3ee4b29441d8b0076bc8d4734bd16e
# good: [dccfae3ab84387c94f2efc574d41efae005eeee5] Merge remote-tracking branch 'tegra/for-next'
git bisect good dccfae3ab84387c94f2efc574d41efae005eeee5
# bad: [20f9d1287c9f0047b81497197c9f4893485bbe15] Merge remote-tracking branch 'djw-vfs/vfs-for-next'
git bisect bad 20f9d1287c9f0047b81497197c9f4893485bbe15
# bad: [6537897637b5b91f921cb0ac6c465a593f4a665e] Merge remote-tracking branch 'sparc-next/master'
git bisect bad 6537897637b5b91f921cb0ac6c465a593f4a665e
# good: [bca1583e0693e0ba76450b684c5910f7083eeef4] Merge remote-tracking branch 'mips/mips-next'
git bisect good bca1583e0693e0ba76450b684c5910f7083eeef4
# good: [1f12096aca212af8fad3ef58d5673cde691a1452] Merge the lockless page table walk rework into next
git bisect good 1f12096aca212af8fad3ef58d5673cde691a1452
# good: [23a457b8d57dc8d0cc1dbd1882993dd2fcc4b0c0] s390: nvme reipl
git bisect good 23a457b8d57dc8d0cc1dbd1882993dd2fcc4b0c0
# good: [f57f5010c0c3fe2d924a957ddf1d17fbebb54d47] Merge remote-tracking branch 'risc-v/for-next'
git bisect good f57f5010c0c3fe2d924a957ddf1d17fbebb54d47
# good: [1d5fd6c33b04e5d5b665446c3b56f2148f0f1272] sh: add missing DECLARE_EXPORT() for __ashiftrt_r4_xx
git bisect good 1d5fd6c33b04e5d5b665446c3b56f2148f0f1272
# bad: [8c8f3156dd40f8bdc58f2ac461374bc804c28e3b] sparc32: mm: Reduce allocation size for PMD and PTE tables
git bisect bad 8c8f3156dd40f8bdc58f2ac461374bc804c28e3b
# good: [8e958839e4b9fb6ea4385ff2c52d1333a3a618de] sparc32: mm: Restructure sparc32 MMU page-table layout
git bisect good 8e958839e4b9fb6ea4385ff2c52d1333a3a618de
# good: [3f407976ac2953116cb8880a7a18b63bcc81829d] sparc32: mm: Change pgtable_t type to pte_t * instead of struct page *
git bisect good 3f407976ac2953116cb8880a7a18b63bcc81829d
# first bad commit: [8c8f3156dd40f8bdc58f2ac461374bc804c28e3b] sparc32: mm: Reduce allocation size for PMD and PTE tables

---
Log messages:

Lots of:

BUG: scheduling while atomic: kthreadd/2/0xffffffff
Modules linked in:
CPU: 0 PID: 2 Comm: kthreadd Tainted: G        W         5.7.0-rc5-next-20200515 #1
[f04f2c94 :
here+0x16c/0x250 ]
[f04f2df0 :
schedule+0x78/0x11c ]
[f003f100 :
kthreadd+0x188/0x1a4 ]
[f0008448 :
ret_from_kernel_thread+0xc/0x38 ]
[00000000 :
0x0 ]

followed by:

Kernel panic - not syncing: Aiee, killing interrupt handler!
CPU: 0 PID: 19 Comm: cryptomgr_test Tainted: G        W         5.7.0-rc5-next-20200515 #1
[f0024400 :
do_exit+0x7c8/0xa88 ]
[f0075540 :
__module_put_and_exit+0xc/0x18 ]
[f0221428 :
cryptomgr_test+0x28/0x48 ]
[f003edc0 :
kthread+0xf4/0x12c ]
[f0008448 :
ret_from_kernel_thread+0xc/0x38 ]
[00000000 :
0x0 ]
