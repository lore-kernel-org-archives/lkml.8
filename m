Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD211C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBCC2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgGPM4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:56:15 -0400
Received: from ozlabs.org ([203.11.71.1]:34619 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728652AbgGPM4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:56:10 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vPx4Cy7z9sTg; Thu, 16 Jul 2020 22:56:05 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org, Nayna Jain <nayna@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Daniel Axtens <dja@axtens.net>
In-Reply-To: <1594813921-12425-1-git-send-email-nayna@linux.ibm.com>
References: <1594813921-12425-1-git-send-email-nayna@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc/pseries: detect secure and trusted boot state of the system.
Message-Id: <159490401795.3805857.12377577444442862197.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:56:05 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 07:52:01 -0400, Nayna Jain wrote:
> The device-tree property to check secure and trusted boot state is
> different for guests(pseries) compared to baremetal(powernv).
> 
> This patch updates the existing is_ppc_secureboot_enabled() and
> is_ppc_trustedboot_enabled() functions to add support for pseries.
> 
> The secureboot and trustedboot state are exposed via device-tree property:
> /proc/device-tree/ibm,secure-boot and /proc/device-tree/ibm,trusted-boot
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries: Detect secure and trusted boot state of the system.
      https://git.kernel.org/powerpc/c/61f879d97ce4510dd29d676a20d67692e3b34806

cheers
