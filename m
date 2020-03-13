Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FFEC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888A42074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584136807;
	bh=9+o01eEyRF/r+Y6iAFd3ZfoNfxNgGfiwA87JE+Vw5D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ntcl5+Zv/7VPnxOqVrWj+wkselAIRBw11E14f4haoVzupkCX51XZt17+0ZRkp5zU9
	 JBX73KpNVWv0kfPQ3RnaqlCA1NoOQcU2jpxhqvRqQIfPug20pm4DqWR26TnjwuRxiQ
	 QrDqOYXMptwgISy/STSdFBbxFwDPXcAo2HVTzALs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgCMWAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 18:00:06 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:41493 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgCMWAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 18:00:06 -0400
Received: by mail-oi1-f172.google.com with SMTP id i1so11064741oie.8;
        Fri, 13 Mar 2020 15:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TVkybssqDWjwLerq8jhj8SF+k5jpdyCgdrT+O+aW7Hk=;
        b=bxxK84ZqQLqozYBkr8gGWuoJiA/6veN5kh8FbWE8vFkMXXCqc9Hy/3gbC/nRPZt/Xa
         JkEZTVQC+AMOQTJRVHTX/cFBpuxo3F25OvWR5xwIGkVNu5xV4L99ZE4JGDQShBjcdlaj
         h3JAETc2CNa6zzTDefkbySGIB6hU6Z8QxpYkTsgRyseM6Nhzf7W0hHbGXINyecnC8NJw
         nbfy0Emjt79r6IdQjYW1a/RjWrO30IutiBYGvksraNxxkcxfNIQIU5Y1Rg0ouJKWr7m4
         /SfBmRNl+eFrjVow6Lg8mSlY+TWQuMFbyu8oPGlnE9uSFDSVe4TOSXcGAp3ybZvGdMVi
         KbCQ==
X-Gm-Message-State: ANhLgQ320ThGkrakVOyGmwiPDKpBZtslFmMU6n6+8BujLYEbjkS3wpx+
        Nm9MyiNqC/eWxOUmMIo85g==
X-Google-Smtp-Source: ADFU+vvD7pkfAG68OdNj/jO4fB2W3uBtGliVneJu4/Kb/0djYQ6eqwv1N6WfcVv5x9z1WO/Gbr9vpg==
X-Received: by 2002:a54:408d:: with SMTP id i13mr2298979oii.42.1584136804853;
        Fri, 13 Mar 2020 15:00:04 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e22sm20340907ote.32.2020.03.13.15.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 15:00:04 -0700 (PDT)
Received: (nullmailer pid 23358 invoked by uid 1000);
        Fri, 13 Mar 2020 22:00:03 -0000
Date:   Fri, 13 Mar 2020 17:00:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robert Foss <robert.foss@linaro.org>
Subject: Re: [v2 1/3] media: dt-bindings: ov8856: Document YAML bindings
Message-ID: <20200313220003.GA21160@bogus>
References: <20200313110350.10864-1-robert.foss@linaro.org>
 <20200313110350.10864-2-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313110350.10864-2-robert.foss@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 12:03:48 +0100, Robert Foss wrote:
> From: Dongchun Zhu <dongchun.zhu@mediatek.com>
> 
> This patch adds documentation of device tree in YAML schema for the
> OV8856 CMOS image sensor.
> 
> Signed-off-by: Dongchun Zhu <dongchun.zhu@mediatek.com>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
> 
> - Changes since v4:
>   * Fabio: Change reset-gpio to GPIO_ACTIVE_LOW, explain in description
>   * Add clock-lanes property to example
>   * robher: Fix syntax error in devicetree example
> 
> - Changes since v3:
>   * robher: Fix syntax error
>   * robher: Removed maxItems
>   * Fixes yaml 'make dt-binding-check' errors
> 
> - Changes since v2:
>   Fixes comments from from Andy, Tomasz, Sakari, Rob.
>   * Convert text documentation to YAML schema.
> 
> - Changes since v1:
>   Fixes comments from Sakari, Tomasz
>   * Add clock-frequency and link-frequencies in DT
> 
>  .../devicetree/bindings/media/i2c/ov8856.yaml | 133 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ov8856.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/media/i2c/ov8856.example.dts:22.13-26: Warning (reg_format): /example-0/camera-sensor@10:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/media/i2c/ov8856.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/media/i2c/ov8856.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/media/i2c/ov8856.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'

See https://patchwork.ozlabs.org/patch/1254346
Please check and re-submit.
