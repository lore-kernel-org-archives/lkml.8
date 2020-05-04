Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC538C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5DE208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="MmB3Bq0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgEDWKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 18:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726419AbgEDWKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 18:10:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D572EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 15:10:12 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b6so323851plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 15:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=jZLyHH0FOwiw9uaFhugdV/Ka8e6kSYMG1voxw4n6zE4=;
        b=MmB3Bq0Svs+rjKoFS/i+2LTtsnNZGfywx63UfiAkbK3FtnIoF8p6fmj2XjUiW4bUb6
         R8YZEMWFy5WnJTtNGzSql1UoGmkMYGd5IxZd2tzhGtnXIfgsgstUTckYT01tdRSqWn++
         mE4FIZRFIEQYZtldnyT6vlylljYv+EXsOfX592bKErbvK9ynfEThFGY0j8+v9yL5+AYn
         2L8UtEV8btm8yMsHYX41rEU4NZWACwluL1ZQEUck3x1d7WUsJVlADU7tkSZPVlOqRfbF
         zWt6tyEH9zFe0oc93kh+0ghawzhaIp4RGYUaOCMuidQUWyUUfKEqoe0qMA5/9tnalteu
         swHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=jZLyHH0FOwiw9uaFhugdV/Ka8e6kSYMG1voxw4n6zE4=;
        b=hlvk7JRC81/xR+uy4wiZDndnYtYudXUZUCS7atkumrehW8Z7S+3sF4Gs/Zgh4HgFvE
         MZHcyCmm3QLmCWZRQedeHDbe5hfNrRceNxDTnrB0T8T0arb5zJgisGqFJFQnWWR+dkDN
         6lXYZH+9DzW3R13lvgmJmDgvY0YdgHURR3kY0iA8OtX4MJ2HEzh0PX2DFNbMzW3aklxh
         5Fhk1U/2D1C4Vy7jAtYJULJ1e5InHzKyQr5AVq5701/hJuK2IwZLiZY5ozyGO2fwrVoL
         Bi3zChGD/jUlZGkkfwlSv+2yccFd4mQfe4uf57X58a3eH/G5vTgyw92ICPC46ide1TCM
         ZetA==
X-Gm-Message-State: AGi0PuaC4WqyoqJ/ARcgbM8eko8M7jD0cBTj1Dbd9Anta+EwO1glvvGV
        iY5z8yF4c4BlyphVMWxghB5Bvg==
X-Google-Smtp-Source: APiQypJJPcF0dlqI2sacmykdGez1Z2nDV2mUtw2uVa6WLfP1A1vNVDcBNDSbyg81qVrCEIJS07OSsA==
X-Received: by 2002:a17:90b:46c2:: with SMTP id jx2mr296161pjb.67.1588630212239;
        Mon, 04 May 2020 15:10:12 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 14sm86208pfy.38.2020.05.04.15.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 15:10:11 -0700 (PDT)
Date:   Mon, 04 May 2020 15:10:11 -0700 (PDT)
X-Google-Original-Date: Mon, 04 May 2020 15:09:13 PDT (-0700)
Subject:     Re: [PATCH 1/2] riscv: defconfig: enable spi nor on Hifive Unleashed A00 board.
In-Reply-To: <1588240732-13905-2-git-send-email-sagar.kadam@sifive.com>
CC:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, sagar.kadam@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sagar.kadam@sifive.com
Message-ID: <mhng-ccfe9c83-41d6-47a0-b7bc-347573973fec@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 02:58:51 PDT (-0700), sagar.kadam@sifive.com wrote:
> Enable MTD based SPI-NOR framework in order to use spi flash
> available on HiFive Unleashed A00 board.
>
> Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> ---
>  arch/riscv/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 4da4886..970580b 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -80,6 +80,8 @@ CONFIG_USB_STORAGE=y
>  CONFIG_USB_UAS=y
>  CONFIG_MMC=y
>  CONFIG_MMC_SPI=y
> +CONFIG_MTD=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_VIRTIO_PCI=y
>  CONFIG_VIRTIO_BALLOON=y

From the second patch's description I'm assuming that MTD still functions
correctly without that change?
