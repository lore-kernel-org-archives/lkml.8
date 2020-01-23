Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3284C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF0A2467E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WpbRkF0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgAWIBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 03:01:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38806 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWIBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 03:01:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so1978052wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 00:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=R+FbpZ9Vb49+TjvLZCwmovH5x+NpT0b9MCXQeRi4iaw=;
        b=WpbRkF0gd/AHPTow/6O4uJYyullaxBVlxFlo899UJgx8grcJ2ArsnoUrjQfO7rM1uU
         w6TuQ9tjZcwoQJOosgtcXcutXa4FhjX0+5MWUZ6xGZQUnKmtb9vS3r+kZEBzoZTkmnAl
         PNKEGuSCt5Nok/9UJdqABRb2sW4ICZo1PZ7sM2DRiPaiaOaDyf2sLVF0pRw8h5gZU83A
         gv6ME43amhCy88bJKCVHSO0e6kHsU3QowDaz+8c0TqSjPGj2T8ew2HQdACFkS3gsmCIz
         /WQSKWmEoDWLrD02HXTjnV2+7LmeRNCzAwh1DGC5tgAxbRx+B7SGDWDQT5ZsGHXGI8gS
         tDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=R+FbpZ9Vb49+TjvLZCwmovH5x+NpT0b9MCXQeRi4iaw=;
        b=Irr8oikxcRKjyRIA0BNmvTdGG6qXq9iKyrRj/lTi1pDAcGxEe/oQi91a+yNh0RMlSK
         SW1xFdsl5y7aoJu/PlBZbx4m86flPJgBGsCtUr1kkcgATli/lJL9xSDO7m36W5/AOVsj
         HwgGx/iKxRLz5r2IE42WrVXdPbZGxBSV4dnqoMmQbcjD95k5BeFN7G5+Gjrh0DSngO/t
         UY7H3qts00qZe1k+fae7ubVgj92R8AutnMqsT2U/1qyTOxp3CxZiIETVG4Ej7G5mvRqZ
         i6uKuUW1C5E6YaGzklJtzB4XB+n6v0eQKMRIuyNr0XZP5yy3XQD6ccKbEVSaDDO2yHGv
         kwVQ==
X-Gm-Message-State: APjAAAXVfrmP3BUw7tB2SnASD4Ohb8SRYlNh01vGaNfhFarQwDsAeHV3
        V5VkdJNbcdTLwFQcZjK2kxMX2g==
X-Google-Smtp-Source: APXvYqwj5eR+g+mDnB5c9lVZNCKpo5UV/rYlef1uJMqn0W4226bEd71KH95SIuuF96EgTkH5Bl9CaA==
X-Received: by 2002:adf:f885:: with SMTP id u5mr16166384wrp.359.1579766489342;
        Thu, 23 Jan 2020 00:01:29 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id w22sm1552914wmk.34.2020.01.23.00.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 00:01:28 -0800 (PST)
Date:   Thu, 23 Jan 2020 08:01:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Brown <broonie@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 37/38] platform/x86: intel_pmc_ipc: Convert to MFD
Message-ID: <20200123080142.GP15507@dell>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121160114.60007-38-mika.westerberg@linux.intel.com>
 <20200122123454.GL15507@dell>
 <20200122125300.GO2665@lahna.fi.intel.com>
 <20200122132757.GM15507@dell>
 <20200122144523.GX2665@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200122144523.GX2665@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020, Mika Westerberg wrote:

> On Wed, Jan 22, 2020 at 01:27:57PM +0000, Lee Jones wrote:
> > > Which type of device you suggest here? And which bus it should be
> > > registered to? I think we can make this create a platform_device but
> > > then we would need to do that from the PCI driver as well which seems
> > > unnecessary since we already have the struct pci_dev.
> > 
> > What kind of device is it?
> 
> It is either part of an ACPI device (platform_device) or a PCI device
> depending on the platform.
> 
> > Refrain from using platform device, unless it is one please.
> 
> OK.
> 
> Greg suggested making the SCU IPC functionality a class and I think it
> fits here nicely so I'm going to try that next if nobody objects. I'll
> send the first cleanup patches separately.

Sounds good.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
