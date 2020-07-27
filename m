Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504B9C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29AFA2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595841259;
	bh=o5jOp/8zQ9YbOxHw+LsaOEzaSAyW1H9Jsr8CqOR6FzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HjObt4VUwMMUoOWwRN/oC5CKy+xoJfoGaMPzQ32MrtJ2UaKjnkk0VUXvFqsd4dkxo
	 Ks0XZM8LfmucWOuwrCeI8jp3IB7PnxI9n+u1aSlU1MOFEQGPZyEpLNRK9N8xR/nSlV
	 4rxBZjWyLvStxeFnzqYuw4BUbPI2vu8PmRApL8sA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgG0JOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:14:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgG0JOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:14:17 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5166020714;
        Mon, 27 Jul 2020 09:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595841257;
        bh=o5jOp/8zQ9YbOxHw+LsaOEzaSAyW1H9Jsr8CqOR6FzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSNUenWfQbksNx8nHR6QVZ4TJ1iF8At5KwYT6Ku/S1RJ+ktV1EEvsB3EGJ8Po1Yrz
         Xn7/vrLXLj7YX1fqCY48lWyjyfDOJGar2rZMHjCI68fUmdA5lHnB5k9GlvMAezG5om
         c0hK7M0R0HuFxuPS8j+J7QrijIfVjYS1LuPQO33Y=
Date:   Mon, 27 Jul 2020 14:44:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, dan.j.williams@intel.com,
        cristian.ciocaltea@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v7 03/10] dmaengine: Actions: Add support for S700 DMA
 engine
Message-ID: <20200727091413.GR12965@vkoul-mobl>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
 <1595180527-11320-4-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595180527-11320-4-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-20, 23:12, Amit Singh Tomar wrote:
> DMA controller present on S700 SoC is compatible with the one on S900
> (as most of registers are same), but it has different DMA descriptor
> structure where registers "fcnt" and "ctrlb" uses different encoding.
> 
> For instance, on S900 "fcnt" starts at offset 0x0c and uses upper 12
> bits whereas on S700, it starts at offset 0x1c and uses lower 12 bits.
> 
> This commit adds support for DMA controller present on S700.

Applied, thanks

-- 
~Vinod
