Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E68BC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE2E2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QWEtnZvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgCXOgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:36:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46143 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbgCXOgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:36:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id j17so18333433wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Gevp5sNHQH6ntbIhc5KBRCvoT0lWeFA/LkmXeB8P9E=;
        b=QWEtnZvQ1iQRPlDbwUTeGiUrXB27aZockiWFe9Uw/f7RtYAuaq2WSvU7o/JvfzTE+r
         FILMMZHnhKpWeOXJ0NOOwmnvkpwsdIc2Z8zdBiyNI7yhDJ4oLv4UThW8q7WQ9CmWImqH
         t2RQB85pz7VK6/dKeSt+hq6X+OsVILksQ79wThA2rgb2G4jwjFIB8jKucq8RuJTp4ikW
         V8yN3DWK+gHLlOgSp+0560hKPoVmK4M9BpYZJmkfZH24SEOyAxzmkN2LaAnhRemyZQxv
         jxqkRUTqTU2vBJ6mFp/VFnXGkgwBNeL1kw69wnXKeM2cOR3qk28vqaLEtbTQauXnbLE+
         XPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0Gevp5sNHQH6ntbIhc5KBRCvoT0lWeFA/LkmXeB8P9E=;
        b=jdeEVut6y4eyckdJT36fYBw6JBbqVu4uIUk8RoH7NjrnPlNN+2DsoFYqCTknGfe6d3
         OwfOx1ukl6wjLqG01cyHfi/IZW4WsiQp6tyV5oGLKYxLGH4DvXHdRgIkai8t3mngmkcX
         nsGpRxj6sjWyL0WpUzEcvUQOAKQLlvLteINZEEJWRVPIUsPMalYXsutgV4TbHhjGCGzj
         WDJdRugV4OsqeRNyka1kza1IYB5BblOeT0BRS1ptdspMeNkY0RUF091gpjpIIvd8HaQe
         7CLdU0/iEEKcq0ZxNn4VLW5xWghWoY1yrsN47zqETr7cYqMhIIgWHGPbUMic1+54BaET
         Sbgg==
X-Gm-Message-State: ANhLgQ2/NdRKxdUM4IcGMw8lytel4lW0FzJNu3kjxs1+spbGeIuZoog6
        B+nNF7E3BHehpU7oQp7vd5PQpSwTO25SZg==
X-Google-Smtp-Source: ADFU+vtAanKj3SwM60GzKfDQBA9hFthXHkws+CwWdcn/gkfYLeklLyNG7Gsfh5EBlF7lUncr2P4fZg==
X-Received: by 2002:adf:f7cf:: with SMTP id a15mr32030001wrq.224.1585060560076;
        Tue, 24 Mar 2020 07:36:00 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2? ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id s131sm4566887wmf.35.2020.03.24.07.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 07:35:59 -0700 (PDT)
Subject: Re: [PATCH 05/13] usb: dwc3: meson-g12a: refactor usb2 phy init
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200324102030.31000-1-narmstrong@baylibre.com>
 <20200324102030.31000-6-narmstrong@baylibre.com>
 <CAFBinCDrycKy6sJfpUjoB3_jkHP-ssmwvr-Cab1-fOmz_i_bGQ@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwU0EVid/pAEQAND7AFhr
 5faf/EhDP9FSgYd/zgmb7JOpFPje3uw7jz9wFb28Cf0Y3CcncdElYoBNbRlesKvjQRL8mozV
 9RN+IUMHdUx1akR/A4BPXNdL7StfzKWOCxZHVS+rIQ/fE3Qz/jRmT6t2ZkpplLxVBpdu95qJ
 YwSZjuwFXdC+A7MHtQXYi3UfCgKiflj4+/ITcKC6EF32KrmIRqamQwiRsDcUUKlAUjkCLcHL
 CQvNsDdm2cxdHxC32AVm3Je8VCsH7/qEPMQ+cEZk47HOR3+Ihfn1LEG5LfwsyWE8/JxsU2a1
 q44LQM2lcK/0AKAL20XDd7ERH/FCBKkNVzi+svYJpyvCZCnWT0TRb72mT+XxLWNwfHTeGALE
 +1As4jIS72IglvbtONxc2OIid3tR5rX3k2V0iud0P7Hnz/JTdfvSpVj55ZurOl2XAXUpGbq5
 XRk5CESFuLQV8oqCxgWAEgFyEapI4GwJsvfl/2Er8kLoucYO1Id4mz6N33+omPhaoXfHyLSy
 dxD+CzNJqN2GdavGtobdvv/2V0wukqj86iKF8toLG2/Fia3DxMaGUxqI7GMOuiGZjXPt/et/
 qeOySghdQ7Sdpu6fWc8CJXV2mOV6DrSzc6ZVB4SmvdoruBHWWOR6YnMz01ShFE49pPucyU1h
 Av4jC62El3pdCrDOnWNFMYbbon3vABEBAAHCwn4EGAECAAkFAlYnf6QCGwICKQkQFpq3saTP
 +K7BXSAEGQECAAYFAlYnf6QACgkQd9zb2sjISdGToxAAkOjSfGxp0ulgHboUAtmxaU3viucV
 e2Hl1BVDtKSKmbIVZmEUvx9D06IijFaEzqtKD34LXD6fjl4HIyDZvwfeaZCbJbO10j3k7FJE
 QrBtpdVqkJxme/nYlGOVzcOiKIepNkwvnHVnuVDVPcXyj2wqtsU7VZDDX41z3X4xTQwY3SO1
 9nRO+f+i4RmtJcITgregMa2PcB0LvrjJlWroI+KAKCzoTHzSTpCXMJ1U/dEqyc87bFBdc+DI
 k8mWkPxsccdbs4t+hH0NoE3Kal9xtAl56RCtO/KgBLAQ5M8oToJVatxAjO1SnRYVN1EaAwrR
 xkHdd97qw6nbg9BMcAoa2NMc0/9MeiaQfbgW6b0reIz/haHhXZ6oYSCl15Knkr4t1o3I2Bqr
 Mw623gdiTzotgtId8VfLB2Vsatj35OqIn5lVbi2ua6I0gkI6S7xJhqeyrfhDNgzTHdQVHB9/
 7jnM0ERXNy1Ket6aDWZWCvM59dTyu37g3VvYzGis8XzrX1oLBU/tTXqo1IFqqIAmvh7lI0Se
 gCrXz7UanxCwUbQBFjzGn6pooEHJYRLuVGLdBuoApl/I4dLqCZij2AGa4CFzrn9W0cwm3HCO
 lR43gFyz0dSkMwNUd195FrvfAz7Bjmmi19DnORKnQmlvGe/9xEEfr5zjey1N9+mt3//geDP6
 clwKBkq0JggA+RTEAELzkgPYKJ3NutoStUAKZGiLOFMpHY6KpItbbHjF2ZKIU1whaRYkHpB2
 uLQXOzZ0d7x60PUdhqG3VmFnzXSztA4vsnDKk7x2xw0pMSTKhMafpxaPQJf494/jGnwBHyi3
 h3QGG1RjfhQ/OMTX/HKtAUB2ct3Q8/jBfF0hS5GzT6dYtj0Ci7+8LUsB2VoayhNXMnaBfh+Q
 pAhaFfRZWTjUFIV4MpDdFDame7PB50s73gF/pfQbjw5Wxtes/0FnqydfId95s+eej+17ldGp
 lMv1ok7K0H/WJSdr7UwDAHEYU++p4RRTJP6DHWXcByVlpNQ4SSAiivmWiwOt490+Ac7ATQRN
 WQbPAQgAvIoM384ZRFocFXPCOBir5m2J+96R2tI2XxMgMfyDXGJwFilBNs+fpttJlt2995A8
 0JwPj8SFdm6FBcxygmxBBCc7i/BVQuY8aC0Z/w9Vzt3Eo561r6pSHr5JGHe8hwBQUcNPd/9l
 2ynP57YTSE9XaGJK8gIuTXWo7pzIkTXfN40Wh5jeCCspj4jNsWiYhljjIbrEj300g8RUT2U0
 FcEoiV7AjJWWQ5pi8lZJX6nmB0lc69Jw03V6mblgeZ/1oTZmOepkagwy2zLDXxihf0GowUif
 GphBDeP8elWBNK+ajl5rmpAMNRoKxpN/xR4NzBg62AjyIvigdywa1RehSTfccQARAQABwsBf
 BBgBAgAJBQJNWQbPAhsMAAoJEBaat7Gkz/iuteIH+wZuRDqK0ysAh+czshtG6JJlLW6eXJJR
 Vi7dIPpgFic2LcbkSlvB8E25Pcfz/+tW+04Urg4PxxFiTFdFCZO+prfd4Mge7/OvUcwoSub7
 ZIPo8726ZF5/xXzajahoIu9/hZ4iywWPAHRvprXaim5E/vKjcTeBMJIqZtS4u/UK3EpAX59R
 XVxVpM8zJPbk535ELUr6I5HQXnihQm8l6rt9TNuf8p2WEDxc8bPAZHLjNyw9a/CdeB97m2Tr
 zR8QplXA5kogS4kLe/7/JmlDMO8Zgm9vKLHSUeesLOrjdZ59EcjldNNBszRZQgEhwaarfz46
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <5e5a5a25-bd3e-e476-2ed1-635d9c4a7773@baylibre.com>
Date:   Tue, 24 Mar 2020 15:35:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCDrycKy6sJfpUjoB3_jkHP-ssmwvr-Cab1-fOmz_i_bGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2020 15:33, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Tue, Mar 24, 2020 at 11:20 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> [...]
>> @@ -195,23 +239,9 @@ static int dwc3_meson_g12a_usb2_init(struct dwc3_meson_g12a *priv)
>>                 if (!strstr(priv->drvdata->phy_names[i], "usb2"))
>>                         continue;
>>
>> -               regmap_update_bits(priv->u2p_regmap[i], U2P_R0,
>> -                                  U2P_R0_POWER_ON_RESET,
>> -                                  U2P_R0_POWER_ON_RESET);
>> -
>> -               if (priv->drvdata->otg_switch_supported && i == USB2_OTG_PHY) {
>> -                       regmap_update_bits(priv->u2p_regmap[i], U2P_R0,
>> -                               U2P_R0_ID_PULLUP | U2P_R0_DRV_VBUS,
>> -                               U2P_R0_ID_PULLUP | U2P_R0_DRV_VBUS);
>> -
>> -                       dwc3_meson_g12a_usb2_set_mode(priv, i,
>> -                                                     priv->otg_phy_mode);
>> -               } else
>> -                       dwc3_meson_g12a_usb2_set_mode(priv, i,
>> -                                                     PHY_MODE_USB_HOST);
>> -
>> -               regmap_update_bits(priv->u2p_regmap[i], U2P_R0,
>> -                                  U2P_R0_POWER_ON_RESET, 0);
>> +               ret = priv->drvdata->usb2_init_phy(priv, i, mode);
>> +               if (ret)
>> +                       return ret;
>>         }
> this doesn't compile for me, it complains that mode is undefined
> I believe we need something like the attached patch on top.

I'll investigate

> 
> [...]
>> @@ -580,7 +612,9 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
>>         /* Get dr_mode */
>>         priv->otg_mode = usb_get_dr_mode(dev);
>>
>> -       dwc3_meson_g12a_usb_init(priv);
>> +       ret = dwc3_meson_g12a_usb_init(priv);
>> +       if (ret)
>> +               goto err_disable_clks;
> this looks like an unrelated fix, dwc3_meson_g12a_usb_init has always
> returned int (as potential error)
> also the same check is missing in dwc3_meson_g12a_resume
> can you please move this to a separate patch with the appropriate tag:
> Fixes: c99993376f72ca ("usb: dwc3: Add Amlogic G12A DWC3 glue")

Ok

Thanks,
Neil

> 
> 
> Martin
> 

