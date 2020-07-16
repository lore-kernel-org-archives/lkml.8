Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27015C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF14A20760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZyITWdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgGPXVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:21:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52287 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726333AbgGPXVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594941673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TIFp0Hg7q04yf1DG6HMd9RGoWeHArzTBdvRZoWQamlI=;
        b=ZZyITWdZzUpnU3UL9yU1OoHzqC56oiPPr0fn0mUF4qk2g/g5V+s84FOQm2vclSz7S/T5u4
        fKm39WgbIrKhq5uHEcHxhUJdNnQ6CsC86WXbuKgARNZbQIW4WWqYvFU4jEOmJopL36LaNN
        O6/GmmCLTL1oN99EQUbrKqjZ9L+MtkA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-27nXiqm1NS6ECX0Exu4U7A-1; Thu, 16 Jul 2020 18:50:55 -0400
X-MC-Unique: 27nXiqm1NS6ECX0Exu4U7A-1
Received: by mail-qv1-f70.google.com with SMTP id j4so4373839qvt.20
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 15:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TIFp0Hg7q04yf1DG6HMd9RGoWeHArzTBdvRZoWQamlI=;
        b=o3iOP3NGTc+C/2u+Yo/AZjuCoZtS8wp+SUcPt5kKyCJvdwVc2ZjyYZuS9zC8do/0B+
         qH+cSoN7fcedI6Fqtl3I+BXxnEW+MMhYtnNGjmuC/M7j19DcoQbtOf5rZoJjGX1BnM/O
         LMi7DLHw6RNh8JoWdpc6UtbnscdLefr0Pc18gBNpFJUHW9X/CBR6brjfjDN+46YtHQJ5
         dOdkBM20mVVlPKoTkipXiVUUJZ5LCuQW/IalSyYxyxu0BLec47UDW1tJKQiHz7Qx2rIu
         8hRXwR6Qc+LeJ79gDR0VXHCyFaULb//MaDitq4/qhKANiXcp2e9Bgo906QYIXBzc6ZJP
         nP4A==
X-Gm-Message-State: AOAM5318RXHkJCekAvCkqlzvM6tW9eTc/m7koBtchpAzD2hxnfOb1adp
        L4f4wnTSbXZR0UdOC7ag+LH0b90kqUi8i0x/bfwNyt6coBx/nN4Nl/XuS7MG2b2cvNCotV6whYq
        7EVqnfaX8ibe0hIY5VAoE6upB
X-Received: by 2002:a37:6343:: with SMTP id x64mr6351693qkb.114.1594939854034;
        Thu, 16 Jul 2020 15:50:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9I+YtgVZqYJkdYGFK6gqcCdhQADDw6d3C/sjWjsOMDp/j86RqH2uKqe6zw6lUnjp2cIPBRg==
X-Received: by 2002:a37:6343:: with SMTP id x64mr6351678qkb.114.1594939853688;
        Thu, 16 Jul 2020 15:50:53 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a6sm8439003qkd.69.2020.07.16.15.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 15:50:52 -0700 (PDT)
Subject: Re: [PATCH 0/2] Modularization of DFL private feature drivers
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0c7c63b8-5444-2deb-9fed-18956a5ad938@redhat.com>
Date:   Thu, 16 Jul 2020 15:50:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generally i think this is a good approach.

However I do have concern.

The feature_id in dfl is magic number, similar to pci id but without a vendor id.

Is it possible to add something like a vendor id so different vendors would not have to be so careful to use a unique id ?

This touches some of the matching function of the bus ops.  Could there be a way for bus ops to be used so that there could be multiple matching function.  Maybe the one in 0002 as a default so users could override it ?

The use case I am worrying about is an OEM.  The OEM uses an unclaimed feature_id and supplies their own platform device device driver to match the feature_id.  But some later version of the kernel claims this feature_id and the OEM's driver no longer works and since the value comes from pci config space it is difficult to change.

So looking for something like

register_feature_matcher((*bus_match)(struct device *dev, struct device_driver *drv))

static int dfl_bus_match_default(struct device *dev, struct device_driver *drv)
{
    struct dfl_device *dfl_dev = to_dfl_dev(dev);
    struct dfl_driver *dfl_drv = to_dfl_drv(drv);
    const struct dfl_device_id *id_entry = dfl_drv->id_table;

    while (id_entry->feature_id) {
        if (dfl_match_one_device(id_entry, dfl_dev)) {
            dfl_dev->id_entry = id_entry;
            return 1;
        }
        id_entry++;
    }

    return 0;
}

register_feature_matcher(&dfl_bus_match_default)

static int dfl_bus_match(struct device *dev, struct device_driver *drv)
{

    struct dfl_device *dfl_dev = to_dfl_dev(dev);
    struct dfl_driver *dfl_drv = to_dfl_drv(drv);
    const struct dfl_device_id *id_entry = dfl_drv->id_table;

    while (id_entry->feature_id) {

        matcher = Loop over matchers()

        if (matcher(dev, drv)) {
            dfl_dev->id_entry = id_entry;
            return 1;
        }
        id_entry++;
    }

    return 0;
}

Or maybe use some of the unused bits in the dfl header to add a second vendor-like id and change existing matcher to look feature_id and vendor_like_id.

Tom

 

On 7/14/20 10:38 PM, Xu Yilun wrote:
> This patchset makes it possible to develop independent driver modules
> for DFL private features. It also helps to leverage existing kernel
> drivers to enable some IP blocks in DFL.
>
> Xu Yilun (2):
>   fpga: dfl: map feature mmio resources in their own feature drivers
>   fpga: dfl: create a dfl bus type to support DFL devices
>
>  Documentation/ABI/testing/sysfs-bus-dfl |  15 ++
>  drivers/fpga/dfl-pci.c                  |  21 +-
>  drivers/fpga/dfl.c                      | 435 +++++++++++++++++++++++++++-----
>  drivers/fpga/dfl.h                      |  91 ++++++-
>  4 files changed, 492 insertions(+), 70 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
>

