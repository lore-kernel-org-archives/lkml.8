Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7C0C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983A420643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zP/tWS3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgEGNeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:34:13 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47232 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgEGNeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=r6eWlavmJYFaBTK6r09hetkA8pAPpK8I2TqwDeTM2JY=; b=zP/tWS3SdCBoj5Lh0SgOxCGgXx
        ghpwqWGrUjeN/zzDqNsQQ6KuGefokWV1EaFGrsXjvYiA2UfGipq633L0tD7ruCcxqJN22804AVigL
        TpAYp5Dvula+Xey3wO3E6/yHCpxasC6be+Cl044t+PB+eTkWMLFlINgCy0Agtd/eOcTk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jWgfC-001EFc-Fn; Thu, 07 May 2020 15:34:10 +0200
Date:   Thu, 7 May 2020 15:34:10 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Diana Craciun <diana.craciun@oss.nxp.com>
Cc:     linux-kernel@vger.kernel.org, stuyoder@gmail.com,
        gregkh@linuxfoundation.org, leoyang.li@nxp.com,
        Bharat Bhushan <Bharat.Bhushan@nxp.com>,
        linux-arm-kernel@lists.infradead.org, laurentiu.tudor@nxp.com
Subject: Re: [PATCH v2 03/12] bus/fsl-mc: add support for 'driver_override'
 in the mc-bus
Message-ID: <20200507133410.GN208718@lunn.ch>
References: <20200507073431.2710-1-diana.craciun@oss.nxp.com>
 <20200507073431.2710-4-diana.craciun@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507073431.2710-4-diana.craciun@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 10:34:22AM +0300, Diana Craciun wrote:
> From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> 
> This patch is required for vfio-fsl-mc meta driver to successfully bind
> layerscape container devices for device passthrough. This patch adds
> a mechanism to allow a layerscape device to specify a driver rather than
> a layerscape driver provide a device match.
> 
> Example to allow a device (dprc.1) to specifically bind
> with driver (vfio-fsl-mc):
>  - echo vfio-fsl-mc > /sys/bus/fsl-mc/devices/dprc.1/driver_override
>  - echo dprc.1 > /sys/bus/fsl-mc/drivers/fsl_mc_dprc/unbind
>  - echo dprc.1 > /sys/bus/fsl-mc/drivers/vfio-fsl-mc/bind

Hi Bharat, Diana

grep -r "/driver_override" Documentation 
Documentation/ABI/testing/sysfs-bus-rpmsg:What:		/sys/bus/rpmsg/devices/.../driver_override
Documentation/ABI/testing/sysfs-bus-pci:What:		/sys/bus/pci/devices/.../driver_override
Documentation/ABI/testing/sysfs-bus-platform:What:		/sys/bus/platform/devices/.../driver_override
Documentation/ABI/testing/sysfs-bus-css:What:		/sys/bus/css/devices/.../driver_override
Documentation/ABI/testing/sysfs-bus-vmbus:What:		/sys/bus/vmbus/devices/.../driver_override
Documentation/ABI/testing/sysfs-bus-amba:What:		/sys/bus/amba/devices/.../driver_override

Maybe it is time to move this into the core, and avoid yet another
implementation of driver_override_store() and driver_override_show()
functions etc.

   Andrew
