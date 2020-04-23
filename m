Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1C9C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FB721569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587626181;
	bh=O6o2Of0DFp28XhgDfxDM7sJ9hlhjy+9H4psZjTSSZ7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xWzkeW+JQW2m7Ekysi4rxpoF5QO6LSE3/mdNi7GjVphnqRbl92vudLErmNSjp2bsw
	 DmtE4H1wEGmpRk2O4jrAHLUmi9gXR8MweqzzooY18rhf5aTFmn1gk/11a+3wsUUosN
	 mI01MI9rFToZzJVkRQvcE4WEhdYPphJeytAtzP78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgDWHQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgDWHQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:16:20 -0400
Received: from localhost (unknown [49.207.59.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7AA920736;
        Thu, 23 Apr 2020 07:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587626180;
        bh=O6o2Of0DFp28XhgDfxDM7sJ9hlhjy+9H4psZjTSSZ7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RWv06fzlQAg4U4Y+AI8+/q4CLOySNMXHjJLdpaT24QQr43mWKYrQ2yalljRts6Pgb
         LOjL0Ty2eW5YurqXr8zFsb3io5wI8gstJfiTO5F24wxn1lQZZn+p5lYLQSRH9Qrm0F
         OgmgP86UuQxBFa4qj8chFFAHwdCjpHUxfBlK1gmc=
Date:   Thu, 23 Apr 2020 12:46:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] dmaengine: mmp_tdma: Fill in slave capabilities
Message-ID: <20200423071616.GB72691@vkoul-mobl>
References: <20200419164912.670973-1-lkundrak@v3.sk>
 <20200419164912.670973-7-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419164912.670973-7-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-04-20, 18:49, Lubomir Rintel wrote:
> This makes dma_get_slave_caps() work with the device so that it could
> actually be used with soc-generic-dmaengine-pcm.

Applied, thanks

-- 
~Vinod
