Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B2CC33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC332087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579278775;
	bh=FO48zQEQwocB6lV87keX2zJT4La31Mc5wcHkp/4iBLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KhVBZ7Fy02meuQHF1UdLxYB2DxrvXD+pmg4UcIOjqAiSlL9aT3vkvo/mJOCGRhXIF
	 pZ0u5HE07t9QdPwjQlReyGN41ZVsaXti7RCnFkr1MnE/+oUI28g+j2L6KsVJ9EcMtX
	 KXt+ba2nYZ3jT9hvS4wT2qgVaLm/i/pBR8QU0WKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgAQQcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:32:55 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37196 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgAQQcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:32:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id k14so23059608otn.4;
        Fri, 17 Jan 2020 08:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q77MY408jGCmYpI+zv//3ZdL+CvYzoBq5oPF0P9Vlwk=;
        b=KMU2Wmv73EQhLnPelUTP+9Q3zTS3vvCwWJn0Y9kyftaa2441K8Kn9jHq5fbkcEG8GW
         DvAikaTWMWahywX4sVO1w44JPq92GigsXfji1FWrxd4lsjyopJg7EzPKJJeZQe9bDxDB
         gZzCA5Vep9Yke6Y7ynlO7arAAxiXJIrJC57kgl2uEQQiMBWceb9izMQHkXgzmQtCbUf/
         zDyUErzrQtPCqV8sc864ZXtj+xkX2pBDtWlMGRurjk/9D1VmYUd4QKqq2++4uSAkeGMW
         +zjA1DU7YBpUVW1EPF0ZzF37Ke9I9NNiYkiN4s/lkYQBWQ0QLT/y38Ygnx+5srA4mDHp
         oM1w==
X-Gm-Message-State: APjAAAV9CnpvyXHxtWOFD8zKYhEQj/TLXLLxJAbSUEPMdbl5r+t09g9j
        zh1FF1ZiHmsycJqq7nt+eQ==
X-Google-Smtp-Source: APXvYqxYC/6JwXiUv+1TD0mNMzTSSYbrWFU8g5c8PonVdmTsLzmIkAEwVjI/lxj7VYnLmqTCG1kosg==
X-Received: by 2002:a9d:402:: with SMTP id 2mr6152888otc.357.1579278773544;
        Fri, 17 Jan 2020 08:32:53 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p65sm7957935oif.47.2020.01.17.08.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 08:32:53 -0800 (PST)
Received: (nullmailer pid 26849 invoked by uid 1000);
        Fri, 17 Jan 2020 16:32:52 -0000
Date:   Fri, 17 Jan 2020 10:32:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Logan Shaw <logan.shaw@alliedtelesis.co.nz>
Cc:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Joshua.Scott@alliedtelesis.co.nz,
        Chris.Packham@alliedtelesis.co.nz, logan.shaw@alliedtelesis.co.nz
Subject: Re: [PATCH v3 2/2] hwmon: (adt7475) Added attenuator bypass support
Message-ID: <20200117163252.GA26187@bogus>
References: <20200117035018.11985-1-logan.shaw@alliedtelesis.co.nz>
 <20200117035018.11985-3-logan.shaw@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117035018.11985-3-logan.shaw@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 16:50:18 +1300, Logan Shaw wrote:
> 
> Added a new file documenting the adt7475 devicetree and added the four
> new properties to it.
> 
> Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> ---
> ---
>  .../devicetree/bindings/hwmon/adt7475.yaml    | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Documentation/devicetree/bindings/hwmon/adt7475.example.dts:20.11-39: ERROR (duplicate_property_names): /example-0/hwmon@2e:bypass-attenuator-in1: Duplicate property name
ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/hwmon/adt7475.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/hwmon/adt7475.example.dt.yaml] Error 2
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1224608
Please check and re-submit.
