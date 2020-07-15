Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D690C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE42D20663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGOPjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:39:21 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:35041 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbgGOPjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:39:19 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1jvjV5-003CrQ-RT; Wed, 15 Jul 2020 17:39:15 +0200
Received: from p57bd93f9.dip0.t-ipconnect.de ([87.189.147.249] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.93)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1jvjV5-002QSz-KF; Wed, 15 Jul 2020 17:39:15 +0200
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de>
 <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx>
 <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com>
 <def65208-a38b-8663-492a-cae150027003@physik.fu-berlin.de>
 <b5f1853e-031d-c09d-57d2-fb4baffa01ea@physik.fu-berlin.de>
 <CAMuHMdW8RtJKk3u7RWQKP2tA3AYT2rB2aqhUT1KnJ4tJwWWKDA@mail.gmail.com>
 <b5cd845f-7b5e-af8e-a15d-3ede7e61ced4@physik.fu-berlin.de>
 <0322def7-fc16-c805-8f2b-c88fffce2f1e@physik.fu-berlin.de>
Autocrypt: addr=glaubitz@physik.fu-berlin.de; keydata=
 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
 scOkTAZQGVpD/8AaLH4v1w==
Message-ID: <f10d2711-674b-50b4-cf7a-234070b3c265@physik.fu-berlin.de>
Date:   Wed, 15 Jul 2020 17:39:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0322def7-fc16-c805-8f2b-c88fffce2f1e@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.147.249
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/20 4:37 PM, John Paul Adrian Glaubitz wrote:
> Will report once I found the bad commit that introduced the problem.

git bisect lead me to a merge commit:

glaubitz@epyc:..glaubitz/linux> git bisect log
git bisect start
# good: [1c163f4c7b3f621efff9b28a47abb36f7378d783] Linux 5.0
git bisect good 1c163f4c7b3f621efff9b28a47abb36f7378d783
# bad: [7bc20f6563b4e117d61ca575427208e0eaa945b9] sh: Fix unneeded constructor in page table allocation
git bisect bad 7bc20f6563b4e117d61ca575427208e0eaa945b9
# bad: [eeb2045bb7d20fea0a242148059377cd0cb4a499] Merge branch '10GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue
git bisect bad eeb2045bb7d20fea0a242148059377cd0cb4a499
# bad: [5ce40fd86cf155e0eefc73509343bb3eeaafa4bc] drm/amdgpu: add Arcturus chip_name for init sdma microcode
git bisect bad 5ce40fd86cf155e0eefc73509343bb3eeaafa4bc
# good: [8f14c99c7edaaba9c0bb1727d44db6ebf157cc61] netfilter: conntrack: limit sysctl setting for boolean options
git bisect good 8f14c99c7edaaba9c0bb1727d44db6ebf157cc61
# good: [dce45af5c2e9e85f22578f2f8065f225f5d11764] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
git bisect good dce45af5c2e9e85f22578f2f8065f225f5d11764
# bad: [60fce36afa9c77c7ccbf980c4f670f3be3651fce] mm/compaction.c: correct zone boundary handling when isolating pages from a pageblock
git bisect bad 60fce36afa9c77c7ccbf980c4f670f3be3651fce
# bad: [414147d99b928c574ed76e9374a5d2cb77866a29] Merge tag 'pci-v5.2-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
git bisect bad 414147d99b928c574ed76e9374a5d2cb77866a29
# bad: [1fb3b526df3bd7647e7854915ae6b22299408baf] Merge tag 'docs-5.2a' of git://git.lwn.net/linux
git bisect bad 1fb3b526df3bd7647e7854915ae6b22299408baf
# bad: [ea5aee6d97fd2d4499b1eebc233861c1def70f06] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect bad ea5aee6d97fd2d4499b1eebc233861c1def70f06
# bad: [45182e4e1f8ac04708ca7508c51d9103f07d81ab] Merge branch 'i2c/for-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect bad 45182e4e1f8ac04708ca7508c51d9103f07d81ab
# good: [5940d1cf9f42f67e9cc3f7df9eda39f5888d6e9e] SUNRPC: Rebalance a kref in auth_gss.c
git bisect good 5940d1cf9f42f67e9cc3f7df9eda39f5888d6e9e
# bad: [abde77eb5c66b2f98539c4644b54f34b7e179e6b] Merge branch 'for-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
git bisect bad abde77eb5c66b2f98539c4644b54f34b7e179e6b
# bad: [7664cd6e3a0b2709f04c07435e96c7c85e7d7324] Merge branch 'next-integrity' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
git bisect bad 7664cd6e3a0b2709f04c07435e96c7c85e7d7324
# good: [3e9dfc6e1e8bce62a329f1452c7eeccbac230980] orangefs: move do_readv_writev to direct_IO
git bisect good 3e9dfc6e1e8bce62a329f1452c7eeccbac230980
# good: [4077a0f25b001926f86d35f6236351583bada9a4] orangefs: pass slot index back to readpage.
git bisect good 4077a0f25b001926f86d35f6236351583bada9a4
# good: [2bfebea90dd5e8c57ae1021a5d1bb6c1057eee6d] Merge branch 'next-integrity-for-james' of git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity into next-integrity
git bisect good 2bfebea90dd5e8c57ae1021a5d1bb6c1057eee6d
# good: [33713cd09ccdc1e01b10d0782ae60200d4989553] orangefs: truncate before updating size
git bisect good 33713cd09ccdc1e01b10d0782ae60200d4989553
# bad: [882388056194d2d4c3f589b194b6bdcc47e677e8] Merge tag 'for-linus-5.2-ofs1' of git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux
git bisect bad 882388056194d2d4c3f589b194b6bdcc47e677e8
# first bad commit: [882388056194d2d4c3f589b194b6bdcc47e677e8] Merge tag 'for-linus-5.2-ofs1' of git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux
glaubitz@epyc:..glaubitz/linux>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
