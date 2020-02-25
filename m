Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959CBC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C682176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UX/uBkct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgBYJYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:24:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36191 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgBYJY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:24:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so13812263wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 01:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=B2Wn7bp8mwDsyKil1xJSYrr5dzE0ECUygFczfDQtiCc=;
        b=UX/uBkctcPJP7Z9Ef3O9L7Rh8MRawKboHaoXxjT/K66NeGwG0xk3hLaVqNsZib8s2m
         X5X251q1fKiBr05kj8dAU1xM1nk70DwP0UEVz4cQptIEKTTjTFGM+I6Fp/l2yLHju8Uc
         b1Y56hmnySg6k0r0yqRIUS+Vbz9zP9Oq2Bka56+o+ZdH05r9+ENl+1C7RwhWreRM/YKX
         uvALM6Hqi5NPnpd/9wXgl/21UdavNoJjnyfOr7r2wP/SDXRCkM0N7gJdzA2l4onPDIu8
         FX0Slj6HNRxpG8w1fgeCB/RKyvDj0Hn7z3iNkh7Ky6ft4T9vxNXOvf4PcZElGbN7saqa
         r7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B2Wn7bp8mwDsyKil1xJSYrr5dzE0ECUygFczfDQtiCc=;
        b=iCLkik+kiKu2s/BbA3Gz+3YRrEuefUVKzF7iVgePr78SdjP9NBdd+4kek3S0TtJZuC
         Nz65mxZYlK5VLTwGWozuHhQi2fCabUFHvi9YdWWvr0yDlPg7aeHoaNLViWIC/a0rCS9V
         QaGWKio28/EmouMRehVSijj+GGDxojd+zDxZeA7TQ4WZU7H6mE/A7iIZWDsjZhX8EQpj
         soFh8Lxye0kXVXjpbEkeMo0M05XeQvUCv0kufcle50tJLjw8CEn9PcgOc/0qK4SMD/mR
         4ZH6uXGxW7dsO2ro4oc8Z+WmOY0pD/Bal7kzmpmg8lhUCc3JtpkXugMVZ2SfeRj06Kdy
         r5CA==
X-Gm-Message-State: APjAAAX4r+AzkABM+r4jlK2aSbZqIbQeB3lplpgF6A6ivwY7nHZj9mXZ
        2DPYp2YGHCuXp7Dh+j68+1KEkw==
X-Google-Smtp-Source: APXvYqyFOfTgV+V6vmdVHCuWMMJUDmnzwi6Ot5XHkHO9FlpDBsFTOAzK2PxOP/WSt92wo2kSTR0qPA==
X-Received: by 2002:adf:aadb:: with SMTP id i27mr75876977wrc.105.1582622666951;
        Tue, 25 Feb 2020 01:24:26 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id a22sm3344132wmd.20.2020.02.25.01.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 01:24:25 -0800 (PST)
Date:   Tue, 25 Feb 2020 09:24:57 +0000
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
Subject: Re: [PATCH v6 11/19] mfd: intel_soc_pmic_bxtwc: Convert to use new
 SCU IPC API
Message-ID: <20200225092457.GY3494@dell>
References: <20200217131446.32818-1-mika.westerberg@linux.intel.com>
 <20200217131446.32818-12-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200217131446.32818-12-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020, Mika Westerberg wrote:

> Convert the Intel Broxton Whiskey Cover PMIC driver to use the new SCU
> IPC API. This allows us to get rid of the PMC IPC implementation which
> is now covered in SCU IPC driver. We drop the error log if the IPC
> command fails because intel_scu_ipc_dev_command() does that already.
> 
> Also move PMIC specific IPC message constants to the PMIC driver from
> the intel_pmc_ipc.h header.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_pmc_ipc.h |  3 ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c   | 34 ++++++++++++++--------------
>  2 files changed, 17 insertions(+), 20 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
