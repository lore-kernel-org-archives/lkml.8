Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C22EC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CB32073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgCZMGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:06:44 -0400
Received: from ozlabs.org ([203.11.71.1]:53377 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgCZMGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:06:43 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48p3cd3rbBz9sRY; Thu, 26 Mar 2020 23:06:41 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 697ece78f8f749aeea40f2711389901f0974017a
In-Reply-To: <c4d6c18a7f8d9d3b899bc492f55fbc40ef38896a.1583861325.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc/32s: reorder Linux PTE bits to better match Hash PTE bits.
Message-Id: <48p3cd3rbBz9sRY@ozlabs.org>
Date:   Thu, 26 Mar 2020 23:06:41 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-10 at 17:29:12 UTC, Christophe Leroy wrote:
> Reorder Linux PTE bits to (almost) match Hash PTE bits.
> 
> RW Kernel : PP = 00
> RO Kernel : PP = 00
> RW User   : PP = 01
> RO User   : PP = 11
> 
> So naturally, we should have
> _PAGE_USER = 0x001
> _PAGE_RW   = 0x002
> 
> Today 0x001 and 0x002 and _PAGE_PRESENT and _PAGE_HASHPTE which
> both are software only bits.
> 
> Switch _PAGE_USER and _PAGE_PRESET
> Switch _PAGE_RW and _PAGE_HASHPTE
> 
> This allows to remove a few insns.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/697ece78f8f749aeea40f2711389901f0974017a

cheers
