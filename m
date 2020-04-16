Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACB8C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CEE2206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635572AbgDPMXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:23:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39508 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635285AbgDPMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:22:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 7E5B226040B
Message-ID: <d33aef355623a5abd6eec176d33a167c456ed915.camel@collabora.com>
Subject: Re: [PATCH 0/4] media: rockchip: rga: PX30 support and YUV2YUV fix
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jacob Chen <jacob-chen@iotwrt.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hansverk@cisco.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Thu, 16 Apr 2020 09:22:41 -0300
In-Reply-To: <20200416115047.233720-1-paul.kocialkowski@bootlin.com>
References: <20200416115047.233720-1-paul.kocialkowski@bootlin.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thanks for the patch.

On Thu, 2020-04-16 at 13:50 +0200, Paul Kocialkowski wrote:
> Hi,
> 
> This series adds support for the Rockchip PX30 SoC in the V4L2 M2M RGA driver.
> It also contains a fix for the YUV2YUV case that was not properly handled.
> 

How have you been testing this?

Thanks,
Ezequiel

> Cheers,
> 
> Paul
> 
> Paul Kocialkowski (4):
>   dt-bindings: rockchip-rga: Add PX30 compatible
>   arm64: dts: rockchip: Add RGA support to the PX30
>   media: rockchip: rga: Add support for the PX30 compatible
>   media: rockchip: rga: Only set output CSC mode for RGB input
> 
>  .../devicetree/bindings/media/rockchip-rga.txt |  1 +
>  arch/arm64/boot/dts/rockchip/px30.dtsi         | 11 +++++++++++
>  drivers/media/platform/rockchip/rga/rga-hw.c   | 18 +++++++++++-------
>  drivers/media/platform/rockchip/rga/rga.c      |  4 +++-
>  4 files changed, 26 insertions(+), 8 deletions(-)
> 


