Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112F2C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D8121D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OBwZ48eB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgCBUf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:35:26 -0500
Received: from mout.gmx.net ([212.227.17.20]:60163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgCBUf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583181313;
        bh=6e+M36ttER99x7kYZFh6MiZeo1sjmywxIwpgstZVw4g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OBwZ48eB2pVjL+QQ/o4mOtXcZ0z0+K6ukH3klWV8EBgS+d8g0JuhokTHsX8qng/3P
         R9IabB9EfjiDnmtQAcdcZCiXbYadqN+hKaILJlrA1J6Jo81Xd46+Z5xUb0K3jPQDP4
         3k6Bj37/bfE3QXPyAbPuvO7i+5/O+Cj7pHUSHQKs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.130.108]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oBx-1jKm4C0Jld-00woGf; Mon, 02
 Mar 2020 21:35:13 +0100
Subject: Re: [PATCH 2/7] parport: Use more comon logging styles
To:     Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1582878393.git.joe@perches.com>
 <1da80f696e3602cc2533988b20f9a47cd42db1c4.1582878394.git.joe@perches.com>
 <b4a4f5a8-9ff0-e3d3-93c9-260a11cdb439@gmx.de>
 <ff833cf6a9a489ff446910c85e2a56ff1c11ccb4.camel@perches.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <3f313e06-8e6e-49ee-e2eb-89224b1d2aa1@gmx.de>
Date:   Mon, 2 Mar 2020 21:35:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ff833cf6a9a489ff446910c85e2a56ff1c11ccb4.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BIqykeU/7uXvlXpa8cyZzkT/tC7seLvRvl1r+IYa28MQN4Ebali
 Lxzkd1vqBtI4z0yopol88TtgNtS+/1xU2FGR8E9kbW62o+DmBbvXjMJrWD0PqA0fcKgMMxN
 hKZkYshKmj6yPMHhVw42gj1OueHmBzTFx0hFvh2dqLsNLNyG+MI3Wd5LfAm91uVrXV44r3O
 St2ruHt3vxkEOHAJLnCOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZIX/GxpddQQ=:qU7cd1q/IrgwNbTE4JMxAx
 hdlm3ybwm+FNfNk9DiSRxZ2lI/UK86gwuj1kwpZd8rWX2ltIQs3kgYwhCDgxN9TQUU0v0GC1N
 tqaUNuCvhzN/d60QIOsEjkslOkO6Vx0gFcMfpmEs4NRnTHLq3YGqXvvrLDpd1ixAZB+WfrWEC
 HQENYogfUedOFUetbo2oDmyhPyZz0cUMG6rdXtqJ0Q31CbdkjgXZQiT+vrSt7GRpHS2pVxzaN
 wMvjL8ywzjCQCHtJV3NTFvc91maMUlkHcYjEnKpVuGXFpFmDt3431A38+4xaSw7JMnzTqmIEr
 atqSY8+bdKnVQPpieUTqScd8ka4oBQSVhsK5Wu+PEeQnbv4q29eeinJSd2+23uPC1DEc7KzUR
 Jz5DVD7imffKHw+ZwSyodC4wsh4XdVp605C9pXdM3aQe+WBUvZz1ZYet6t7nUdmE+QwutdN6E
 3xu0ypsGafJsNvGJPI8cJaHYVm3AisdsKBDNQANblkxVl2Rc7ldi3jVPWFcqGnlWDuLZ8Ix6n
 Sah5FMTcA3ZTUKMQnF4OkiulKHzKv3Kgiw19duDSAVnZgehocQbfqKWpX5vkL3OhHSEmVI+2g
 /Ih/w2APWf1G/wbDp3A0gKNIaEV9mEkQdTq6+cHp3JHzqHEFvhvMCigPuOiw5KOIFxsL7/CWn
 pNewXEZx2BQ5UEQtYFEfxQ/XWhlSR1MW8uhySOhbzJcNa9dIKbueKUM+ekCczy0X/IR/OzLt2
 tS9DI29okI5mAjGRXFg5AJUsDz2yfQdUj6dxzzCH8qLNzuGj3atbnt3C+KQTY3hCuRHJTNDLx
 iEmB6hIhkNFYSdBQS5Zm7KhKNh9GjIE2he2sY4OwN4NtLskAOR6OxmHhcpKRV+ym8HNCciFRZ
 EnOoCKUzlsKYTV43nXimIBYNruFhzxVK9UiZv+cZS5XrHwNG9oWpGviG/3L9K86u2huQB65Wh
 2vhX1BVxFUh6QHGWw8Gd6GmpKm7RxD9zQPHmIH+25OZnI+M2Uus4ba1zJqIOCvWV+LiH8KjCF
 G0MVp5QeYIMBrnFQcFTs8EEAAxRoLwwASc9SYdPjU9AKTNIlaX8VhSoeaGXxHefdivCCBWDMG
 hj0Jz64Vt7ae80X92vTknExFUXlrJYIQekEhF9NRB+b/U+OqwspYuOHHijwMKKZGHIxfalgZE
 3grtu6SmclFZo+VcOZbcIRMj3xv29a2wFs6JWnDoj9vHJsYwf7qHDl68f3W+s1s+zKNEKfiPB
 GChOWgwQAaFMClGiJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.03.20 20:39, Joe Perches wrote:
> On Mon, 2020-03-02 at 20:29 +0100, Helge Deller wrote:
>> On 28.02.20 09:32, Joe Perches wrote:
>>> Some of the logging can be poorly formatted because of unexpected
>>> line breaks given printks without KERN_CONT that should be pr_cont.
> []
>>> diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_g=
sc.c
> []
>>> @@ -238,14 +238,14 @@ struct parport *parport_gsc_probe_port(unsigned =
long base,
>>>
>>>  	priv =3D kzalloc (sizeof (struct parport_gsc_private), GFP_KERNEL);
>>>  	if (!priv) {
>>> -		printk (KERN_DEBUG "parport (0x%lx): no memory!\n", base);
>>> +		printk(KERN_DEBUG "parport (0x%lx): no memory!\n", base);
>>
>> pr_warn() instead?
>
> For all of your remarks, the intent here is to keep the
> same output.

Ok.

> Logging level changes and printk(KERN_DEBUG -> pr_debug(
> conversions cause the dmesg output to be different.
>
> 	printk(KERN_DEBUG...)
>
> is always emitted when the console level allows but
>
> 	pr_debug(...)
>
> is not normally compiled in at all.
>
> So it's possible for all printk(KERN_DEBUG to be pr_debug
> but that causes no logging at all to be emitted when
> DEBUG is not defined or CONFIG_DYNAMIC_DEBUG not enabled.

Ok, then keep it as you had.

Thanks!
Helge
