Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA34C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94155207BB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJ3+Ofpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgGHUc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGHUc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 16:32:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B2EC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 13:32:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g67so21322650pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 13:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LUqEZly64FOmIG6+9cb4DAtPXZe27rHEqLAQ5x9iY/Q=;
        b=jJ3+OfpxoR4T19hfjYINQFSBMw60Z7ipUUC4Pve6L6ZRBN+rzw9ViFxXpEvFVZF803
         NSwnIhowl52r4Bcr0ng/Xo6EjwqXPf0wJ3ti+XHo/+j2tBSYbmEr9W6+5w31mBB364OF
         21K9IvXDajs18p5BtAAfNnIGpPoaCd4b8PGIr2x8kr6k0TuNdtwt7eskdI3KPX0jBglh
         GdGpQYu6S+EYtG39icn7rBtHssBoFBJB1LMcl8ocO7cHntyCxzlkUrhwK9dVwtHYgMTX
         m1JLlGQH8Be0+rhhpz5tgv9zBBNX1ndAM8zLIbGO0Mkprla9n6ReIQkUpuUaU5jZEpi2
         AIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LUqEZly64FOmIG6+9cb4DAtPXZe27rHEqLAQ5x9iY/Q=;
        b=fh6ZN1zGfJ64Oli2M1vcEU6ztsRn87s9/okpmHY6DkIiqq6K3uU5Q2uCU/TKahbXUy
         hY5c/ih2gBXe3rompOIk4EyCoMc5SBOlzDEHSgeMQcxDRZWx6HNAw3sWs1yVEhRRKVFV
         huc+6OdQ9jD9iiVyalop9Yj5vD+tFfs7yee2dLHZ3Rpt4KOM75w2nHNyADxcSp55cLII
         9T7cKpb7FOvcWNHkda9oHlYrRcC4HA4et9hpKLGoVtF3LsYO8PpoLB0RZwvgXbSjJ6Jb
         O9F0WT4k0LonnbTUnIFMIsYEXYmqpYYMIWpcQIpE4UyYU8Fx70Iq9FvRZhNeh1RgkB2l
         010w==
X-Gm-Message-State: AOAM533px5PdfGUNGQ5o2x0WqogHZKI64DgO/qEa9834sJwRzJBXVD5d
        EWupQ2RRFZUIBuTiE1jJNzA=
X-Google-Smtp-Source: ABdhPJyNlmrpS0OvU1R4qvkhZ/9Rv2pXi88udVrYmfi14TnsTA5T3W4oHIHdO57ApXMeR/B6sskxKQ==
X-Received: by 2002:aa7:948c:: with SMTP id z12mr24034609pfk.47.1594240347151;
        Wed, 08 Jul 2020 13:32:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e128sm584420pfe.196.2020.07.08.13.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:32:26 -0700 (PDT)
Subject: Re: chrome-platform/for-kernelci bisection:
 baseline.bootrr.rockchip-dp-probed on rk3399-gru-kevin
To:     "kernelci.org bot" <bot@kernelci.org>, gtucker@collabora.com,
        kernelci-results@groups.io,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <5f06177f.1c69fb81.ed8e4.1a92@mx.google.com>
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
Message-ID: <a79f116f-2c6d-570d-8e06-95082d26d42d@roeck-us.net>
Date:   Wed, 8 Jul 2020 13:32:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5f06177f.1c69fb81.ed8e4.1a92@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 11:59 AM, kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> chrome-platform/for-kernelci bisection: baseline.bootrr.rockchip-dp-probed on rk3399-gru-kevin
> 
> Summary:
>   Start:      154353417996 KERNELCI: x86_64_defconfig: Enable support for Chromebooks devices
>   Plain log:  https://storage.kernelci.org/chrome-platform/for-kernelci/v5.8-rc1-20-g154353417996/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
>   HTML log:   https://storage.kernelci.org/chrome-platform/for-kernelci/v5.8-rc1-20-g154353417996/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
>   Result:     8c9a6ef40bf4 platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       chrome-platform
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
>   Branch:     for-kernelci
>   Target:     rk3399-gru-kevin
>   CPU arch:   arm64
>   Lab:        lab-collabora
>   Compiler:   gcc-8
>   Config:     defconfig
>   Test case:  baseline.bootrr.rockchip-dp-probed
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 8c9a6ef40bf400c64c9907031bd32b59f9d4aea2
> Author: Guenter Roeck <linux@roeck-us.net>
> Date:   Sat Jul 4 07:26:07 2020 -0700
> 
>     platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
>     
>     The EC reports a variety of error codes. Most of those, with the exception
>     of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
>     error code gets lost. Convert all EC errors to Linux error codes to report
>     a more meaningful error to the caller to aid debugging.
>     
>     Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
>     Cc: Prashant Malani <pmalani@chromium.org>
>     Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>     Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 

So, just FTR, turns out that there are callers which specifically check for
-EPROTO and examine the EC error code if it is returned, or just accept
-EPROTO as generic failure (but nothing else). Example is drivers/pwm/pwm-cros-ec.c:
cros_ec_num_pwms(). Such commands now fail, in this case because
EC_RES_INVALID_PARAM is now returned as -EINVAL and cros_ec_num_pwms()
doesn't expect that.

drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c has a similar problem;
it only accepts -EPROTO as "valid" error, but nothing else. I didn't check
for others.

Guenter
