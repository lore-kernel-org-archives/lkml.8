Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC82C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EE320722
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TrdZpEjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgBRJbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:31:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33207 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgBRJbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:31:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so23070158wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vAU9/IZSkHK9Aox2zLWCunLKvqMaq8guO6eTCBwn3vM=;
        b=TrdZpEjHaVMp2FbbqFvXLcNLZ5tJrqRNCYsPUUHgk1LytkOkvj4NX1xQxBbnLNhQTH
         QYzIdUfTjMP04BOi9cSIXMN5FEanQjQkhC4zSVmO+U+TlyKw3dsDDLq/lv10+AqvpbtD
         5wmOEfU89X4C6yhzw9So3VKldv0d5K90/WoJDeXquYVdRJXuMfWfaQ7r2Km6GQ0ADv1f
         9eu3e1sF06POjcQVM+v7mO8OT0rO4UpGUnQQ/zhhiUmuwtg5tUfta6W+FIGIi7N0u4Nz
         5Jao+ml0uoWNfHUthcbjeWzmdRZFWeyqGW18Ct4KjuA/S2mSBr0anMc/3JAHfgvL5YTv
         kDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vAU9/IZSkHK9Aox2zLWCunLKvqMaq8guO6eTCBwn3vM=;
        b=mCf2BMV4VQQuRC7iOQTR9O/Xje+sXwQsshs3w6iLDtUTvTRr0rySeQKZfjaQv8wF+b
         IcaQwlAy5VFgCg3oSU3jbNtJYMpnSyD7Xds4BMYbqpsZZMQDnQENPX/1m9H1UBczsSov
         qmX8viXkAzLtaZC5ELLj86UapnfgyA6VnpJAUIwK1HVTR2t4RfkFkxiv5hJkWASSdBgY
         3FwVmGuVwbf0BGpTBRvLVwYZHcZwNIe6+mlrgXzq5hlx9tOIbMdwQZ5TfOSGZ0SmoYH2
         0ok208WeMv1biA6LDcorX/0Ky91IkiGlKYP4JqsPtO+/V4IzNnhd86KRILuGnLoCnym0
         PRpQ==
X-Gm-Message-State: APjAAAVQ9Rk/KJ7XYttrkwfcn9UVG/MulASyRp2aYy9kTYzTscPiq97l
        g55pPUO++1npiEnG2KhfRA1zVg==
X-Google-Smtp-Source: APXvYqxyRlCWcR9Z4C5bM0MuV/o6OE2fb+ZexSAjZZxI6JOU6i9S6EKW4FsZGGwmHmRl0Qe157Zc5Q==
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr28649558wrk.101.1582018271282;
        Tue, 18 Feb 2020 01:31:11 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h205sm2899648wmf.25.2020.02.18.01.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 01:31:10 -0800 (PST)
Subject: Re: [PATCH 3/6] nvmem: remove a stray newline in nvmem_register()
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20200217195435.9309-1-brgl@bgdev.pl>
 <20200217195435.9309-4-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <abbdbb0c-7a89-b8fe-d1b9-85c593598375@linaro.org>
Date:   Tue, 18 Feb 2020 09:31:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200217195435.9309-4-brgl@bgdev.pl>
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
> Two newlines are unnecessary - remove one.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---


Applied thanks,
--srini
