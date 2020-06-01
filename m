Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94464C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B338206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591031333;
	bh=U4zySYo9+Zn4LG0NqTAIuOjQNwa7638vn5i7EqhQmGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0YepicFAR4ojb/NU6461jv//rAFvbwBfp2dyQEq9xgno1Fbz8s1Sg+lI7GSaw369n
	 c8cDQuD4V8EDW62HWioyS4XHgPg34CTxTBwCyvO/XoEDE7b5ToHaq7pUNj21iJx19Y
	 NPMTBWwuWxmQ1ofcRMJ4Ni9Vm17inBuxwiZH/RAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgFARIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:08:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbgFARIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:08:50 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77F5D207D0;
        Mon,  1 Jun 2020 17:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591031329;
        bh=U4zySYo9+Zn4LG0NqTAIuOjQNwa7638vn5i7EqhQmGc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ni6vAZlZT4tj1xl51yOTbBxf5AwGuYWF7t8Rps7Sqztp3gZOZLVqUOrKv5yhUVa5Y
         qZlEnxrRdplCiICKkBvni4EjL4RXM5OQlcSmYIewhdE3iN8gFnlE5AUnW1H5Ql4qMl
         2MSFYfDkprtS06cQXSsTxuHUJiK4fn6SU1enW+AI=
Received: by mail-oo1-f54.google.com with SMTP id h7so1558501ooc.9;
        Mon, 01 Jun 2020 10:08:49 -0700 (PDT)
X-Gm-Message-State: AOAM530KkjzcWllcaTBi4LLgadeAkBBvPtTE1bfnYJXmUw08EAkGveZ2
        tecXVbvrz0226++kt6XNigC34xvFFN585rjuGg==
X-Google-Smtp-Source: ABdhPJz8JITuBczH1/+7mXTyYTNWxr6eeT/W/in0quS2K3VUyNTENu0mTyptKAZMzD7iEn/vxKZx2t9W6xAOzoCb/Bg=
X-Received: by 2002:a4a:2c88:: with SMTP id o130mr17580139ooo.81.1591031328789;
 Mon, 01 Jun 2020 10:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200527122525.6929-1-Sergey.Semin@baikalelectronics.ru>
 <20200527141517.22677-1-Sergey.Semin@baikalelectronics.ru> <20200530093152.GA1038@ninjato>
In-Reply-To: <20200530093152.GA1038@ninjato>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 1 Jun 2020 11:08:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJeod3Rm4K_7c3AcH8A4aMKKmT97CcbGpRbG4b0yWzrXA@mail.gmail.com>
Message-ID: <CAL_JsqJeod3Rm4K_7c3AcH8A4aMKKmT97CcbGpRbG4b0yWzrXA@mail.gmail.com>
Subject: Re: [PATCH v2] check: Add 10bit/slave i2c reg flags support
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Devicetree Compiler <devicetree-compiler@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 3:32 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > +     addr = reg & 0x3FFFFFFFU;
> > +     snprintf(unit_addr, sizeof(unit_addr), "%x", addr);
>
> Hmm, this hardcoded value will not work if we ever need to add another
> bit. I hope this will never happen, though.

I had this concern and requested the first time this was submitted
(and abandoned) to just mask out the top byte. However, Joel's version
of this fix[1] does some actual checks on 10-bit addressing, so I've
dropped that request.

> > +             if ((reg & (1U << 31)) && addr > 0x3ff)
>
> Same here with bit 31. I haven't checked DTC but can't we import the
> header with the defines into the project? Or is this then a circular
> dependency?

Easier to just duplicate the define here which Joel's patches do.

Rob

[1] https://www.spinics.net/lists/devicetree-compiler/msg03196.html
