Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C242BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E09620760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3sv5DwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgFKM4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:56:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24912 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726346AbgFKM4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591880202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fq4jWTmxvdTOixqCSNHPWC+W1UeHSFDB5a+MOgnJLHI=;
        b=c3sv5DwIx6rXrS13Y/uDhUSx0cqSokh194UxZ6TjXLIFquxm5/Z+Yy4+hNcvr6rA/wTjCb
        jYDa945yQ0FmT2g5SEHI+4tBaqwTygdR4awiB3hRssx7o4bnc9YIgX1HgjghfvIPIXmN36
        hPSFOSMcyJOmYk2rAzblQp7nVsXAe5Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-kjjaHxJuOUivsKg__do2VA-1; Thu, 11 Jun 2020 08:56:38 -0400
X-MC-Unique: kjjaHxJuOUivsKg__do2VA-1
Received: by mail-qt1-f199.google.com with SMTP id l26so4720744qtr.14
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Fq4jWTmxvdTOixqCSNHPWC+W1UeHSFDB5a+MOgnJLHI=;
        b=QyIRGOsm57mvQkDI4koNxuPVxeD5eGQ8spzqnFyyvK5KM+WTcbnGoWC4qEG1lhSkdC
         EC0CnkPteWrBxyIeaUA/cTmxIbJA6a606xtgfKurNGm2UzHmcKBy/3cOQRgGoOzWb/n3
         7EVRT0vDB1KVRH0BJcTytKyw35qwBe6gk6+Z+bbh5EuVmr1ASJ7cn35pOAofz8EEuaRT
         YKHrdfoY+iOdYYaqQFqW1zEhmPjOpmv1l5pXhjbNRR4KnbrJlQtMX9HP/7jjommA+PDo
         ha8pkW7s6Yo5IhVftKQfn+vcw3ET+Kt+qWT6/bMimdT38C7QTVrwa54G+UBQs+IU/zDk
         YSIQ==
X-Gm-Message-State: AOAM5335TFE7VBnFSsy0OTUPVS9UE2kZPTEiHE7UR9cYAq2u4kAuUaAN
        +/ifDi9WiN+Xu4JEo31cJebVZEeFOSuxve76ITqVrV43WdUJ7u4oIdDEoFseGyOJRVHzarcDGAY
        zQBKhx7wvoy4lZyjuEUeyzYnT
X-Received: by 2002:a05:6214:b33:: with SMTP id w19mr7223586qvj.7.1591880197758;
        Thu, 11 Jun 2020 05:56:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+JyKVnjOWvjSt9Z4+PqIeU1E00Ib2Tef8IcgZTQ1YgELkIq0HkZauAQyYv/J2UaWpMgxv7Q==
X-Received: by 2002:a05:6214:b33:: with SMTP id w19mr7223575qvj.7.1591880197557;
        Thu, 11 Jun 2020 05:56:37 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b4sm2229646qtp.63.2020.06.11.05.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 05:56:36 -0700 (PDT)
Subject: Re: [PATCH 0/6] Add more configuration and regmap support for
 spi-altera
To:     Xu Yilun <yilun.xu@intel.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com
References: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <fb4a6f25-9f93-7618-d64e-20b93b1fcade@redhat.com>
Date:   Thu, 11 Jun 2020 05:56:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset looks good to me.

Reviewed-by: Tom Rix <trix@redhat.com>

Thanks,

Tom

On 6/10/20 8:25 PM, Xu Yilun wrote:
> This patchset adds platform_data for spi-altera, to enable more IP
> configurations, and creating specific spi client devices. It also adds
> regmap support, to enable the indirect access to this IP.
>
> We have a PCIE based FPGA platform which integrates this IP to communicate
> with a BMC chip (Intel MAX10) over SPI. The IP is configured as 32bit data
> width. There is also an indirect access interface in FPGA for host to
> access the registers of this IP. This patchset enables this use case.
>
> Matthew Gerlach (1):
>   spi: altera: fix size mismatch on 64 bit processors
>
> Xu Yilun (5):
>   spi: altera: add 32bit data width transfer support.
>   spi: altera: add SPI core parameters support via platform data.
>   spi: altera: add platform data for slave information.
>   spi: altera: use regmap instead of direct mmio register access
>   spi: altera: move driver name string to header file
>
>  drivers/spi/Kconfig        |   1 +
>  drivers/spi/spi-altera.c   | 161 +++++++++++++++++++++++++++++++++++++--------
>  include/linux/spi/altera.h |  37 +++++++++++
>  3 files changed, 171 insertions(+), 28 deletions(-)
>  create mode 100644 include/linux/spi/altera.h
>

