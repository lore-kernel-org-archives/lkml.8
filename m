Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28256C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2042468E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dQIiCreo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgA1KNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:13:38 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48280 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgA1KNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:13:37 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00SADID0118110;
        Tue, 28 Jan 2020 04:13:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580206398;
        bh=+C6eAOrqKoHaKj+enDAIeqTSENNe2U0bzKRvVZeWNHA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dQIiCreocT+01MqIJWtH6uYJvxVSEgMvgkg3OYg3HkzsmI0GycsfMv4V4JLyaWwMO
         l8Lz+WJ/GsmUPkZIh7qQ7bBhrrR8dT/W7ux6sAlBO30UdaB1SkJZMPZpacKLPU03F+
         erZLFbYbpVVmFIPD5qEC2hNeHNE/DdBzEpwTwDtM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00SADIvw127549
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jan 2020 04:13:18 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 28
 Jan 2020 04:13:17 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 28 Jan 2020 04:13:17 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00SADEG4107748;
        Tue, 28 Jan 2020 04:13:15 -0600
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: Add documentation
 for Toshiba tc358768
To:     Rob Herring <robh@kernel.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <mark.rutland@arm.com>,
        <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <tomi.valkeinen@ti.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>
References: <20200127105634.7638-1-peter.ujfalusi@ti.com>
 <20200127105634.7638-2-peter.ujfalusi@ti.com> <20200127184939.GA4237@bogus>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <17fbdcd2-48fa-1b09-683d-cef7e1e40046@ti.com>
Date:   Tue, 28 Jan 2020 12:14:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200127184939.GA4237@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 27/01/2020 20.49, Rob Herring wrote:
> On Mon, Jan 27, 2020 at 12:56:33PM +0200, Peter Ujfalusi wrote:
>> TC358768/TC358778 is a Parallel RGB to MIPI DSI bridge.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  .../display/bridge/toshiba,tc358768.yaml      | 158 ++++++++++++++++++
>>  1 file changed, 158 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
>> new file mode 100644
>> index 000000000000..8dd8cca39a77
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
>> +examples:
>> +  - |
>> +    i2c1 {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      dsi_bridge: tc358768@0e {
> 
> Generic node names and no leading 0s:
> 
> dsi-bridge@e

Right, I'll correct it.

>> +        compatible = "toshiba,tc358768";
>> +        reg = <0x0e>;
>> +
>> +        clocks = <&tc358768_refclk>;
>> +        clock-names = "refclk";
>> +
>> +        /* GPIO line is inverted before going to the bridge */
>> +        reset-gpios = <&pcf_display_board 0 1 /* GPIO_ACTIVE_LOW */>;
> 
> You just need to add the include for the define to work.

You are right, it compiles fine with the include added.

Thank you,
- Péter

>> +
>> +        vddc-supply = <&v1_2d>;
>> +        vddmipi-supply = <&v1_2d>;
>> +        vddio-supply = <&v3_3d>;
>> +
>> +        dsi_bridge_ports: ports {
>> +          #address-cells = <1>;
>> +          #size-cells = <0>;
>> +
>> +          port@0 {
>> +            reg = <0>;
>> +            rgb_in: endpoint {
>> +              remote-endpoint = <&dpi_out>;
>> +              data-lines = <24>;
>> +            };
>> +          };
>> +
>> +          port@1 {
>> +            reg = <1>;
>> +            dsi_out: endpoint {
>> +              remote-endpoint = <&lcd_in>;
>> +            };
>> +          };
>> +        };
>> +      };
>> +    };
>> +    
>> -- 
>> Peter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
