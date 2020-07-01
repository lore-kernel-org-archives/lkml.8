Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD8DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4EF20760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593615957;
	bh=eYeQqWGzvCIGM96lU2UmvLU+iTPFUjr0pWA5ecLh5Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aCmgLrujPnRWq7OV5LrQKUddQ2iTh5Rt1R05fTPR/VFgh9SgUC1jEPS5psbOX+5xX
	 Lnrtu/iSmBPJtzonQJKl22CDf/2IkZSaORz9GDWPR0Xh/d0WSpI58d+oKH3TkE6Rri
	 cLlIKkJNOi63NcsqGmXkjwLC5Tyi4Vu1Op5ecqDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbgGAPFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731039AbgGAPFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:05:54 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19FE7206C3;
        Wed,  1 Jul 2020 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593615953;
        bh=eYeQqWGzvCIGM96lU2UmvLU+iTPFUjr0pWA5ecLh5Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NrfFfeEZwoHPLjLeCiy9QEFPl1uu6H55aZuMpTH1Q7rlZpzsriJxiOGqo4GkhoOmR
         ZEM22GOtrqf/RpFKhJd98IlSHq4gI3gMfszNEeUU3XSkQfiAznYmluQ5qzv/GAGRdT
         naCNvGjlPLNCNdW/KKKbPYZpppp5hW0ih/JzyBcs=
Date:   Wed, 1 Jul 2020 20:35:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] phy: zynqmp: Fix unused-function compiler warning
Message-ID: <20200701150550.GD2599@vkoul-mobl>
References: <20200701090438.21224-1-tklauser@distanz.ch>
 <20200701141017.26931-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701141017.26931-1-tklauser@distanz.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-07-20, 16:10, Tobias Klauser wrote:
> Mark xpsgtr_suspend and xpsgtr_resume as __maybe_unused to fix the
> following compiler warning when building with !CONFIG_PM_SLEEP:
> 
> drivers/phy/xilinx/phy-zynqmp.c:830:12: warning: ‘xpsgtr_resume’ defined but not used [-Wunused-function]
>   830 | static int xpsgtr_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~
> drivers/phy/xilinx/phy-zynqmp.c:819:12: warning: ‘xpsgtr_suspend’ defined but not used [-Wunused-function]
>   819 | static int xpsgtr_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~
> 
> Also drop the existing #ifdef CONFIG_PM so the functions are always
> compile-checked regardless of CONFIG_PM and/or CONFIG_PM_SLEEP being
> set.

Applied, thanks

-- 
~Vinod
