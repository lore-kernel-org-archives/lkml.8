Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DA9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F159206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFf8QcTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgEUPhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgEUPhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:37:15 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54156C061A0E;
        Thu, 21 May 2020 08:37:15 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cx22so3266305pjb.1;
        Thu, 21 May 2020 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OYdj3oxUiuAB3tF1DL5vk5uopxT2+mvFqmfAbEhUB1g=;
        b=MFf8QcTOrO8Ra7gNBFCANWuveR+1bbr9CpBpHXHkXgn9qqvIx/HNS2FbHlh/e72Lu0
         Vem8O5NInGtDsTDFbdvIMKl/MxvAw0Zp6mVgkVItEB8/cZ0eH+GK9VwaZ+eMS2Yn2UxD
         eBJDDuU6iTQEbRopa+o8c9A10+NO9FoP+KtK4Ym9C2YMOjVpzdmih6W7MKEVdkZt5ltw
         rCwjb63+rAjoQ3aReV9rmLT7FiZJL0UBxpuKz8+QNdx6Qxcr41d06qXMojtwseK55tc8
         40a+5JAPqiaHoHhgGhI3ACW7tY12Wsm9B3R+TbSx9PZf4MoH56VuTk7bGhWPxNpbVaf2
         AX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OYdj3oxUiuAB3tF1DL5vk5uopxT2+mvFqmfAbEhUB1g=;
        b=KehT16MFVqPyvRBKLunc/uf9R4MmBaHqUV7FvJamNmgeUAl8boaTgdZD1lWJ0EnkDA
         FCvRvM4DANUZtcS1t8ufwZ/hJK903nyw7rwY5Lz6rPK+zu0xvZgvFdEBZcTwXaBis9ON
         0WaiMbziWbSHZzfPDhBWojmKRPiQy6gR/hLihGXSZZDThUR6E1LgJFechi0gz2g86cib
         MSa289wNoGSMB0f2rYIzdaaA4FJa0QFVRwmzBaIrH4uMUo2ppmI9e246RJfGxcpbs/QX
         VOeMGRQkWrXs/5KKfmjtNo0WypCOFM9AbwqBcJgdw2veUSeQrtKzI4e0/t7OIwixcveC
         kUzw==
X-Gm-Message-State: AOAM533r+4Cq3qWnQg9InRvB7W6UbW56Jof/VFiHUhgwGPEeNamZQPMX
        UxvKi1LAgtqJM9HB9RBK+IhKhypL
X-Google-Smtp-Source: ABdhPJyGLHzpHZBoedtyrQSiqCnwKrfq06H/6/+CBPSmDYNpYufikHQWwq0KIeX0RRG/hwFS+uLKDg==
X-Received: by 2002:a17:902:9342:: with SMTP id g2mr10323962plp.326.1590075434732;
        Thu, 21 May 2020 08:37:14 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b14sm3760925pgb.32.2020.05.21.08.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 08:37:13 -0700 (PDT)
Subject: Re: [PATCH v10 1/5] usb: xhci: Change the XHCI link order in the
 Makefile
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cooper <alcooperx@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20200512150019.25903-2-alcooperx@gmail.com>
 <20200513122613.GA1023594@kroah.com>
 <7acc2a4c-caab-11e7-7b3f-4176f19c58cf@gmail.com>
 <20200513162723.GF1362525@kroah.com>
 <38ff034d-a84c-2309-a8d5-f344930d9a31@gmail.com>
 <20200513170505.GB1369204@kroah.com>
 <20200513173920.GA2862@rowland.harvard.edu>
 <c0642cf4-1436-aec4-96fd-355a897f6418@gmail.com>
 <CAOGqxeU=LjAmAYR9wGeKZo_eLj+ehkrANTM+04E7xWNAp82EJA@mail.gmail.com>
 <CAOGqxeV_9LpFudC3VuFPAOmYVYBQGJ+s01HCK2nP6XxpprK2Qw@mail.gmail.com>
 <20200521060902.GA2352222@kroah.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <42cd3742-ade9-55eb-a804-d81b2af62f75@gmail.com>
Date:   Thu, 21 May 2020 08:37:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521060902.GA2352222@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/2020 11:09 PM, Greg Kroah-Hartman wrote:
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> 
> A: No.
> Q: Should I include quotations after my reply?
> 
> http://daringfireball.net/2007/07/on_top
> 
> On Wed, May 20, 2020 at 01:29:45PM -0400, Alan Cooper wrote:
>> Greg, Alan,
>>
>> The other 4 related patches were accepted into usb-next and I just
>> realized that this one didn't make it. This patch will not fix the
>> "insmod out of order" issue, but will help our controllers work with
>> some poorly behaved USB devices when the drivers are builtin.
> 
> As it doesn't solve the real issue, I did not accept this so that you
> all can continue to work on creating a real solution that works for both
> situations (built in and as modules.)
> 
> I thought I said that already...

Your message was not clear to me at least, I understood your message as:
I acknowledge the problem you are trying to solve and accept Al's
solution for the case where modules are built-in, and another solution
should be found for when the modules are built as loadable modules.

But okay, your message is clear now :).
-- 
Florian
