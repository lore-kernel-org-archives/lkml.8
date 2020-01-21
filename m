Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2BCC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30CB24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579598589;
	bh=wZZNyw6+oSP85Yme6UFz+brQhhEAm7nf6YggeNNFXbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=liJsa2kj9XVBoVDr5fkCwPi9KBHDisFlP4c7IN1bhK5FOZP2UdWjaPqNmxGzJAtrK
	 PVTg3Z3OTatHx1VMQND77OLDk0XE4W+NpGmBJo2qFv/e5TfZLp2pvsKSKmr35sQnR1
	 DFFBc2qMsqam9Xgv7CMvcQjCNBXxtDaLSNWcorvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgAUJXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:23:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUJXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:23:08 -0500
Received: from localhost (unknown [171.76.119.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E467222522;
        Tue, 21 Jan 2020 09:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579598587;
        bh=wZZNyw6+oSP85Yme6UFz+brQhhEAm7nf6YggeNNFXbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hD0mrIThL3GK+lN3Da5Lcqodqf9BQLQ723AJxKcFmJbqXTzxWFURHsvF2cR2CemS7
         6G1Ngi1Mf3iubDjp8y2elwS0n5J11S9qQpivGpUf6ivaRDb2Wym53Jhi/h2TWc3fYC
         jrnVKBluZKmM0HCSNA4GF7f0djMZCzeMNn1w1uDU=
Date:   Tue, 21 Jan 2020 14:53:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Porter <mporter@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dmaengine: Miscellaneous cleanups
Message-ID: <20200121092303.GI2841@vkoul-mobl>
References: <20200117152933.31175-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117152933.31175-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-01-20, 16:29, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series contains a few miscellaneous cleanups for the DMA
> engine code and API.

This looks good, thanks for the cleanup. But it fails to apply, can you
please rebase and resend

Thanks
-- 
~Vinod
