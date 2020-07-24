Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5211BC433FC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 328AC2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgGXNZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgGXNZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:25:20 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38D3C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:25:20 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BCqgt2CHWz9sV7; Fri, 24 Jul 2020 23:25:14 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     npiggin@gmail.com, ego@linux.vnet.ibm.com,
        pratik.r.sampat@gmail.com,
        Pratik Rajesh Sampat <psampat@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, paulus@samba.org,
        benh@kernel.crashing.org, svaidy@linux.ibm.com,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au
In-Reply-To: <20200721153708.89057-1-psampat@linux.ibm.com>
References: <20200721153708.89057-1-psampat@linux.ibm.com>
Subject: Re: [PATCH v4 0/3] powernv/idle: Power9 idle cleanup
Message-Id: <159559697373.1657499.7241293049572955828.b4-ty@ellerman.id.au>
Date:   Fri, 24 Jul 2020 23:25:14 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 21:07:05 +0530, Pratik Rajesh Sampat wrote:
> v3: https://lkml.org/lkml/2020/7/17/1093
> Changelog v3-->v4:
> Based on comments from Nicholas Piggin and Gautham Shenoy,
> 1. Changed the naming of pnv_first_spr_loss_level from
> pnv_first_fullstate_loss_level to deep_spr_loss_state
> 2. Make the P9 PVR check only on the top level function
> pnv_probe_idle_states and let the rest of the checks be DT based because
> it is faster to do so
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/powernv/idle: Replace CPU feature check with PVR check
      https://git.kernel.org/powerpc/c/8747bf36f312356f8a295a0c39ff092d65ce75ae
[2/3] powerpc/powernv/idle: Rename pnv_first_spr_loss_level variable
      https://git.kernel.org/powerpc/c/dcbbfa6b05daca94ebcdbce80a7cf05c717d2942
[3/3] powerpc/powernv/idle: Exclude mfspr on HID1, 4, 5 on P9 and above
      https://git.kernel.org/powerpc/c/5c92fb1b46102e1efe0eed69e743f711bc1c7d2e

cheers
