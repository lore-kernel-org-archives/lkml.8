Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0F0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28BE32068D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590517925;
	bh=n281IfLAcbTb85CPm0jqUkyIWkLnfrct5htszXNofyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C8GdhbjJ0WmetikzzFstq1ldKZ8l+0LPFJUpaOARfEAGNC7CiWbnCavosiKDstwdX
	 c1SDK65oEvkT23qzgtbZ6yHvRiEmacFsNFY0S8HoW9/tzL9rYDyp6RJc9vict/w/nJ
	 7Rslp4WQyp1Msd57EXO630G7HBvTGrRpzd0sOiL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgEZScE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:32:04 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41682 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbgEZScE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:32:04 -0400
Received: by mail-il1-f194.google.com with SMTP id b71so21490862ilg.8;
        Tue, 26 May 2020 11:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ys3yTN0+ac2nWV6kQ76kCGllrYqouXUa6sUx/6wOfQY=;
        b=lnnf5hFzNB9mmXIPcS/jXV+Wb+0opq/TFSC5gnJr5xKIYn7qXOqXe9gMrbQEpGHklM
         XMsL4BbXo0GxQW4BY5kQAyajBxVVuVPhs/MTDoiaxbVjoxfMrGdTqErPUS+fwXPtkpuv
         epokcma+O4hJtb0L6maZ9imtbOIqIgzBimzP/vUN4a6166Mj0QJ8PeEgHn0fwCuhIkq6
         qMYfAqO5tjwMk/Z2liqsTs4fkqF6aVpB/jb+49vSFH4pp/UKFwFo9fPRqnX3Vk4dydYY
         NjGlr+kG3+NC4w0BIr5HSCnSLchZUSo8mJMpwNqlsLNIUMEcz1iW2PRTxcKN+yZ6gGaJ
         JXHQ==
X-Gm-Message-State: AOAM532l2sStlqhWhx2nnOxtKf8Bau4b1zWDL4nrAQ0ZmJLQ88Ghula6
        BuYYXkqJ5RSnY0sggw2usT5UCU8=
X-Google-Smtp-Source: ABdhPJz2NnH/oN4bzaqTdkmM0QjsDMmHpgRJNYGOFD8tjeWWgs/oLbkXDGmpwX/yhqi6vu2TeQsv/Q==
X-Received: by 2002:a92:b0d:: with SMTP id b13mr2435731ilf.225.1590517922981;
        Tue, 26 May 2020 11:32:02 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p22sm55193ill.52.2020.05.26.11.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 11:32:02 -0700 (PDT)
Received: (nullmailer pid 135011 invoked by uid 1000);
        Tue, 26 May 2020 18:32:01 -0000
Date:   Tue, 26 May 2020 12:32:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v8 1/3] dt-bindings: phy: Add DT bindings for Xilinx
 ZynqMP PSGTR PHY
Message-ID: <20200526183201.GA134956@bogus>
References: <20200513172239.26444-1-laurent.pinchart@ideasonboard.com>
 <20200513172239.26444-2-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513172239.26444-2-laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 20:22:37 +0300, Laurent Pinchart wrote:
> From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> 
> Add DT bindings for the Xilinx ZynqMP PHY. ZynqMP SoCs have a High Speed
> Processing System Gigabit Transceiver which provides PHY capabilities to
> USB, SATA, PCIE, Display Port and Ehernet SGMII controllers.
> 
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> Changes since v7:
> 
> - Switch to GPL-2.0-only OR BSD-2-Clause
> 
> Changes since v6:
> 
> - Fixed specification of compatible-dependent xlnx,tx-termination-fix
>   property
> - Dropped status property from example
> - Use 4 spaces to indent example
> 
> Changes since v5:
> 
> - Document clocks and clock-names properties
> - Document resets and reset-names properties
> - Replace subnodes with an additional entry in the PHY cells
> - Drop lane frequency PHY cell, replaced by reference clock phandle
> - Convert bindings to YAML
> - Reword the subject line
> - Drop Rob's R-b as the bindings have significantly changed
> - Drop resets and reset-names properties
> ---
>  .../bindings/phy/xlnx,zynqmp-psgtr.yaml       | 105 ++++++++++++++++++
>  include/dt-bindings/phy/phy.h                 |   1 +
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
