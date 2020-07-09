Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54520C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BAC52077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594313177;
	bh=JfFF8+CMKABCuPn0K8Tniqu0lfWES1uKahWsojmYWHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WN2qv9bAYtd4m0xzzjwjB7tsbSD7q7wKrCFIOdXJEU74yfECsVzxOYbPOLOPtd++C
	 qMLMKBwbKVzd7+kOmWlLZ30XmRId11uB+tIzGQ+0NVMe8ZtlDnLIsiYnDzXV7bkyS4
	 OZr7t765de5IlWVDHOO02xgI/hipMCrl05+K/37M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgGIQqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:46:16 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44042 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGIQqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:46:15 -0400
Received: by mail-il1-f193.google.com with SMTP id h16so2569547ilj.11;
        Thu, 09 Jul 2020 09:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dYgb8/mkuUxIt2m5PD9T5anmcR08HvFF0Uc/2CHjdPQ=;
        b=He1m/PsIVb5tKHHq8mBC69c7AEDk6NE5Pi0/2neqZ3zXdqZ5rgIkM7Jp6pFrhkjrxY
         fMxwWS0nHtdWh8Irsf89PETwv5mLhAOjMoCgfu1G8AWQOcWQMOysUahrPpAIvz8rqhv1
         zwOIWUj35dpPapdZkxnwLTktPgqVyPzs4XmYzSpQxRqDY6XTFu7/b8lmIjyC5v7zQ0RF
         Mf+is7A+4/zCbMouNYcSMadMkmsY6unfZtnX/UFvGCfLOiC5BI5isQETu6v5HZLPhiFb
         8MfO1/gyHtlro4zkNxsNGP83tC04kIoJAzJhmiX1c6T5nFwTDSLom8/jxXi/50VFSdmy
         KUfw==
X-Gm-Message-State: AOAM533sHhRPAs1k/2x8ZwAGEiMBrjSkggKwT4vB1A6EkNmF46T98p1e
        ocolo75F6FyJzvppvetYSw==
X-Google-Smtp-Source: ABdhPJwYm6C3eOH7D/4rieFBCAyN9fWZOQE2mUBpGjJ9eTOUprMXR7+3CRFw2hY7dFeVrVSISj+QSA==
X-Received: by 2002:a92:4810:: with SMTP id v16mr47587387ila.75.1594313174582;
        Thu, 09 Jul 2020 09:46:14 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id j28sm2264580ili.76.2020.07.09.09.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 09:46:14 -0700 (PDT)
Received: (nullmailer pid 498959 invoked by uid 1000);
        Thu, 09 Jul 2020 16:46:09 -0000
Date:   Thu, 9 Jul 2020 10:46:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     linux-hwmon@vger.kernel.org, Jack Lo <jack.lo@gtsys.com.hk>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 2/2] devicetree: hwmon: shtc1: Add sensirion,shtc1.yaml
Message-ID: <20200709164609.GA498064@bogus>
References: <20200708040748.9014-1-chris.ruehl@gtsys.com.hk>
 <20200708040748.9014-3-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708040748.9014-3-chris.ruehl@gtsys.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jul 2020 12:07:47 +0800, Chris Ruehl wrote:
> Add documentation for the newly added DTS support in the shtc1 driver.
> To align with the drivers logic to have high precision by default
> a boolean sensirion,low_precision is used to switch to low precision.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  .../bindings/hwmon/sensirion,shtc1.yaml       | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dts:26.13-14 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:315: recipe for target 'Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1324936

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

