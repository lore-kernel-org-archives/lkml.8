Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457B2C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 06:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2B820738
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 06:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="INFWHtf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgH2G4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 02:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgH2G4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 02:56:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D339C061236
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 23:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=bxHexHiPlyNdhHAodxRi7MUtYBNji9c53gJAu6KWNtQ=; b=INFWHtf/ST9bM/wqLyCq+I4nnI
        F4b671LD+l1YSBsv1gZnvvd4H1xMhASDhUaHF2JlirM+jNfRNhWB+6PmeQrfXkVEzgkM9LSc3NXAm
        YSDjs3dwZVf/VHlGJfh+isJqdWgBekAnuNhRZInjQB309Shq/A+lzRjvxDHE7ltufeld1e7vAfg+/
        XOZTzYrrCpx8FPN4urGv2At6v0QMfFSAa9WYlV+qEYRaSSk2KTm90OZrSwAotGHCMEYLEw4CCsPfI
        DXMHTB6eGeQ4sK5ymoVrINolpP7b8DN2yTcHmv69FSVtPKC7go0KXcwZaT7/AC7xXJGUOIhP3Y289
        1CPj79hQ==;
Received: from [2601:1c0:6280:3f0::96df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBuma-0007Bw-Hr; Sat, 29 Aug 2020 06:56:12 +0000
Subject: Re: aarch64 iio build error [PATCH]
To:     Dave Airlie <airlied@gmail.com>, jonathan.cameron@huawei.com,
        LKML <linux-kernel@vger.kernel.org>
References: <CAPM=9txbCfEB0x+uxw9qWH24-ziY5BK25r-S-HWYhe+UCW_rKQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <380f1b70-6575-5869-edf4-28842e818732@infradead.org>
Date:   Fri, 28 Aug 2020 23:56:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPM=9txbCfEB0x+uxw9qWH24-ziY5BK25r-S-HWYhe+UCW_rKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/20 12:39 PM, Dave Airlie wrote:
> Hi Jonahtan,
> 
> Since rc1 my aarch64 builds have been failing
> 
>   MODPOST Module.symvers
> ERROR: modpost: "devm_iio_triggered_buffer_setup"
> [drivers/iio/adc/rockchip_saradc.ko] undefined!
> ERROR: modpost: "iio_trigger_notify_done"
> [drivers/iio/adc/rockchip_saradc.ko] undefined!
> ERROR: modpost: "iio_push_to_buffers"
> [drivers/iio/adc/rockchip_saradc.ko] undefined!
> make[2]: *** [/home/airlied/devel/kernel/dim/src/scripts/Makefile.modpost:111:
> Module.symvers] Error
> 
> Attached config.
> 
> Dave.

I haven't see any fixes for this, although I could have easily
missed a patch.

The patch below should fix these build errors.

---
From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors in iio/rockchip_saradc by adding selects
to drivers/iio/adc/Kconfig.

Fixes these build errors:

ERROR: modpost: "devm_iio_triggered_buffer_setup"
[drivers/iio/adc/rockchip_saradc.ko] undefined!
ERROR: modpost: "iio_trigger_notify_done"
[drivers/iio/adc/rockchip_saradc.ko] undefined!
ERROR: modpost: "iio_push_to_buffers"
[drivers/iio/adc/rockchip_saradc.ko] undefined!

Reported-by: Dave Airlie <airlied@gmail.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: jonathan.cameron@huawei.com
---
 drivers/iio/adc/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20200825.orig/drivers/iio/adc/Kconfig
+++ linux-next-20200825/drivers/iio/adc/Kconfig
@@ -865,6 +865,10 @@ config ROCKCHIP_SARADC
 	tristate "Rockchip SARADC driver"
 	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
 	depends on RESET_CONTROLLER
+	select IIO_BUFFER
+	select IIO_TRIGGER
+	select IIO_TRIGGERED_BUFFER
+	select IIO_TRIGGERED_EVENT
 	help
 	  Say yes here to build support for the SARADC found in SoCs from
 	  Rockchip.
