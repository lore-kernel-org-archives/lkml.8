Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7BBC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AA224656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgBSMkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:40:09 -0500
Received: from ozlabs.org ([203.11.71.1]:40673 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbgBSMkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:40:08 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48My3q1XP9z9sSv; Wed, 19 Feb 2020 23:40:06 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9eb425b2e04e0e3006adffea5bf5f227a896f128
In-Reply-To: <a99fc0ad65b87a1ba51cfa3e0e9034ee294c3e07.1582034961.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/entry: Fix a #if which should be a #ifdef in entry_32.S
Message-Id: <48My3q1XP9z9sSv@ozlabs.org>
Date:   Wed, 19 Feb 2020 23:40:06 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-18 at 14:09:29 UTC, Christophe Leroy wrote:
> Fixes: 12c3f1fd87bf ("powerpc/32s: get rid of CPU_FTR_601 feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/9eb425b2e04e0e3006adffea5bf5f227a896f128

cheers
