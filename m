Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691E1C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B4F92076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgGPM42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:56:28 -0400
Received: from ozlabs.org ([203.11.71.1]:51081 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728777AbgGPM4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:56:23 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vQF6sjHz9sVl; Thu, 16 Jul 2020 22:56:19 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     paulus@samba.org, mpe@ellerman.id.au, groug@kaod.org,
        benh@kernel.crashing.org, YueHaibing <yuehaibing@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200715025040.33952-1-yuehaibing@huawei.com>
References: <20200715025040.33952-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] powerpc/xive: Remove unused inline function xive_kexec_teardown_cpu()
Message-Id: <159490401670.3805857.414808886972366764.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:56:19 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 10:50:40 +0800, YueHaibing wrote:
> commit e27e0a94651e ("powerpc/xive: Remove xive_kexec_teardown_cpu()")
> left behind this, remove it.

Applied to powerpc/next.

[1/1] powerpc/xive: Remove unused inline function xive_kexec_teardown_cpu()
      https://git.kernel.org/powerpc/c/29d9407e1037868b59d12948d42ad3ef58fc3a5a

cheers
