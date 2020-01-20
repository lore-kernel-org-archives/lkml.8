Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91340C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E35F208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfT1D7xS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgATMur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:50:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55769 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgATMur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:50:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so14353631wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 04:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+csJ84XYM4bhae3N58ALZkmsVjW/yy2/bR4YAjn4OgE=;
        b=gfT1D7xSGof/v3tYHtoV/vzR/nYFeaHKsIKpkKl91mfNpz7ejVni5j+qyfTwv4ge1r
         u/pzoDEQj8feLoVT/FwYs0Re1Lfccc1aDsIZs/cP0G3thIJUjmZuHcBlZnQhtaMj+yUi
         322+OgnvEgHkOzCQ04isoDRgAnPy6crqZC3U/gCTRO8wWgGerGlkyB1PO0/aJ1IMOBL0
         t6JG9z9YK3dYjyB6wF4pg7qDLLTOOO91Y9K1puF6Dmy0cfrBb8ifhcsPkcsQ7Wdlj4s4
         YCzGXCXDP9L0mC0qcsqcAlyU5ev5myl6TZYlKXGUafLrY62tSlNt8orPK828cGxNrUWy
         OpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+csJ84XYM4bhae3N58ALZkmsVjW/yy2/bR4YAjn4OgE=;
        b=DQAuDTir93wiXnLa2b4em2QM1IXUKXvpe3p3y+xayDRFNP33RAGuV2qwIT0v5wg0Kx
         D9BzNCYv780TGMM36wwnGu+j45EQU0IEtj7VYpJ2F0wPw6w+KP6/L9JlSZk6x3MiVRWJ
         odwXmtUh9CaU52Z+bn/uVSITs/wP97n/SOVOSA4iyy9Ylu+4OVRoBsjeEG1MY4MpMsNq
         ZS21GhkA/a+MoDGzRX109h2Bd+EkeTfcp4donBZTDwRig6/yLKnleggEHDlfnW3bEf0Q
         aVP2gdqr0qkiGd4YP8rzN1wLZxkV7Zy8/Tb/FAkwL/+Qil6TUlUVOZ/ksb8U6kUrjvoa
         V9lQ==
X-Gm-Message-State: APjAAAX+EvxcGXsnTzQmuCnrDja0EnifesBTaS28eTfpnElJg5PV3hic
        EUi9gHDXpoUpspBF7Dwq9R0BDw==
X-Google-Smtp-Source: APXvYqy6MSyQr/Pp/PBDcNgF+gm9KhMYhrSXFDl9fqUFsh0lM7gm2JlbQchIeYedUytd4DmBnvmsKA==
X-Received: by 2002:a1c:7901:: with SMTP id l1mr18462191wme.67.1579524644681;
        Mon, 20 Jan 2020 04:50:44 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id w13sm47780798wru.38.2020.01.20.04.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 04:50:44 -0800 (PST)
Date:   Mon, 20 Jan 2020 12:50:59 +0000
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
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 35/36] platform/x86: intel_pmc_ipc: Convert to MFD
Message-ID: <20200120125059.GF15507@dell>
References: <20200113135623.56286-1-mika.westerberg@linux.intel.com>
 <20200113135623.56286-36-mika.westerberg@linux.intel.com>
 <20200116132108.GH325@dell>
 <20200116143730.GE2838@lahna.fi.intel.com>
 <20200117113202.GH15507@dell>
 <20200117142750.GP2838@lahna.fi.intel.com>
 <20200120081246.GS15507@dell>
 <20200120091258.GH2665@lahna.fi.intel.com>
 <20200120111450.GE15507@dell>
 <20200120112634.GN2665@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200120112634.GN2665@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020, Mika Westerberg wrote:
> On Mon, Jan 20, 2020 at 11:14:50AM +0000, Lee Jones wrote:
> > On Mon, 20 Jan 2020, Mika Westerberg wrote:
> > 
> > > On Mon, Jan 20, 2020 at 08:12:46AM +0000, Lee Jones wrote:
> > > > > Well, by "library" I mean that the SCU IPC itself does not bind to
> > > > > anything but instead it gets called by different drivers such as this
> > > > > one passing the device pointer that is the SCU IPC device. Here for
> > > > > example it is the platfrom device created from an ACPI description.
> > > > 
> > > > Not keen on that at all.  Why can it not be a platform device?
> > > 
> > > We also call the same library from a PCI driver (intel_scu_pcidrv.c in
> > > this series) where the device is of type struct pci_dev.
> > 
> > Not sure I understand the issue.
> 
> You are asking why it cannot be a platform device. It cannot be because
> we are calling the same library from a PCI driver where there is no
> platform device available (only struct pci_dev).

I'm asking why it needs to be called at all.  Why can't it be probed
using the Device Driver API, like most other drivers?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
