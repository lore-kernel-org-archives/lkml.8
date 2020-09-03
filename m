Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD14FC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A763020737
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COnn8dkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgICPDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:03:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24702 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728998AbgICN7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 09:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599141541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4d0hEtzj1O3cLEd0CxX1kXJFeAKPS5/bs25SNIlY4YA=;
        b=COnn8dkBJzEIwPBAmnnGndFE4V/PA/tzQHhkX2H9DbDFVfoTYEbJNSJFsIIqRSoBh1nTBR
        NtogilpwIXkTsxHv2rUNqR8jqXzdW18vaBVBC75oljCF8KRjHZhzl8ynUxCRHr8arnfeQc
        JCwMXPQuW7CVGAOhqf6FKg56jbPLISs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70--m16VAb4NcG2EptIAfNEgQ-1; Thu, 03 Sep 2020 09:40:16 -0400
X-MC-Unique: -m16VAb4NcG2EptIAfNEgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04D2380046A;
        Thu,  3 Sep 2020 13:40:15 +0000 (UTC)
Received: from [10.36.112.51] (ovpn-112-51.ams2.redhat.com [10.36.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 183D61C4;
        Thu,  3 Sep 2020 13:40:07 +0000 (UTC)
Subject: Re: [PATCH v4 00/10] vfio/fsl-mc: VFIO support for FSL-MC device
To:     Diana Craciun <diana.craciun@oss.nxp.com>,
        alex.williamson@redhat.com, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bharatb.linux@gmail.com,
        laurentiu.tudor@nxp.com
References: <20200826093315.5279-1-diana.craciun@oss.nxp.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <ae46be70-82d3-6137-6169-beb4bf8ae707@redhat.com>
Date:   Thu, 3 Sep 2020 15:40:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200826093315.5279-1-diana.craciun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Diana,

On 8/26/20 11:33 AM, Diana Craciun wrote:
> DPAA2 (Data Path Acceleration Architecture) consists in
> mechanisms for processing Ethernet packets, queue management,
> accelerators, etc.
> 
> The Management Complex (mc) is a hardware entity that manages the DPAA2
> hardware resources. It provides an object-based abstraction for software
> drivers to use the DPAA2 hardware. The MC mediates operations such as
> create, discover, destroy of DPAA2 objects.
> The MC provides memory-mapped I/O command interfaces (MC portals) which
> DPAA2 software drivers use to operate on DPAA2 objects.
> 
> A DPRC is a container object that holds other types of DPAA2 objects.
> Each object in the DPRC is a Linux device and bound to a driver.
> The MC-bus driver is a platform driver (different from PCI or platform
> bus). The DPRC driver does runtime management of a bus instance. It
> performs the initial scan of the DPRC and handles changes in the DPRC
> configuration (adding/removing objects).
> 
> All objects inside a container share the same hardware isolation
> context, meaning that only an entire DPRC can be assigned to
> a virtual machine.
> When a container is assigned to a virtual machine, all the objects
> within that container are assigned to that virtual machine.
> The DPRC container assigned to the virtual machine is not allowed
> to change contents (add/remove objects) by the guest. The restriction
> is set by the host and enforced by the mc hardware.
> 
> The DPAA2 objects can be directly assigned to the guest. However
> the MC portals (the memory mapped command interface to the MC) need
> to be emulated because there are commands that configure the
> interrupts and the isolation IDs which are virtual in the guest.
> 
> Example:
> echo vfio-fsl-mc > /sys/bus/fsl-mc/devices/dprc.2/driver_override
> echo dprc.2 > /sys/bus/fsl-mc/drivers/vfio-fsl-mc/bind
> 
> The dprc.2 is bound to the VFIO driver and all the objects within
> dprc.2 are going to be bound to the VFIO driver.
> 
> More details about the DPAA2 objects can be found here:
> Documentation/networking/device_drivers/freescale/dpaa2/overview.rst
> 
> The patches are dependent on some changes in the mc-bus (bus/fsl-mc)
> driver. The changes were needed in order to re-use code and to export
> some more functions that are needed by the VFIO driver.
> Currenlty the mc-bus patches are under review:
> https://www.spinics.net/lists/kernel/msg3639226.html
Could you share a branch with both series? This would help the review.

Thanks

Eric
> 
> v3 --> v4
> - use bus provided functions to tear down the DPRC
> - added reset support
> 
> v2 --> v3
> - There is no need to align region size to page size
> - read/write implemented for all DPAA2 objects
> - review fixes
> 
> v1 --> v2
> - Fixed the container reset, a new flag added to the firmware command
> - Implement a bus notifier for setting driver_override
> 
> 
> Bharat Bhushan (1):
>   vfio/fsl-mc: Add VFIO framework skeleton for fsl-mc devices
> 
> Diana Craciun (9):
>   vfio/fsl-mc: Scan DPRC objects on vfio-fsl-mc driver bind
>   vfio/fsl-mc: Implement VFIO_DEVICE_GET_INFO ioctl
>   vfio/fsl-mc: Implement VFIO_DEVICE_GET_REGION_INFO ioctl call
>   vfio/fsl-mc: Allow userspace to MMAP fsl-mc device MMIO regions
>   vfio/fsl-mc: Added lock support in preparation for interrupt handling
>   vfio/fsl-mc: Add irq infrastructure for fsl-mc devices
>   vfio/fsl-mc: trigger an interrupt via eventfd
>   vfio/fsl-mc: Add read/write support for fsl-mc devices
>   vfio/fsl-mc: Add support for device reset
> 
>  MAINTAINERS                               |   6 +
>  drivers/vfio/Kconfig                      |   1 +
>  drivers/vfio/Makefile                     |   1 +
>  drivers/vfio/fsl-mc/Kconfig               |   9 +
>  drivers/vfio/fsl-mc/Makefile              |   4 +
>  drivers/vfio/fsl-mc/vfio_fsl_mc.c         | 684 ++++++++++++++++++++++
>  drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c    | 221 +++++++
>  drivers/vfio/fsl-mc/vfio_fsl_mc_private.h |  56 ++
>  include/uapi/linux/vfio.h                 |   1 +
>  9 files changed, 983 insertions(+)
>  create mode 100644 drivers/vfio/fsl-mc/Kconfig
>  create mode 100644 drivers/vfio/fsl-mc/Makefile
>  create mode 100644 drivers/vfio/fsl-mc/vfio_fsl_mc.c
>  create mode 100644 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
>  create mode 100644 drivers/vfio/fsl-mc/vfio_fsl_mc_private.h
> 

