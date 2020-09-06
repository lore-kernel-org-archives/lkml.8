Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AE7C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 16:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7837F2080A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 16:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQxRNQx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgIFQj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 12:39:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23847 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725841AbgIFQjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 12:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599410355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4OX3Xc/v5tqk5R7fQDohwMLEotWZXIlqF2f90wFzok8=;
        b=eQxRNQx0gsljcZFPblQ51f9jcJF1tyCgHlcjzqUJSdYCH4F0qaN2FdT0rM1IekNf9HQKf1
        WL6PP0+bsui/l+5pj2Vazeoj8O81iB+1tx3OyoYjRPqhGF75k2at0gXjY40Ea+1s6jDjrf
        nPTgEtPKt8HS+TWy457Lf5yb9wTXFPk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-c3BMQCJuPQSxhBn3D-C5rQ-1; Sun, 06 Sep 2020 12:39:13 -0400
X-MC-Unique: c3BMQCJuPQSxhBn3D-C5rQ-1
Received: by mail-qk1-f199.google.com with SMTP id m203so6424362qke.16
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 09:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4OX3Xc/v5tqk5R7fQDohwMLEotWZXIlqF2f90wFzok8=;
        b=pZLcDWOdnV5XbKeS2G5Z4+tdxaWYFPq2lCN2c5TK+XbRSqTgofj7dl+mpGBH8nVCL4
         q3Gkat/4ehYZJDKW8zdXwCyKxyRoF6l3IZfn+qP55uExzWjquFwmzB+VNHU1ZTtVoWQ0
         FMOAwfTN/i5vtIQNVxToZf55PfFlE340wyb7kMrBw5vzBuCoHYZACoFf5pxPFBoTCZ8H
         XMit9uq3p4VQhTDXBmdUyGpZt66BhsYzckf57V1JuPX6zli44qUxGZB4xU72AuHRBdnf
         sdqHST5HDVr68sLyqLuzNliM/8n/oLex95X9YKmdABUQ5+DxXHTS7vw5jnhRk59QhQ3k
         W8Kg==
X-Gm-Message-State: AOAM533/3141YlvSU8bG+lkCPvy+PPsv4kQF4TswH5rF7qLHliWJzckj
        8O/5/LHReCSqOxpN9ewx1op59kj1oKzvXsCeJs1kLDc+Z2jHGAn4H++QQM/6I6Y7yNLj6Dj/h4T
        3ZmtzQRXRjzU4TvpIeq/PID8P
X-Received: by 2002:ac8:12c1:: with SMTP id b1mr17880970qtj.148.1599410352725;
        Sun, 06 Sep 2020 09:39:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBTjz40kE7kH1ObZ2Pej4m3hzM4p5WVMaw+MYN4tu+a8LcxfIaVB94ri8o+oZypOdb+KtYpg==
X-Received: by 2002:ac8:12c1:: with SMTP id b1mr17880953qtj.148.1599410352451;
        Sun, 06 Sep 2020 09:39:12 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s20sm9041012qkg.65.2020.09.06.09.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 09:39:11 -0700 (PDT)
Subject: Re: [PATCH v1 09/12] fpga: expose sec-mgr update size
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-10-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f9212bb3-c624-06e3-383b-9bb56717f795@redhat.com>
Date:   Sun, 6 Sep 2020 09:39:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-10-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/4/20 4:53 PM, Russ Weight wrote:
> Extend the Intel Security Manager class driver to include
> an update/remaining_size sysfs node that can be read to
> determine how much data remains to be transferred to the
> secure update engine. This file can be used to monitor
> progress during the "writing" phase of an update.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Wu Hao <hao.wu@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr | 11 +++++++++++
>  drivers/fpga/ifpga-sec-mgr.c                        | 10 ++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> index e7b1b02bf7ee..cf1967f1b3e3 100644
> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> @@ -98,6 +98,17 @@ Description:	Read-only. Returns a string describing the current
>  		as it will be signaled by sysfs_notify() on each
>  		state change.
>  
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/remaining_size
> +Date:		Sep 2020
> +KernelVersion:  5.10
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read-only. Returns the size of data that remains to
> +		be written to the secure update engine. The size
> +		value is initialized to the full size of the file
> +		image and the value is updated periodically during
> +		the "writing" phase of the update.
> +		Format: "%u".
> +
>  What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/error
>  Date:		Sep 2020
>  KernelVersion:  5.10
> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
> index a7718bd8ee61..4ca5d13e5656 100644
> --- a/drivers/fpga/ifpga-sec-mgr.c
> +++ b/drivers/fpga/ifpga-sec-mgr.c
> @@ -325,6 +325,15 @@ error_show(struct device *dev, struct device_attribute *attr, char *buf)
>  }
>  static DEVICE_ATTR_RO(error);
>  
> +static ssize_t remaining_size_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
> +
> +	return sprintf(buf, "%u\n", imgr->remaining_size);
> +}
> +static DEVICE_ATTR_RO(remaining_size);
> +
>  static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>  			      const char *buf, size_t count)
>  {
> @@ -364,6 +373,7 @@ static struct attribute *sec_mgr_update_attrs[] = {
>  	&dev_attr_filename.attr,
>  	&dev_attr_status.attr,
>  	&dev_attr_error.attr,
> +	&dev_attr_remaining_size.attr,
>  	NULL,
>  };
>  

Looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

