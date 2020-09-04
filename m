Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71E8C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 23:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA702151B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 23:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgIDX0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 19:26:36 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34838 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbgIDX02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 19:26:28 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 7745D2ACD4; Fri,  4 Sep 2020 19:26:27 -0400 (EDT)
Message-Id: <cover.1599260540.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 0/5] powerpc/tau: TAU driver fixes
Date:   Sat, 05 Sep 2020 09:02:20 +1000
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes various bugs in the Thermal Assist Unit driver.
It was tested on 266 MHz and 292 MHz PowerBook G3 laptops.


Finn Thain (5):
  powerpc/tau: Use appropriate temperature sample interval
  powerpc/tau: Convert from timer to workqueue
  powerpc/tau: Remove duplicated set_thresholds() call
  powerpc/tau: Check processor type before enabling TAU interrupt
  powerpc/tau: Disable TAU between measurements

 arch/powerpc/include/asm/reg.h |   2 +-
 arch/powerpc/kernel/tau_6xx.c  | 147 +++++++++++++--------------------
 arch/powerpc/platforms/Kconfig |  14 +---
 3 files changed, 62 insertions(+), 101 deletions(-)

-- 
2.26.2

