Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDF4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A187320737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPUt0nwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgFINuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730311AbgFINuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:50:17 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC613C05BD1E;
        Tue,  9 Jun 2020 06:50:16 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y17so8058943plb.8;
        Tue, 09 Jun 2020 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T+YJKeaOVYUazWEiD+FC8ATuHe96dWcYavuW/yCbOJ8=;
        b=jPUt0nwIlm22VZ9NM8bA8jJUH3/vojexLi25P2CSJEQLLyMcgS8L/O4tdrqBie5DG4
         lpCQ83zaNoNLyRbtv9PXZCVijMfIgwToB80TVKfygem0BD5GN3TnPDkl51B0erQQEcRS
         pMj8dmvRdp9ouEyAd7C9OqJrcaimaa1bFk3SsTLknJtj7oY5n1oF/oD+DrLSdyBeNmGK
         5xX5S7MH7aWAkbXmi5KB4cvcbCiIrDwj6Nw1dPTdUAmH1816/77epygsbbWsxIk33Xse
         9pGKdpJ3QG5CdWJgCtKD1wWBA/dEIG5uwm9zvFXlpqmZ7oeFxg4JKuNkAPbt9424wrZ0
         oFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=T+YJKeaOVYUazWEiD+FC8ATuHe96dWcYavuW/yCbOJ8=;
        b=FzOgqGoJ2QH9UGgla4PiiCIrbtbGA7e726Lqo7mJ4BnMoFy/XCiHyHVmaonPzRKdOM
         r22rh2f/UoyRk/HUB9yj1OX7PiUPlem0lNPdUr6Juv1bdJ3T7HCHAnp2pB4ZeQIRrZ3x
         VHiQtZhWyLlUN+S4RKFC0NzpmZUQhkeDKKxSW+M8UKOAAWvYsVtlQCCgZKKhaUoNBSTg
         mC0RUoCbpl4b3YrBlrqcRAUHjbmpyf3iFmROzeyC+AsrAC9vAEnx5QK/h1npk2l7DXy/
         mK9KIjCuhHn1yi4o/DeuqECmqcO46yzpEom6ZsnCpA3aRMKXzjzS/jURwNwWF/nb1lR+
         qC8Q==
X-Gm-Message-State: AOAM533gqgHnhXwD4jP2OpV0Bp1JvCUs4qpzySEsL4/Hi0PX3A/WoXFz
        wqjw3DiIjEaRlAbEgsVX5qc=
X-Google-Smtp-Source: ABdhPJyUnUWzeW0xWjPqzYyPmmCu9YaKhZU6LXzT6RNu0dBqMFw/Le2X2mLtUg75RNwhOibnjx6iRA==
X-Received: by 2002:a17:90a:9484:: with SMTP id s4mr5008356pjo.30.1591710616351;
        Tue, 09 Jun 2020 06:50:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gq8sm2668734pjb.14.2020.06.09.06.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 06:50:15 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] hwmon: Adding support for Microchip Sparx5 SoC
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20200609072828.9088-1-lars.povlsen@microchip.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <5f006733-52b6-e003-5db3-2ff16596918c@roeck-us.net>
Date:   Tue, 9 Jun 2020 06:50:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200609072828.9088-1-lars.povlsen@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 12:28 AM, Lars Povlsen wrote:
> This is an add-on series to the main SoC Sparx5 series
> (Message-ID: <20200608123024.5330-1-lars.povlsen@microchip.com>)
> 
> Changes in v2:
> - Changes in driver as per review comments
> 

And you expect the reviewers/maintainers to remember what those were ?

> Lars Povlsen (3):
>   dt-bindings: hwmon: Add Sparx5 temperature sensor
>   arm64: dts: sparx5: Add hwmon temperature sensor
>   hwmon: sparx5: Add Sparx5 SoC temperature driver
> 
>  .../bindings/hwmon/microchip,sparx5-temp.yaml |  39 +++++
>  arch/arm64/boot/dts/microchip/sparx5.dtsi     |   6 +
>  drivers/hwmon/Kconfig                         |  10 ++
>  drivers/hwmon/Makefile                        |   2 +-
>  drivers/hwmon/sparx5-temp.c                   | 152 ++++++++++++++++++
>  5 files changed, 208 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
>  create mode 100644 drivers/hwmon/sparx5-temp.c
> 
> --
> 2.27.0
> 

