Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DAEC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B04206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psnmWQR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgDCVHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:07:05 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37077 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgDCVHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 17:07:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id t11so6963530lfe.4;
        Fri, 03 Apr 2020 14:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jki7A5iXnffJdSlBZi8ckrm0OPi/inFqAyqX+Ha0Fdc=;
        b=psnmWQR6M6uPn8Yo1rz3yibcg8vtiiPJOu+yZiqhT9h6oYYRGUiMYw0ydiNWZy79EK
         DyV+mlJnkfAj4B961XkNmZF4OFiogv5ZLPB8Cu4idUD+vzEyYewf4FciyDIaark+LBXG
         5JoDHNE8IxGLUg9LsVeUwLmH/2mGSuSbj97ai31NkxeTMQfmn5VnZAHfMKXqI/VVA/22
         kRXyBuExEsnv9IDj3tIIHO84bnWPpH8gPSMv4NKGD6VHcx3OMVYtmwqWB3JedKtsMypM
         6VpaDGcz9UQpqemClrB9rwOBJxv4JuqihcKstW0N5myOqQ8Os2c1s6Qe1DeJL7Kn+uRT
         ptNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jki7A5iXnffJdSlBZi8ckrm0OPi/inFqAyqX+Ha0Fdc=;
        b=rXcaXp8Y4oCvsjBpwe19+qGU8aDyKsYjoun4dZNb+DCID6SUDZlH55im9htUgzzYaI
         sCPkVBvz4uxJwzfJUHyaZ30w0dWaUZ4ltxw8veQm96qTT8SnnrIvooYw9Nc9Xk7Kln3+
         +P5wptBwWql0vNvH+ttHg014iGeIDvTh091Pm1UvSgBL//VeruA6TotALsSjdShC5KVc
         JLD2rUJaxcGBOdCSrSm4NmlZNB84ixo+6mlD8p6kgNOyWUttRoTCxqy/LGBougUicj40
         ib/ev42pmqauVWAgHfR1Rpzq0jkSiRDrxMbIPuBAM2Kf6BkGmQQTHv2wzJ6T5P4RDzMk
         kaSQ==
X-Gm-Message-State: AGi0Pub4YiLTy2wf44acTMHTgxPzYZqM2yV+pf0lBvTkZ3755Gp2MCco
        hQV0fp1+RmHV1o5K81r+3Dsg4SO4
X-Google-Smtp-Source: APiQypLLBXgFa4KTCAa3WGPmA2abd73sXhS1qwFRuXxsawAd5A+taNVNWmqUMr0ilw3v+Ti7hCbBng==
X-Received: by 2002:ac2:58c8:: with SMTP id u8mr6591647lfo.115.1585948019676;
        Fri, 03 Apr 2020 14:06:59 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id h3sm6838873lfk.30.2020.04.03.14.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 14:06:59 -0700 (PDT)
Subject: Re: [PATCH v3 2/7] clocksource: Add Tegra186 timers support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200403202209.299823-1-thierry.reding@gmail.com>
 <20200403202209.299823-3-thierry.reding@gmail.com>
 <eb2a848f-9a4f-7c06-aff0-86d5087fe053@gmail.com>
Message-ID: <185abbe6-5c17-1c04-708e-6374b28ce97f@gmail.com>
Date:   Sat, 4 Apr 2020 00:06:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <eb2a848f-9a4f-7c06-aff0-86d5087fe053@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.04.2020 23:51, Dmitry Osipenko пишет:
> 03.04.2020 23:22, Thierry Reding пишет:
> ...
>> +static irqreturn_t tegra186_timer_irq(int irq, void *data)
>> +{
>> +	struct tegra186_timer *tegra = data;
>> +
>> +	if (watchdog_active(&tegra->wdt->base)) {
>> +		tegra186_wdt_disable(tegra->wdt);
>> +		tegra186_wdt_enable(tegra->wdt);
>> +	}
> 
> Shouldn't this return IRQ_NONE if watchdog is inactive?
> 
>> +	return IRQ_HANDLED;
>> +}
> 

Could you please explain why this interrupt handler is needed at all?
Shouldn't the watchdog's core take care of the pinging?
