Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C20C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA5920780
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593469816;
	bh=O+5/632VmkMlqnpdl0jutUizUbyPJrK/xc+bhIzMP5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C8TS5cUFmpK8biQTyJhZs1St/uPHSPatvaBE8kBlGMDfosKaD2Z3puC3+GzVX0zeR
	 Mt9iYJsU9i8dlWDkbw4j030QAjQKOTWKM6cr7h4EqeAQkRiu5dWWmy4eBxCNaWaNiN
	 Lq0IFrE00pJZQSSoENc/hjo/Q3lmcHtZ8Bldpt5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgF2WaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:30:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42832 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgF2WaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:30:14 -0400
Received: by mail-io1-f65.google.com with SMTP id c16so18933166ioi.9;
        Mon, 29 Jun 2020 15:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aGmQNEbF1Z1L1phYaSvVlsTnm5BPf7k4yHvjYUm7EmA=;
        b=QFCSmxbD1AFNB8e12QdRIMIaOlWF3vVF/rHRcRmxdzBU9kJbIyIFHFkY1PqESuHAyT
         kf5bnh5Hf+UlpZRn0AqCiZhaC+lxVlF7Re+d1UaowkxRPCTlKn3YfOPob4zi2XB/q1kR
         MEq2CMXB2eZjJ3ugzfcbi2LW3qEyh941HxJej8p6THYY/9cfznJX8e2Ll3VX09ZhXqaz
         Fi0yh1XVZKS6F7CZo+mWklVOqjgswJtTT1vdUs5RL9EdF0Fmyyhxy8yaLr9g0iE7IpE7
         5Zq8ag9T83KIvHiA/F6r3W4r7qYh2v0i3oN8WKpoWwUK122LRnTgzp0+lA6eC5HxFnNC
         M+iw==
X-Gm-Message-State: AOAM533eYNXa69ombeL4d2s6h4RwoW4AlWIM8xIIuRpn5Drilc1bQTDX
        kL+Vby7AyRUnC1sfyeat0HzHaMxwtA==
X-Google-Smtp-Source: ABdhPJyVNbvX17VhfX0EFlfpZLx+W/pn+BWFrDM6q+CHhAkYhKFVPGebNlEHbcPwRZOyWWP0JNqCOw==
X-Received: by 2002:a6b:ee02:: with SMTP id i2mr2855447ioh.110.1593469813356;
        Mon, 29 Jun 2020 15:30:13 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id x16sm540604iob.35.2020.06.29.15.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 15:30:12 -0700 (PDT)
Received: (nullmailer pid 3075349 invoked by uid 1000);
        Mon, 29 Jun 2020 22:30:11 -0000
Date:   Mon, 29 Jun 2020 16:30:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/3] dt-bindings: phy: Add DT bindings for Xilinx
 ZynqMP PSGTR PHY
Message-ID: <20200629223011.GA3074548@bogus>
References: <20200629120054.29338-1-laurent.pinchart@ideasonboard.com>
 <20200629120054.29338-2-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629120054.29338-2-laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 15:00:52 +0300, Laurent Pinchart wrote:
> From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> 
> Add DT bindings for the Xilinx ZynqMP PHY. ZynqMP SoCs have a High Speed
> Processing System Gigabit Transceiver which provides PHY capabilities to
> USB, SATA, PCIE, Display Port and Ehernet SGMII controllers.
> 
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v8:
> 
> - Rebase on phy/next
> 
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


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.example.dt.yaml: example-0: phy@fd400000:reg:0: [0, 4248829952, 0, 262144] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.example.dt.yaml: example-0: phy@fd400000:reg:1: [0, 4248633344, 0, 4096] is too long


See https://patchwork.ozlabs.org/patch/1319269

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

