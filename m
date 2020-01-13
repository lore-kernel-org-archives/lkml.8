Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41E2C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DE120661
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KwwD0GTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgAMKht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:37:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40835 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgAMKht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:37:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so9012794wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 02:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6WqfNTaoz9oUMKahiQ01rs4vy1pCQ6D74ABCSMutBuE=;
        b=KwwD0GTQaXZZEd9qvsPWrmSvdhwE/+9roNnWdzL6+nRcY4o4LGQXhfRbEJ55u4rK67
         +yN1z17AJeQ8HQFv0MPfDNClSImQYxqGnNesJOSAgYH9EnqYdaY3Z08WKqwrjllEQaBw
         7ei8/kF8ft2CDRH6OeXQkozWm2+cu8wi+QpZ4Gy2BMGyTVafS0Hog0hJX7eC/A75y8Wg
         p1dJr7YQ2+SIostZhlMiIl+yL64jj/bDegDz97Py4aD5pUr/4kLdYjrP9jI0rQs3m9Y9
         af9M8ymhjZ/WHBOJGtUdpQkWKjolU5moZqG8DBbrPt0AM1X+5PHgzlS+RY8P3RGKXqXk
         GaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6WqfNTaoz9oUMKahiQ01rs4vy1pCQ6D74ABCSMutBuE=;
        b=PzmnI15JojjNv82YeBf38JPQMO1574oRRbVD3YqaOirJp4FiH1ximnD6fqTAwku+l6
         yctBD8sHnDrrLDvlTfyHufd6ZM1k3qQefl1Sc/VzixNBCuE5nwsjzqCwa2Xhp1HqWs4u
         K68R4qMjLyzgBPoSZ8aKp6HXtG+F6OIP/WJ/rHnzkuBeWdayTpL61bT1hyisNSlXYae+
         IXUeCZsEiTkZ3vDWrawqG5yEzw0KPZwLGCAwnNqLL4RDrrORi/v/evCQtzsqnEK8IMXn
         9WWgjxyx16sD2AsYVS6jSXWNBCTCwXw8UL350lgJGpuQXhDXrhApxZJsYm5EgEKy/HLb
         h7mQ==
X-Gm-Message-State: APjAAAXbmduy73eViVRCQ6fgyHuyDCfZXjKycFKvuBX6Ve64ojDC+EYx
        GzHuEbepiu97e1st+UCla+75/w==
X-Google-Smtp-Source: APXvYqzCv1Hxba5fCGbGRxgMoRyFZbg/AOD0UK4Y6Z6J4lWP46slDzTi8e91CleKQGucqy4XNlGr/A==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr20495147wmg.66.1578911867398;
        Mon, 13 Jan 2020 02:37:47 -0800 (PST)
Received: from dell ([95.147.198.95])
        by smtp.gmail.com with ESMTPSA id o16sm14272405wmc.18.2020.01.13.02.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 02:37:46 -0800 (PST)
Date:   Mon, 13 Jan 2020 10:38:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/36] platform/x86: Rework intel_scu_ipc and
 intel_pmc_ipc drivers
Message-ID: <20200113103807.GA5414@dell>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jan 2020, Mika Westerberg wrote:

> Hi,
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
> Previous version of the series:
> 
>   https://www.spinics.net/lists/platform-driver-x86/msg20359.html
> 
> Changes from the previous version:
> 
>   * Update changelog of patch 16 according to what the patch actually does.
>   * Add kernel-doc for struct intel_soc_pmic.
>   * Move octal permission patch to be before MFD conversion.
>   * Convert the intel_pmc_bxt.c to MFD APIs whilst it is being moved under
>     drivers/mfd.
> 
> I'm including all x86 maintainers just to be sure they are aware of this as
> I'm not sure if x86@kernel.org reaches them all. Let me know if you have
> issues with this series.
> 
> I would prefer this to be merged through platform/x86 or MFD trees assuming
> there are no objections.
> 
> I have tested this on Intel Edison (Merrifield) and Joule (Broxton-M).

FYI, I'm waiting until v3 before I conduct my review.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
