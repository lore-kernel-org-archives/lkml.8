Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7571CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622CF2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgGAUa6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:30:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49504 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgGAUa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:30:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id DEA832A5718
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Philippe CORNU <philippe.cornu@st.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-imx@nxp.com,
        kernel@collabora.com, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v9 00/11] Genericize DW MIPI DSI bridge and add i.MX 6
 driver
In-Reply-To: <6400388.H4HLtoO0Qf@diego>
References: <20200609174959.955926-1-adrian.ratiu@collabora.com>
 <6400388.H4HLtoO0Qf@diego>
Date:   Wed, 01 Jul 2020 23:32:18 +0300
Message-ID: <87imf7j7sd.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Wed, 01 Jul 2020, Heiko Stübner <heiko@sntech.de> wrote:
> Hi Adrian, 
> 
> Am Dienstag, 9. Juni 2020, 19:49:48 CEST schrieb Adrian Ratiu: 
>> [Re-submitting to cc dri-devel, sorry about the noise]  Hello 
>> all,  v9 cleanly applies on top of latest next-20200609 tree. 
> 
> at least it doesn't apply on top of current drm-misc-next for me 
> which I really don't understand. 
> 
> Like patch 2/11 does 
> 
> @@ -31,6 +31,7 @@ 
>  #include <drm/drm_probe_helper.h> 
> . 
>  #define HWVER_131<----><------><------>0x31333100<---->/* IP 
>  version 1.31 */ 
> +#define HWVER_130<----><------><------>0x31333000<---->/* IP 
> version 1.30 */ . 
>  #define DSI_VERSION<--><------><------>0x00 #define 
>  VERSION<------><------><------><------>GENMASK(31, 8) 
> 
> where the file currently looks like 
> 
> #include <drm/drm_atomic_helper.h> #include <drm/drm_bridge.h> 
> #include <drm/drm_crtc.h> #include <drm/drm_mipi_dsi.h> #include 
> <drm/drm_modes.h> #include <drm/drm_of.h> #include 
> <drm/drm_print.h> 
> 
> #define HWVER_131			0x31333100	/* IP 
> version 1.31 */ 
> 
> #define DSI_VERSION			0x00 #define VERSION 
> GENMASK(31, 8) 
>  
> even in Linux-next 
>  
> So I guess ideally rebase on top of drm-misc-next

I will send a rebase on top of drm-misc-next soon (with the last 
DTS nitpick fixed and the latest acks and reviewed-by tags added).

In the meantime I also found someone within Collabora who has a RK 
with a DSI panel and found a bug (likely clock is not enabled 
early enough to access the cfg registers to get the version for 
regmap).

I'm super happy this is getting tested on RK, thank you!

>
>
> Thanks
> Heiko
