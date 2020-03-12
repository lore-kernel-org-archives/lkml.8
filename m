Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB21C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4D920578
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgCLIz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:55:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39716 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgCLIz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:55:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 47F8C29642E
Subject: Re: [PATCH] ASoC: dt-bindings: google,cros-ec-codec: Fix dtc warnings
 in example
To:     Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Benson Leung <bleung@chromium.org>, alsa-devel@alsa-project.org
References: <20200311205841.2710-1-robh@kernel.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <d6c612db-d4fd-e0e5-aff0-c3963322830c@collabora.com>
Date:   Thu, 12 Mar 2020 09:55:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311205841.2710-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 11/3/20 21:58, Rob Herring wrote:
> Extra dtc warnings (roughly what W=1 enables) are now enabled by default
> when building the binding examples. These were fixed treewide in
> 5.6-rc5, but the newly added google,cros-ec-codec schema adds some new
> warnings:
> 
> Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:17.28-21.11:
> Warning (unit_address_vs_reg): /example-0/reserved_mem: node has a reg or ranges property, but no unit name
> Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:22.19-32.11:
> Warning (unit_address_vs_reg): /example-0/cros-ec@0: node has a unit name, but no reg property
> Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:26.37-31.15:
> Warning (unit_address_vs_reg): /example-0/cros-ec@0/ec-codec: node has a reg or ranges property, but no unit name
> 
> Fixing the above, then results in:
> 
> Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:26.13-23:
> Warning (reg_format): /example-0/cros-ec@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:27.37-32.15:
> Warning (unit_address_vs_reg): /example-0/cros-ec@0/ec-codec: node has a reg or ranges property, but no unit name
> 
> Fixes: eadd54c75f1e ("dt-bindings: Convert the binding file google, cros-ec-codec.txt to yaml format.")
> Cc: Cheng-Yi Chiang <cychiang@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Just a minor nit, but the patch looks good to me, so:

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


> ---
>  .../bindings/sound/google,cros-ec-codec.yaml  | 27 +++++++++++--------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
> index 94a85d0cbf43..c84e656afb0a 100644
> --- a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
> +++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
> @@ -44,19 +44,24 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    reserved_mem: reserved_mem {
> +    reserved_mem: reserved-mem@52800000 {
>          compatible = "shared-dma-pool";
> -        reg = <0 0x52800000 0 0x100000>;
> +        reg = <0x52800000 0x100000>;
>          no-map;
>      };
> -    cros-ec@0 {
> -        compatible = "google,cros-ec-spi";
> -        #address-cells = <2>;
> -        #size-cells = <1>;
> -        cros_ec_codec: ec-codec {
> -            compatible = "google,cros-ec-codec";
> -            #sound-dai-cells = <1>;
> -            reg = <0x0 0x10500000 0x80000>;
> -            memory-region = <&reserved_mem>;
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        cros-ec@0 {
> +            compatible = "google,cros-ec-spi";
> +            #address-cells = <2>;
> +            #size-cells = <1>;
> +            reg = <0>;
> +            cros_ec_codec: ec-codec@10500000 {

nit: shouldn't this be just codec@105500000 to match the class? However I am not
sure codec is a class itself.

> +                compatible = "google,cros-ec-codec";
> +                #sound-dai-cells = <1>;
> +                reg = <0x0 0x10500000 0x80000>;
> +                memory-region = <&reserved_mem>;
> +            };
>          };
>      };
> 
