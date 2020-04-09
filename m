Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26DEC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45B9206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586473310;
	bh=gyYx5I8mx6DibhuxYp/GXl59wF1qEqBA0m8+nyPiuyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=muYcDKBpPlM1PKjfTOlZbwb/qLf9bSamp17gHPszw8BJivoLOMyLNsi3bYQbdZX6l
	 aOBbNV8FX9scuC/5w+aeS/Z/vSgczKkPprx6dEH8HHXhoQcBuDfpBgdvQQGS+3xiIW
	 hGBTW4Akk8hlZH55K7C63ZJs3hthWyzibB/SN82M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgDIXBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:01:49 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43838 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgDIXBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 19:01:49 -0400
Received: by mail-il1-f195.google.com with SMTP id z12so320729ilb.10;
        Thu, 09 Apr 2020 16:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q7Zpp/CoGVKLdpn/4KBo3lndlt2F9/4wcPUKZ05F4Xk=;
        b=o9fYJLwGyHrw48uzNOv3misCSNukX/KoYjHH5cpCI5M1K7/YGsl9+rtnsEHHMGIHT0
         fZyksPOeABdtV+stBa5wC8lmtZh3psbRXygj8Tia1lNnSxW/ayEBzT+/3IT0mtk/DmHw
         TlM4LCfjnc83bDh81SI4la0eNJcb7x/bZcvl1zn7uHDiOc464r47Bg7fTT7u5sV1JEBT
         a9Yu+btFUkHvK1EXpboPFNwMwqNQWaIayKOFuQIwfn5JYHnWbcLsR3Pyn2r/45ZN1fJF
         OVGhjxwdWmGw58uIPTmvQ7UMORaPnYgVuGU+WB/ay33aH0ELQTcEmDoM8uRnHWxmPqoM
         UuMA==
X-Gm-Message-State: AGi0PubbSga3FNkm/f5rSAT9JRGqSLnvUkUJa4Y4UcJ88NjZ3GWBSewp
        3IfM/R1xgo9Lvo8dYlaiMQ==
X-Google-Smtp-Source: APiQypLtYA6H2vEC2MYLE3ZA2qIw2dOIhyc/2W7XmVLMNJYf2n3Ryze9W89syNbMU3qrPnXjbic96Q==
X-Received: by 2002:a92:2544:: with SMTP id l65mr2487739ill.286.1586473306685;
        Thu, 09 Apr 2020 16:01:46 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c4sm141266ilk.75.2020.04.09.16.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 16:01:46 -0700 (PDT)
Received: (nullmailer pid 13647 invoked by uid 1000);
        Thu, 09 Apr 2020 23:01:43 -0000
Date:   Thu, 9 Apr 2020 17:01:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, Gustavo.Pimentel@synopsys.com,
        Joao.Pinto@synopsys.com,
        Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: display: Add IPK DSI subsystem
 bindings
Message-ID: <20200409230143.GA12884@bogus>
References: <cover.1586174459.git.angelo.ribeiro@synopsys.com>
 <e32fdd83d135da8617ba46d53eb95329589ae07d.1586174459.git.angelo.ribeiro@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e32fdd83d135da8617ba46d53eb95329589ae07d.1586174459.git.angelo.ribeiro@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Apr 2020 15:24:11 +0200, Angelo Ribeiro wrote:
> Add dt-bindings for Synopsys DesignWare MIPI DSI Host and VPG (Video
> Pattern Generator) support in the IPK display subsystem.
> 
> The Synopsys DesignWare IPK display video pipeline is composed by a DSI
> controller (snps,dw-ipk-dsi) and a VPG (snps,dw-ipk-vpg) as DPI
> stimulus. Typically is used the Raspberry Pi
> (raspberrypi,7inch-touchscreen-panel) as DSI panel that requires a
> I2C controller (snps,designware-i2c).
> 
> Reported-by: Rob Herring <robh+dt@kernel.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Joao Pinto <jpinto@synopsys.com>
> Signed-off-by: Angelo Ribeiro <angelo.ribeiro@synopsys.com>
> ---
>  .../bindings/display/snps,dw-ipk-dsi.yaml          | 162 +++++++++++++++++++++
>  .../bindings/display/snps,dw-ipk-vpg.yaml          |  75 ++++++++++
>  2 files changed, 237 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/snps,dw-ipk-vpg.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.example.dts:60.17-30: Warning (reg_format): /example-0/i2c@0x01000/lcd@45:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.example.dts:49.21-68.11: Warning (i2c_bus_bridge): /example-0/i2c@0x01000: incorrect #address-cells for I2C bus
Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.example.dts:49.21-68.11: Warning (i2c_bus_bridge): /example-0/i2c@0x01000: incorrect #size-cells for I2C bus
Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.example.dts:58.20-67.15: Warning (avoid_default_addr_size): /example-0/i2c@0x01000/lcd@45: Relying on default #address-cells value
Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.example.dts:58.20-67.15: Warning (avoid_default_addr_size): /example-0/i2c@0x01000/lcd@45: Relying on default #size-cells value
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/snps,dw-ipk-vpg.example.dt.yaml: example-0: 'dw-dsi-vpg@0x03000' does not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/snps,dw-ipk-vpg.example.dt.yaml: dw-dsi-vpg@0x03000: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.example.dt.yaml: example-0: 'dw-ipk-dsi@0x02000', 'i2c@0x01000' do not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.example.dt.yaml: dw-ipk-dsi@0x02000: clock-names: ['pclk', 'ref'] is too short
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.example.dt.yaml: dw-ipk-dsi@0x02000: 'reset' is a required property

See https://patchwork.ozlabs.org/patch/1266879

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
