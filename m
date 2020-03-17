Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B50C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9788220754
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgCQNOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:14:54 -0400
Received: from ozlabs.org ([203.11.71.1]:36657 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgCQNOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:14:53 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48hYYQ3LhHz9sSX; Wed, 18 Mar 2020 00:14:50 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: cc6f0e39000900e5dd1448103a9571f0eccd7d4e
In-Reply-To: <b1177cdfc6af74a3e277bba5d9e708c4b3315ebe.1583575707.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ndesaulniers@google.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: Fix missing NULL pmd check in virt_to_kpte()
Message-Id: <48hYYQ3LhHz9sSX@ozlabs.org>
Date:   Wed, 18 Mar 2020 00:14:50 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-03-07 at 10:09:15 UTC, Christophe Leroy wrote:
> Commit 2efc7c085f05 ("powerpc/32: drop get_pteptr()"),
> replaced get_pteptr() by virt_to_kpte(). But virt_to_kpte() lacks a
> NULL pmd check and returns an invalid non NULL pointer when there
> is no page table.
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Fixes: 2efc7c085f05 ("powerpc/32: drop get_pteptr()")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cc6f0e39000900e5dd1448103a9571f0eccd7d4e

cheers
