Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D842C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BCC214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="usYcQwmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgCBOZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:25:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54728 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgCBOZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:25:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id z12so11404441wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 06:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sgAEKJwQB8Gv3iov0wsQWnGh6y5ovJv8PBH/21hvauM=;
        b=usYcQwmxMZHE9zWt+Wbda0uEYUct6SDSbr90Px4RGOZFaowiN3Uq9L8K4ijB1dMFlP
         r3vFqQ4FO5d2AFOd0tto/SAnmdnug0T1U8Vy0tHmjhwOez2zzWL3R+Y0JOmVkRwOf+QL
         M91LEPgaMATwf/DtIWTUB9PS8WHJ+ybLunoeDvfYtJb23HIDrHBxQdgVg9cqunUPlwsO
         5ZlHbt9rxqKCaXrO8PK6QPmUkWkCoc7v0R26RKTQFX67wgZVnqW8txCZDXhIzzii492B
         M9kMHmMQOTmJTp0j/jMd27Pb+SHRLYRBLDpygWCGiLQtGYjMlpnYFpEV7xO3xzcICi9N
         14Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sgAEKJwQB8Gv3iov0wsQWnGh6y5ovJv8PBH/21hvauM=;
        b=uDl0fu1V/1/1lL/8RoAkxhAF8ODo38H5RoQ6Crh0NvqQ16QEwkbWTKOHRf19BZ6HYh
         DPjD1IjNxY8fN/4qZdZuV14aEksx7VdXWMhYar5me50cw0KT1yCJGtoOFHFCwAW3hlvI
         1jmOytV5SNbnoX0lEb1kik+ua/K/HRtegazslAXQBS8VxY/FLSuYLj/NTY5Fgp3yy4ni
         PjjHbdrRB6LhjbHVa8SE7LWMrysyih3qH4rmJttArricIizygiqJurwJHdGBrGJb0nq0
         BxyLJBuB5oi5icQ/OE0uZP1RDZFoQRwKcBh3wzJKDkjWf7+pNt9H5TsDbC9tIjJ9ilkR
         Armw==
X-Gm-Message-State: ANhLgQ3pGe/Ybj1BiTvMAyI0/VCk68EOkEYo+QQNGqYUenqaegdI1YKg
        S9TOMZwzACnQ2j6BBC+9Inxkpw==
X-Google-Smtp-Source: ADFU+vvHHUg7lLfZiXNvkEyvg6Amyek3SNyX4sKBx5aGr3KFE3/uWGi3Bvm1/kJennkV7lsoWhpEmA==
X-Received: by 2002:a1c:7f87:: with SMTP id a129mr9205826wmd.160.1583159145606;
        Mon, 02 Mar 2020 06:25:45 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id c2sm15935583wma.39.2020.03.02.06.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 06:25:45 -0800 (PST)
Date:   Mon, 2 Mar 2020 14:26:21 +0000
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
Subject: Re: [PATCH v7 00/19] platform/x86: Rework intel_scu_ipc and
 intel_pmc_ipc drivers
Message-ID: <20200302142621.GB3494@dell>
References: <20200302133327.55929-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200302133327.55929-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Mar 2020, Mika Westerberg wrote:

> Hi all,
> 
> Currently both intel_scu_ipc.c and intel_pmc_ipc.c implement the same SCU
> IPC communications with minor differences. This duplication does not make
> much sense so this series reworks the two drivers so that there is only a
> single implementation of the SCU IPC. In addition to that the API will be
> updated to take SCU instance pointer as an argument, and most of the
> callers will be converted to this new API. The old API is left there but
> the plan is to get rid the callers and then the old API as well (this is
> something we are working with Andy Shevchenko).
> 
> The intel_pmc_ipc.c is then moved under MFD which suits better for this
> kind of a driver that pretty much sets up the SCU IPC and then creates a
> bunch of platform devices for the things sitting behind the PMC. The driver
> is renamed to intel_pmc_bxt.c which should follow the existing conventions
> under drivers/mfd (and it is only meant for Intel Broxton derivatives).
> 
> This is on top of platform-driver-x86.git/for-next branch because there is
> already some cleanup work queued that re-organizes Kconfig and Makefile
> entries.
> 
> I have tested this on Intel Joule (Broxton-M) board.
> 
> Changes from v6:
> 
>   * Added Reviewed-by tag from Andy
>   * Expanded PMC, IPC and IA acronyms
>   * Drop TCO_DEVICE_NAME, PUNIT_DEVICE_NAME and TELEMETRY_DEVICE_NAME
>   * Move struct intel_pmc_dev into include/linux/mfd/intel_pmc_bxt.h
>   * Add PMC_DEVICE_MAX to the enum and use it
>   * Add kernel-docs for simplecmd_store() and northpeak_store()
>   * Use if (ret) return ret; over the ternary operator
>   * Drop "This is index X" from comments
>   * Use acpi_has_watchdog() to determine whether iTCO_wdt is added or not.
>   * Rename intel_scu_ipc_pdata -> intel_scu_ipc_data to make it less
>     confusing wrt. platform data for platform drivers.

Any reason why you've dropped all my tags?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
