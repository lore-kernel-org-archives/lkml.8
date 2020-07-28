Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8C6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D28206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SW89oCq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgG1M0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgG1M0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:26:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30704C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=yBYvIwf9TAceURjTfcYJWCSxycUdyCXExJl0HOeXT9k=; b=SW89oCq4NVmToiCnFUrJCN6ESd
        JytiZ/mUug+oIj6e+zEeWlHiSOLXfoN+DB3W4fZyWLGB2JdgB/k1PhX4n3N5JJPnj2sRBF2ioO8bW
        mxjQx2rKpwYDLbVKQFTwnZABaW1K+3Kk+lbNiG92oTDwpX72vQ4dQSvLBBII0bqG5Gwfm6XNnf5Xm
        4N+/Gxt8iILk45H665pENdW9nFzakkmTjuOuAW8C+pxqX49BoPxLO2rt3YeQnAAYU9hXYBvdLItUt
        X2yrtQIrca5f7n1qfE5PxLkED5b5yKIbB0lyV25kAKdyC5o6dkvto9yMUh931OHkDaJccLWx7lC8n
        fnqI1X7A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0OgC-0001rr-4Y; Tue, 28 Jul 2020 12:26:00 +0000
Subject: Re: [PATCH RFC v6 2/6] drm/sprd: add Unisoc's drm kms master
To:     Kevin Tang <kevin3.tang@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <1595930879-2478-1-git-send-email-kevin3.tang@gmail.com>
 <1595930879-2478-3-git-send-email-kevin3.tang@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5ef12508-4600-a5f1-f456-ef0762b81d51@infradead.org>
Date:   Tue, 28 Jul 2020 05:25:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595930879-2478-3-git-send-email-kevin3.tang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/20 3:07 AM, Kevin Tang wrote:
> diff --git a/drivers/gpu/drm/sprd/Kconfig b/drivers/gpu/drm/sprd/Kconfig
> new file mode 100644
> index 0000000..b189a54
> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/Kconfig
> @@ -0,0 +1,12 @@
> +config DRM_SPRD
> +	tristate "DRM Support for Unisoc SoCs Platform"
> +	depends on ARCH_SPRD || COMPILE_TEST
> +	depends on DRM && OF
> +	select DRM_KMS_HELPER
> +	select DRM_GEM_CMA_HELPER
> +	select DRM_KMS_CMA_HELPER
> +	select DRM_MIPI_DSI
> +	help
> +	  Choose this option if you have a Unisoc chipsets.

	                                          chipset.

> +	  If M is selected the module will be called sprd-drm.

	                                             sprd_drm.

> +
> diff --git a/drivers/gpu/drm/sprd/Makefile b/drivers/gpu/drm/sprd/Makefile
> new file mode 100644
> index 0000000..86d95d9
> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +subdir-ccflags-y += -I$(srctree)/$(src)
> +
> +obj-y := sprd_drm.o


-- 
~Randy

