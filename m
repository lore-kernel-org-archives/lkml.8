Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E1FC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3189C20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgA2FSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:18:05 -0500
Received: from ozlabs.org ([203.11.71.1]:54909 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbgA2FRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:41 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDz55YZz9sRp; Wed, 29 Jan 2020 16:17:39 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3d4247fcc938d0ab5cf6fdb752dae07fdeab9736
In-Reply-To: <031dec5487bde9b2181c8b3c9800e1879cf98c1a.1579024426.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, erhard_f@mailbox.org,
        dja@axtens.net
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] powerpc/32: add support of KASAN_VMALLOC
Message-Id: <486sDz55YZz9sRp@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:39 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-14 at 17:54:00 UTC, Christophe Leroy wrote:
> Add support of KASAN_VMALLOC on PPC32.
> 
> To allow this, the early shadow covering the VMALLOC space
> need to be removed once high_memory var is set and before
> freeing memblock.
> 
> And the VMALLOC area need to be aligned such that boundaries
> are covered by a full shadow page.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3d4247fcc938d0ab5cf6fdb752dae07fdeab9736

cheers
