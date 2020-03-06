Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ECFC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1DF20705
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgCFA1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 19:27:49 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:50125 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgCFA1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:27:44 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48YT3M1TFtz9sSZ; Fri,  6 Mar 2020 11:27:43 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 030e347430957f6f7f29db9099368f8b86c0bf76
In-Reply-To: <b30b2eae6960502eaf0d9e36c60820b839693c33.1580542939.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/32s: Don't flush all TLBs when flushing one page
Message-Id: <48YT3M1TFtz9sSZ@ozlabs.org>
Date:   Fri,  6 Mar 2020 11:27:43 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-02-01 at 08:04:31 UTC, Christophe Leroy wrote:
> When flushing any memory range, the flushing function
> flushes all TLBs.
> 
> When (start) and (end - 1) are in the same memory page,
> flush that page instead.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/030e347430957f6f7f29db9099368f8b86c0bf76

cheers
