Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9419DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7EE206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4Y63FKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389161AbgFXGlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388360AbgFXGlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:41:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E014C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:41:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so1368288wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w1X7TJT+/NZGp2t1UBcnbW7TryORo1uDGLtiSLF2dX0=;
        b=F4Y63FKJ0cwNYtuBYuYFD1B6IQvmC0jQveupwHMhBrEzsAnXu0x/XQF0xp02M5Kb/R
         CAvgMujEExgWFUbK/o0mkv3Umjwp+GunX+r3ArbVP9whHFM6+F352dVdcqcGGFPD9W6x
         3zcNl8gc0XQ0obe0wywYkBtMgZlt+oDQ0PQkNzqHUby4hIXM4JkzWFINsYObXDlmblzH
         d1IlV+fJArOOwHCcrgSlePJru0KeizSTypNVzd5JZEMNmfbjlZWx6Dl8gRNLFq9HDc9I
         SlMcxJnFQvkiRKGOd/+G/3D3mNNXbUC96HfOk4HdarpWLIhRu4OTSIky/PO0jZxi7J+j
         dKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w1X7TJT+/NZGp2t1UBcnbW7TryORo1uDGLtiSLF2dX0=;
        b=hzOyirgxzOU01jUlJLdeQqt9otymG0QWasAnglpEShEhrGYOUDx6OIPyL0SoGE6wMi
         qp5NuCPjCKZfGY8jGkW90dHgsDy06uDNdjnFC1mxoOnBI6AX/08Joa5UqZgVWOEqXA5f
         Tr/Z2coyn4gGIahG6rJIT6tf6AsvoOwml9mhMHsZqyjsv/j8shMTJNGBokZFHGqg5l98
         apoc6rsxM6S6X/rNlyAK4htcej3QWA5s4sF9hYF0j5XMygHJwkhgbxqVZspauBjldIy7
         Wb8+Ux/UD9b9enWheag89F1hTKExt0KOnqvA2w6JN9aS4cxiBKNIayXEE6Gcuj9O5SLI
         Nwpg==
X-Gm-Message-State: AOAM531v/7xU91Or+dE7ZWqGQYavCdjHzPAh0PPXA26x8+4vtwATbxwL
        mCht2chDx562pYmtAw+VBSUWWw==
X-Google-Smtp-Source: ABdhPJxxesv3DV42KX9DFPvWgoXognYEeA7BPVgHrFM5XpvKgLlqY6E6cmhuf8i1uDbBZ3dy3VUIng==
X-Received: by 2002:a1c:cc03:: with SMTP id h3mr27931892wmb.87.1592980907725;
        Tue, 23 Jun 2020 23:41:47 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id b18sm25196379wrn.88.2020.06.23.23.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 23:41:46 -0700 (PDT)
Date:   Wed, 24 Jun 2020 07:41:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     andy.shevchenko@gmail.com, michael@walle.cc, robh+dt@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
Message-ID: <20200624064145.GC954398@dell>
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <30f03734-61fd-1b6b-bf11-21b6423a7c50@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30f03734-61fd-1b6b-bf11-21b6423a7c50@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020, Frank Rowand wrote:

> On 2020-06-11 14:10, Lee Jones wrote:
> > Currently, when a child platform device (sometimes referred to as a
> > sub-device) is registered via the Multi-Functional Device (MFD) API,
> > the framework attempts to match the newly registered platform device
> > with its associated Device Tree (OF) node.  Until now, the device has
> > been allocated the first node found with an identical OF compatible
> > string.  Unfortunately, if there are, say for example '3' devices
> > which are to be handled by the same driver and therefore have the same
> > compatible string, each of them will be allocated a pointer to the
> > *first* node.
> 
> As you mentioned elsewhere in this thread, this series "fixes" the
> problem related to the "stericsson,ab8500-pwm" compatible.
> 
> I know, I said I would drop discussion of that compatible, but bear
> with me for a second.  :-)
> 
> The "problem" is that the devices for multiple mfd child nodes with
> the same compatible value of "stericsson,ab8500-pwm" will all have
> a pointer to the first child node.  At the moment the same child
> of_node being used by more than one device does not cause any
> incorrect behavior.
> 
> Just in case the driver for "stericsson,ab8500-pwm" is modified
> in a way that the child of_node needs to be distinct for each
> device, and that changes gets back ported, it would be useful
> to have Fixes: tags for this patch series.
> 
> So, at your discretion (and I'll let you worry about the correct
> Fixes: tag format), this series fixes:
> 
> bad76991d7847b7877ae797cc79745d82ffd9120 mfd: Register ab8500 devices using the newly DT:ed MFD API

This patch isn't actually broken.

The issue is the DTB, which [0] addresses.

[0]
https://lkml.kernel.org/lkml/20200622083432.1491715-1-lee.jones@linaro.org/

> c94bb233a9fee3314dc5d9c7de9fa702e91283f2 mfd: Make MFD core code Device Tree and IRQ domain aware

It sounds reasonable to list this one, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
