Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35917C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2C7206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592325072;
	bh=7t8RgxP0ueHPPX3r70Fomz/wi4nDyTMGz6KPZu6e7eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0wQ/DHbecLpQX8Xp7d6YAenszUti6b4C+Ow1y57KXgb9zPXnV3/PNDRoFNjvl7yhB
	 FLGQ94xa2m/aBmdZL7S21n6zN0M/P6efhDSsgPkkc/TOyBVNcGqS3uWX3Wlq1Jb8tm
	 +qxth1Bwn8kr9Rgqc1nPnK6oofcjM03CuyRhIl8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbgFPQbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729167AbgFPQbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:31:08 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECDF62067B;
        Tue, 16 Jun 2020 16:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592325067;
        bh=7t8RgxP0ueHPPX3r70Fomz/wi4nDyTMGz6KPZu6e7eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1nbFoW4qUXuUvgY6MBgopgG40XyU9Vx7Xser4qkz7ICtuEtO3KQZ7lxRhG1+tqNzd
         IzuwvPosuvCSUBvopfdNVSxZbBtl+JD/WqYBPotTACixjzHofJyAWCMrbneoXyL9vW
         TUEB8J8B+5D5UVAebXmDUS9c1283whOsYIJ9OJsk=
Date:   Tue, 16 Jun 2020 22:01:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] dmaengine: dw-edma: use PCI_IRQ_MSI_TYPES  where
 appropriate
Message-ID: <20200616163104.GN2324254@vkoul-mobl>
References: <20200602092025.31922-1-piotr.stankiewicz@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602092025.31922-1-piotr.stankiewicz@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-06-20, 11:20, Piotr Stankiewicz wrote:
> Seeing as there is shorthand available to use when asking for any type
> of interrupt, or any type of message signalled interrupt, leverage it.

Applied, thanks

-- 
~Vinod
