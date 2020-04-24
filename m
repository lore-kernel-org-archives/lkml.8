Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF3DC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776C320767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587708195;
	bh=KBNrECEkhgCDEuNC/Tl+VNF5jQTy5NLVMWOVNHGuQMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Web53VR8gOkq60u1yArWMSU801XfPsh30vzB3Gf87idJmzFxYnQ3JN2CHp2aSePBg
	 6DFPiOkNQKuUzc9j8VCgiL7D8hjX1wmINAxwkz/k2N8lUig9P0USB0Suivw0JFa9QL
	 Lp+XR4bFhp3KcN/wA6Xf7b0nPT71oRTCJIi6EKLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgDXGDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 02:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgDXGDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 02:03:14 -0400
Received: from localhost (unknown [117.99.83.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D5B520767;
        Fri, 24 Apr 2020 06:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587708194;
        bh=KBNrECEkhgCDEuNC/Tl+VNF5jQTy5NLVMWOVNHGuQMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jo3zZ/eHdd4gZDErWJwc0tiyVmfAeeOn26iJVNWZCNtVo2wuyzyZE3MpVAjzNvSA0
         HQydII3YaWMPCA8drodClYA//GRIXqlvO54Qb+cFBM0fNbanYknb5ckf3Ke2K5XEik
         GlaVtAlPE9fh3AKryYv/gvTXb+cqjKzmuDpqOcic=
Date:   Fri, 24 Apr 2020 11:33:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Vinod Koul as Generic PHY co-maintainer
Message-ID: <20200424060309.GN72691@vkoul-mobl>
References: <20200424055638.834-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424055638.834-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-04-20, 11:26, Kishon Vijay Abraham I wrote:
> Add Vinod Koul as Generic PHY Subsystem co-maintainer.

Thanks Kishon, Glad to help.

Acked-By: Vinod Koul <vkoul@kernel.org>

> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ffcd023d1cba..d61a51b05f17 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7116,6 +7116,7 @@ F:	include/uapi/asm-generic/
>  
>  GENERIC PHY FRAMEWORK
>  M:	Kishon Vijay Abraham I <kishon@ti.com>
> +M:	Vinod Koul <vkoul@kernel.org>
>  L:	linux-kernel@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git
> -- 
> 2.17.1

-- 
~Vinod
