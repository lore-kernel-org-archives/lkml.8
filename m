Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64CEC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCB32081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXHlDgiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgAMSdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:33:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37353 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgAMSdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:33:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so10835961wmf.2;
        Mon, 13 Jan 2020 10:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZXLr4jt3Z0ly6bJlY2S1K+QAkB0UsTXiQL9zQoG2s4c=;
        b=mXHlDgiSO7p/uX3R9XNTgDdGIu/YGZA6qA1uL9FgkaEBt6vhBsjXg3YO9i7CMOhB3j
         MuaaxXJs/7qCYAEOy2rl0yDccD8H+XsP1E4tFJlOvdnNzUnD0BS58a3jfG/MalY4chV0
         dOr1o8A8uUET4aVYVcbOfbaTOTLCHvjclGvrZHrFOgqByKRWF+qdD17NoRYOZLFIxhHw
         dVpVKw9JiDqQN8uveu+hdDr0HHc1vnPKJI8ooC9hXAW2MKWtxD6feQNOS4M+xLC11235
         ln/lgNKbndSLF+653ME1m/3cWrD6ygFqw8OM/mUwQF8A2ApvzcXk4Bt4GOH+ySRbDtCN
         hmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZXLr4jt3Z0ly6bJlY2S1K+QAkB0UsTXiQL9zQoG2s4c=;
        b=ateiwigVuuCKHyvddOUuh6Z7ttbpm67aH4q+aGn/+IV9P4X0jtoWesMK0SKJ73q+g9
         e0c6n/7Uc8aNsHfUVccNpLNBrB5OT1Rl3Tcf7i3XbsK+o6ueZ0FkQX8nBrvqUfCDGWY7
         c5mvtVdcd5jZTMv5Mlh7p+GGwvLI8esyupMRyeeq8WZnRzEbPIdiMhjidpwBJ+tTyAA0
         X0vYfiOm+ZWYcIbIhBQh126z/yugWbyBkFkjWKPOxjurkhZiCMo8h2X1VO7fIW8aPEk6
         TGmWy+Z2qpjF01Q8lvKUAH6MDJQRWdgLJvSwSIc0B0datf1SQIW/DwT9ids0b2VldaSj
         /3Hw==
X-Gm-Message-State: APjAAAUms9voyA1oSVlF1P0BKEwyrMH9lEXgRLvdzkVBG+f+vf08/E0M
        x35BXs0JRBEF/aPJ9cIdUm/EDdSD
X-Google-Smtp-Source: APXvYqyGePBR9ORItEnsI4A/VolH7tK5HABxUgERqXN9F5gLMCg+0OuRxmIZVKfdKncZ1preY0W6VA==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr21557885wmk.172.1578940433124;
        Mon, 13 Jan 2020 10:33:53 -0800 (PST)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n1sm15518360wrw.52.2020.01.13.10.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 10:33:52 -0800 (PST)
Subject: =?UTF-8?Q?Re=3a_=5bRFC_PATCH_v1_00/10=5d_Enable_RK3066_NANDC_for_MK?=
 =?UTF-8?B?ODA444CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGludXgtcm9ja2NoaXAtYm91bmNl?=
 =?UTF-8?Q?s+shawn=2elin=3drock-chips=2ecom=40lists=2einfradead=2eorg?=
 =?UTF-8?B?5Luj5Y+R44CR?=
To:     Shawn Lin <shawn.lin@rock-chips.com>, miquel.raynal@bootlin.com
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org, vigneshr@ti.com,
        richard@nod.at, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, heiko@sntech.de,
        =?UTF-8?B?6LW15Luq5bOw?= <yifeng.zhao@rock-chips.com>
References: <20200108205338.11369-1-jbx6244@gmail.com>
 <aad92eb5-00ed-5071-c206-491eff243537@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <73cb4b1a-aad3-c613-a642-1887905e3932@gmail.com>
Date:   Mon, 13 Jan 2020 19:33:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <aad92eb5-00ed-5071-c206-491eff243537@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Thank you for your notice.
In that case I think that I produce a version 2 "light",
where I address only a small amount of the TODO's and leave all other
things up to you, so that you can do what suits you best.
Hope that RK3066 support for MTD can be included.(Linux and Uboot)

Thanks

On 1/13/20 2:55 AM, Shawn Lin wrote:

> 
> Hi Johan,
> 
> I loop in the author of the original NANDC driver who is now gonna to
> develop a new version of NANDC driver in near future that supports more
> features like bad block supoort. Maybe he could share his TODO.
> 
