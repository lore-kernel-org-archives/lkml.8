Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB62C34033
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742CF2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OsUoa6Qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgBRJbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:31:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46469 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgBRJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:31:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so22974183wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BpO/OHsHA7PV0jqwvZ1c934b+CkSx8X5QNPnOFLhiR0=;
        b=OsUoa6Qr1x69l/fct8bF47dGeH0qBz00GU27Scmsz+7rzcx0ZGOyND+E7ysQx8cdnp
         J/v6EpYKwWMBla2EdpVijHW6Flm5tGOdkv565Y5Qyc+smpaRx7KkouzdbgGuEhW2WXzC
         O7UNtZQn+qd0sbf6YFDZOFcWL61ONNI7hjvibxmg9MfFCIvqXC/0u02qu2oQJOLkCXJJ
         beQJC6K04ZRJJiqZ+IDEicnzHTwHgShvtupkKpKPqmENqxBSp9CwEAElS+yG29J1Yw8d
         9mSk/OufvScKTB2TDZgGqANNkFK7NsWV57J9kI4FJBhpLqPJWGDAHSxOEfV2vh2Deh0b
         Gdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BpO/OHsHA7PV0jqwvZ1c934b+CkSx8X5QNPnOFLhiR0=;
        b=adefm5/1bGS2zo8MTkYyGT1LGre9txeEk+bmHuPiKAZACfExFbQxBvsD0bUrQPLtSl
         7pxN5taJ2wfQhwOPad37nDZVOWOyfZX958UF7XmEy9DyyTifu5ZZcV4cgcYsq0APEg2z
         cTxvcqJJkYT5QYa2kypd9ybpDGX5GBizuTXNveqWsL32FOWiODBr1WgkJuWa6C6JD2jA
         Zn7qpxxH2785nx9J20brtVI1dtgcxDIQ3s6p93lavg0/AQIRQmxtdAgKAg/ySgriEJO8
         Z9NaiUF/JcYHMZgeGUQRN5k3vz2wggUSG8bO+6pMcbsf+uLFP3/cQdzuf5tl5gmn1Km8
         i3kQ==
X-Gm-Message-State: APjAAAX79HZZQoiidV9/HO2RUjxMx86rmEM1v4cm3mC1nTeqi8UFPS5v
        HmVfTDQZUJgweIiUetfKNyZYDg==
X-Google-Smtp-Source: APXvYqyn1G9cbVIBmTWuD/btRrQZYOVc1Qk9wC5TwjUmciWe6Vk3QBn86rksk9mhr6SvzeNEZ8D1SA==
X-Received: by 2002:adf:eb46:: with SMTP id u6mr28188181wrn.239.1582018275789;
        Tue, 18 Feb 2020 01:31:15 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id a9sm5286992wrn.3.2020.02.18.01.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 01:31:15 -0800 (PST)
Subject: Re: [PATCH 4/6] nvmem: add a newline for readability
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20200217195435.9309-1-brgl@bgdev.pl>
 <20200217195435.9309-5-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <59e87e77-1251-38f8-46d6-1d283c89cf7e@linaro.org>
Date:   Tue, 18 Feb 2020 09:31:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200217195435.9309-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/02/2020 19:54, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Visibly separate the GPIO request from the previous operation in the
> code with a newline.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---


Applied thanks,
--srini
