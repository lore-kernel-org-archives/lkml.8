Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D859DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0FA2070C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX3DtDt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgGGDDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 23:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgGGDDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:03:24 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF4BC061755;
        Mon,  6 Jul 2020 20:03:24 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ch3so2681631pjb.5;
        Mon, 06 Jul 2020 20:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IAOSkZY/ZvTM/cuAPxHrdRvDZbhec76EIxGhgmaogKM=;
        b=QX3DtDt2YL5bx4hX5EoZiGPMkyNIohvPQLSqo7V8PD7/NFkl9GkrYUEO50vuV34eZS
         MBtZIWqv6u+nKqs0pI2gy6KVgp+Z16FAikeo5kuPMLNjYTd4uL+0noUOgviEMaDFq5Pl
         mTBcDJfvTE/IfSzPt2DDGeY17UA1IT/3PWuL4+G6ZJcG+gg4X0lyjFv55f76Ji/I9ejZ
         2T3y12DN6Budq9HTIT2PE1Uj4GoENYIOiRmTUO0U9qgMTpJNYAC2t3+9DON4XNPav4YZ
         aW7nv8aSh16qx0qEjH40S1fbrW9iYSQ3p65g8KXt2QkpcLNl8fXlqqa81yZFFlvYdnue
         uETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IAOSkZY/ZvTM/cuAPxHrdRvDZbhec76EIxGhgmaogKM=;
        b=biaFttLXfMTIRC9XADqAbfX0lEpeoRoQ6rxwVdoTvPx0jyP3xfQ/29/54RNyCRTgkn
         okpSyR+kEfqXU+QpvVguHTPMwB/QXvCWkL7JeDXIxvL9lbUlJBMPnt5fWTh1zgsSfVv8
         qBbOsDQzHgchCK5TNb0CbuQV3kKAG3tGk/E5nGTufafknuEugU0DtkVARJv6Df+VvTm2
         g/tW6EkwTajVRJQOkU6jcVakYGvjBbZ/Xuyqcf+rxW7REVLDmiFtjbMBqpuc/b1aVxl/
         P3A19mTvlX3K7vgVh6AKs8ItverOb8kvy2s3137hIDUZb9G11NIq3EkZ3GI9GNIDMt8Y
         77iQ==
X-Gm-Message-State: AOAM533Sr6wWxTtZiOgi+zb5qcdc3QzG0gGFVD5XA6yZc7iCBHLhNbDt
        MD1rjd/MjiUjwfG4MDYWo/TMksikB8I=
X-Google-Smtp-Source: ABdhPJwVOgQJl901G0y9cE+B7MUr9uN02Rm6zLCzJvdRY9JsfU4ndGOk5W6YrfURx0BDOFebeoXyoQ==
X-Received: by 2002:a17:902:ab8e:: with SMTP id f14mr45299469plr.80.1594091004064;
        Mon, 06 Jul 2020 20:03:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c132sm19863805pfb.112.2020.07.06.20.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 20:03:23 -0700 (PDT)
Subject: Re: [PATCH v3 0/1] hwmon:max6697: Allow max6581 to create
 tempX_offset
To:     Chu Lin <linchuyuan@google.com>
Cc:     belgaied@google.com, jasonling@google.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqil@google.com
References: <20200707011810.2508233-1-linchuyuan@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <46c25347-a9d9-3997-9aaa-7393cfccb4f7@roeck-us.net>
Date:   Mon, 6 Jul 2020 20:03:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707011810.2508233-1-linchuyuan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/20 6:18 PM, Chu Lin wrote:
> Per max6581, reg 4d and reg 4e is used for temperature read offset.
> This patch will let the user specify the temperature read offset for
> max6581. This patch is tested on max6581 and only applies to max6581.
> 

Since this is a single patch, you don't need patch 0.
Just add the change log after "---" to the actual patch.

Thanks,
Guenter

> Testing:
> echo 16250 > temp2_offset
> cat temp2_offset
> 16250
> 
> echo 17500 > temp3_offset
> cat temp3_offset
> 17500
> cat temp4_offset
> 0
> cat temp2_offset
> 17500
> 
> echo 0 > temp2_offset
> cat temp2_offset
> 0
> cat temp3_offset
> 17500
> 
> echo -0 > temp2_offset
> cat temp2_offset
> 0
> 
> echo -100000 > temp2_offset
> cat temp2_input
> 4875
> 
> echo 10000 > temp2_offset
> cat temp2_input
> 47125
> 
> echo -2000 > temp2_offset
> cat temp2_input
> 34875
> 
> echo -0 > temp2_offset
> cat temp2_input
> 37000
> 
> Signed-off-by: Chu Lin <linchuyuan@google.com>
> ---
> ChangeLog v2 -> v3:
>   - Use reverse christmas tree order convension
>   - Fix the type issue where comparision is always true
>   - Change the line limit to 100 char instead of 80 char
> 
> ChangeLog v1 -> v2:
>   - Simplify the offset reg raw value to milli ceisus conversion
>   - Substitute the temp1_offset with dummy attr
>   - Avoid using double negative in the macro definition
>   - Return the actual error when i2c read/write is failed
>   - clamp the value to MAX or MIN respectively if an out of range input is given
>   - Provide mux protection when multiple i2c accesses is required
> 
> Chu Lin (1):
>   hwmon:max6697: Allow max6581 to create tempX_offset attributes
> 
>  drivers/hwmon/max6697.c | 92 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 88 insertions(+), 4 deletions(-)
> 

