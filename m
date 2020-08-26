Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF52C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA4720737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HCgGTSL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHZSGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHZSGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:06:36 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68EDC061574;
        Wed, 26 Aug 2020 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Yzdof1CrmZPvQSdWOfnC4TP7kZhRZYrI2aPOvWW4r0c=; b=HCgGTSL+FAaNQNPUZggHMSb/qU
        IOTBhz+Gg+i0Vgo1UqD00Xd1bY4o0NmLCN8nqXTxmBC9NFAKFsSUyOKarB2Wposx0hpyb+zOmjPQg
        N1Pj5XE7fwFSollzF5tTgqRkMuu3E7DOs1Hv/6P26G6/qt/ghuswHev9pEistMeEjTY1CssjjxRBc
        xwh89LItYYWmXe4EzAChp0L/kw46jqk6qV3ytzIhypWPSvzAq+po7+V6OPpo2DNMcRrjU6ANbB9n5
        m82JxLjOc3XD6u9xeBAE80WxpjiuIGjy+VPGHlMe46+dWX+djVwLoICRL5d606rF0oLtfkH1hq+ld
        YZ6UJ8rA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAzoa-0000W1-VS; Wed, 26 Aug 2020 18:06:29 +0000
Subject: Re: [PATCH v6 6/6] Documentation: ACPI: Document
 allow-low-power-probe _DSD property
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, Bingbu Cao <bingbu.cao@intel.com>,
        linux-media@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rajmohan.mani@intel.com, Tomasz Figa <tfiga@chromium.org>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>
References: <20200826115432.6103-1-sakari.ailus@linux.intel.com>
 <20200826115432.6103-7-sakari.ailus@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ac5a7cb9-7fd1-fb73-b872-d5a58846d99f@infradead.org>
Date:   Wed, 26 Aug 2020 11:06:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826115432.6103-7-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/20 4:54 AM, Sakari Ailus wrote:
> Document the probe-low-power _DSD property and how it is used with I²C
> drivers.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  .../acpi/dsd/allow-low-power-probe.rst        | 28 +++++++++++++++++++
>  Documentation/firmware-guide/acpi/index.rst   |  1 +
>  2 files changed, 29 insertions(+)
>  create mode 100644 Documentation/firmware-guide/acpi/dsd/allow-low-power-probe.rst
> 
> diff --git a/Documentation/firmware-guide/acpi/dsd/allow-low-power-probe.rst b/Documentation/firmware-guide/acpi/dsd/allow-low-power-probe.rst
> new file mode 100644
> index 0000000000000..6fcc89162b898
> --- /dev/null
> +++ b/Documentation/firmware-guide/acpi/dsd/allow-low-power-probe.rst
> @@ -0,0 +1,28 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================
> +Probing I²C devices in low power state
> +======================================
> +
> +Introduction
> +============
> +
> +In some cases it may be preferred to leave certain devices powered off for the
> +entire system bootup if powering on these devices has adverse side effects,
> +beyond just powering on the said device. Linux recognizes the _DSD property
> +"allow-low-power-probe" that can be used for this purpose.
> +
> +How it works
> +============
> +
> +The property "allow-low-power-probe" boolean property may be used to tell Linux

Drop the first "property".

> +that the I²C framework should instruct the kernel ACPI framework to leave the
> +device in the low power state. If the driver indicates its support for this by
> +setting the I2C_DRV_FL_ALLOW_LOW_POWER_PROBE flag in struct i2c_driver.flags
> +field and the "allow-low-power-probe" property is present, the device will not
> +be powered on for probe.

thanks.
-- 
~Randy

