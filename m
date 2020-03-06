Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE122C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A187020705
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCFA1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 19:27:37 -0500
Received: from ozlabs.org ([203.11.71.1]:43561 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgCFA1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:27:35 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48YT396mMRz9sSR; Fri,  6 Mar 2020 11:27:33 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0b1c524caaae2428b20e714297243e5551251eb5
In-Reply-To: <7b065c5be35726af4066cab238ee35cabceda1fa.1578558199.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mike Rapoport <rppt@linux.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] powerpc/32: refactor pmd_offset(pud_offset(pgd_offset...
Message-Id: <48YT396mMRz9sSR@ozlabs.org>
Date:   Fri,  6 Mar 2020 11:27:33 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-01-09 at 08:25:25 UTC, Christophe Leroy wrote:
> At several places pmd pointer is retrieved through the same action:
> 
> 	pmd = pmd_offset(pud_offset(pgd_offset(mm, addr), addr), addr);
> 
> or
> 
> 	pmd = pmd_offset(pud_offset(pgd_offset_k(addr), addr), addr);
> 
> Refactor this by implementing two helpers pmd_ptr() and pmd_ptr_k()
> 
> This will help when adding the p4d level.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0b1c524caaae2428b20e714297243e5551251eb5

cheers
