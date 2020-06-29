Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B27CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160EA20663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbgF2UtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731510AbgF2TNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33299C014AFC;
        Mon, 29 Jun 2020 00:59:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: myjosserand)
        with ESMTPSA id EA3EF2A1D14
Subject: Re: [PATCH v4 0/2] ARM: Add Rockchip rk3288w support
To:     Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20200602080644.11333-1-mylene.josserand@collabora.com>
 <159238429476.1470505.6023847362048785737.b4-ty@sntech.de>
From:   Mylene Josserand <mylene.josserand@collabora.com>
Message-ID: <66bfd77c-83e4-3689-d8c1-c5ae47b40f02@collabora.com>
Date:   Mon, 29 Jun 2020 09:59:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159238429476.1470505.6023847362048785737.b4-ty@sntech.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko,

On 6/17/20 10:58 AM, Heiko Stuebner wrote:
> On Tue, 2 Jun 2020 10:06:42 +0200, Mylène Josserand wrote:
>> Context
>> -------
>>
>> Here is my V4 of my patches that add the support for the Rockchip
>> RK3288w which is a revision of the RK3288. It is mostly the same SOC
>> except for, at least, one clock tree which is different.
>> This difference is only known by looking at the BSP kernel [1].
>>
>> [...]
> 
> Applied, thanks!

Thank you!

Best regards,
Mylène

> 
> [1/2] clk: rockchip: Handle clock tree for rk3288w variant
>        commit: 1627f683636df70fb25358b0a7b39a24e8fce5bf
> [2/2] dt-bindings: clocks: add rk3288w variant compatible
>        commit: 00bd404144241155653bb0d0c15be51e4e6983aa
> 
> Best regards,
> 

