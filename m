Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40613C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0683420725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QLq6KXnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgBQKas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:30:48 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:47994 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbgBQKaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:30:46 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200217103044epoutp029b896deba22460022c70d3a06cec91a1~0Kee-NXbM1532015320epoutp02B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 10:30:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200217103044epoutp029b896deba22460022c70d3a06cec91a1~0Kee-NXbM1532015320epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581935444;
        bh=ok8t0QdvH7qfzEnAkZnpXw8pVEVjZqhNypJEm+sb/n4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QLq6KXnI1hAF0m0Kk8LZDvz/9PrENMXD3K78VIq0iZqcYBhPwpjEkOsmumvpA6ERp
         yxex3FEgCkWUZTqgufu2BXQNCSFbKz1t9rUECk7BrTH7OM/rePEMIZTZ8Dwg4ikTcg
         R364hqhshY8SN1CnwZD7WLVWrUDUnCbPFuTWKWFA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200217103043epcas1p216ba466affb25f0e308e316d11fc5758~0Ked883Pw2223622236epcas1p2I;
        Mon, 17 Feb 2020 10:30:43 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48LgHN0sz8zMqYkb; Mon, 17 Feb
        2020 10:30:40 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.03.51241.05B6A4E5; Mon, 17 Feb 2020 19:30:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200217103039epcas1p476015a1db4eef89cffde9711260369f9~0KeaWoS5b2166621666epcas1p4-;
        Mon, 17 Feb 2020 10:30:39 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200217103039epsmtrp123c5c5a84eb1aa0934ac2df5d8074d82~0KeaTIGml0839908399epsmtrp1N;
        Mon, 17 Feb 2020 10:30:39 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-f2-5e4a6b50e24b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.E5.06569.F4B6A4E5; Mon, 17 Feb 2020 19:30:39 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200217103039epsmtip2cae87a1ca501eca058d7510fd7b7e399~0KeaGTJmy3000030000epsmtip2j;
        Mon, 17 Feb 2020 10:30:39 +0000 (GMT)
Subject: Re: [PATCH v4] dt-bindings: extcon: usbc-cros-ec: convert
 extcon-usbc-cros-ec.txt to yaml format
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        devicetree@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com,
        bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        helen.koike@collabora.com, ezequiel@collabora.com,
        kernel@collabora.com, dafna3@gmail.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a1bc262f-d8af-9590-105b-1db0b16f2861@samsung.com>
Date:   Mon, 17 Feb 2020 19:38:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200213123934.10841-1-dafna.hirschfeld@collabora.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmrm5AtlecwamtrBbTn1xmsTi57g2L
        xYUVN5gt5h85x2qx5vYhRoudG76wW5x6tYzZ4lT3O3aLzed6WC0u75rDZrH0+kUmi9uNK9gs
        WvceYXfg9Vgzbw2jx+yGiyweO+4uYfTYOesuu8emVZ1sHn1bVjF6fN4kF8AelW2TkZqYklqk
        kJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SukkJZYk4pUCggsbhY
        Sd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDAyBSoMCE7Y83rT6wFX1Qr
        pk9LbmDcItfFyMkhIWAicf1HL1sXIxeHkMAORon3Rz4yQzifGCUO9Dxkh3C+MUpcfLSaCaZl
        4fqDLBCJvYwSL9e9ZoJw3jNKXDh1ng2kSlggW6L3xFUwW0QgWGLanr+sIEXMAr1MEgffXmQE
        SbAJaEnsf3EDrIhfQFHi6o/HYHFeATuJTc93MIPYLAKqEicfvQGzRQXCJE5ua4GqEZQ4OfMJ
        C4jNKeAiMX/WfzCbWUBc4taT+UwQtrzE9rdzwB6SENjELvHm4AWoH1wk+i61sEDYwhKvjm9h
        h7ClJF72t0HZ1RIrTx5hg2juYJTYsv8CK0TCWGL/0slAgziANmhKrN+lDxFWlNj5ey4jxGI+
        iXdfe1hBSiQEeCU62oQgSpQlLj+4C3WCpMTi9k62CYxKs5C8MwvJC7OQvDALYdkCRpZVjGKp
        BcW56anFhgWmyNG9iRGclrUsdzAeO+dziFGAg1GJh/dFoGecEGtiWXFl7iFGCQ5mJRFeb3Gv
        OCHelMTKqtSi/Pii0pzU4kOMpsDQnsgsJZqcD8wZeSXxhqZGxsbGFiaGZqaGhkrivA8jNeOE
        BNITS1KzU1MLUotg+pg4OKUaGP2s7mw/9LbMUW2Du/zcmkP8H/Rdrl1Me8w3Q/ZGnd4veTvJ
        4L3xXwPCnMp2bqj+Ur3v/R/h5R3f1Pf+uslx9AV/4YZZ141qRUuqLx67/Sj8K+8cV86eOarS
        h34c37A58sRdWVFWlaLVcom2fcmpNmW9/185bFvYXnJavHZ1ulHY0a659Q2bo5VYijMSDbWY
        i4oTASwwhFfhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSvK5/tlecwZLPohbTn1xmsTi57g2L
        xYUVN5gt5h85x2qx5vYhRoudG76wW5x6tYzZ4lT3O3aLzed6WC0u75rDZrH0+kUmi9uNK9gs
        WvceYXfg9Vgzbw2jx+yGiyweO+4uYfTYOesuu8emVZ1sHn1bVjF6fN4kF8AexWWTkpqTWZZa
        pG+XwJWx5vUn1oIvqhXTpyU3MG6R62Lk5JAQMJFYuP4gSxcjF4eQwG5GiU8fv7JAJCQlpl08
        ytzFyAFkC0scPlwMUfOWUWLfpzZ2kBphgWyJ3hNX2UBsEYFgiVd72sAGMQv0Mkk8br7KDNEx
        nVFi+vmXTCBVbAJaEvtf3ADr4BdQlLj64zEjiM0rYCex6fkOZhCbRUBV4uSjN2C2qECYxM4l
        j5kgagQlTs58AnYdp4CLxPxZ/8FsZgF1iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFReBaS9llI
        WmYhaZmFpGUBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg+NTS2sF44kT8IUYB
        DkYlHl6HEM84IdbEsuLK3EOMEhzMSiK83uJecUK8KYmVValF+fFFpTmpxYcYpTlYlMR55fOP
        RQoJpCeWpGanphakFsFkmTg4pRoY5bj9ows+rak6f/vA4pw7Gc7P19kdbI2c+F184emtLzN2
        Cv9yrovK4MmdF/bWLXu59Oa3QjtnLunxsl06Ozb0/6nNQYbfP+2yfnB76e/zB/UaDT49SspZ
        dHDjSu6q2a+OS6744ncpt2RW8dJvutezWu6+OTmlvc/s5qUbikapX6XD1kyMN3SxPKXEUpyR
        aKjFXFScCABgb6HJywIAAA==
X-CMS-MailID: 20200217103039epcas1p476015a1db4eef89cffde9711260369f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200213123953epcas1p45c39830a9ec6bd535f5370702f603806
References: <CGME20200213123953epcas1p45c39830a9ec6bd535f5370702f603806@epcas1p4.samsung.com>
        <20200213123934.10841-1-dafna.hirschfeld@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/20 9:39 PM, Dafna Hirschfeld wrote:
> convert the binding file extcon-usbc-cros-ec.txt to
> yaml format extcon-usbc-cros-ec.yaml
> 
> This was tested and verified on ARM with:
> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Changes since v1:
> 1 - changing the license to (GPL-2.0-only OR BSD-2-Clause)
> 2 - changing the maintainers
> 3 - changing the google,usb-port-id property to have minimum 0 and maximum 255
> 
> Changes since v2:
> 1 - Changing the patch subject to start with "dt-bindings: extcon: usbc-cros-ec:"
> 2 - In the example, adding a parent isp node, a reg field to cros-ec@0
> and adding nodes 'extcon0/1' instead of one node 'extcon'.
> 
> Changes since v3:
> in the example, changing the node isp1 to spi0
> 
>  .../bindings/extcon/extcon-usbc-cros-ec.txt   | 24 --------
>  .../bindings/extcon/extcon-usbc-cros-ec.yaml  | 56 +++++++++++++++++++
>  2 files changed, 56 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
>  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> deleted file mode 100644
> index 8e8625c00dfa..000000000000
> --- a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -ChromeOS EC USB Type-C cable and accessories detection
> -
> -On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
> -able to detect the state of external accessories such as display adapters
> -or USB devices when said accessories are attached or detached.
> -
> -The node for this device must be under a cros-ec node like google,cros-ec-spi
> -or google,cros-ec-i2c.
> -
> -Required properties:
> -- compatible:		Should be "google,extcon-usbc-cros-ec".
> -- google,usb-port-id:	Specifies the USB port ID to use.
> -
> -Example:
> -	cros-ec@0 {
> -		compatible = "google,cros-ec-i2c";
> -
> -		...
> -
> -		extcon {
> -			compatible = "google,extcon-usbc-cros-ec";
> -			google,usb-port-id = <0>;
> -		};
> -	}
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> new file mode 100644
> index 000000000000..9c5849b341ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: https://protect2.fireeye.com/url?k=d3c63a24-8e5dc647-d3c7b16b-0cc47a31cdbc-e8d8e2b7806aed8e&u=http://devicetree.org/schemas/extcon/extcon-usbc-cros-ec.yaml#
> +$schema: https://protect2.fireeye.com/url?k=04f78247-596c7e24-04f60908-0cc47a31cdbc-1b9a3937c161a4b6&u=http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ChromeOS EC USB Type-C cable and accessories detection
> +
> +maintainers:
> +  - Benson Leung <bleung@chromium.org>
> +  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +
> +description: |
> +  On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
> +  able to detect the state of external accessories such as display adapters
> +  or USB devices when said accessories are attached or detached.
> +  The node for this device must be under a cros-ec node like google,cros-ec-spi
> +  or google,cros-ec-i2c.
> +
> +properties:
> +  compatible:
> +    const: google,extcon-usbc-cros-ec
> +
> +  google,usb-port-id:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    description: the port id
> +    minimum: 0
> +    maximum: 255
> +
> +required:
> +  - compatible
> +  - google,usb-port-id
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        cros-ec@0 {
> +            compatible = "google,cros-ec-spi";
> +            reg = <0>;
> +
> +            usbc_extcon0: extcon0 {
> +                compatible = "google,extcon-usbc-cros-ec";
> +                google,usb-port-id = <0>;
> +            };
> +
> +            usbc_extcon1: extcon1 {
> +                compatible = "google,extcon-usbc-cros-ec";
> +                google,usb-port-id = <1>;
> +            };
> +        };
> +    };
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
