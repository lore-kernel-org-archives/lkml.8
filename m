Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8C1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1AB5206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591998935;
	bh=TwFDJ9OTJGXyGJZORxhiZic17q3ShKFikP08rHwk4iM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HKGrOtE22td18ISs+0PtE2LbJsJ10TIH2i5WP9nfDet7bIyyAOzNt6lqS4YGD0Unv
	 VZuLHXBQTit/Bc4rm9c0LkRQwWsGJRReF3xPg2gcGxX6Lui21KUDVMYkKi30nFMID1
	 UmF4yQA4fR9Cnkyxcskd29opNPB+Wd0duh6ku0ho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgFLVzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 17:55:33 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42236 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFLVz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 17:55:27 -0400
Received: by mail-io1-f67.google.com with SMTP id x189so2761937iof.9;
        Fri, 12 Jun 2020 14:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zeSbj81vVnxS9NXhKFb49ek1Y7R+SLP12ZGaeIEM7FU=;
        b=sUIzjAKY/TCUNn5MBCnBBfEKejBeZOWOrOcvaBuDEongT0hUyY5fuzi352giJ1tdeX
         PEUdqf7HovE90SFMuF2OwY/wI83HddKnng+jxULvu6qm95X9wy772LmC7fl64aGuCOF/
         ZmpGzRfbKq3SQjG6Qnl6qyRw3Lo2SruNF6B3rgtLaM95jFTff/Y1+hQdXiTI+XxpcFaY
         rQKfuIsOG1ban4EteA8006pFCSbkJAxd/FANIaA3+zQLPkwibTwAzterJ8CL8g9vnWpp
         fAffXPgjzZ2fciyfK/t1/2fZK4Lk+7DvEHpsAI7PZr5pTuq6t6AhHUaflZitfiQjvtLz
         zeFw==
X-Gm-Message-State: AOAM530UVEa/Ln1NNWtuz3Zqn2ha4Sy3aI0HL6RBEUFLHMZ6p0xF5+6l
        fBXgSfRx0VRfm+ObPSJrfw==
X-Google-Smtp-Source: ABdhPJxHabdY5JdKROrKpr08zxF3Ux2W47mrJIq4u461tlw37JjLxpZP72odON2nr5lHup0MB5NI8Q==
X-Received: by 2002:a02:c9c5:: with SMTP id c5mr10251999jap.5.1591998924878;
        Fri, 12 Jun 2020 14:55:24 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l3sm3845591iow.55.2020.06.12.14.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 14:55:24 -0700 (PDT)
Received: (nullmailer pid 3882057 invoked by uid 1000);
        Fri, 12 Jun 2020 21:55:22 -0000
Date:   Fri, 12 Jun 2020 15:55:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     tsbogend@alpha.franken.de, hauke@hauke-m.de,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        jonas.gorski@gmail.com, zajec5@gmail.com,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com
Subject: Re: [PATCH v3 1/9] dt-bindings: soc: brcm: add BCM63xx power domain
 binding
Message-ID: <20200612215522.GA3881384@bogus>
References: <20200610163301.461160-1-noltari@gmail.com>
 <20200610171630.465579-1-noltari@gmail.com>
 <20200610171630.465579-2-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200610171630.465579-2-noltari@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 19:16:22 +0200, Álvaro Fernández Rojas wrote:
> BCM6318, BCM6328, BCM6362 and BCM63268 SoCs have a power domain controller
> to enable/disable certain components in order to save power.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  v3: fix reg maxItems and quote #power-domain-cells.
>  v2: Add separate YAML file.
> 
>  .../bindings/soc/bcm/brcm,bcm63xx-power.yaml  | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm63xx-power.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/soc/bcm/brcm,bcm63xx-power.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/soc/bcm/brcm,bcm63xx-power.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/bcm/brcm,bcm63xx-power.example.dt.yaml: power-controller@10001848: reg: [[268441672, 4]] is too short


See https://patchwork.ozlabs.org/patch/1307099

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

