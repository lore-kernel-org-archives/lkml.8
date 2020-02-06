Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB8BC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED36C21775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581025210;
	bh=g6ZoXtcIdjS3JCNPJCvhQ72dM7/fPJRl4tXSNXB+Uic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DmwrPv6TuqiUwAfAPDBqlnA81VJ1jfojBYprIF5NLymk+PmPsUsWbAWV2dDwaISn8
	 gnN6l9zjAfm9kpfnx5K+nx/Y/ZIhvq7rltRc/gOff3h2USw6L2KChjYJ1UcMEpBgXI
	 c9r+L5NCg+agVjxeXt/o+UTQzJWaMKUSdTNfn/mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBFVkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 16:40:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36504 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgBFVkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 16:40:09 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so98845plm.3;
        Thu, 06 Feb 2020 13:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5vvIq67JV+Oxp9NKbdutNRvJz8PnZ+ipDgXIat3s/IM=;
        b=Oi1pgWOYemZXbgqg32b3O1nImywT+pcyhhlTRA+3upt44XAK/6TqB7ULYqzOgL8app
         RxTYqil60rk8tRBJxLcv0Gd4ZUQNK02XZZ6KusH6Fggc6uKBAq8ZGaJj/mD5MT6ZNuNt
         Ni+LLa9VWGWgpDLxMWEUYFjrSMnZ72aRibfEyHEJN3d+pkrv40YPXLSJXetLvHzLgIwC
         Fn/UDSmhAvxdg2bzpD8ijshmMBBrJyaJ/oB0vkvVpAIXNv34GAgMGqe90gZAjknPa/zv
         975CQsS+h5dI3w4R4A+y6tcLGGuR3326QmkTGrr7qvRFDmCrDIv7JWJ3NbaewjZkmTPh
         u/TQ==
X-Gm-Message-State: APjAAAWNIX98WzToDznBGvlP+Gcdnm1w/HywvbBTGfEJNsTmf16eFBV5
        DCqckrJ37oRSTkNloyWazg==
X-Google-Smtp-Source: APXvYqwwexPoc9Hz2nHTx6PnK5C22QnItXhc4L9PublC77ZX1pijc5BwfgydEIocGZDePnqHtWRQAg==
X-Received: by 2002:a17:90b:3109:: with SMTP id gc9mr7013106pjb.30.1581025207964;
        Thu, 06 Feb 2020 13:40:07 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id g13sm322250pfo.169.2020.02.06.13.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 13:40:06 -0800 (PST)
Received: (nullmailer pid 23807 invoked by uid 1000);
        Thu, 06 Feb 2020 21:40:05 -0000
Date:   Thu, 6 Feb 2020 14:40:05 -0700
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        devicetree@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, mark.rutland@arm.com, bleung@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        helen.koike@collabora.com, ezequiel@collabora.com,
        kernel@collabora.com, dafna3@gmail.com
Subject: Re: [PATCH v2] dt-bindings: convert extcon-usbc-cros-ec.txt
 extcon-usbc-cros-ec.yaml
Message-ID: <20200206214005.GA20153@bogus>
References: <20200205110029.3395-1-dafna.hirschfeld@collabora.com>
 <59ec876a-a77a-9b6d-34dd-272292102ed9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59ec876a-a77a-9b6d-34dd-272292102ed9@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 04:47:59PM +0100, Enric Balletbo i Serra wrote:
> Hi Dafna,
> 
> On 5/2/20 12:00, Dafna Hirschfeld wrote:
> > convert the binding file extcon-usbc-cros-ec.txt to yaml format
> > This was tested and verified on ARM with:
> > make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> > make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> > 
> > Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> > ---
> > Changes since v1:
> > 1 - changing the license to (GPL-2.0-only OR BSD-2-Clause)
> > 2 - changing the maintainers
> > 3 - changing the google,usb-port-id property to have minimum 0 and maximum 255
> > 
> >  .../bindings/extcon/extcon-usbc-cros-ec.txt   | 24 ----------
> >  .../bindings/extcon/extcon-usbc-cros-ec.yaml  | 45 +++++++++++++++++++
> >  2 files changed, 45 insertions(+), 24 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> >  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> > deleted file mode 100644
> > index 8e8625c00dfa..000000000000
> > --- a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> > +++ /dev/null
> > @@ -1,24 +0,0 @@
> > -ChromeOS EC USB Type-C cable and accessories detection
> > -
> > -On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
> > -able to detect the state of external accessories such as display adapters
> > -or USB devices when said accessories are attached or detached.
> > -
> > -The node for this device must be under a cros-ec node like google,cros-ec-spi
> > -or google,cros-ec-i2c.
> > -
> > -Required properties:
> > -- compatible:		Should be "google,extcon-usbc-cros-ec".
> > -- google,usb-port-id:	Specifies the USB port ID to use.
> > -
> > -Example:
> > -	cros-ec@0 {
> > -		compatible = "google,cros-ec-i2c";
> > -
> > -		...
> > -
> > -		extcon {
> > -			compatible = "google,extcon-usbc-cros-ec";
> > -			google,usb-port-id = <0>;
> > -		};
> > -	}
> > diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> > new file mode 100644
> > index 000000000000..fd95e413d46f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> > @@ -0,0 +1,45 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/extcon/extcon-usbc-cros-ec.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ChromeOS EC USB Type-C cable and accessories detection
> > +
> > +maintainers:
> > +  - Benson Leung <bleung@chromium.org>
> > +  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > +
> > +description: |
> > +  On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
> > +  able to detect the state of external accessories such as display adapters
> > +  or USB devices when said accessories are attached or detached.
> > +  The node for this device must be under a cros-ec node like google,cros-ec-spi
> > +  or google,cros-ec-i2c.
> > +
> > +properties:
> > +  compatible:
> > +    const: google,extcon-usbc-cros-ec
> > +
> > +  google,usb-port-id:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: the port id
> > +    minimum: 0
> > +    maximum: 255
> > +
> > +required:
> > +  - compatible
> > +  - google,usb-port-id
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    cros-ec@0 {
> > +        compatible = "google,cros-ec-i2c";
> 
> Now that you are here ... could you use compatible = "google,cros-ec-spi" here?
> 
> The reason is that the label above, cros-ec@0 is not really correct for an i2c
> device because after the @ you should put the address, cros-ec@1e will have more
> sense here. But cros-ec-i2c is rarely used, so I'd change the compatible to use
> "google,cros-ec-spi" and the entry "cros-ec@0" is fine.
> 
> > +        extcon {
> > +            compatible = "google,extcon-usbc-cros-ec";
> > +            google,usb-port-id = <0>;
> > +        };
> 
> And maybe would be useful have a more complete example like this?
> 
>     cros-ec@0 {
>         compatible = "google,cros-ec-spi";

There should also be a 'spi' parent node and 'reg' here.

> 
> 	usbc_extcon0: extcon@0 {

And no unit-address here as there's no 'reg'.

> 		compatible = "google,extcon-usbc-cros-ec";
> 		google,usb-port-id = <0>;
> 	};
> 
> 
> 	usbc_extcon1: extcon@1 {
> 		compatible = "google,extcon-usbc-cros-ec";
> 		google,usb-port-id = <1>;
> 	};
>     };
