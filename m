Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34764C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A14214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NKfeuU6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgCCKRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:17:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54546 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgCCKRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:17:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id i9so1034901wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 02:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YfpfnT9N+enxbVfw8OUfHW35/Eys7WMdDnf9Q3fUgeo=;
        b=NKfeuU6PsS0I/cnkSHorRy9uISdCdIHIdHCNfo1YVON/zbC7attc5yn0ODbRKD0H+b
         9owqpSDnkSLsYm/ku3TISi58CaGEzCX84WV07V5xHOch4NtbuoPQB221HWwYBg/V51r2
         ekzK7YCN1CcAEpGzVUUiydQPDf//7srFD5Iz0+iWFdDq5sUU6vf+t8JFY71jOUqH+gDE
         vv9ODutAa1HIrx7ubIpuHfwdftrV+voWpKz/HFiHs7zTtR94aWjh5UZrTWdhI23ZQFF4
         gxbHsB8m8KrJZqUpc3aYQJ9k/o1+KuI+duF7WPXRKGIbWdC8g0+u8v+IKQTXssCYOQdw
         dwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YfpfnT9N+enxbVfw8OUfHW35/Eys7WMdDnf9Q3fUgeo=;
        b=KWYY3+ZuFCXT91GbSm35w6oQ+/n42VLyAjmaXnT2ns31jfoNaKvgNvW+jSBSVclhwx
         COOqgJ3GNTLp9kzHpj9jbMtfbWyCBV6WvC1xNT2v4t9B49Eg0CeEiDH/emzSVYRDbQ1j
         coNajQDQOqw1rSfiTkHvRRA2fkEzkvvHU7zIKK3FeqI4s57zVzkMKwiYFf2W03Qb8cZk
         ogspp9+K0w9yPOtPpWRP9gD2YNREPMwLzGQYzm+OGeUR5eh1dVBZCRtSUUTcGTzOpKf8
         yVHMFTLyY891T7/p7VifwNKHcSjTeLFTyFCXjJ8eNyqQlw39k2WdcgwDniesAdSpxF/+
         gzrg==
X-Gm-Message-State: ANhLgQ06IyrYGWumCbDA7UjpUAC9KTl2aluP6w9gjO4daTRORzKeJrsV
        Ip6v9Fv+a8cpABtAGygmj/s3kFR+g8XxRw==
X-Google-Smtp-Source: ADFU+vtffG/wEOzgw5QP8a52SN+d9kOR9DZgHxqSjx90JgazrgkKvPaXb4KlQUwOFoY/oMn7RnA9HQ==
X-Received: by 2002:a1c:2358:: with SMTP id j85mr3841579wmj.137.1583230664639;
        Tue, 03 Mar 2020 02:17:44 -0800 (PST)
Received: from [10.1.3.173] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i204sm3284696wma.44.2020.03.03.02.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 02:17:44 -0800 (PST)
Subject: Re: [PATCH 2/4] drm/bridge: dw-hdmi: Fix color space conversion
 detection
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>,
        a.hajda@samsung.com
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200229163043.158262-1-jernej.skrabec@siol.net>
 <20200229163043.158262-3-jernej.skrabec@siol.net>
 <c1cbcdc0-61a7-e5cb-4ad0-7057c33da154@baylibre.com>
 <1955232.bB369e8A3T@jernej-laptop>
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
Message-ID: <610707a3-1596-252d-f507-c3c70179683d@baylibre.com>
Date:   Tue, 3 Mar 2020 11:17:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1955232.bB369e8A3T@jernej-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2020 17:42, Jernej Škrabec wrote:
> Dne ponedeljek, 02. marec 2020 ob 10:26:09 CET je Neil Armstrong napisal(a):
>> Hi Jernej,
>>
>> On 29/02/2020 17:30, Jernej Skrabec wrote:
>>> Currently, is_color_space_conversion() compares not only color spaces
>>> but also formats. For example, function would return true if YCbCr 4:4:4
>>> and YCbCr 4:2:2 would be set. Obviously in that case color spaces are
>>> the same.
>>>
>>> Fix that by comparing if both values represent RGB color space.
>>>
>>> Fixes: b21f4b658df8 ("drm: imx: imx-hdmi: move imx-hdmi to
>>> bridge/dw_hdmi")
>>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>>> ---
>>>
>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
>>> 24965e53d351..9d7bfb1cb213 100644
>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> @@ -956,7 +956,8 @@ static void hdmi_video_sample(struct dw_hdmi *hdmi)
>>>
>>>  static int is_color_space_conversion(struct dw_hdmi *hdmi)
>>>  {
>>>
>>> -	return hdmi->hdmi_data.enc_in_bus_format !=
>>> hdmi->hdmi_data.enc_out_bus_format; +	return
>>> hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_in_bus_format) !=
>>> +		hdmi_bus_fmt_is_rgb(hdmi-
>> hdmi_data.enc_out_bus_format);
>>>
>>>  }
>>>  
>>>  static int is_color_space_decimation(struct dw_hdmi *hdmi)
>>
>> I think in this case you should also fix the CEC enablement to:
>> if (is_color_space_conversion(hdmi) || is_color_space_decimation(hdmi))
>>
>> in dw_hdmi_enable_video_path() otherwise CSC won't be enabled and will be
>> bypassed in decimation case only.
> 
> On second thought, I think original implementation is correct, just misnamed. 
> Laurent, Neil, do you agree if I replace this patch with patch which renames 
> is_color_space_conversion() to is_conversion_needed() ?

Sure,
Neil

> 
> Best regards,
> Jernej
> 
> 
> 

