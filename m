Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561AFC4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3648C21582
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588577960;
	bh=oDKCJU2obIh3Cj8bmL05TD+Z+nupQK0pG1qBoRHHc64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rFO1lMlo5tz6qP95flIxwI3u+xkpK+y+S2wuzYf3DkXPeavs7PyXR/RCPboq6bJMw
	 o9JxI2zhXaDvlu74z1g8WU3FsRDtYtJt+YZMYSR3/JT8qgM5Pw62b8tISGsN1QDgdA
	 D2pK23oMoQaY1as9b+IWpLJ/aYSXmPMeZT/qkDEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgEDHjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 03:39:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgEDHjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 03:39:19 -0400
Received: from localhost (unknown [171.76.84.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C6AF20735;
        Mon,  4 May 2020 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588577958;
        bh=oDKCJU2obIh3Cj8bmL05TD+Z+nupQK0pG1qBoRHHc64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RpbDvU/gftGBUe4r7c2p3M87nbI0TDTblYhyaH0GKMl6e+Fkf9dQHjn/7+mRaDjuw
         Wmybhe4YDgFWH26DIEWX4BssYHr8tu96+zByK+bDuh1yCLesZ9kcauVbaA2jz/ALSV
         DlmKDanUlqbhKglqqzLn1/r5zInHnsUQSO0iLleQ=
Date:   Mon, 4 May 2020 13:09:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH v7 3/3] ARM: dts: qcom: ipq4019: add USB devicetree nodes
Message-ID: <20200504073914.GQ1375924@vkoul-mobl>
References: <20200503201823.531757-1-robert.marko@sartura.hr>
 <20200503201823.531757-3-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503201823.531757-3-robert.marko@sartura.hr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-05-20, 22:18, Robert Marko wrote:
> From: John Crispin <john@phrozen.org>
> 
> Since we now have driver for the USB PHY, lets add the necessary nodes to DTSI.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

Bjorn, I have picked the phy and dt binding, feel free to apply this one

Thanks
-- 
~Vinod
