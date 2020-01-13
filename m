Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4BFC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411B12081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgAMRdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:33:02 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:44092 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgAMRdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:33:01 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 183C52009B;
        Mon, 13 Jan 2020 18:33:00 +0100 (CET)
Date:   Mon, 13 Jan 2020 18:32:58 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: panel-simple: Add compatible for
 Frida FRD350H54004 LCD
Message-ID: <20200113173258.GB20743@ravnborg.org>
References: <20200113161741.32061-1-paul@crapouillou.net>
 <20200113161741.32061-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113161741.32061-2-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=x7rxvukQcr2PK0DXAjAA:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=pHzHmUro8NiASowvMSCR:22 a=6VlIyEUom7LUIeUMNQJH:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Mon, Jan 13, 2020 at 01:17:40PM -0300, Paul Cercueil wrote:
> Add bindings documentation for the Frida 3.5" (320x240 pixels) 24-bit
> TFT LCD panel.
> 
> v2: Switch documentation from plain text to YAML
> v3: Simply add new compatible to panel-simple.yaml file instead of
>     adding new file
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Thanks, applied to drm-misc-next.

	Sam

> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 8fe60ee2531c..4a8064e31793 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -37,6 +37,8 @@ properties:
>        - auo,b116xa01
>          # BOE NV140FHM-N49 14.0" FHD a-Si FT panel
>        - boe,nv140fhmn49
> +        # Frida FRD350H54004 3.5" QVGA TFT LCD panel
> +      - frida,frd350h54004
>          # GiantPlus GPM940B0 3.0" QVGA TFT LCD panel
>        - giantplus,gpm940b0
>          # Satoz SAT050AT40H12R2 5.0" WVGA TFT LCD panel
> -- 
> 2.24.1
