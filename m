Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC49C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F5120CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgA2FRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:17:22 -0500
Received: from ozlabs.org ([203.11.71.1]:45713 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgA2FRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:22 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDc4NdMz9sPW; Wed, 29 Jan 2020 16:17:20 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6a3163212f311daaf2ca3b676db2e11cfd81c6b3
In-Reply-To: <156219139988.578018.1046848908285019838.stgit@bahia.lan>
To:     Greg Kurz <groug@kaod.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     trivial@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: XIVE: Fix typo in comment
Message-Id: <486sDc4NdMz9sPW@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:20 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-03 at 22:03:19 UTC, Greg Kurz wrote:
> Cc: trivial@kernel.org
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6a3163212f311daaf2ca3b676db2e11cfd81c6b3

cheers
