Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AB7C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0374822522
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofZAaEqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgAaUsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:48:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46640 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgAaUsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 15:48:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id k29so3914125pfp.13;
        Fri, 31 Jan 2020 12:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3C6QHOm9kLlMNSEBc1VIbyYgFyyrxZylD3jkKeywRZU=;
        b=ofZAaEqCrl3a0R/wvij9pEEI34+UVgFAmbhBB2Kbx7NFYXiZ8Y2GeVTHr0RCEyena8
         DE7jXQ+UVliiBLCo/VwvjaGcJG5zq2aZx0ZBBLnG0ynPpkghFygNgTZUOehbPjFkf1zt
         AYWvchulGKnfxKg/zwMLQeUMWx3aTSm7OAHw+LK9Wo5/E9Jo1x+RaDKeVhzqfdhxwJo1
         MUFjifbNUg6M3zZJJkLKkOQiixu/ADPc70yVVD3STnDitYdJmgOw1QacW6UEZyj8pIJ+
         gWnhUzEISvdOz9qJLFEZf/z+UuEWWoPeKMtvSKQ11vGRElej2jm5mAZI8WEbITBCyKVB
         RN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3C6QHOm9kLlMNSEBc1VIbyYgFyyrxZylD3jkKeywRZU=;
        b=qJiAkjhBIK18N8siftiWcfsbZm+scadBteUVFzJMZ1hvWPLW7q4LKaxl5XZVg5bnEr
         aZb4EF38+rsgsnVX07OZOREUZhnBzVO0ZOv1Zdi4/5mBZWm2lPBoaswa5ebze2ALaEz7
         Al+5JpIfZT6Sz/iHwzQElBHkU7m/T1IW2Qw/DLq69B34MVeqPCerRFOdgJJreiOkaSjA
         pDpgOgfIVqieAS/2nlIpr/RWh3tzL0/VMhivhvl0hrM3gZ9AHvrgEB9FValZ/BVMOUgJ
         r9HoJye6n55fAIxQ1c0NwG9GBlfoRpHQg54MDZYu9ptYz9631iJKR2otZquj4qE4olnF
         /9vg==
X-Gm-Message-State: APjAAAWCXfffVWzvg0kD9EVWZRcOnI2DAWplJhqB2wG38K4Jiw+KhVu1
        adgMTx5veQAfu0pTZaTHTM4=
X-Google-Smtp-Source: APXvYqzOJRfqW17uCQm7Nv01ZzIqEWvenFXOJ535jg/Lxw2RfOrSbDIElC/ZGG2C46dCs/XadS1H5A==
X-Received: by 2002:a62:ab13:: with SMTP id p19mr3240625pff.98.1580503716828;
        Fri, 31 Jan 2020 12:48:36 -0800 (PST)
Received: from [10.67.48.234] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g13sm7288640pfo.169.2020.01.31.12.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 12:48:36 -0800 (PST)
Subject: Re: [PATCH v2 0/7] Introduce bus firewall controller framework
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "system-dt@lists.openampproject.org" 
        <system-dt@lists.openampproject.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lkml@metux.net" <lkml@metux.net>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Robin.Murphy@arm.com" <Robin.Murphy@arm.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128163628.GB30489@bogus> <7f54ec36-8022-a57a-c634-45257f4c6984@st.com>
 <20200128171639.GA36496@bogus> <26eb1fde-5408-43f0-ccba-f0c81e791f54@st.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 G10n8gCguORqNGMsVRxrlLs7/himep7MrCc=
Message-ID: <548b1427-cf6e-319a-36e2-c3e9363b930d@gmail.com>
Date:   Fri, 31 Jan 2020 12:48:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <26eb1fde-5408-43f0-ccba-f0c81e791f54@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/20 12:06 PM, Benjamin GAIGNARD wrote:
> 
> On 1/28/20 6:17 PM, Sudeep Holla wrote:
>> On Tue, Jan 28, 2020 at 04:46:41PM +0000, Benjamin GAIGNARD wrote:
>>> On 1/28/20 5:36 PM, Sudeep Holla wrote:
>>>> On Tue, Jan 28, 2020 at 04:37:59PM +0100, Benjamin Gaignard wrote:
>>>>> Bus firewall framework aims to provide a kernel API to set the configuration
>>>>> of the harware blocks in charge of busses access control.
>>>>>
>>>>> Framework architecture is inspirated by pinctrl framework:
>>>>> - a default configuration could be applied before bind the driver.
>>>>>     If a configuration could not be applied the driver is not bind
>>>>>     to avoid doing accesses on prohibited regions.
>>>>> - configurations could be apllied dynamically by drivers.
>>>>> - device node provides the bus firewall configurations.
>>>>>
>>>>> An example of bus firewall controller is STM32 ETZPC hardware block
>>>>> which got 3 possible configurations:
>>>>> - trust: hardware blocks are only accessible by software running on trust
>>>>>     zone (i.e op-tee firmware).
>>>>> - non-secure: hardware blocks are accessible by non-secure software (i.e.
>>>>>     linux kernel).
>>>>> - coprocessor: hardware blocks are only accessible by the coprocessor.
>>>>> Up to 94 hardware blocks of the soc could be managed by ETZPC.
>>>>>
>>>> /me confused. Is ETZPC accessible from the non-secure kernel space to
>>>> begin with ? If so, is it allowed to configure hardware blocks as secure
>>>> or trusted ? I am failing to understand the overall design of a system
>>>> with ETZPC controller.
>>> Non-secure kernel could read the values set in ETZPC, if it doesn't match
>>> with what is required by the device node the driver won't be probed.
>>>
>> OK, but I was under the impression that it was made clear that Linux is
>> not firmware validation suite. The firmware need to ensure all the devices
>> that are not accessible in the Linux kernel are marked as disabled and
>> this needs to happen before entering the kernel. So if this is what this
>> patch series achieves, then there is no need for it. Please stop pursuing
>> this any further or provide any other reasons(if any) to have it. Until
>> you have other reasons, NACK for this series.
> 
> No it doesn't disable the nodes.
> 
> When the firmware disable a node before the kernel that means it change
> 
> the DTB and that is a problem when you want to sign it. With my proposal
> 
> the DTB remains the same.

Could you use an overlay then which is the result of the firewalling
results by your firewall block, which is smaller than the main SoC/board
DTB and can be easily audited not to accidentally enable blocks, but
only disable them by adding/changing the respective "status" property.
Worst case, your driver probes, has been firewalled and this is not
reflected in the DTB, you get a bus error, or a hang, or however it gets
implemented.

Like Robin and Sudeep here, I do not understand why the kernel should
have any business in this, let alone allowing blocks to change owners,
that sounds contrary to the purpose of a firewall being controlled under
an untrusted entity (Linux).
-- 
Florian
