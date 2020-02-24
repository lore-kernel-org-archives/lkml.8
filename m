Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39351C38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1429220836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582569494;
	bh=HKGf1vixZ1cIXykh3YzYG1OpYhwbo+RkoLyvnacjPoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FhpcVaWw0bAYmExXbmEXc5OiNvSXfPgACL5fXwIsnbCJDnA7ztwzb+P741QtRaAcH
	 k92j8NuDLdv0vbb+180ru9qBiYCYHNK70+Ytbn36h0O+fg+oFBRjLfrBNRXYDxA5mv
	 qhghS5TJMZ/Lm7tCVqTSn1vszse/JE3oOvffl4iI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgBXSiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:38:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36120 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBXSiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:38:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id j20so9683143otq.3;
        Mon, 24 Feb 2020 10:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CTcGzA0z5i+6lNDLcB/Tsj2HAX7a4+dM5kF5P26aJ2Y=;
        b=k2JC62cHMtWz7LTQXqVrY5QKna9x8UDbQDJkUF07FaV9q1x6t9roaGxsv6cYCC87x9
         4rZG9Tu6PzT7Vh3nYvhLhI/AvmIUluQnssRHAOe+T20rZIFkMPlQMxz7c74tuDHaOm+C
         wyUxob4BfNvLFIfdbmBM+Oh2bjHa+/4LFhMUjU6+8G4CNSvbrxG22BTokdI3FbFtiplt
         6GprUsbHBDdk0ldg39zylIE9XEAdF7o9kmACVbSjlaL+od3Oc9uteb2CYgbSn2YB5B4o
         +wvnb7/EojT7RXoQHzU702XZFEskKOJ/0FTkaDui3VLJHPhVYoTvOUqv/qFHtv2/UPyu
         hBMg==
X-Gm-Message-State: APjAAAVArL3LsqZXwFmp3HB+vTiVwxy28WB/6z07JTpbEnke+1SCN9Nw
        9ii/iyTdL7wlhd5g8GFBfqbQtI4=
X-Google-Smtp-Source: APXvYqxDJn4NGNj1cMp1cZ6TxisP/0/u3ApEFGvmUGox+1qFMTezAYo1AiqpbEkiMaIenh1wvw6Fng==
X-Received: by 2002:a9d:624e:: with SMTP id i14mr42070548otk.371.1582569491495;
        Mon, 24 Feb 2020 10:38:11 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 108sm4769375oti.1.2020.02.24.10.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:38:10 -0800 (PST)
Received: (nullmailer pid 32747 invoked by uid 1000);
        Mon, 24 Feb 2020 18:38:10 -0000
Date:   Mon, 24 Feb 2020 12:38:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>,
        Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: mfd: Add Gateworks System Controller
 bindings
Message-ID: <20200224183810.GA32214@bogus>
References: <1582320476-1098-1-git-send-email-tharvey@gateworks.com>
 <1582320476-1098-2-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582320476-1098-2-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 13:27:54 -0800, Tim Harvey wrote:
> This patch adds documentation of device-tree bindings for the
> Gateworks System Controller (GSC).
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> 
> v4:
>  - move to using pwm<n>_auto_point<m>_{pwm,temp} for FAN PWM
>  - remove unncessary resolution/scaling properties for ADCs
>  - update to yaml
>  - remove watchdog
> 
> v3:
>  - replaced _ with -
>  - remove input bindings
>  - added full description of hwmon
>  - fix unit address of hwmon child nodes
> 
> update dts
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> 
> merge with binding doc
> ---
>  .../devicetree/bindings/mfd/gateworks-gsc.yaml     | 156 +++++++++++++++++++++
>  1 file changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

warning: no schema found in file: Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml: ignoring, error parsing file
Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml:  while parsing a block mapping
  in "<unicode string>", line 62, column 11
did not find expected key
  in "<unicode string>", line 75, column 12
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/mfd/gateworks-gsc.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/mfd/gateworks-gsc.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1242346
Please check and re-submit.
