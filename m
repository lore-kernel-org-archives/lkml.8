Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB510C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C918320814
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgFIF7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:59:39 -0400
Received: from ozlabs.org ([203.11.71.1]:37297 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbgFIF7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:59:38 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49gzwT05fTz9sTG; Tue,  9 Jun 2020 15:59:36 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2f62870ca5bc9d305f3c212192320c29e9dbdc54
In-Reply-To: <20200502115949.139000-1-christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        tglx@linutronix.de, maddy@linux.vnet.ibm.com,
        cclaudio@linux.ibm.com, zhangshaokun@hisilicon.com,
        atrajeev@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
        ego@linux.vnet.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/powernv: Fix a warning message
Message-Id: <49gzwT05fTz9sTG@ozlabs.org>
Date:   Tue,  9 Jun 2020 15:59:36 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-05-02 at 11:59:49 UTC, Christophe JAILLET wrote:
> Fix a cut'n'paste error in a warning message. This should be
> 'cpu-idle-state-residency-ns' to match the property searched in the
> previous 'of_property_read_u32_array()'
> 
> Fixes: 9c7b185ab2fe ("powernv/cpuidle: Parse dt idle properties into global structure")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2f62870ca5bc9d305f3c212192320c29e9dbdc54

cheers
