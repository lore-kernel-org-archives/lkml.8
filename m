Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D7DC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3D82176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQpnX3Fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgBYOti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:49:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45594 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBYOti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:49:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so7276238pfg.12;
        Tue, 25 Feb 2020 06:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zqNQMQTgL7w8ueyDiwX5gME5EnoZmFsKC426nVt4A5Q=;
        b=PQpnX3FjM3RCssErYIw2A5JEKajXy69L7DyFIgMIP1X/3Z6PhovdzzI+J0UP2PwOrO
         5tc44InXaEpP8g3vT6qRtS8KL1b+NeNLAITxwanDM5g4Ufm5MCuuiw2jbDw0tk5SxmPq
         7RHtTCOYRlAodLwGdw0zxLTU/YpmUJuIkgz+aC2PLQVz8b2cKcPCqj2b5YqHJpli5zcj
         sHS98TE6tATc5lf0YnEleCmZPyIGS1mEcVNEYsETGwy5QnpJbj/On0QSsSspjuYy/jGt
         2JMT3UsNfKmVkT04DBPnuEM/JIZWTGLk3Sh1tIH8lJ99Vev+TzTu47byPZzKshP27QhL
         ZuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zqNQMQTgL7w8ueyDiwX5gME5EnoZmFsKC426nVt4A5Q=;
        b=FdXNf9ZvJ0YCh0/eqIHC8+cP6jROH4NnQdbTh6ZfXWf/ytHalWixT3x14dxCSmdTxi
         yUcWMZ1Z8UFQ5CUi4xqtF2jw7OITWEVGJhiSlteoF3QoWQR/sx2vu/wKhJy56+Xbra3t
         bhOci9OigbqhyKAar77b8oWs0P6X0n+RaPhHs6NushTOzhPsTBd8k2n3f3jlwFiEacl2
         IP7Q7LyI4HcUA8P/85NtlI6wxAHoRNHBTsSBBdYrRkZJjmoaMlEg9EGSU1tzrKQARaSV
         3pmZY3WcbXmyh60nTtZNBpyBvT9EUhuoWwQzMTK4YpHI811O7yLE0EvJpIZGulJwRC82
         YAsA==
X-Gm-Message-State: APjAAAUlTvXP8sEm/EzUXez5R5bzdivVpvtJIbP2bVQ9aeFLP2j3Efg7
        xI7Q6Hxx7DlKqIfvXfuWvXNQwHXw
X-Google-Smtp-Source: APXvYqxL32OfGVZHNZfwe0F18cET3H1W2w0CWGwGd6xnfcgd2nbInsCMqR8BZdH+If+CPcPllFkyGA==
X-Received: by 2002:a62:7b93:: with SMTP id w141mr59104079pfc.226.1582642177035;
        Tue, 25 Feb 2020 06:49:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x7sm17778950pfp.93.2020.02.25.06.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 06:49:36 -0800 (PST)
Subject: Re: [PATCH 2/3] docs: hwmon: Add support for ina2xx
To:     Franz Forstmayr <forstmayr.franz@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20200224232647.29213-1-forstmayr.franz@gmail.com>
 <20200224232647.29213-2-forstmayr.franz@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f4142460-ec38-a427-8429-8a4aa660aa8a@roeck-us.net>
Date:   Tue, 25 Feb 2020 06:49:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224232647.29213-2-forstmayr.franz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/20 3:26 PM, Franz Forstmayr wrote:
> Add documentation for INA260, power/current monitor with I2C interface.
> 

Subject should match description here (this patch does not add support
for ina2xx).

> Signed-off-by: Franz Forstmayr <forstmayr.franz@gmail.com>
> ---
>   Documentation/hwmon/ina2xx.rst | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/hwmon/ina2xx.rst b/Documentation/hwmon/ina2xx.rst
> index 94b9a260c518..74267dd433dd 100644
> --- a/Documentation/hwmon/ina2xx.rst
> +++ b/Documentation/hwmon/ina2xx.rst
> @@ -53,6 +53,16 @@ Supported chips:
>   
>   	       http://www.ti.com/
>   
> +  * Texas Instruments INA260
> +
> +    Prefix: 'ina260'
> +
> +    Addresses: I2C 0x40 - 0x4f
> +
> +    Datasheet: Publicly available at the Texas Instruments website
> +
> +         http://www.ti.com/
> +
>   Author: Lothar Felten <lothar.felten@gmail.com>
>   
>   Description
> @@ -72,14 +82,17 @@ INA230 and INA231 are high or low side current shunt and power monitors
>   with an I2C interface. The chips monitor both a shunt voltage drop and
>   bus supply voltage.
>   
> +INA260 is a high or low side current and power monitor with an integrated
> +shunt and I2C interface.
> +
>   The shunt value in micro-ohms can be set via platform data or device tree at
>   compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
>   refer to the Documentation/devicetree/bindings/hwmon/ina2xx.txt for bindings
>   if the device tree is used.
>   
> -Additionally ina226 supports update_interval attribute as described in
> -Documentation/hwmon/sysfs-interface.rst. Internally the interval is the sum of
> -bus and shunt voltage conversion times multiplied by the averaging rate. We
> +Additionally ina226 and ina260 supports update_interval attribute as described

s/supports/support/

> +in Documentation/hwmon/sysfs-interface.rst. Internally the interval is the sum
> +of bus and shunt voltage conversion times multiplied by the averaging rate. We
>   don't touch the conversion times and only modify the number of averages. The
>   lower limit of the update_interval is 2 ms, the upper limit is 2253 ms.
>   The actual programmed interval may vary from the desired value.
> 

