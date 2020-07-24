Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E755C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83ED92065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgGXNZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgGXNZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:25:15 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7602C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:25:15 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BCqgs5ZZwz9sVG; Fri, 24 Jul 2020 23:25:12 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Will Deacon <willdeacon@google.com>
Cc:     npiggin@gmail.com, tglx@linutronix.de, bigeasy@linutronix.de,
        jniethe5@gmail.com, msuchanek@suse.de, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
In-Reply-To: <20200716193820.1141936-1-palmer@dabbelt.com>
References: <20200716193820.1141936-1-palmer@dabbelt.com>
Subject: Re: [PATCH] powerpc/64: Fix an out of date comment about MMIO ordering
Message-Id: <159559697172.1657499.14368228495374762010.b4-ty@ellerman.id.au>
Date:   Fri, 24 Jul 2020 23:25:12 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 12:38:20 -0700, Palmer Dabbelt wrote:
> This primitive has been renamed, but because it was spelled incorrectly in the
> first place it must have escaped the fixup patch.  As far as I can tell this
> logic is still correct: smp_mb__after_spinlock() uses the default smp_mb()
> implementation, which is "sync" rather than "hwsync" but those are the same
> (though I'm not that familiar with PowerPC).

Applied to powerpc/next.

[1/1] powerpc/64: Fix an out of date comment about MMIO ordering
      https://git.kernel.org/powerpc/c/147c13413c04bc6a2bd76f2503402905e5e98cff

cheers
