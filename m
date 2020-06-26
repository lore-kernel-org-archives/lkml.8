Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3B6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EADD20885
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgFZEqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgFZEqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:46:07 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF159C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 21:46:06 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49tPTk46GLz9sT6; Fri, 26 Jun 2020 14:46:01 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Alistair Popple <alistair@popple.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Murilo Opsfelder Araujo <mopsfelder@gmail.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Daniel Axtens <dja@axtens.net>
In-Reply-To: <20200610215114.167544-1-muriloo@linux.ibm.com>
References: <20200610215114.167544-1-muriloo@linux.ibm.com>
Subject: Re: [PATCH 0/3] powerpc/dt_cpu_ftrs: Make use of ISA_V3_* macros
Message-Id: <159314672575.1150869.4769012042408741773.b4-ty@ellerman.id.au>
Date:   Fri, 26 Jun 2020 14:46:01 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 18:51:11 -0300, Murilo Opsfelder Araujo wrote:
> The first patch removes unused macro ISA_V2_07B.  The second and third
> patches make use of macros ISA_V3_0B and ISA_V3_1, respectively,
> instead their corresponding literals.
> 
> Murilo Opsfelder Araujo (3):
>   powerpc/dt_cpu_ftrs: Remove unused macro ISA_V2_07B
>   powerpc/dt_cpu_ftrs: Make use of macro ISA_V3_0B
>   powerpc/dt_cpu_ftrs: Make use of macro ISA_V3_1
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/dt_cpu_ftrs: Remove unused macro ISA_V2_07B
      https://git.kernel.org/powerpc/c/f39eb5d8ac707fd59029a06c3f985f29b1aaa26b
[2/3] powerpc/dt_cpu_ftrs: Make use of macro ISA_V3_0B
      https://git.kernel.org/powerpc/c/e781f12a60a7bddb50909d42478cca8724c8b113
[3/3] powerpc/dt_cpu_ftrs: Make use of macro ISA_V3_1
      https://git.kernel.org/powerpc/c/7714394706c0309b3f3fc474b390463d60eb6cb1

cheers
