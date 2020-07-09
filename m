Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFC7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF5E20720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594325667;
	bh=3yxM1WkZxyTZK/DPo2InIyO4oMakgKt0fDsAZesjXrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zyr/UfO4sWubiubrbIhcqxb1PRl1dyq5wxurDEY+1Df4aKc4VEWtrfzNpFVDQ8j2V
	 qRnsFijIbwZFk/Oqqagb3lJqjmv7a1Ynxjb0piw5GKqZXIDWJVClAMgCjlDY6TroRe
	 2gu1ZgFOMVq8xvQOsrXEBs8LXt+sQ2KKKVBhJ5cU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgGIUOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:14:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36219 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgGIUOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:14:24 -0400
Received: by mail-io1-f66.google.com with SMTP id y2so3698714ioy.3;
        Thu, 09 Jul 2020 13:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vf6z2fNalEK1tmwmLTZC1NF3oFCXxWx2VBCEuDAzzVc=;
        b=QjS9C85gUtTr7Wtm0nmMs3YuK19VN7zWQdTfhQRpXTDJJCNauR2sqi8wI0ZDJL6jD7
         6hYrQn3TBGlIgBpu6iVKCBu5q1gxQvUXffXWW2TPK6zlhW5yZnULuo+SUY8FFoj6sA9Y
         hU0F5wQgPni31ZqPn+iePZ/xcF92C0hbXUCG8Aq96/wFMFiqto4q3MEElBaCWu/kFlLg
         NFxPqBYIdj9vU+LZ8i4wYR6oTw6pwmrAGGMLV0A8EMOftUuC6m8VHWZQvXGefBZD1eP3
         T+doh2panXuf3rTIFI4XN+fyIjDT6m6IN80HRfseuuGO9Sg2VFFui41P3rogqBkKKKM6
         cPhg==
X-Gm-Message-State: AOAM533RDavizKyHcNu50G891NMNXyGDGAijxerldLJhiEETTO12/E+B
        4yFFIrdKgTc8RNoqOEMmVA==
X-Google-Smtp-Source: ABdhPJx+DiJRk5yzkMMoXVl/dkAChhdV7+zltpOTy2w+Wv8CYdmdknLqd02DDMKgnwnhVAiWo4YPRg==
X-Received: by 2002:a02:cc24:: with SMTP id o4mr17435026jap.105.1594325663645;
        Thu, 09 Jul 2020 13:14:23 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id m2sm2206130iln.1.2020.07.09.13.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:14:23 -0700 (PDT)
Received: (nullmailer pid 814596 invoked by uid 1000);
        Thu, 09 Jul 2020 20:14:22 -0000
Date:   Thu, 9 Jul 2020 14:14:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v9 1/5] dt-bindings: arm: fsl: add different Protonic
 boards
Message-ID: <20200709201422.GA814548@bogus>
References: <20200701130330.9089-1-o.rempel@pengutronix.de>
 <20200701130330.9089-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701130330.9089-2-o.rempel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jul 2020 15:03:26 +0200, Oleksij Rempel wrote:
> Add Protonic PRTI6Q, WD2, RVT, VT7 boards.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
