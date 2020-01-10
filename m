Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62CCC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D182072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZR1SmNa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgAJROB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:14:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44727 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgAJROB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:14:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so2517063wrm.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TqK59IlRDTivNScIrv1p8mcek/6EynWWU6nqtJax3dI=;
        b=ZR1SmNa4ewMC+9bM1Qd4GEbT6TIUSkZWMhmNlR2/u1Q/XFPT4nonM1wMrjJxGix6n2
         vhJO/XCFrDTqySe7vOWbZrXp5bXcEGNf/rNQnFfGXEOjdrbyEsLjN+z9bEmAWZ8K0f0U
         kVbNfNmPt5U41w/4K4sAOgAwMx/hQF7n1iRnS/qWrZkBkn27LU/qN6GafSrJBsGhJ42B
         bVqiRWp4xbKWaabr9qGEpOxzZmwJSWfA5A2hMCUw2LPtafQIIelXj6hSS6iDAkqxJ5df
         tI7NsvhNpPaS2b1U91/Iw44l7T/lFaJh5jifN1UMwwLq4SSdJY1aSAcPIZkrEwiR6LN9
         Hwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TqK59IlRDTivNScIrv1p8mcek/6EynWWU6nqtJax3dI=;
        b=ETlvW6fdLrN2I2oDAn3jHh2LFxd7yMewMRavuu4x4unl5hQ1jq4nisHLtsQgPKf0lG
         ar54E3k3DQw/QRN4R1jXfDD8HaZVyhHlL84DirDlm8Y6enxjsyM10xA3PpFYUgKkblAJ
         9M+MrbCMuiL6BiR+eZ9MTehnySLJQLU897ge/6fUcGKMgDksQFXUoL4tGm7TI6eXjBdH
         Kb50/0hUmcf01vYRhSUFigd/7ku/Ok/7TSYLtvE86qNgGbYTLCzBIqVy/4/EPtHF4X2p
         6ZUFPVTXaqbLCC2lCoPuwhoSU3d9jcvquDCYa200zksIs3L9+yJ1x3GSjzxEMknlGsdt
         HGKg==
X-Gm-Message-State: APjAAAVdWDk6vFQHfoQxPtkFv9GLA0XN/CF1R0J8B8fY2hJ1g6DMltz4
        GDLlsqeHbsNyxQUETcV3egQ=
X-Google-Smtp-Source: APXvYqzkM/IaRhGQUdWJmLCKFeuPcx4+bwvHlSzMI4PzLnvql8zHATRdwxGunpYHB7YsgHiLEaCBLg==
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr4561515wrn.280.1578676438437;
        Fri, 10 Jan 2020 09:13:58 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id t131sm2999586wmb.13.2020.01.10.09.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 09:13:57 -0800 (PST)
Subject: Re: mtd raw nand denali.c broken for Intel/Altera Cyclone V
To:     Tim Sander <tim@krieglstein.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <5143724.5TqzkYX0oI@dabox> <23083624.r2bJSIadJk@dabox>
 <CAK7LNASG+b03NDhrenB9yfvgYDVpYSnb2vSCu_-DB8dh70boMg@mail.gmail.com>
 <2827587.laNcgWlGab@dabox>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <0cc8ef75-8263-d8c8-b545-8d55c14ab2f4@gmail.com>
Date:   Fri, 10 Jan 2020 18:13:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2827587.laNcgWlGab@dabox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/20 5:46 PM, Tim Sander wrote:
> Hi Masahiro Yamada

Hi,

> Sorry for the large delay. I have seen the patches at 
> https://lists.infradead.org/pipermail/linux-mtd/2019-December/092852.html
> Seem to resolve the question about the spare_area_skip_bytes register.
> 
> I have now set the register to 2 which seems to be the right choice on an Intel  
> SocFPGA. But still i am out of luck trying to boot 5.4.5-rt3 or 5.5-rc5. I get the 
> following messages during bootup booting:
> [    1.825590] denali-nand-dt ff900000.nand: timeout while waiting for irq 0x1000
> [    1.832936] denali-nand-dt: probe of ff900000.nand failed with error -5
> 
> But the commit c19e31d0a32dd 2017-06-13 22:45:38 predates the 4.19 kernel
> release (Mon Oct 22 07:37:37 2018). So it seems there is not an obvious commit
> which is causing the problem. Looking at the changes it might be that the timing
> calculations in the driver changed which might also lead to a similar error.
> 
> I am booting via NFS the bootloader is placed in NOR flash.  The corresponding 
> nand dts entry is updated to the new format and looks like this:
>                 nand@ff900000 {
>                         #address-cells = <0x1>;
>                         #size-cells = <0x0>;
>                         compatible = "altr,socfpga-denali-nand";
>                         reg = <0xff900000 0x100000 0xffb80000 0x10000>;
>                         reg-names = "nand_data", "denali_reg";
>                         interrupts = <0x0 0x90 0x4>;
>                         clocks = <0x2d 0x1e 0x2e>;
>                         clock-names = "nand", "nand_x", "ecc";
>                         resets = <0x6 0x24>;
>                         status = "okay";
>                         nand@0 {
>                                 reg = <0x0>;
>                                 #address-cells = <0x1>;
>                                 #size-cells = <0x1>;
>                                 partition@0 {
>                                         label = "work";
>                                         reg = <0x0 0x10000000>;
>                                 };
>                         };
>                 };
> 
> The last kernel i am able to boot is 4.19.10. I have tried booting:
> 5.1.21, 5.2.9, 5.3-rc8, 5.4.5-rt3 and 5.5-rc5. They all failed. Unfortunately the 
> range is quite large for bisecting the problem. It also occurred to me that
> all the platforms with Intel Cyclone V in mainline are development boards
> which boot from SD-card not exhibiting this problem on their default boot path.

There are also patches for U-Boot which you need to get this whole thing
working, unless you have reset support for the Denali NAND in mainline
Linux. See

https://patchwork.ozlabs.org/project/uboot/list/?series=152289

Sadly, all of the efforts thus far crashed on various review pushback.

> Best regards
> Tim
> 
> PS: Here is some snippet from an older mail i didn't sent to the list yet which
> might be superseded by now:
> To get into this matter i started reading the "Intel Cyclone V HPS TRM" 
> Section 13-20 Preserving Bad Block Markers:
> "You can configure the NAND flash controller to skip over a specified number of 
> bytes when it writes the last sector in a page to the spare area. This option 
> write the desired offset to the spare_area_skip_bytes register in the config 
> group. For example, if the device page size is 2 KB, and the device 
> area, set the spare_area_skip_bytes register to 2. When the flash controller 
> writes the last sector of the page that overlaps with the spare area, it 
> spare_area_skip_bytes must be an even number. For example, if the bad block 
> marker is a single byte, set spare_area_skip_bytes to 2."
> 
> 
> 
> 
> 


-- 
Best regards,
Marek Vasut
