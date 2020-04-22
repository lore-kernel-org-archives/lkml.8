Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3890EC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E9020787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzChMebo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgDVNmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgDVNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:42:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61536C03C1A9;
        Wed, 22 Apr 2020 06:42:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id ay1so961252plb.0;
        Wed, 22 Apr 2020 06:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TIDuXbZ2U4Q/XGkKZ9RA/iT/l6pKZMhPvkvqlhOOBvM=;
        b=uzChMeboRHPUxQ56l516/IBfyUidRU3+UY8lsTkCgKBit2KAlpFYYtZFpOx+nynLqz
         On9GXR/hKPD8g9RxJvbaQ9Gl54zV/RNUye8IBw9ZSiRrVl8YbFxgZ823vTdJt/Eqbn+h
         Qt7wtYTmx/ZJ/+/fh9Qvua4Ko2t+xu8ARLd5Cb5TtoGaVI8xmHZrbf557qZwCn5ykKf/
         KAoPN1u5QN4/AosUwzcphBPNmsY1RFse76OTrasOvBMGKnyFKNBKcRRXdGSiW64qeHRb
         JNXM4dpFIT3VOMfUm5x3/4i+hmhY9L8CZamll9DSOITEmI5Bbay4jLtccjaJsgoschjy
         bzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TIDuXbZ2U4Q/XGkKZ9RA/iT/l6pKZMhPvkvqlhOOBvM=;
        b=kVizTNbauIUe75pbLYzlhI9nTAWgoNWO6lwTeRxVodfe+YSo4HTkjwnDi+Z9J4qdB8
         k0u2REocHNdvvYmyXXZbq8vEge0UGtPOLwcfePb21b0oU0jOOSRJXhWuIdGU4A1SS/Mf
         ErhVdSYrG0AbiwMvbtADx/DVE5ikBs5aFwrSyf2boSnNCQZ1xxxmDzkppaN9WXCvEP2/
         TX5QJGVULENu4cIRxRzIFcU1JBuoIIijK7OAZ/YWhnhg4i2G/aZQupti5ncpjEcr+9mb
         03/icI/K9dcpmAmG+CJuob3Q48VB7QZ/qlXUGcKmWBRYRzvkz39hMrlWSkMTugrdWyT+
         zmYA==
X-Gm-Message-State: AGi0PuZW94zuZEmDWL0bcJIvo9+N7+BcYeDeNbRYfzqdHUDujZKtrxAU
        O687RNrGdWmqe+zQMjNaUndSu45GjLzvynmFmHM=
X-Google-Smtp-Source: APiQypIhpYMQR1pywfJ3cBC+Sx23f83MTTS8W0amEFIO00K6rC8hY9Yi9SnMdufcfwG4NEBk0Xwsm2zb2vVclA641Gw=
X-Received: by 2002:a17:90a:224b:: with SMTP id c69mr12137070pje.8.1587562929796;
 Wed, 22 Apr 2020 06:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200420194405.8281-1-jithu.joseph@intel.com> <20200420194405.8281-2-jithu.joseph@intel.com>
In-Reply-To: <20200420194405.8281-2-jithu.joseph@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Apr 2020 16:42:03 +0300
Message-ID: <CAHp75VeV+HOditUphBkFoy6LLh6QKfBoC-eLixquAHLTwaz4RQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] platform/x86: Add Slim Bootloader firmware update
 signaling driver
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        maurice.ma@intel.com, ravi.p.rangarajan@intel.com,
        sean.v.kelley@intel.com, kuo-lang.tseng@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 10:50 PM Jithu Joseph <jithu.joseph@intel.com> wrote:
>
> Slim Bootloader(SBL) [1] is a small open-source boot firmware,
> designed for running on certain Intel platforms. SBL can be
> thought-of as fulfilling the role of a minimal BIOS
> implementation, i.e initializing the hardware and booting
> Operating System.
>
> Since SBL is not UEFI compliant, firmware update cannot be triggered
> using standard UEFI runtime services. Further considering performance
> impact, SBL doesn't look for a firmware update image on every reset
> and does so only when firmware update signal is asserted.
>
> SBL exposes an ACPI-WMI device which comes up in sysfs as
> /sys/bus/wmi/44FADEB1xxx and this driver adds a
> "firmware_update_request" device attribute. This attribute normally
> has a value of 0 and userspace can signal SBL to update firmware,
> on next reboot, by writing a value of 1:
>
> echo 1 > /sys/bus/wmi/devices/44FADEB1-B204-40F2-8581-394BBDC1B651/firmware_update_request
>
> This driver only implements a signaling mechanism, the actual firmware
> update process and various details like firmware update image format,
> firmware image location etc are defined by SBL [2] and are not in the
> scope of this driver.

I have noticed that it misses ABI documentation. So, please add. Also
some comments below.

...

> [1] https://slimbootloader.github.io
> [2] https://slimbootloader.github.io/security/firmware-update.html

Can you add a DocLink: tag below for the reference to the official
documentation?

...

> +SLIM BOOTLOADER (SBL) FIRMWARE UPDATE WMI DRIVER
> +M:     Jithu Joseph <jithu.joseph@intel.com>
> +R:     Maurice Ma <maurice.ma@intel.com>
> +S:     Maintained
> +W:     https://slimbootloader.github.io/security/firmware-update.html
> +F:     drivers/platform/x86/sbl_fwu_wmi.c

I hope you run latest and greatest version of checkpatch.pl and it's
okay with this section.

...

> @@ -114,6 +114,16 @@ config XIAOMI_WMI
>           To compile this driver as a module, choose M here: the module will
>           be called xiaomi-wmi.
>
> +config SBL_FWU_WMI
> +       tristate "WMI driver for Slim Bootloader firmware update signaling"
> +       depends on ACPI_WMI
> +       help
> +         Say Y here if you want to be able to use the WMI interface to signal
> +         Slim Bootloader to trigger update on next reboot.
> +
> +         To compile this driver as a module, choose M here: the module will
> +         be called sbl-fwu-wmi.

> @@ -15,6 +15,7 @@ obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)   += intel-wmi-thunderbolt.o
>  obj-$(CONFIG_MXM_WMI)                  += mxm-wmi.o
>  obj-$(CONFIG_PEAQ_WMI)                 += peaq-wmi.o
>  obj-$(CONFIG_XIAOMI_WMI)               += xiaomi-wmi.o
> +obj-$(CONFIG_SBL_FWU_WMI)              += sbl_fwu_wmi.o

I didn't get an ordering schema in above files.
Shouldn't be rather alphasort?

...

> +static ssize_t firmware_update_request_store(struct device *dev,
> +                                            struct device_attribute *attr,
> +                                            const char *buf, size_t count)
> +{
> +       bool val;
> +       int ret;
> +
> +       ret = kstrtobool(buf, &val);
> +       if (ret)
> +               return ret;
> +

> +       ret = set_fwu_request(dev, val ? 1 : 0);

Hmm... If you are going to extend this, why not to pass integer
directly? (And thus take one from user)

> +       if (ret)
> +               return ret;
> +
> +       return count;
> +}

> +

Extra blank line.

> +static DEVICE_ATTR_RW(firmware_update_request);
> +
> +static struct attribute *firmware_update_attrs[] = {
> +       &dev_attr_firmware_update_request.attr,
> +       NULL
> +};

> +

Extra blank line.

> +ATTRIBUTE_GROUPS(firmware_update);

...

> +MODULE_DEVICE_TABLE(wmi, sbl_fwu_wmi_id_table);

Move it closer to the table structure.

-- 
With Best Regards,
Andy Shevchenko
