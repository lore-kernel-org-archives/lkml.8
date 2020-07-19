Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BA4C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 04:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B3220656
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 04:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shNpNfD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgGSEdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 00:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGSEdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 00:33:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62CEC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 21:33:43 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 207so7387967pfu.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 21:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NMnuLh+n2hjqR5MnJLBU8rHuDpwc8jSXNcEkAGw08r0=;
        b=shNpNfD7ydknC+2m8bihpNOtvb4urvKd9/86e2kcEaXXeB4oSt3iYJ4S6Ri0Ts7fYC
         D5QmjRh1QkEdVPL70XfAEStJ0MvcigrrqJvCCFSxB1tiYER0rWojGwXJNu7k/Y5VpLmZ
         4uZ2KezgDGTcAj59w4wPz44oxlKCFCnp+4vSNXHbzzoRaCMBKikeSASc5+F4mwUgdvZp
         mkGDJNp89MA16FM05n/8JA1xdHNV6ZsONqoIzhQv0ASJZw46b7w0rl+7wGgvfEAWvx/U
         xNX8lqzdncZ09m7AfmGRAZMv7c3dpRyDbjyoM+wcLJIGD1QjjoGINkYegB7MZ5R8c0VZ
         BVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NMnuLh+n2hjqR5MnJLBU8rHuDpwc8jSXNcEkAGw08r0=;
        b=gd/vqKEXKXfE432oJlllP5E9b7WEJZIeo8DSq3K71kGPMeOyvYi+6PM+KSQsynOWDm
         nG+jFxDm3sCMwt6FF0xMDEEFDml36wiDgrlXbHefuaC5HyS8ZCGkKsDWaULjP0nLp7WW
         gEZaaXbtkQHvP/ZVLlE2bhRiUzj34uVNWcwmfHzbMstv3ydB3V00Z7FHA/Ng7IkyQbON
         kr/V7wZhkWGY5OKJkSDFUFV5rBqCguZQlyYoqg+TOZASle53RHWnmF8CyfGbNTe2BzT+
         W0UZu3Q0sdc2z/hDmERN4y/boQOrWfsdVC7394SoJcRFrs9TVAm2VXUjXILtJ0kATriq
         lYXw==
X-Gm-Message-State: AOAM531fqtzrX5nK112QJCf0dn/u33Qwkf8xUAN5IpbxXB8yRy7+qWXI
        zqVtiDCbGzXDORCNlqBSnZvjCfRMZ/BTqA==
X-Google-Smtp-Source: ABdhPJzJHKMcXcrP4HWoI82Bip3+QWOih5BY3UYhF0neGE8ul+At8jy/Vsx9mAekGGJvYsaIiTEp2w==
X-Received: by 2002:a63:8dc4:: with SMTP id z187mr12971922pgd.199.1595133223417;
        Sat, 18 Jul 2020 21:33:43 -0700 (PDT)
Received: from blackclown ([2405:204:219:61b6:3945:8436:8c57:56d5])
        by smtp.gmail.com with ESMTPSA id o129sm12684414pfg.14.2020.07.18.21.33.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jul 2020 21:33:42 -0700 (PDT)
Date:   Sun, 19 Jul 2020 10:03:24 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: kpc2000: Replace depracated MSI API.
Message-ID: <20200719043324.GA28510@blackclown>
References: <20200718154951.GA28857@blackclown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718154951.GA28857@blackclown>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 09:19:51PM +0530, Suraj Upadhyay wrote:
> Replace depracated pci_enable_msi with pci_alloc_irq_vectors.
> And as a result modify how the returned value is handled.
> 
> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> ---
> Changes:
> 	v2: Removed the undefined variable.
> 	    Reported by kernel-bot.
> 
Don't merge it.
This patch is incomplete.
I have to replce pci_disable_msi too.
I hope this didn't cause any annoyances.

Thanks,

Suraj Upadhyay.

>  drivers/staging/kpc2000/kpc2000/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
> index 358d7b2f4ad1..8339026ffb41 100644
> --- a/drivers/staging/kpc2000/kpc2000/core.c
> +++ b/drivers/staging/kpc2000/kpc2000/core.c
> @@ -440,7 +440,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
>  	dev_dbg(&pcard->pdev->dev,
>  		"Using DMA mask %0llx\n", dma_get_mask(PCARD_TO_DEV(pcard)));
>  
> -	err = pci_enable_msi(pcard->pdev);
> +	err = pci_alloc_irq_vectors(pcard->pdev, 1, 1, PCI_IRQ_MSI);
>  	if (err < 0)
>  		goto err_release_dma;
>  
> -- 
> 2.17.1
> 


