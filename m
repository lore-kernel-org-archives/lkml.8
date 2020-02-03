Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECB9C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E932086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="wgFtHtAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgBCVts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:49:48 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:57173 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgBCVts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 16:49:48 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id f3554ba7
        for <linux-kernel@vger.kernel.org>;
        Mon, 3 Feb 2020 21:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=T2lm6YFFIWgVMmvJn5NLSjAoCHc=; b=wgFtHt
        AUcfXvrA8vdhAKVRnkfoMbdip8GK37ZTHXVSR8yQh2o34Q/EPo5v1ScdeR0UCkAO
        DKnGqvRaHFQmkqmCgEKei9zsoxc7Le99QBehrvleUp4nLP5FKgx4vK73hfMkpS+R
        23E4MeNeu8cuW3UfAd7zgdHryRt9RGcc4SPHwhjipsDq8E7caMgyjXeraHoJYXu+
        vEK3tAIOVMnQ+UbXXdSL8Vfn4PNVYiiXtqMnnWTwPec882fV8hUgBXtqXqL16d1Q
        g3uh/y+zuqiM8VHPa3UlznCqBAbeJX2pIiNVPQrqWvMVohePSfo8rJQJVQUV7bMc
        B96BPp6MZ1U1k5bg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e25fe0a1 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 3 Feb 2020 21:49:02 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id i1so16308898oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 13:49:45 -0800 (PST)
X-Gm-Message-State: APjAAAUcduJMmeHFeD64MC9ccfEalXqiHFqPOYAV0Hw0V2CivOjvMokE
        UoHDIU+zCjQLDdlixn9frrz4Ba6KOfQTP55odKw=
X-Google-Smtp-Source: APXvYqwVOy+fo01ROSSyR+F1mqm1CWyz92lyZg8u7voFECQsUc1KralIhj3zFhh+oRwouX9YzqapxQ1gPW/d81mtACw=
X-Received: by 2002:aca:2109:: with SMTP id 9mr772054oiz.119.1580766585132;
 Mon, 03 Feb 2020 13:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20200203181906.78264-1-Jason@zx2c4.com> <20200203200942.GA130652@google.com>
In-Reply-To: <20200203200942.GA130652@google.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 3 Feb 2020 22:49:33 +0100
X-Gmail-Original-Message-ID: <CAHmME9p5WdixOFvwGXWynWazP6ZRPXBzK-6a9M1hcuEFGR3SKg@mail.gmail.com>
Message-ID: <CAHmME9p5WdixOFvwGXWynWazP6ZRPXBzK-6a9M1hcuEFGR3SKg@mail.gmail.com>
Subject: Re: [PATCH] x86/PCI: ensure to_pci_sysdata usage is guarded by CONFIG_PCI
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 9:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> Another possibility would be to move the to_pci_sysdata() definition
> outside of #ifdef CONFIG_PCI, just as the struct pci_sysdata is.  Then
> we wouldn't have to change the availability of __pcibus_to_node().

Seems more reasonable. v2 coming your way momentarily.
