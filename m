Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C966CC4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988A12076E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UdFlom2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgCTONr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:13:47 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57352 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:13:47 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02KEDND3006881;
        Fri, 20 Mar 2020 09:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584713603;
        bh=mu+BoT8A50KslgSNWzXNMxybhbiLSSBFgyKQqHAr+dI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UdFlom2r94evMKBigrj9JDnIXdMv4E1hiw35KrvbD4ZAl9Q6U92wtQ92x2c/+ywJ6
         0lsQb4McJzrBHzZjNOkpiQndZhMd5kUxCFfZUycS6QeTah6MF6lRYPCVNAoyQ+dIDv
         I+grZA8L3YQ+Os70OQWHXmXJPPALntgrDtnkn3EY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02KEDNER025695
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Mar 2020 09:13:23 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Mar 2020 09:13:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Mar 2020 09:13:23 -0500
Received: from [10.250.133.193] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02KEDHhH019392;
        Fri, 20 Mar 2020 09:13:18 -0500
Subject: Re: [PATCH v1] dt-bindings: phy: cadence-torrent: Fix YAML check
 error
To:     Yuti Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>
References: <1584712171-27632-1-git-send-email-yamonkar@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <796a2433-b847-83fc-3fc0-3df090262030@ti.com>
Date:   Fri, 20 Mar 2020 19:43:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1584712171-27632-1-git-send-email-yamonkar@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/2020 7:19 PM, Yuti Amonkar wrote:
> Fix YAML check error by renaming node name from "phy" to
> "torrent-phy" as this node is not a phy_provider.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> ---
> 
> This fix patch is in reference to Rob's comment given below:
> 
> https://lkml.org/lkml/2020/3/11/1091

merged and squashed with the original patch.

Thanks
Kishon
> 
>  Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> index 9f94be1..c779a3c 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> @@ -120,7 +120,7 @@ additionalProperties: false
>  examples:
>    - |
>      #include <dt-bindings/phy/phy.h>
> -    torrent_phy: phy@f0fb500000 {
> +    torrent_phy: torrent-phy@f0fb500000 {
>            compatible = "cdns,torrent-phy";
>            reg = <0xf0 0xfb500000 0x0 0x00100000>,
>                  <0xf0 0xfb030a00 0x0 0x00000040>;
> 
