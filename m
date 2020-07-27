Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D8CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408C1206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N64yA6en"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbgG0Pmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbgG0Pml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:42:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165A1C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:42:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p14so14231065wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q30VrVY5X0HHdrGzlOgbzohfZx9h3nY4CKObZ9uief0=;
        b=N64yA6enn2h2KhVpllPNrEdDz0RrQ7jqd01zk5ciCF9VgY1wF6gi8LNAggzubBmIfk
         4uGhhEPE2QX/cY7tKM+QCjTPoj/KkOGBlDnJ8TiZHV/gEKNVAlTmgNsfoNvQZPhbpaVK
         OiOAEVmyXwW432/bO8bsIg67ZINiqTIrjqc9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q30VrVY5X0HHdrGzlOgbzohfZx9h3nY4CKObZ9uief0=;
        b=GRbTQ1qhJS27CKQEOujqjJ0k43ptysNekBlawHUmeFHkyn+14vbLvbRGGsN1JdeVol
         F3zaqcSrF73qJPjxHY1HDCb1Vpqg/2qUXwfrook6/C0/jxhx8Fa/jPp9IfG5HV4453bU
         9Npx84fVYHMrU+YTl+vHG1WxAdGHBu9AUEhiPTu/lS91YqwKddaSzjLfjLjgsE4ZXIuD
         RiXIh4tnMm8B/yZ7fU4fAbp6EyJvUIb1Y8hytbvWUn24fAeJPvnycWoSt1bJo9nIeAM+
         dIjsO/vhbF2BdZhu2c6wShD3K1Zpu8MF4naa9AoerqoONJcnNcj/JEMuqbzOYvNasj7t
         YT1A==
X-Gm-Message-State: AOAM533cljfLULn9J5ggcSAgU4l8Tfv7H7rGyarcweXb9lB4Xd8HfQq6
        r5HhH3Dd5TyF6SiBjQVCX6+SGBDFkKhLin1F
X-Google-Smtp-Source: ABdhPJw2AFsLQ3QfoNPjcQVXUMOo94VGbLrWaNX6UgSpcDfrl2zhz/5cV8jTG+eKSfbeiAD3UuccXA==
X-Received: by 2002:a1c:9914:: with SMTP id b20mr20577167wme.15.1595864559486;
        Mon, 27 Jul 2020 08:42:39 -0700 (PDT)
Received: from [10.136.8.246] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c25sm1318wml.18.2020.07.27.08.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 08:42:38 -0700 (PDT)
Subject: Re: [PATCH] i2c: iproc: fix race between client unreg and isr
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Dhananjay Phadke <dphadke@linux.microsoft.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <1595115599-100054-1-git-send-email-dphadke@linux.microsoft.com>
 <116ac90c-8b49-ca89-90a4-9a28f43a7c50@broadcom.com>
 <20200722104128.GK1030@ninjato>
 <5048cf44-e2c2-ee31-a9fb-b823f16c2c7d@broadcom.com>
 <20200725101815.GA1519@ninjato>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <4cf12c92-889d-ffbf-f8de-c1e08cfb8ce9@broadcom.com>
Date:   Mon, 27 Jul 2020 08:42:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200725101815.GA1519@ninjato>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On 7/25/2020 3:18 AM, Wolfram Sang wrote:
> 
>> I think the following sequence needs to be implemented to make this
>> safe, i.e., after 'synchronize_irq', no further slave interrupt will be
>> fired.
>>
>> In 'bcm_iproc_i2c_unreg_slave':
>>
>> 1. Set an atomic variable 'unreg_slave' (I'm bad in names so please come
>> up with a better name than this)
>>
>> 2. Disable all slave interrupts
>>
>> 3. synchronize_irq
>>
>> 4. Set slave to NULL
>>
>> 5. Erase slave addresses
> 
> What about this in unreg_slave?
> 
> 1. disable_irq()
> 	This includes synchronize_irq() and avoids the race. Because irq
> 	will be masked at interrupt controller level, interrupts coming
> 	in at the I2C IP core level should still be pending once we
> 	reenable the irq.
> 

Can you confirm that even if we have irq pending at the i2c IP core
level, as long as we execute Step 2. below (to disable/mask all slave
interrupts), after 'enable_irq' is called, we still will not receive any
further i2c slave interrupt?

Basically I'm asking if interrupts will be "cached" at the GIC
controller level after 'disable_irq' is called. As long as that is not
the case, then I think we are good.

The goal of course is to ensure there's no further slave interrupts
after 'enable_irq' in Step 3 below.

Thanks!

> 2. disable all slave interrupts
> 
> 3. enable_irq()
> 
> 4. clean up the rest (pointer, address)
> 
> Or am I overlooking something?
> 
