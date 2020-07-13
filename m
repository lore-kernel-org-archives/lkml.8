Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D9CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D6052075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594652427;
	bh=faqXRTQRj1ai8haPxygiQcTONY0UlLlv9f1SCf6j4Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rHN/lb1RgIN+zsFWykAww4uxnShN8gJYaSUzK2umOqjYOI9ien6Rh4LJfAiQrP0n5
	 rnNWI0AZujEDVEfb2wYI89kB8QM9SwlcZPoC+lZrSeC7remGfw5/bq+vtOYDuM7zuw
	 e4zE2iYAy7bQAVdaaiTGBSZTt3UjZEWT6YKNrd6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgGMPAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:00:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35352 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMPAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:00:25 -0400
Received: by mail-io1-f67.google.com with SMTP id v8so13796065iox.2;
        Mon, 13 Jul 2020 08:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MM2yTv6DinfgqMVw8u+xsXUDt72qpAhR1wtad/uJxSs=;
        b=QXYE0BR/YPgl8jWfleDo3Fwwqm61a8gIX1v9FFh24MhZc0dgvkLBxASHP4ZQmOW0Ux
         je6Jy5mhL+xvp0DhfKhcbHtQ4BC2VWievBWIPcBhP2oe7s1LNOAso8rUoUUjI3VchWAV
         DW9xUq6429ITYDzjBffHhRjGSiGwwVpdej2j9KH731YeWFeCccNr3Bz3Codv1txm23B4
         L+Wu+OuuDHyJvHDFdi+ZQm6ZkrL83M46ySmwfEXeGFKhkdqhummYd9hzSW4MUWK15qE6
         IpLhodGfdAjxn9w2Fk7DmXUMOOQ4osB+oEeh0kAzWvHjExmyviUgVsYRBSJQeh7HVR1a
         UW8w==
X-Gm-Message-State: AOAM533p+eOefYBPpHQxLFIbzgcPhtBgnlTgJ6FTW+sGwZf3cjDHzAtL
        Lr1d2EaEHZLY3O1WKRHRZA==
X-Google-Smtp-Source: ABdhPJw9dH7GkiyHKPqotimBI3XEZeBw0QpeeQPxAZCZiPuu3Ko3Ig3bhS7yI9kTEPmDk7sFb4DFGw==
X-Received: by 2002:a5e:840b:: with SMTP id h11mr102578ioj.106.1594652424139;
        Mon, 13 Jul 2020 08:00:24 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v10sm8394512ilj.40.2020.07.13.08.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 08:00:23 -0700 (PDT)
Received: (nullmailer pid 175663 invoked by uid 1000);
        Mon, 13 Jul 2020 15:00:22 -0000
Date:   Mon, 13 Jul 2020 09:00:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v6 2/2] devicetree: hwmon: shtc1: Add sensirion,shtc1.yaml
Message-ID: <20200713150022.GA175274@bogus>
References: <20200712044411.23323-1-chris.ruehl@gtsys.com.hk>
 <20200712044411.23323-3-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712044411.23323-3-chris.ruehl@gtsys.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jul 2020 12:44:10 +0800, Chris Ruehl wrote:
> Add documentation for the newly added DTS support in the shtc1 driver.
> To align with the drivers logic to have high precision by default
> a boolean sensirion,low_precision is used to switch to low precision.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  .../bindings/hwmon/sensirion,shtc1.yaml       | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dts:24.13-26: Warning (reg_format): /example-0/i2c1/shtc3@70:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dts:22.20-26.13: Warning (avoid_default_addr_size): /example-0/i2c1/shtc3@70: Relying on default #address-cells value
Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dts:22.20-26.13: Warning (avoid_default_addr_size): /example-0/i2c1/shtc3@70: Relying on default #size-cells value
Documentation/devicetree/bindings/hwmon/sensirion,shtc1.example.dt.yaml: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'


See https://patchwork.ozlabs.org/patch/1327453

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

