Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69944C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE68206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYdPIASj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgCMJsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:48:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43598 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgCMJsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:48:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id b2so4975737wrj.10;
        Fri, 13 Mar 2020 02:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XQL/ya+7buqNZWgLcV53EPIchP1Jf2XAfvnaPJGA1KA=;
        b=pYdPIASjYoqpQoZ+d0D1BtbpFxOaL31zy7s2vppMa61ioYUMdqnfucab9xSLprGaDe
         KGicwSl2z64hVgJwPPxeOtKJSWJRP0vq189Vy1BPL+jTmMa+VMOWe/NXV//VrMWJCkUy
         5m9fX3NLEGm86NabuYrtSJ5drAQItP1zom27YjfmHKtnXn03WFVN39BlGaUpr3OKh/pW
         useVs+j1RAHP31DeNOzwEI0F8RdbySDuG9ZwxP0fv0m+LSQJyq6zpF54I/BNiIJyB5d9
         rkMCgtLU6AMeSCqrgPTrLvm1L6c3kAt+8Ak/s+CyalMgFapywFDRN8dOqKsEWuSOeWRt
         3qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XQL/ya+7buqNZWgLcV53EPIchP1Jf2XAfvnaPJGA1KA=;
        b=r+fCloiLMutgB2s9NtcLvX3XC+urR5oQJNA3Y7xfoig4DV4yezMhii8k6v8CdXp4sK
         Bz41nOo5OVDtcn7ZZ/KSS49QphnxwIF2Wkxfzjd6JlKsl1ltB8boeQJhbSWzTEUvneRe
         6vLlzQRH5naz6Wwv+z+jT+hu4jgphOZRonKvXEd1SXhFQ72u1ydYeQ6gLijfjP/u+rtg
         L7TYFzbESftkr3xpsVWu5qMWbQEvcVTZAlbBeeScSHt9lVotqyOAmuJ3xrStZ/Vxyod6
         O0+o0VD0CEaMLZvvhpp8vwLNRchver0D9tBKZveA7XGXUFcPAP2H0VmIjRbkyVh4Wqyp
         hyOQ==
X-Gm-Message-State: ANhLgQ2DmiIa82AryWt8I+VlVc7DvHtuCjfQN8ml04BQGFW/YJJ3GRLT
        kzRGp/HBBzx8yNjkgVmRipInR7nO
X-Google-Smtp-Source: ADFU+vtaxHOPeIyS6PgzifyQThwGs16+e+1vFL082dvhCXY95j+M8YBn6L+ANelNhAcd5SM3g8oOtQ==
X-Received: by 2002:adf:94c2:: with SMTP id 60mr16813347wrr.396.1584092877688;
        Fri, 13 Mar 2020 02:47:57 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u7sm8109776wme.43.2020.03.13.02.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 02:47:57 -0700 (PDT)
Subject: Re: [PATCH 2/3] ARM: dts: rockchip: add missing @0 to memory
 nodenames
To:     Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200304074051.8742-1-jbx6244@gmail.com>
 <1784340.9KJLpVao5L@phil> <2a5ef6fc-2487-91ef-24ce-97dd47b0a137@gmail.com>
 <7869677.iSBujUIW6u@phil>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <5af5bdfd-3522-9066-8bde-84a5e468be32@gmail.com>
Date:   Fri, 13 Mar 2020 10:47:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7869677.iSBujUIW6u@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko, Rob,

From https://coreboot.org/status/board-status.html

The only supported boards listed are:

Veyron Rockchip RK3288 boards
Veyron Mickey Rockchip RK3288 board
Veyron Rialto Rockchip RK3288 board
Gru Rockchip RK3399 reference board

Fixed with:
ARM: dts: rockchip: Remove @0 from the veyron memory node
https://patchwork.kernel.org/patch/10688081/

The problem is rk3288-veyron only I think.
Else fix coreboot to comply with DT rules, not the other way around.
Will make v2.

Can robh give advice here?

Thanks

On 3/6/20 12:58 AM, Heiko Stuebner wrote:
> Hi Johan, Rob,
> 
> Am Donnerstag, 5. März 2020, 23:21:52 CET schrieb Johan Jonker:
>> Goal was to reduce the error output of existing code a little bit,
>> so that we can use it for the review of new patches.
>> Some questions:
>> As I don't have the hardware, where else is coreboot used?
>> Is this a rk3288-veyron.dtsi problem only?
>> ie. Is it a option to produce a patch serie v2 without veyron?
>> Can someone help testing?
> 
> I believe that is more question for @Rob :
> 
> In the past we said that it would be ok to have "memory" nodes without
> address, so "memory {}" instead of "memory@0 {}", simply because
> bootloaders mess up sometimes.
> 
> Question now would be how to make the yaml bindings happy.
> 
> Thanks
> Heiko
> 
> 
>>
>> Johan
>>
>> On 3/5/20 10:31 PM, Heiko Stuebner wrote:
>>> Hi Johan,
>>>
>>> Am Mittwoch, 4. März 2020, 08:40:50 CET schrieb Johan Jonker:
>>>> A test with the command below gives for example this error:
>>>>
>>>> arch/arm/boot/dts/rk3288-tinker.dt.yaml: /: memory:
>>>> False schema does not allow
>>>> {'device_type': ['memory'], 'reg': [[0, 0, 0, 2147483648]]}
>>>>
>>>> The memory nodes all have a reg property that requires '@' in
>>>> the nodename. Fix this error by adding the missing '@0' to
>>>> the involved memory nodenames.
>>>>
>>>> make ARCH=arm dtbs_check
>>>> DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/
>>>> schemas/root-node.yaml
>>>
>>> changes to memory nodes you sadly cannot do in such an automated fashion.
>>> If you read the comment in rk3288-veyron.dtsi you'll see that a previous
>>> similar iteration broke all of those machines as their coreboot doesn't
>>> copy with memory@0 and would insert another memory node without @0
>>>
>>> In the past iteration the consensus then was that memory without @0
>>> is also ok (as it isn't changeable anyway).
>>>
>>
>>> As I don't really want to repeat that, I'd like actual hardware tests
>>> before touching memory nodes.
>>
>> Any suggestion/feedback rapport welcome.
>>
>>>
>>> Heiko
>>>
>>>
>>
> 
> 
> 
> 

