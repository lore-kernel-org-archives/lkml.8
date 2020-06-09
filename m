Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A993DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EA420812
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgFIF26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgFIF2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:28:45 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393E1C03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 22:28:45 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49gzDq4Mzpz9sTY; Tue,  9 Jun 2020 15:28:42 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
References: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 01/12] powerpc/52xx: Blacklist functions running with MMU disabled for kprobe
Message-Id: <159168034995.1381411.12691438266986038237.b4-ty@ellerman.id.au>
Date:   Tue,  9 Jun 2020 15:28:42 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 16:03:36 +0000 (UTC), Christophe Leroy wrote:
> kprobe does not handle events happening in real mode, all
> functions running with MMU disabled have to be blacklisted.

Applied to powerpc/next.

[01/12] powerpc/52xx: Blacklist functions running with MMU disabled for kprobe
        https://git.kernel.org/powerpc/c/e83f01fdb9143a4f90b17fbf7d8b8b21efb2f968
[02/12] powerpc/82xx: Blacklist pq2_restart() for kprobe
        https://git.kernel.org/powerpc/c/1740f15a99d30a5e2710b2b0754e65fc5ba68d1d
[03/12] powerpc/83xx: Blacklist mpc83xx_deep_resume() for kprobe
        https://git.kernel.org/powerpc/c/7aa85127b1a170694b042cbc35a07afe3904173e
[04/12] powerpc/powermac: Blacklist functions running with MMU disabled for kprobe
        https://git.kernel.org/powerpc/c/32a820670fa00419375a964ca8bc569e1499b90d
[05/12] powerpc/mem: Blacklist flush_dcache_icache_phys() for kprobe
        https://git.kernel.org/powerpc/c/a64371b5d4fb37199dcd04cb7bf0132894018e33
[06/12] powerpc/32s: Make local symbols non visible in hash_low.
        https://git.kernel.org/powerpc/c/f892c21d2efb3b86ecbf8f5a95ea4abeedcc91b0
[07/12] powerpc/32s: Blacklist functions running with MMU disabled for kprobe
        https://git.kernel.org/powerpc/c/e6209318d63e2774c5ab214b14b948079e040064
[08/12] powerpc/rtas: Remove machine_check_in_rtas()
        https://git.kernel.org/powerpc/c/32746dfe4cf37f4077929601e8877a7fd02676e8
[09/12] powerpc/32: Blacklist functions running with MMU disabled for kprobe
        https://git.kernel.org/powerpc/c/5f32e8361cba8c58c4f272a389296f489ecc2823
[10/12] powerpc/entry32: Blacklist exception entry points for kprobe.
        https://git.kernel.org/powerpc/c/a616c442119f2ea5641e6abc215d7255b73b982b
[11/12] powerpc/entry32: Blacklist syscall exit points for kprobe.
        https://git.kernel.org/powerpc/c/7cdf4401388572f720403a7038a178a4b30ac14c
[12/12] powerpc/entry32: Blacklist exception exit points for kprobe.
        https://git.kernel.org/powerpc/c/e51c3e13709fe55d4d0eb50ba435bc53a64152bf

cheers
