Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE24AC4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A6C2076E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/xQo1zE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCTNfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:35:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53264 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbgCTNfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:35:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id 25so6533221wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 06:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YxuT8VTRArGqn+RIbW+oB8jNX+9BGigb4/P7CTp2s5o=;
        b=d/xQo1zEVHGFHHdCRvK8nW9vYq6E1xfkwHUI4GlFPAkTk2rJ93zWgsa1nut8ctMhGe
         VeA2tmm32Zl+raj+zbklYNwpNwZVrGRl/KL7Jug6kWnfjrmOTegCVdlJn53XoeIEZZjL
         rp/VqZw2cRv64TXa1hlwS4i4Qbh15SIgzxPI34v9T0JPXCLSRLSuqFlDMmpB9n4Nj2Jk
         rbNnT5SJO8v5GqtQY8co5lBXL5VEnixLdYKADGtcRN17BexHmwe93R6tAupYdz26vDsu
         v4IfzIX5KkJTeWJ+ZjXiG/4En9l4N0Far7/+Ha4U5k25Ho/TL+Dn0nGHOsEcIjGxTig0
         O1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YxuT8VTRArGqn+RIbW+oB8jNX+9BGigb4/P7CTp2s5o=;
        b=YBZZ4C0uZ1QI4oal1yEuUJ4wSfabDKaYx+KMtC+sJNtDgeMmmsC8MQyck0VXPOuyBz
         WL5sRjMcXChBnoSDpsWexkB8Qfn2uPQdx0RyvOHTAmVM79nMCGNBLk5GF3a/QOfMjOjI
         oheS4M2BFlRbjAO4urvkP9rIW2dNRpmbB9Dtpkq9v+N5ZW0vDxgaNZnsSxpDpQLAA8ra
         gCnu3+MPaoDN9zcJ3eZU2nvMZnxaCW4tvs7K6efmYhth3mmH2BWP+4Ac0vey5BJArpAz
         J0EC17myUz5sNB2CXTbG6N8zk3NlDi7YaPWIWjpxoB+WKB/Q0lVahy+NVHzZAZvruSEC
         BnBg==
X-Gm-Message-State: ANhLgQ0FAo3VMEH/iatEYutmCF6fP7HfQqfTr0R3GnUBLw5Qb0gz1jnU
        P2mn16dGW0QEmoJGRG+eAoYJLg==
X-Google-Smtp-Source: ADFU+vvbxhZ+jhlGwAXeXKHcTIWOulxfuzDlUOLQY4koNixlyTIbyAUF4Hg2xDKlNLPbZ3JGZf0lWg==
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr10692628wmf.50.1584711317396;
        Fri, 20 Mar 2020 06:35:17 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id m17sm8457182wrw.3.2020.03.20.06.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 06:35:16 -0700 (PDT)
Date:   Fri, 20 Mar 2020 13:36:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/19] platform/x86: intel_scu_ipc: Split out SCU IPC
 functionality from the SCU driver
Message-ID: <20200320133602.GE5477@dell>
References: <20200303133649.39819-1-mika.westerberg@linux.intel.com>
 <20200303133649.39819-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200303133649.39819-2-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Mar 2020, Mika Westerberg wrote:

> The SCU IPC functionality is usable outside of Intel MID devices. For
> example modern Intel CPUs include the same thing but now it is called
> PMC (Power Management Controller) instead of SCU. To make the IPC
> available for those split the driver into core part (intel_scu_ipc.c)
> and the SCU PCI driver part (intel_scu_pcidrv.c) which then calls the
> former before it goes and creates rest of the SCU devices. The SCU IPC
> will also register a new class that gets assigned to the device that is
> created under the parent PCI device.
> 
> We also split the Kconfig symbols so that INTEL_SCU_IPC enables the SCU
> IPC library and INTEL_SCU_PCI the SCU driver and convert the users
> accordingly. While there remove default y from the INTEL_SCU_PCI symbol
> as it is already selected by X86_INTEL_MID.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/Kconfig                        |   2 +-
>  arch/x86/include/asm/intel_scu_ipc.h    |  18 +++

>  drivers/mfd/Kconfig                     |   4 +-

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

>  drivers/platform/x86/Kconfig            |  24 ++--
>  drivers/platform/x86/Makefile           |   1 +
>  drivers/platform/x86/intel_scu_ipc.c    | 172 ++++++++++++++++--------
>  drivers/platform/x86/intel_scu_pcidrv.c |  55 ++++++++
>  7 files changed, 208 insertions(+), 68 deletions(-)
>  create mode 100644 drivers/platform/x86/intel_scu_pcidrv.c

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
