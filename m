Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D2BC1975A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 02:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BF6206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 02:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NuDoBdHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgCMCrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 22:47:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38414 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgCMCrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 22:47:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id x11so5447128wrv.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 19:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OdrpLOjcNV9+wy4GNwbzFp8QEspzVR1N0/SaxxYMR5A=;
        b=NuDoBdHxvbbaqnKwo1XHy53ClOrSFGSHpDKm2UoEh+goApuSz24i0u5RU8OoHamVM7
         yMECZOzOwXYTiO5YRBY25Zbsht6q5TIl98DYqD5NVG+hWiGdKtMpD0a6Hs3c0uvoOnet
         y1luDcq6utIhuQBtF/yTiouNsxZcKdfpekGXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OdrpLOjcNV9+wy4GNwbzFp8QEspzVR1N0/SaxxYMR5A=;
        b=Y7KrpLwXISBhKyYPzU2aXHrwMdXaXWWocE/+r+fX0pgzX1ySE1i8JsSmdy1zaA3Nu6
         KdyG9EFC+5s4aEssmiMcxHrdqhPfg6IaHgAf5jvM3icOZ/rn0NDBt8nMSXfFfQy4qr/m
         ZhLuCd1sZeEN3MwhAhUigAXH//eKysfCI7McD24EhLoZxEDzGoaoHI6CG0T6OSSVdpEm
         lxlx07LpdkrwM2CZfUAkdX3wKrkj8x6dFhsv8YP/hkyys+khqAeZ8WiO+yrJEi/iLl1t
         UGX+IbvV2w0YA6gDWHbSzj2UANP5skSlEI1iHkmnCa69ZIgLCPpg90ZI1uJyRS1fWtYw
         s/5Q==
X-Gm-Message-State: ANhLgQ37xbrYx+xFiZ6NyFA3pOMvu4xSUiNJtGOpxk+pnhmjFgYpD7uP
        /zsFQjaPOafzemaw+W0ijyN/Kg==
X-Google-Smtp-Source: ADFU+vvBv9f6+FaaZ139ZafywBC2OcKDNJ12Yf14ArY8iMPQt8yHd/6v2z3jKPrMkNuoGshVYEqjmQ==
X-Received: by 2002:a5d:508b:: with SMTP id a11mr13838274wrt.332.1584067632756;
        Thu, 12 Mar 2020 19:47:12 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p4sm2668427wma.21.2020.03.12.19.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 19:47:11 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: always allow C99 SPDX License Identifer
 comments
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20200311191128.7896-1-scott.branden@broadcom.com>
 <2c4b42d1fb0bdb6604a72b2a10d49f9eae4b0ff4.camel@perches.com>
 <7056bd62-4251-f9bb-2b97-15f93a1e7142@broadcom.com>
 <4aadd119d4336de9eafcfbadb951630eb0cf2eb9.camel@perches.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <fa9eaa68-c950-6cc8-78fd-a0f4923ac2c5@broadcom.com>
Date:   Thu, 12 Mar 2020 19:47:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4aadd119d4336de9eafcfbadb951630eb0cf2eb9.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 2020-03-11 9:42 p.m., Joe Perches wrote:
> On Wed, 2020-03-11 at 19:48 -0700, Scott Branden wrote:
>> Hi Joe,
>>
>> On 2020-03-11 7:26 p.m., Joe Perches wrote:
>>> On Wed, 2020-03-11 at 12:11 -0700, Scott Branden wrote:
>>>> Always allow C99 comment styles if SPDK-License-Identifier is in comment
>>>> even if C99_COMMENT_TOLERANCE is specified in the --ignore options.
>>> Why is this useful?
>> This is useful because if you run checkpatch with
>> --ignore=C99_COMMENT_TOLERANCE
>> right now it will warn on almost every .c file in the linux kernel due
>> to the decision to
>> use // SPDX-License-Identifier: at the start of every c file
> Maybe this is better:
>
> Just don't perform any other per-line checks on a valid or invalid
> SPDX line.
I tried your change and it works as well.
Probably better/simpler if no other processing is needed on lines with 
SPDX-License-Indentifier: on it.

Would you like to just submit your patch or do I need to construct 
something?
> ---
>   scripts/checkpatch.pl | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 529c892..3f2ae7 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3171,6 +3171,7 @@ sub process {
>   						WARN("SPDX_LICENSE_TAG",
>   						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
>   					}
> +					next;
>   				}
>   			}
>   		}
>
>

