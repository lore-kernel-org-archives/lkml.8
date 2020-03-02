Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29097C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E566C217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCsQqhun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgCBP4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:56:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55128 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbgCBP4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:56:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id z12so11790741wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 07:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=b3t9aJpKXeK1YZcEru2kIhftxfshYeOnQjG1qownOxY=;
        b=ZCsQqhund0Bl0vrZ/HLmfGsxW+P97mm6Y+YzcAOyx3EZrWRw4XooGbDN+QpGa1Ff+t
         rOU1jPTnvzhZJpv8mVleUEAlwCumB5yvqkGKBZ+Reqzf2gjtxfN6p4nLZdAejZsEFZi8
         J42O9Dz4ZbEEvFyfXMZB6YRvFfnbL6WDvEX/gJZzYq3HkjXK6UTterIVApuC45TkTFdc
         RnsE9Gln2hTWvPcFWyUFAyuuuTZvCMALA2vcVfGRaOrMTYGUJ8nyYCpQmE+oX/mucTzO
         b2IksTI3UbgY1wNEuHSOrKHpUmWNsZxzwSPRmbThfD5UAZjbNkckm3sBD6yAu0gjFWyw
         D4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=b3t9aJpKXeK1YZcEru2kIhftxfshYeOnQjG1qownOxY=;
        b=E0uYiKNp1XMgbXCG5thpr40szbr5A7YcSlyZYrlnMRPONwrl3RGL1ypp+JB5diYiPS
         CgoLOpX1wi/trXLeEYnGs6CwGqVNzhELcATxhSd/12IkaPCSu/4mFoygVWE2szaQdWKF
         II3LG8J/yuBuJ0K2u7eLT8TjwXHAwNPCcyDIG0bPCfFa12aXfueM/mgOSp+5Pt+524G4
         7SBAa6/l85oFVD/sDyqZehClAk1NtTz+PbECvcSDaXrBE0boSda+zUC22dbSvC/zvRrU
         Re5ByFEAOqhMMBytGDCx/2nBVA4uDV3FWbfJUPAd9KT/eFK2YIqVmK5PwqRMqj5hgKUX
         FkBA==
X-Gm-Message-State: ANhLgQ0r6t1AmgvxUBkbic2yf8iYMVfD/qYrUDmeFRIvQ8seFJX9UiXf
        SkpcyBUNeGkqYFTEgSCaW/1aJw==
X-Google-Smtp-Source: ADFU+vu0GIhLzLXDBquuqbkjLhURd3FsUF9wGfdQaK+BZVVoyVOi2JRI+GBMEtGns797d/283FHtkA==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr128259wmb.42.1583164601025;
        Mon, 02 Mar 2020 07:56:41 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id o24sm15918154wmh.28.2020.03.02.07.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 07:56:40 -0800 (PST)
Date:   Mon, 2 Mar 2020 15:57:16 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
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
Subject: Re: [PATCH v7 00/19] platform/x86: Rework intel_scu_ipc and
 intel_pmc_ipc drivers
Message-ID: <20200302155716.GD3494@dell>
References: <20200302133327.55929-1-mika.westerberg@linux.intel.com>
 <20200302142621.GB3494@dell>
 <20200302143803.GI2667@lahna.fi.intel.com>
 <20200302151924.GC3494@dell>
 <20200302154205.GF1224808@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200302154205.GF1224808@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Mar 2020, Andy Shevchenko wrote:

> On Mon, Mar 02, 2020 at 03:19:24PM +0000, Lee Jones wrote:
> > On Mon, 02 Mar 2020, Mika Westerberg wrote:
> > > On Mon, Mar 02, 2020 at 02:26:21PM +0000, Lee Jones wrote:
> > > > On Mon, 02 Mar 2020, Mika Westerberg wrote:
> 
> > > > > Currently both intel_scu_ipc.c and intel_pmc_ipc.c implement the same SCU
> > > > > IPC communications with minor differences. This duplication does not make
> > > > > much sense so this series reworks the two drivers so that there is only a
> > > > > single implementation of the SCU IPC. In addition to that the API will be
> > > > > updated to take SCU instance pointer as an argument, and most of the
> > > > > callers will be converted to this new API. The old API is left there but
> > > > > the plan is to get rid the callers and then the old API as well (this is
> > > > > something we are working with Andy Shevchenko).
> > > > > 
> > > > > The intel_pmc_ipc.c is then moved under MFD which suits better for this
> > > > > kind of a driver that pretty much sets up the SCU IPC and then creates a
> > > > > bunch of platform devices for the things sitting behind the PMC. The driver
> > > > > is renamed to intel_pmc_bxt.c which should follow the existing conventions
> > > > > under drivers/mfd (and it is only meant for Intel Broxton derivatives).
> > > > > 
> > > > > This is on top of platform-driver-x86.git/for-next branch because there is
> > > > > already some cleanup work queued that re-organizes Kconfig and Makefile
> > > > > entries.
> > > > > 
> > > > > I have tested this on Intel Joule (Broxton-M) board.
> > > > > 
> > > > > Changes from v6:
> > > > > 
> > > > >   * Added Reviewed-by tag from Andy
> > > > >   * Expanded PMC, IPC and IA acronyms
> > > > >   * Drop TCO_DEVICE_NAME, PUNIT_DEVICE_NAME and TELEMETRY_DEVICE_NAME
> > > > >   * Move struct intel_pmc_dev into include/linux/mfd/intel_pmc_bxt.h
> > > > >   * Add PMC_DEVICE_MAX to the enum and use it
> > > > >   * Add kernel-docs for simplecmd_store() and northpeak_store()
> > > > >   * Use if (ret) return ret; over the ternary operator
> > > > >   * Drop "This is index X" from comments
> > > > >   * Use acpi_has_watchdog() to determine whether iTCO_wdt is added or not.
> > > > >   * Rename intel_scu_ipc_pdata -> intel_scu_ipc_data to make it less
> > > > >     confusing wrt. platform data for platform drivers.
> > > > 
> > > > Any reason why you've dropped all my tags?
> > > 
> > > You mean these?
> > > 
> > > For my own reference:
> > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > 
> > > I wasn't really sure what to do with them. They are not in the normal
> > > tag format I've seen so I thought you use them yourself somehow to
> > > manage your mailboxes. I can add them back if needed.
> > 
> > Yes, please add them, so I can track them.
> > 
> > It normally means that I plan to take the set through MFD and
> > subsequently send an immutable pull-request out to the other
> > Maintainers once all the other Acks have been provided.
> > 
> > MFD handles these kinds of cross-subsystem patch-sets often.
> 
> This series has dependencies to PDx86 (as mentioned in cover letter).
> 
> What do you prefer then, me to:
> a) prepare ib from what I have, then you take it followed by me taking your ib, or
> b) take everything and prepare ib for you?

Either would be fine by me.

What kind of dependencies are they?  Are they protected by Kconfig
options?  Another way of asking that would be to say, would this set
throw build errors if I tried to apply and build it or would it just
refuse to compile?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
