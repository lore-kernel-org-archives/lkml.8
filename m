Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FCFC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 634AC21941
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgIIPVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:21:52 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:35999 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgIIL2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:28:32 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MG9Xu-1kJCr04Bbw-00GaHP; Wed, 09 Sep 2020 13:27:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/23] Use asm-generic for mmu_context no-op functions
Date:   Wed,  9 Sep 2020 13:27:08 +0200
Message-Id: <159965079776.3591084.10754647036857628984.b4-ty@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7OMazxQ6DY8MEF6H/bZ/vvXzzHh3+g8R4o0uC3slmdaoHjeIgYq
 yYLMHXATL1HlHzETUxMec1heCWdAqn5Xbe34Z7iqBpu9Y+QREbqvwyqSFWcQXq6+OkYWUq4
 mlJxy2fwrK+/O2uwi47EP5zNbeaSwyCVP23+DW/IriB8kDIZHKFD40PKK96QjJV0N2KRzcV
 XgsmqvhStI+/vCfKlCM9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YBNooPUWFN8=:iu760Z4R7UBivMuwhQHeHx
 YWGUNWbZBoBYfk7wdQPrvP1mVGFgET9PxQovhGbZlFI5aEYtZuOzHfM/eRykMdbMQ6ww1LpMc
 WK7ZuviVeyXh5f8DYbWBSRFbHi7frupdJsOKbULIrnLSZpdcX/PmV9M7eC2i4AHqbGInC63cs
 z+hNRtsNbWqEhoyXzsPm49s+EKw+XpUQZM50TYKqMcSbprL3tkjFiOxFGWpCFWmidcZ+qj/+l
 EKg37uALHPRd2MfjLG0mKt9/hR5zuy57OeAJax1lCwlORQa5kpTvsOhUR5hxRFgN4ZXFQk9wp
 3ooVViweyIcusk1tEDI+U9N5c/qXBG7FnGvHREG4qGAfcBw/HTT0zvh8TPR+0HAbcA+Y29nV3
 HIOH1B6nt0FWzIDzno0O9y/cfTwxDLtOxPqrv+oVWlCsRH8DA63nGHDSTFpE+Q9qCCHzctsVv
 pLp4TLvZegnYRHmCF44R+K/A/H6jKrFe/snW7gywhGynxLUVNO8MThghQtVUt6m5t8YHcD1wG
 I/nCCzrTddRlOqIWNT56HKsDJIL6wmlw0xY0V0PXxA/4Hc+4+7xVpEAMttmEa+2airyFYsLaL
 HIgm4ihHJlHkDCu6WVpWN+D+zYIH/sVzsaQ+0+KB8BMQos8oc4NYbUSlP7RAX9wV7aP47qTMR
 CWebRmcNhnV55e6Ni/NUvroWkjws9gk8V1vyndOZU09izuC7dDHDUgY6lVvOaN8zv0h9sox/h
 gscn/yomTex4SVx5LjeVs4jcvyTcr5Pe3XjyR3nvBkLqTFH5dx7HqJNAyqFp5a3OGfu2Gc9Zv
 qHxP6rHut/gY4hmgJ/SZ/5dZJlXZe+6D6/6HWtbIDvbVPTNE7E/I3CRmKD9daBAzcGBYTMu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 00:15:16 +1000, Nicholas Piggin wrote:
> It would be nice to be able to modify mmu_context functions or add a
> hook without updating all architectures, many of which will be no-ops.
> 
> The motivation for this series is a change to lazy mmu handling, but
> this series stands on its own as a good cleanup whether or not we end
> up making that change.
> 
> [...]

Applied to asm-generic, thanks!

[01/23] asm-generic: add generic MMU versions of mmu context functions
        (no commit info)
[02/23] alpha: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[03/23] arc: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[04/23] arm: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[05/23] arm64: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[06/23] csky: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[07/23] hexagon: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[08/23] ia64: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[09/23] m68k: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[10/23] microblaze: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[11/23] mips: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[12/23] nds32: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[13/23] nios2: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[14/23] openrisc: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[15/23] parisc: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[16/23] powerpc: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[17/23] riscv: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[18/23] s390: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[19/23] sh: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[20/23] sparc: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[21/23] um: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[22/23] x86: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[23/23] xtensa: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)

       Arnd
