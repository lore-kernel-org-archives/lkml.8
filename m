Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6576AC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483CF214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgA2FSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:18:09 -0500
Received: from ozlabs.org ([203.11.71.1]:54909 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbgA2FRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:39 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDy1V07z9sRk; Wed, 29 Jan 2020 16:17:37 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f509247b08f2dcf7754d9ed85ad69a7972aa132b
In-Reply-To: <922d4939c735c6b52b4137838bcc066fffd4fc33.1578989545.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ptdump: only enable PPC_CHECK_WX with STRICT_KERNEL_RWX
Message-Id: <486sDy1V07z9sRk@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:37 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-14 at 08:13:10 UTC, Christophe Leroy wrote:
> ptdump_check_wx() is called from mark_rodata_ro() which only exists
> when CONFIG_STRICT_KERNEL_RWX is selected.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Fixes: 453d87f6a8ae ("powerpc/mm: Warn if W+X pages found on boot")

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f509247b08f2dcf7754d9ed85ad69a7972aa132b

cheers
