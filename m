Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D162EC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A492520801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjlglfJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgCEWV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:21:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43817 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgCEWV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:21:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id v9so39952wrf.10;
        Thu, 05 Mar 2020 14:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z7TiigNdjz+orfMlREKYMBZDrTKamsieMAuLprR2Fyw=;
        b=DjlglfJNJgBMOUmIioZMi+av2xMFnc/T2klMGdKaUEe06g41gCfZe+GdBgLANYqHFX
         YEy+LhwwPcxS+IzUlpR7Yu0fPJoFIsO/YtQgKWkHJPOux8wQCWy4uMX1phLX2cozPtbA
         rZ6TESS/7JM35YzciXup4yFqEK6ME98LnEQfT41dSfiIBHJd3vvhqaYwm4Z1jOJ8+YJ1
         hO2mdK6OiIT0dZmXXy/Ll4eoQYtZhPg7DTU/hoVFRNrzQ6GTnIe9O838s6bWWtTKQMJm
         /mx8ecIwB4CdKPG+vxVFkqaknTLQhfHIg6DRiLB+ENIwkvWiqj7rj1GnLe6WvxhvV8AD
         3+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z7TiigNdjz+orfMlREKYMBZDrTKamsieMAuLprR2Fyw=;
        b=NhC7ezAQ53FGACFE5l3zMh9frzYcv+rVsfNSRXn7cIY/sM6hneN4hXol6C+hbqKBNb
         4sh2gBsMq77k1cKXg9Ab1QYEvu54ePG8dVujxIPWM09R6oRu4Nvdaovu0HQLvG63mwAH
         rcH0ib5Izpdisba24oBQBVVonPA/8TyMo5oDZrAYvKVu3f5lgtTGKsyzAeYwdGurOPQk
         uoeWlp1NcMLZ8B9IOvdgFS+oCqadCcO+fNFahiqj8gbZcEeqv0RNq8AJFqgnnSKA5Im3
         uAcsffMcqUu527V9ib5CthQayTGmjy0/amrFjoVQfhJImCiLPOJnkyBoPQ3cfjICoJGW
         JjsQ==
X-Gm-Message-State: ANhLgQ2NCGlnx3Af74WKFxoOSEI7jlzYQ0G8Iz8o8L76Tv8NB096F71p
        7OSxfLh1ESCLfQPm79Yc9R9CRk15
X-Google-Smtp-Source: ADFU+vsPqjTKstCk+aKgW/j6ZMymiLJfuaIaKNq2Eq1mnpCpBxTW05y745VZ2m97812uXc1VuwMZOg==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr132122wrv.114.1583446914878;
        Thu, 05 Mar 2020 14:21:54 -0800 (PST)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id l5sm11017229wml.3.2020.03.05.14.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 14:21:54 -0800 (PST)
Subject: Re: [PATCH 2/3] ARM: dts: rockchip: add missing @0 to memory
 nodenames
To:     Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200304074051.8742-1-jbx6244@gmail.com>
 <20200304074051.8742-2-jbx6244@gmail.com> <1784340.9KJLpVao5L@phil>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <2a5ef6fc-2487-91ef-24ce-97dd47b0a137@gmail.com>
Date:   Thu, 5 Mar 2020 23:21:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1784340.9KJLpVao5L@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Goal was to reduce the error output of existing code a little bit,
so that we can use it for the review of new patches.
Some questions:
As I don't have the hardware, where else is coreboot used?
Is this a rk3288-veyron.dtsi problem only?
ie. Is it a option to produce a patch serie v2 without veyron?
Can someone help testing?

Johan

On 3/5/20 10:31 PM, Heiko Stuebner wrote:
> Hi Johan,
>
> Am Mittwoch, 4. März 2020, 08:40:50 CET schrieb Johan Jonker:
>> A test with the command below gives for example this error:
>>
>> arch/arm/boot/dts/rk3288-tinker.dt.yaml: /: memory:
>> False schema does not allow
>> {'device_type': ['memory'], 'reg': [[0, 0, 0, 2147483648]]}
>>
>> The memory nodes all have a reg property that requires '@' in
>> the nodename. Fix this error by adding the missing '@0' to
>> the involved memory nodenames.
>>
>> make ARCH=arm dtbs_check
>> DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/
>> schemas/root-node.yaml
>
> changes to memory nodes you sadly cannot do in such an automated fashion.
> If you read the comment in rk3288-veyron.dtsi you'll see that a previous
> similar iteration broke all of those machines as their coreboot doesn't
> copy with memory@0 and would insert another memory node without @0
>
> In the past iteration the consensus then was that memory without @0
> is also ok (as it isn't changeable anyway).
>

> As I don't really want to repeat that, I'd like actual hardware tests
> before touching memory nodes.

Any suggestion/feedback rapport welcome.

>
> Heiko
>
>
