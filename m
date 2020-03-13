Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D67FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CF62074C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgCMXF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:05:29 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:48890 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgCMXF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:05:29 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 4408C20029;
        Sat, 14 Mar 2020 00:05:23 +0100 (CET)
Date:   Sat, 14 Mar 2020 00:05:21 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] dt-bindings: display: ti: Fix dtc unit-address
 warnings in examples
Message-ID: <20200313230521.GA8476@ravnborg.org>
References: <20200313180727.23044-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313180727.23044-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=sozttTNsAAAA:8
        a=VwQbUJbxAAAA:8 a=7gkXJVJtAAAA:8 a=k4r3PqWcPq6Qy1X7_v8A:9
        a=rbD8nFOAu45xlIuL:21 a=UehPyaCQOHXEbEJC:21 a=CjuIK1q_8ugA:10
        a=aeg5Gbbo78KNqacMgKqU:22 a=AjGcO6oz07-iQ99wixmX:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 01:07:27PM -0500, Rob Herring wrote:
> Extra dtc warnings (roughly what W=1 enables) are now enabled by default
> when building the binding examples. These were fixed treewide in
> 5.6-rc5, but some new display bindings have been added with new
> warnings:
> 
> Documentation/devicetree/bindings/display/ti/ti,am65x-dss.example.dts:21.27-49.11: Warning (unit_address_format): /example-0/dss@04a00000: unit name should not have leading 0s
> Documentation/devicetree/bindings/display/ti/ti,j721e-dss.example.dts:21.27-72.11: Warning (unit_address_format): /example-0/dss@04a00000: unit name should not have leading 0s
> Documentation/devicetree/bindings/display/ti/ti,k2g-dss.example.dts:20.27-42.11: Warning (unit_address_format): /example-0/dss@02540000: unit name should not have leading 0s
> 
> Cc: Jyri Sarha <jsarha@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

> ---
> v2:
>  - Drop panel fixes as there's another patch fixing the 3 panels plus
>    others.
Will revisit the panel/ fixes patch and apply tomorrow.

	Sam

> ---
>  Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml | 2 +-
>  Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml | 2 +-
>  Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> index cac61a998203..aa5543a64526 100644
> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> @@ -121,7 +121,7 @@ examples:
>      #include <dt-bindings/interrupt-controller/irq.h>
>      #include <dt-bindings/soc/ti,sci_pm_domain.h>
>  
> -    dss: dss@04a00000 {
> +    dss: dss@4a00000 {
>              compatible = "ti,am65x-dss";
>              reg =   <0x0 0x04a00000 0x0 0x1000>, /* common */
>                      <0x0 0x04a02000 0x0 0x1000>, /* vidl1 */
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
> index ade9b2f513f5..6d47cd7206c2 100644
> --- a/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
> +++ b/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
> @@ -154,7 +154,7 @@ examples:
>      #include <dt-bindings/interrupt-controller/irq.h>
>      #include <dt-bindings/soc/ti,sci_pm_domain.h>
>  
> -    dss: dss@04a00000 {
> +    dss: dss@4a00000 {
>              compatible = "ti,j721e-dss";
>              reg =   <0x00 0x04a00000 0x00 0x10000>, /* common_m */
>                      <0x00 0x04a10000 0x00 0x10000>, /* common_s0*/
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml
> index 385bd060ccf9..7cb37053e95b 100644
> --- a/Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml
> +++ b/Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml
> @@ -81,7 +81,7 @@ examples:
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
>  
> -    dss: dss@02540000 {
> +    dss: dss@2540000 {
>              compatible = "ti,k2g-dss";
>              reg =   <0x02540000 0x400>,
>                      <0x02550000 0x1000>,
> -- 
> 2.20.1
