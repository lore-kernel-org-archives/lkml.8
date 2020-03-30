Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387E1C2D0F0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A38C20771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgC3VTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:19:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36766 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgC3VTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:19:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 027AC296467
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rockchip@lists.infradead.org,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, kernel@collabora.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Emil Velikov <emil.velikov@collabora.com>,
        Sjoerd Simons <sjoerd.simons@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH v5 4/5] drm: imx: Add i.MX 6 MIPI DSI host platform driver
In-Reply-To: <CAOMZO5CEZSBfhb9xAdf=sDhUnmSeuWSsnUQArz=a1TPzytLAeQ@mail.gmail.com>
References: <20200330113542.181752-1-adrian.ratiu@collabora.com>
 <20200330113542.181752-5-adrian.ratiu@collabora.com>
 <CAOMZO5CEZSBfhb9xAdf=sDhUnmSeuWSsnUQArz=a1TPzytLAeQ@mail.gmail.com>
Date:   Tue, 31 Mar 2020 00:20:42 +0300
Message-ID: <87a73x35g5.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Adrian, 
> 
> On Mon, Mar 30, 2020 at 8:34 AM Adrian Ratiu 
> <adrian.ratiu@collabora.com> wrote: 
>> 
>> This adds support for the Synopsis DesignWare MIPI DSI v1.01 
>> host controller which is embedded in i.MX 6 SoCs. 
>> 
>> Based on following patches, but updated/extended to work with 
>> existing support found in the kernel: 
>> 
>> - drm: imx: Support Synopsys DesignWare MIPI DSI host 
>> controller 
>>   Signed-off-by: Liu Ying <Ying.Liu@freescale.com> 
>> 
>> - ARM: dtsi: imx6qdl: Add support for MIPI DSI host controller 
>>   Signed-off-by: Liu Ying <Ying.Liu@freescale.com> 
> 
> This one looks like a devicetree patch, but this patch does not 
> touch devicetree. 
> 
>> +       ret = clk_prepare_enable(dsi->pllref_clk); +       if 
>> (ret) { +               dev_err(dev, "%s: Failed to enable 
>> pllref_clk\n", __func__); +               return ret; +       } 
>> + +       dsi->mux_sel = 
>> syscon_regmap_lookup_by_phandle(dev->of_node, "fsl,gpr"); + 
>> if (IS_ERR(dsi->mux_sel)) { +               ret = 
>> PTR_ERR(dsi->mux_sel); +               dev_err(dev, "%s: Failed 
>> to get GPR regmap: %d\n", +                       __func__, 
>> ret); +               return ret; 
> 
> You should disable the dsi->pllref_clk clock prior to returning 
> the error. 
> 
>> +       dsi->mipi_dsi = dw_mipi_dsi_probe(pdev, pdata); + 
>> if (IS_ERR(dsi->mipi_dsi)) { +               ret = 
>> PTR_ERR(dsi->mipi_dsi); +               dev_dbg(dev, "%s: 
>> Unable to probe DW DSI host device: %d\n", + 
>> __func__, ret); +               return -ENODEV; 
> 
> Same here. You should disable the clock. Shouldn't you return 
> 'ret' here instead of -ENODEV? 
> 
>> +module_platform_driver(imx_mipi_dsi_driver); + 
>> +MODULE_DESCRIPTION("i.MX6 MIPI DSI host controller driver"); 
>> +MODULE_AUTHOR("Liu Ying <Ying.Liu@freescale.com>"); 
> 
> The freescale.com domain is no longer functional. 
> 
> Ying Liu's NXP address is victor.liu@nxp.com. You could probably 
> add your entry as well. 

Hi Fabio,

All the issues you pointed out are valid and will be addressed in 
v6 (including the device tree ones).

Thank you, much appreciated,
Adrian
