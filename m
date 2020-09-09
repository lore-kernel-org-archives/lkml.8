Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24316C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40E821D6C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599684548;
	bh=dTaWtRLVjVHYDXooy7OEcSgpv2GBSNMmEJmHtxn04yI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s21ktlwPg0vhECYyP8kB48HGUtWqa+CbfDO9auWLtbqohgKYl3r9/PRC8FnxZ3ul9
	 fwrBM99cUTChmfL8vLn+yxNok2FarjUdy0ov2lk6UUgtu9Y9thgmlBD/p2WBdHhfWo
	 mjr/YmsZ46zOta/trjvDl5sziH112qZoY9tvLeLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgIIUtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:49:07 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44186 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgIIUtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 16:49:00 -0400
Received: by mail-io1-f68.google.com with SMTP id g128so4666806iof.11;
        Wed, 09 Sep 2020 13:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X1yklNCC3KY/Gs5Y5NdD6OT5AMVk6VxEpKZgwPcaiH0=;
        b=m4HQSfASEip/JpVmXXgvY9GjYTchc9oWGFobK+Ufd+IJsflf+WopPUzTkYf6efIWab
         Go4xRTfLulrHlcN1UYDVvLU4h3rEQZiYKm54pXixWmffzFMI06D2tKvyLR/HNgWEm9on
         eM2217LucPt4NTQ3GNpj1a0usxxEL2i5pB1LTTJVVhYYDpixc+C63OYwnfvypDDlxaiu
         IaVBQfpuOkeQA03ySV1m9kbpaSCjrw8rgmhsYGCOgO0XQq0r2aVjqiemtMuuNzEciMlC
         MHXZH9OYDFliz2HgA+BDwcH+VVD1ePNimw9KAtnAVxrDIKEWcHdODwiSKSdqYyILGzSv
         ongg==
X-Gm-Message-State: AOAM533RfP/SAhJ9zaKQZ2e4dtQBI05EW5SEFnhkzaF1T4tPUkw1jzvK
        8ykozDm6LFfSMRa9q88xMg==
X-Google-Smtp-Source: ABdhPJwuKsNwM3eYTa9UQ137jTI89LfA/ybJLpEwE2hfB1EGMU9XBo58RKm2vKe66ffW988f8PDohg==
X-Received: by 2002:a5d:8e12:: with SMTP id e18mr4476925iod.99.1599684539346;
        Wed, 09 Sep 2020 13:48:59 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id u89sm2091730ili.63.2020.09.09.13.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 13:48:58 -0700 (PDT)
Received: (nullmailer pid 3051842 invoked by uid 1000);
        Wed, 09 Sep 2020 20:48:48 -0000
Date:   Wed, 9 Sep 2020 14:48:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     rtanwar@maxlinear.com, cheol.yong.kim@intel.com,
        devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com, andriy.shevchenko@intel.com,
        p.zabel@pengutronix.de, linux@roeck-us.net, songjun.Wu@intel.com,
        qi-ming.wu@intel.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH 1/2] Add DT bindings schema for PVT controller
Message-ID: <20200909204848.GA3051408@bogus>
References: <cover.1599634208.git.rahul.tanwar@linux.intel.com>
 <e0fd02f63c5b6f46376eb709ebac6da36bfe26d8.1599634208.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0fd02f63c5b6f46376eb709ebac6da36bfe26d8.1599634208.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Sep 2020 14:52:04 +0800, Rahul Tanwar wrote:
> PVT controller (MR75203) is used to configure & control
> Moortec embedded analog IP which contains temprature sensor(TS),
> voltage monitor(VM) & process detector(PD) modules.
> 
> Add DT bindings schema for PVT controller.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml: required:6: {'#thermal-sensor-cells': None} is not of type 'string'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml: ignoring, error in schema: required: 6
warning: no schema found in file: ./Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/moortec,mr75203.example.dt.yaml: example-0: pvt@e0680000:reg:0: [3764912128, 128, 3764912256, 384, 3764912640, 512, 3764913152, 3072] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml


See https://patchwork.ozlabs.org/patch/1360350

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

