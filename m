Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323F6C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C20A207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgA2FR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:17:27 -0500
Received: from ozlabs.org ([203.11.71.1]:45201 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgA2FR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:26 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDj1nHjz9sS3; Wed, 29 Jan 2020 16:17:25 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 991d656d722dbc783481f408d6e4cbcce2e8bb78
In-Reply-To: <45f4f414bcd7198b0755cf4287ff216fbfc24b9d.1574774187.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/8xx: Fix permanently mapped IMMR region.
Message-Id: <486sDj1nHjz9sS3@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:25 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-26 at 13:16:50 UTC, Christophe Leroy wrote:
> When not using large TLBs, the IMMR region is still
> mapped as a whole block in the FIXMAP area.
> 
> Properly report that the IMMR region is block-mapped even
> when not using large TLBs.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/991d656d722dbc783481f408d6e4cbcce2e8bb78

cheers
