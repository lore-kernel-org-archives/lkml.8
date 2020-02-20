Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9875C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D932051A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lebedev-lt.20150623.gappssmtp.com header.i=@lebedev-lt.20150623.gappssmtp.com header.b="Xj26QZhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgBTSTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:19:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40823 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbgBTSTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:19:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id c23so3862060lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 10:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lebedev-lt.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BMudXWRavzU8ncImx/aSRyw9UQtZ0RxHFgnxmYTgr/o=;
        b=Xj26QZhSq3ROB90ZKv65EPbntTSjJUf3ya+rYi7+K0z+zCwE2HDMhX6XR2ngsFAHrk
         WqseTzGt6xHvQJvJmqulNHCpJczepO4PqkrxTfihTZO2iq5t0TofG1ZTnI4uoRA7ufvL
         qskk6GiWl9zsd3upI1+AWYLf1LoNDh+dEFxaEfWRQuYAl7dYFxZN46AOnn2OtFxwXt+g
         5CbB0cbMdLH72cWILlpauiaDrf7+0Zk+frFtn8HCuzccfS1fxF5bKeLitpE7V23PVtEF
         BWNTIpUXt8oEvVgKoMo1Ycii4G0XS7B9lo4Wl/9WHMu9xDvuroOt5XWmNBsN7kEsIwsy
         763A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BMudXWRavzU8ncImx/aSRyw9UQtZ0RxHFgnxmYTgr/o=;
        b=DSPsyGEstqIlyWHed7BByh2+Tx0RE3lvGAF3MIW/x2uKTqUVbrVhIviQc93QhvGOQq
         qFkc4QaQyqgtLMdO6pGIPOYSvhT1WgU5F9rW29pD01mEhvM1GunXsRlTa8FrcLHYnxw1
         YP412uPDRHHSP1t20vvpZbjU2JTonDEvbVYKYxUhQgkZl0qFZXSUDokKDgEp8dLXR1Gm
         aE+6V0jLHDe/JwCW6Tnug0/H2YbGdpMX7Uz0rz9eu4lOUzH8YT99VAQu+VRz2d/qYHk0
         uKC+v6u8d1NclcStNlwpkKnSDXlhLilVWwDsI9PKKsBlQGVcrdBkumuNiNramOnM1Hq0
         PB8g==
X-Gm-Message-State: APjAAAU0zgQsbiV/8fXEfD6imoEbFioTaXJji7EesH36PpvM5etVn7Tf
        kZOSG6Ba9T5LKKFSZtd5ZP8S4g==
X-Google-Smtp-Source: APXvYqwHMD7TjvA9qSHLAjro81EJY6e+tgA6JElGztVdIMsefhnoFuMqmbeC+l1pV9gnkOJ6fpFbKQ==
X-Received: by 2002:a19:97:: with SMTP id 145mr16976846lfa.98.1582222743500;
        Thu, 20 Feb 2020 10:19:03 -0800 (PST)
Received: from [192.168.1.108] ([5.20.204.163])
        by smtp.gmail.com with ESMTPSA id m21sm156300lfb.59.2020.02.20.10.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 10:19:02 -0800 (PST)
Subject: Re: [PATCH 1/5] drm/sun4i: tcon: Introduce LVDS setup routine setting
To:     Maxime Ripard <maxime@cerno.tech>,
        Andrey Lebedev <andrey.lebedev@gmail.com>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20200210195633.GA21832@kedthinkpad>
 <20200219180858.4806-1-andrey.lebedev@gmail.com>
 <20200219180858.4806-2-andrey.lebedev@gmail.com>
 <20200220172154.22gw55s2mzyr45tj@gilmour.lan>
From:   Andrey Lebedev <andrey@lebedev.lt>
Message-ID: <1002d964-28c9-ed69-64fe-6527418092bb@lebedev.lt>
Date:   Thu, 20 Feb 2020 20:19:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220172154.22gw55s2mzyr45tj@gilmour.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/20 7:21 PM, Maxime Ripard wrote:
>> +	regmap_write_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
>> +			  SUN6I_TCON0_LVDS_ANA0_EN_DRVD(0xf),
>> +			  SUN6I_TCON0_LVDS_ANA0_EN_DRVD(val));
>> +
>> +}
>> +
> There's an extra blank line here that was reported by checkpatch. I've
> fixed it up while applying.

Weird, checkpatch didn't warn me about that:

./scripts/checkpatch.pl 
patches/0001-drm-sun4i-tcon-Introduce-LVDS-setup-routine-setting.patch
total: 0 errors, 0 warnings, 103 lines checked

patches/0001-drm-sun4i-tcon-Introduce-LVDS-setup-routine-setting.patch 
has no obvious style problems and is ready for submission.

In any case, thanks for correcting it!

-- 
Andrey Lebedev aka -.- . -.. -.. . .-.
Software engineer
Homepage: http://lebedev.lt/
