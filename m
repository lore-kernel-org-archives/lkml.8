Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F38C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 15:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75AFA206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 15:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594569397;
	bh=qytnBpeo5SVmmrKysDJrmaQrOV+4aUUXlH6YcA2atXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YwYB4C7P1uQAsMa8xtX+8RO4rtNIm6mgB3xNe0cj0gdEgW8laAyMq5+NXHPce+bDj
	 zBiLmjCs6/rhGY2F8AMy+y5ScoTDl1zdWLutyVKgK4FK/CZMOZi68PdxEJJpxsK0IP
	 O2X1Fn/Qo49UFbEyLHTjHrhM0vGhmkCVtG+X1V5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgGLP4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 11:56:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728862AbgGLP4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 11:56:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C862B2068F;
        Sun, 12 Jul 2020 15:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594569395;
        bh=qytnBpeo5SVmmrKysDJrmaQrOV+4aUUXlH6YcA2atXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jLK9c0cwUji2AL9QM0O8ri9t+/eN7uc0xqTiv5xKlXcMek+++TydqAOy4wMJsy2MP
         aUxAZazB2kdCCJWcLXBenUDqGT8Ir0aHfHuFv8LqrHq4WW9hag7otuCUoBGUKiS4pT
         RguLSdz2S16fHqAYdlM6fWLphaBb1i8YLK+uG6zY=
Date:   Sun, 12 Jul 2020 17:56:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gage Eads <gage.eads@intel.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: Re: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
Message-ID: <20200712155631.GB186665@kroah.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-2-gage.eads@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712134331.8169-2-gage.eads@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 08:43:12AM -0500, Gage Eads wrote:
> +config INTEL_DLB2
> +       tristate "Intel(R) Dynamic Load Balancer 2.0 Driver"
> +       depends on 64BIT && PCI && X86

Why just that platform?  What about CONFIG_TEST for everything else?

> +       help
> +         This driver supports the Intel(R) Dynamic Load Balancer 2.0 (DLB 2.0)
> +         device.

Are you sure you need the (R) in Kconfig texts everywhere?

And a bit more info here would be nice, as no one knows if they have
this or not, right?

> --- /dev/null
> +++ b/drivers/misc/dlb2/dlb2_hw_types.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)

Why dual licensed?  I thought that Intel told me they were not going to
do that anymore for any kernel code going forward as it was just such a
pain and never actually helped anything.  Has that changed?


> + * Copyright(c) 2016-2020 Intel Corporation
> + */
> +
> +#ifndef __DLB2_HW_TYPES_H
> +#define __DLB2_HW_TYPES_H
> +
> +#define DLB2_MAX_NUM_VDEVS 16
> +#define DLB2_MAX_NUM_DOMAINS 32
> +#define DLB2_MAX_NUM_LDB_QUEUES 32 /* LDB == load-balanced */
> +#define DLB2_MAX_NUM_DIR_QUEUES 64 /* DIR == directed */
> +#define DLB2_MAX_NUM_LDB_PORTS 64
> +#define DLB2_MAX_NUM_DIR_PORTS DLB2_MAX_NUM_DIR_QUEUES
> +#define DLB2_MAX_NUM_LDB_CREDITS 8192
> +#define DLB2_MAX_NUM_DIR_CREDITS 2048
> +#define DLB2_MAX_NUM_HIST_LIST_ENTRIES 2048
> +#define DLB2_MAX_NUM_AQED_ENTRIES 2048
> +#define DLB2_MAX_NUM_QIDS_PER_LDB_CQ 8
> +#define DLB2_MAX_NUM_SEQUENCE_NUMBER_GROUPS 2
> +#define DLB2_MAX_NUM_SEQUENCE_NUMBER_MODES 5
> +#define DLB2_QID_PRIORITIES 8
> +#define DLB2_NUM_ARB_WEIGHTS 8
> +#define DLB2_MAX_WEIGHT 255
> +#define DLB2_NUM_COS_DOMAINS 4
> +#define DLB2_MAX_CQ_COMP_CHECK_LOOPS 409600
> +#define DLB2_MAX_QID_EMPTY_CHECK_LOOPS (32 * 64 * 1024 * (800 / 30))
> +#define DLB2_HZ 800000000

No tabs?  How easy is that to read?  :(

greg k-h
