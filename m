Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC2BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70476206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597841455;
	bh=KYHqaPF4Vq7HcbkeXfIEw9ryB6UECQlidbUN7f0BjlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0tTd3SAM+Vf+EFk8Sc8XtoXJomWSLfaID7mel7dt2C20gBXpAeRzyKI6GTxLyW6fp
	 5AwqxhWwTArjdi0hVfdlKb349D1x/YxZfPpo0Z6Giy9ptSeyKoN7K8X2qSU1sUBj1n
	 UbFSV7GNqY5Zme9iWsxAcB/jRBks3uHW6a1Nt4bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgHSMus convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:50:48 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:44720 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgHSMun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:50:43 -0400
Received: by mail-ej1-f68.google.com with SMTP id bo3so26100878ejb.11;
        Wed, 19 Aug 2020 05:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=guHE7kaLBs8UPVVaHMDy7kFcmOqgLCIVdBiRCknqZHk=;
        b=grKHJbHTQHclPZHw+hEqEezBvFICRLFbBsBSOgzcQqDby3k3APQJdmJyK+Gc5N2k6r
         zr9cEIOW9FscfAqESRiZf6GxR34D7hKzpKc6lpzDlHxB/wx20PiLV4Om85Z6wHoGinON
         KpF/czDzuAdk4NakL1LQa7jxiF1lmf6TiAlJ7P4yR13PLv2m7HR2GVw7qIf9BdTPSBhP
         J9LuV6x4NGI90gjHqKXDgPqmRG4ZNwIgAM0aX1g3M+OG7+VPJHVCf7BwyhY6N9oldq20
         8Vja3VQhG8ck0wsTlqaIReHsuRTH5pLnQ7sQAXUtHlAia2upZbcNbcoALPBQdMqUC68M
         9M+A==
X-Gm-Message-State: AOAM533z4wMdYlVedWikGJt3DeF5AQux6rIH8XqoIK5ECtTE4Jo1VoC1
        G/osg54L5J1njrKxM22uR4Y=
X-Google-Smtp-Source: ABdhPJxcdxhxCkLCpuXsJQcplWd5WlvSDkMJO+88bZGztYzhcIRHaQJNH4sjOc3WO0go4kE78GVsbA==
X-Received: by 2002:a17:906:1106:: with SMTP id h6mr25077878eja.200.1597841441336;
        Wed, 19 Aug 2020 05:50:41 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id v14sm18724416ejb.63.2020.08.19.05.50.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 05:50:40 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:50:38 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 0/8] Some fixes for spi-s3c64xx
Message-ID: <20200819125038.GH18122@kozik-lap>
References: <CGME20200819123225eucas1p28be1b1920ade0ba8997bc17da97599b6@eucas1p2.samsung.com>
 <20200819123208.12337-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200819123208.12337-1-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 02:32:00PM +0200, Łukasz Stelmach wrote:
> This is a series of fixes created during porting a device driver (these
> patches will be released soon too) for an SPI device to the current kernel.
> 
> The two most important are 
> 
>   spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and s3c64xx_enable_datapath()
>   spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for Exynos3250
> 
> Without them DMA transfers larger than 512 bytes from the SPI controller
> would fail.

If these are two most important patches here, there should have a commit
message explaining their importance.

Best regards,
Krzysztof
