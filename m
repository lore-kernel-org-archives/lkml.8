Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A78CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33AAB205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589928254;
	bh=KV1br4RP62dfaY+YojzIIXCxa+4QL84xTnfa3sI135I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ff8DoU4xA+UXFZIekoEQNbveI8YxAhKFya+rr8B4WLD32WoojmH12UUaJUZ7lsYhw
	 eDwGF3k3gfKaGiL0e40SAF/eW2OgDUhaDzDxOP3OgrIL6+q11wFz0QLSNy/a/hrKTm
	 LG0ft5IOzvgOXNYk6qDhC2MstIoi/u8lP1Q7zfp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgESWoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:44:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37324 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgESWoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:44:13 -0400
Received: by mail-io1-f67.google.com with SMTP id t15so1043888ios.4;
        Tue, 19 May 2020 15:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N1lmJuXT33q6aZH18d7DfYmv0StosYI0OPktchqqKbA=;
        b=OtUsF+RqRV1tX9pbf5h7C6lMXhObFIJe4jmotw3LJPDpxAtsNGhbvo5tmcpmdcXaQS
         C37YIE4vnrUNaY9BijeQPF+ZhJ8lB1RrTVkulGWHZLleOtlFZwGjjAAjgifljgSiJge8
         KGNc4tHwR9ASBDAVUmJxJhugByWm47bggakCs14unNpmWngcwdk0ncubZIDQYn5WqY3B
         q4t2ECyNl0HSCDb3xh4IaM6bPXGhrbA9QroZxH2hRcHQUI6FH6g/D3UZLeKrdp8g5EKa
         scDu0UOVRXs2ckwFiMjLpqLURfQlXKbJtsrLjrZZGWg7i7EB9GT0eLBuLSoYGT4mkSd1
         yXbQ==
X-Gm-Message-State: AOAM533PNk+0kb5xu+0IFsgg2m74VgjV+BNfEW0y/1/Ln3qh596JxtFM
        KuZvoJwq+meJIBF3r7pW2A==
X-Google-Smtp-Source: ABdhPJxKQ/TzQq03uf2VEzCewTAUROD8cEguB2dRtrUO2bJaC96i0KsUN7VLp2Hv2j6a2B1DjXP6BA==
X-Received: by 2002:a02:76c4:: with SMTP id z187mr1922106jab.72.1589928252182;
        Tue, 19 May 2020 15:44:12 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b7sm366733ioq.40.2020.05.19.15.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 15:44:11 -0700 (PDT)
Received: (nullmailer pid 827084 invoked by uid 1000);
        Tue, 19 May 2020 22:44:10 -0000
Date:   Tue, 19 May 2020 16:44:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        peterhuewe@gmx.de, christophe-h.richard@st.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Subject: Re: [PATCH v8 7/8] tpm: Add YAML schema for TPM TIS I2C options
Message-ID: <20200519224410.GA824372@bogus>
References: <20200512141431.83833-1-amirmizi6@gmail.com>
 <20200512141431.83833-8-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512141431.83833-8-amirmizi6@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 05:14:30PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Added a YAML schema to support tpm tis i2c related dt-bindings for the I2c
> PTP based physical layer.
> 
> This patch adds the documentation for corresponding device tree bindings of
> I2C based Physical TPM.
> Refer to the 'I2C Interface Definition' section in
> 'TCG PC Client PlatformTPMProfile(PTP) Specification' publication
> for specification.
> 
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---
>  .../bindings/security/tpm/tpm-tis-i2c.yaml         | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> new file mode 100644
> index 0000000..628c8f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: I2C PTP based TPM Device Tree Bindings
> +
> +maintainers:
> +  - Amir Mizinski <amirmizi6@gmail.com>
> +
> +description:
> +  Device Tree Bindings for I2C based Trusted Platform Module(TPM).
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

You don't need 'oneOf'.

> +          - enum:
> +              # Nuvoton's Trusted Platform Module (TPM) (NPCT75x)
> +              - nuvoton,npct75x
> +          - const: tcg,tpm-tis-i2c
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt:
> +    maxItems: 1
> +
> +  crc-checksum:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Set this flag to enable CRC checksum.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      tpm_tis@2e {

tpm@2e

> +        compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
> +        reg = <0x2e>;
> +        crc-checksum;
> +      };
> +    };
> +...
> -- 
> 2.7.4
> 
