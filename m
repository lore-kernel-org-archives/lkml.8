Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801D3C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2171621D46
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbzUu3wZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgIIVOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:14:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29237 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726408AbgIIVOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599686044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=flt0vZjtupO4BhZTnrF4cJuXNpxXUArPDdGRHgaQJh8=;
        b=VbzUu3wZc3nblpV3NqASa9JG3/OXk6zkDSmETzTMVHMcvjQMKT1DMme1ypONJ7FQt/+iwS
        WZUHPKTQUm6Lti9QZSsg/2hOMDnJHGEY+LP/pLs98cLMwVS1W90L7TLIugLRli9OEICTAG
        jGjv1nDMaNZ0ybzlY6rAKn36eiLn1uM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-q-VLg_65MnOkTS1OuVAfiA-1; Wed, 09 Sep 2020 17:14:02 -0400
X-MC-Unique: q-VLg_65MnOkTS1OuVAfiA-1
Received: by mail-qk1-f200.google.com with SMTP id s141so2186399qka.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 14:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=flt0vZjtupO4BhZTnrF4cJuXNpxXUArPDdGRHgaQJh8=;
        b=cU1FpSCAdUBniPoDSU0yy/S8MDUrZ4wc2Xb3VwtbWjufhAxhxpvYoy5ZiwDve9om2R
         dY2Y3lD1JWUhJNtK3ZRV8m7SUnQKXfCBtbbA8sh1279cTjVqtl3wfiqKYPAslzQpSStS
         pEN4xEpx96PZknn3Y6sJ+zwmFEZAdDGYlzjFWNfAyzZLZiARtgUCsjs0qkxi0hnD/tFA
         kX4Qj72lUqhYPcZaGE3006OkXOoJnY217dsQOKvuhQiD1Wbl1OAaWFnIbwfpqvL7tWEK
         nFJfWKj0KF73EpUmoda41XQSWSmZlhWnTixuoRKI9D0eWKYHzPNe/LX1FnYzkUYgJLcg
         U4Sw==
X-Gm-Message-State: AOAM532ynauhahutJOqSaVDRaX0PXNpCkLHDOKFlR3zmq0tIDxEs9hQv
        W7VV9SOS2FK/YNktCFgEMTpIm4+brnS+F6E+pZIoOfzOfgjVw+FPWP4rwvcI82Xh+FyQbsz5UnI
        BHdmbntAgN6qe010TzezydS3C
X-Received: by 2002:a05:620a:567:: with SMTP id p7mr5307794qkp.164.1599686042139;
        Wed, 09 Sep 2020 14:14:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxelahEbXCJiVWCSYD1eRWMhxmTJwjtxCSAXIXQuZh3Dl5ebQkWRsonB1gBL69zicWzPYE1UA==
X-Received: by 2002:a05:620a:567:: with SMTP id p7mr5307772qkp.164.1599686041865;
        Wed, 09 Sep 2020 14:14:01 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m68sm2009028qkd.105.2020.09.09.14.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 14:14:01 -0700 (PDT)
Subject: Re: [PATCH 0/3] add VFIO mdev support for DFL devices
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        linux-fpga@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com
References: <1599549212-24253-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <93200a4f-55a3-0798-3ef2-e0467288d5ba@redhat.com>
Date:   Wed, 9 Sep 2020 14:13:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1599549212-24253-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new interface, the documentation needs to go

into greater detail. I am particularly interested in the user workflow.

This seems like it would work only for kernel modules. 

Please describe both in the documentation.

A sample of a user mode driver would be helpful.

Is putting driver_override using sysfs for each device scalable ? would a list sets of {feature id,files}'s the vfio driver respond to better ? 

To be consistent the mdev driver file name should be dfl-vfio-mdev.c

There should be an opt-in flag for drivers being overridden instead of blanket approval of all drivers.

Tom

On 9/8/20 12:13 AM, Xu Yilun wrote:
> These patches depend on the patchset: "Modularization of DFL private
> feature drivers" & "add dfl bus support to MODULE_DEVICE_TABLE()"
>
> https://lore.kernel.org/linux-fpga/1599488581-16386-1-git-send-email-yilun.xu@intel.com/
>
> This patchset provides an VFIO Mdev driver for dfl devices. It makes
> possible for dfl devices be direct accessed from userspace.
>
> Xu Yilun (3):
>   fpga: dfl: add driver_override support
>   fpga: dfl: VFIO mdev support for DFL devices
>   Documentation: fpga: dfl: Add description for VFIO Mdev support
>
>  Documentation/ABI/testing/sysfs-bus-dfl |  20 ++
>  Documentation/fpga/dfl.rst              |  20 ++
>  drivers/fpga/Kconfig                    |   9 +
>  drivers/fpga/Makefile                   |   1 +
>  drivers/fpga/dfl.c                      |  54 ++++-
>  drivers/fpga/vfio-mdev-dfl.c            | 391 ++++++++++++++++++++++++++++++++
>  include/linux/fpga/dfl-bus.h            |   2 +
>  7 files changed, 496 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/fpga/vfio-mdev-dfl.c
>

