Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21062C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 17:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C2720760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 17:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6Kr2cFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgIERRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 13:17:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54906 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728042AbgIERRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 13:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599326223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OGH1OnR/QF8fAlfetLwGLNG+GGcP9kLctGj2h9MJIrs=;
        b=b6Kr2cFgV6Zpq3sqVqc6PGg1/2tIY8FjPbPSmcS9FSsAg6HRKGlwtV+X7wmX9+APCYeN3c
        b1If4skq9M8VTs4oVrVwKUem8rZMeJm1X+xKdhbnA/Y3U/9pbkYG8SXAC6zqiZTkGZ/mYY
        too/cyyuVW2/5rHi9Mo9fzpAf9SWc3E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-0EfJSCIGOByPvkJqAHO3_w-1; Sat, 05 Sep 2020 13:17:00 -0400
X-MC-Unique: 0EfJSCIGOByPvkJqAHO3_w-1
Received: by mail-qv1-f72.google.com with SMTP id k14so1296917qvw.20
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 10:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OGH1OnR/QF8fAlfetLwGLNG+GGcP9kLctGj2h9MJIrs=;
        b=q7iA3O/NkqsmwByaP1LsUTJiNcjocLOT5saLPwHqKCdB1Epo56R9AW7hbSt4MDjiIB
         MzKjbsgeyxmuVpueVnoAoUbKmk6jn09vk1gB99gClFxa+Qstp0mdV13PjQPnTY8VCtQB
         BM4VPBMv25X01GBQLZTCwPr54YNyZ1HtJcR36v2pSde0hbW6QNgitv8zuj4iAqPUlWKZ
         0zlMa8Oze2doWXDcg5x93cpTHY/HDfGIxBouLp9LEzysaQjDMLYIpXhhzIlZUqIxjAjE
         eQnd1UA2O7qkKXvOgI1XNIK3p3lUslPhN0s5RHN2YQSFaJNSsnzxJMfG8ugTPfRmiPJ9
         bX6Q==
X-Gm-Message-State: AOAM532GmWkdvUiRQuRC6QLM+6uSYXMGYFnpV3vDeHRR2vx2WpyXWDBB
        gwBV1+16iEN1Ogq9K0jJuM9LDTtYrrkwdmGCtx2W5uP12sGfZpEoK5i63M0PUVPAuag54mRmK0X
        d1uQTLu6SIVWXRTvDxHUjATpK
X-Received: by 2002:a05:620a:63a:: with SMTP id 26mr12686357qkv.68.1599326219188;
        Sat, 05 Sep 2020 10:16:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGkgNlnjq7sXD89ZZZPWab22phjXYNVylh52vCAoImwt8VZZowarPMOEpWWRdtGCLfo67SLQ==
X-Received: by 2002:a05:620a:63a:: with SMTP id 26mr12686338qkv.68.1599326218833;
        Sat, 05 Sep 2020 10:16:58 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c7sm7024602qkd.92.2020.09.05.10.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2020 10:16:58 -0700 (PDT)
Subject: Re: [PATCH v1 00/12] Intel FPGA Security Manager Class Driver
To:     linux-kernel@vger.kernel.org,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
References: <20200904235305.6254-1-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4d554f31-1267-92cc-f717-00992144c41b@redhat.com>
Date:   Sat, 5 Sep 2020 10:16:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resending.
sorry for blowing past 80 chars.

On 9/4/20 4:52 PM, Russ Weight wrote:
> These patches depend on the patchset: "add regmap-spi-avmm & Intel
> Max10 BMC chip support" which is currently under review.

https://marc.info/?l=linux-kernel&m=159782274232229&w=2

regmap-spi-avmm is in linux-next.

max10 is not. however applying it does not resolve resolve
git am conflicts with yesterday's linux-next.
I normally build the larger patchsets as a test.

>
>            --------------------------------------------------
>
> This patchset introduces the Intel Security Manager class driver
> for managing secure updates on Intel FPGA Cards. It also provides
> the n3000bmc-secure mfd sub-driver for the MAX10 BMC for the n3000
> Programmable Acceleration Cards (PAC). The n3000bmc-secure driver
> is implemented using the Intel Security Manager class driver.
>
> The Intel Security Manager class driver provides a common API for
> user-space tools to manage updates for Secure FPGA devices. Device
> drivers that instantiate the Intel Security Manager class driver will
> interact with the HW secure update engine in order to transfer
> new FPGA and BMC images to FLASH so that they will be automatically
> loaded when the FPGA card reboots.
>
> The API consists of sysfs nodes and supports the following functions:
>
> (1) Instantiate and monitor a secure update
> (2) Display security information including: Root Entry Hashes (REH),
>     Cancelled Code Signing Keys (CSK), and flash update counts for
>     both BMC and FPGA images.
>
> Secure updates make use of the request_firmware framework, which
> requires that image files are accessible under /lib/firmware. A request
> for a secure update returns immediately, while the update itself
> proceeds in the context of a kernel worker thread. Sysfs files provide
> a means for monitoring the progress of a secure update and for
> retrieving error information in the event of a failure.
>
> The n3000bmc-secure driver instantiates the Intel Security Manager
> class driver and provides the callback functions required to support
> secure updates on Intel n3000 PAC devices.

This is a good description.  Because security manager is a new
interface, there should be a Documentation/fpga/ifpga-sec-mgr.rst
to collect this description.

How will these devices be discovered ? n3000 is a dfl device,
will there be a dfl feature id for it at some point ? 

Can you describe if/how the security manager would live outside
of dfl ?  I am wondering why this shouldn't be dfl-sec-mgr. 

I did not see any version handling.  How would this sw adapt
to a newer or older version of the bmc interface?

Tom

>
> Russ Weight (12):
>   fpga: fpga security manager class driver
>   fpga: create intel max10 bmc security engine
>   fpga: expose max10 flash update counts in sysfs
>   fpga: expose max10 canceled keys in sysfs
>   fpga: enable secure updates
>   fpga: add max10 secure update functions
>   fpga: expose sec-mgr update status
>   fpga: expose sec-mgr update errors
>   fpga: expose sec-mgr update size
>   fpga: enable sec-mgr update cancel
>   fpga: expose hardware error info in sysfs
>   fpga: add max10 get_hw_errinfo callback func
>
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 151 ++++
>  MAINTAINERS                                   |   8 +
>  drivers/fpga/Kconfig                          |  20 +
>  drivers/fpga/Makefile                         |   6 +
>  drivers/fpga/ifpga-sec-mgr.c                  | 669 ++++++++++++++++++
>  drivers/fpga/intel-m10-bmc-secure.c           | 557 +++++++++++++++
>  include/linux/fpga/ifpga-sec-mgr.h            | 201 ++++++
>  include/linux/mfd/intel-m10-bmc.h             | 116 +++
>  8 files changed, 1728 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>  create mode 100644 drivers/fpga/ifpga-sec-mgr.c
>  create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
>  create mode 100644 include/linux/fpga/ifpga-sec-mgr.h
>

