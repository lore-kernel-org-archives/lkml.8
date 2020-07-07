Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA17C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B0FE21582
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594152937;
	bh=I9HbhhuzQLNHpA2LIgmLXf0xSkdCv3OLshOfoSE0EIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0/dYllNiswAN4Fm08U0giYJZp2a8uBI+WA1UBPWEpa0KKyaQ+FJrFsGqZMAZVfxlt
	 HXK7pGxKZJFpcHJ82TUv/DFlIv9e0cJ69xzYGqmyLGGjaOJyd/1E7O5755vNglCoD3
	 rn8Qj3VG/iBL9uk0wj6rlfmDb2z9gYa2J3rt+Vkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgGGUPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:15:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42828 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgGGUPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:15:35 -0400
Received: by mail-io1-f68.google.com with SMTP id c16so44581037ioi.9;
        Tue, 07 Jul 2020 13:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K966dzq3887Uzlyy0dRpEQhzNCgkZkq/ZzXqsSsdFE4=;
        b=l+/w6iL4OQeCt/Gc7j4Pj8KcY7A9KbXxAPGD3UCOmyuObC/KrZuOj1exitXs0P7IFF
         dN9eAysWQAodsbUo/D961Ou16JjNlOWc3urGI/g/77PBzFvkqkIGx4Kph4Njt3rL8ZZd
         MzuZX4Zi3FnWBbL3j4xDMGLii0oA7rESj2gV7TqQ56tIIl5oElwO+e8ziwaKRM27NQBh
         emf5ZiB/7BwrNJ0JT2b0oqMQOJyO8bblJ92eN8tXbO1Q76KG8/e5ApeX4alf2HFPsP3x
         7MGwV3MaiFrIrMJbD3Rqz2drJgxB6++hS/SjUGFlu80xztZeCpdazv1H4i05iLOVrsnI
         PS+g==
X-Gm-Message-State: AOAM5311TnxfBG413LvxKp1TRg4pSRjJKWpfMSPBqsWxClHpTwQgBMH1
        cp9BNCicya690VPhQdboRQ==
X-Google-Smtp-Source: ABdhPJyyR0n/NJPHCUOxaun8dycLNdyQs4Era0rW43mycahPjoJooqZYSp6SyU9Cvr6sdhxGu1p8yQ==
X-Received: by 2002:a05:6638:dd3:: with SMTP id m19mr63316901jaj.106.1594152934274;
        Tue, 07 Jul 2020 13:15:34 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id d77sm13999482ill.67.2020.07.07.13.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:15:33 -0700 (PDT)
Received: (nullmailer pid 558788 invoked by uid 1000);
        Tue, 07 Jul 2020 20:15:32 -0000
Date:   Tue, 7 Jul 2020 14:15:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Rob Herring <robh+dt@kernel.org>, Jack Lo <jack.lo@gtsys.com.hk>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] devicetree: hwmon: shtc1: Add sensirion,shtc1.yaml
Message-ID: <20200707201532.GA558059@bogus>
References: <20200705034727.1429-1-chris.ruehl@gtsys.com.hk>
 <20200705034727.1429-3-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705034727.1429-3-chris.ruehl@gtsys.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Jul 2020 11:47:26 +0800, Chris Ruehl wrote:
> Add documentation for the newly added DTS support in the shtc1 driver.
> To align with the drivers logic to have high precision by default
> a boolean sensirion,low_precision is used to switch to low precision.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  .../bindings/hwmon/sensirion,shtc1.yaml       | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml:  while parsing a flow mapping
  in "<unicode string>", line 43, column 9
did not find expected ',' or '}'
  in "<unicode string>", line 47, column 14
Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1322963

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

