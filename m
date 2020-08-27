Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C157AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B23320786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgH0Hq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:46:56 -0400
Received: from ozlabs.org ([203.11.71.1]:48159 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgH0Hqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:46:55 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BcZYn4Gh6z9sTj; Thu, 27 Aug 2020 17:46:53 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc:     daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, b.zolnierkie@samsung.com,
        sam@ravnborg.org, linux-fbdev@vger.kernel.org
In-Reply-To: <20200821104910.3363818-1-mpe@ellerman.id.au>
References: <20200821104910.3363818-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] video: fbdev: controlfb: Fix build for COMPILE_TEST=y && PPC_PMAC=n
Message-Id: <159851436069.52163.17558243673000868151.b4-ty@ellerman.id.au>
Date:   Thu, 27 Aug 2020 17:46:53 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 20:49:10 +1000, Michael Ellerman wrote:
> The build is currently broken, if COMPILE_TEST=y and PPC_PMAC=n:
> 
>   linux/drivers/video/fbdev/controlfb.c: In function ‘control_set_hardware’:
>   linux/drivers/video/fbdev/controlfb.c:276:2: error: implicit declaration of function ‘btext_update_display’
>     276 |  btext_update_display(p->frame_buffer_phys + CTRLFB_OFF,
>         |  ^~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to powerpc/fixes.

[1/1] video: fbdev: controlfb: Fix build for COMPILE_TEST=y && PPC_PMAC=n
      https://git.kernel.org/powerpc/c/4d618b9f3fcab84e9ec28c180de46fb2c929d096

cheers
