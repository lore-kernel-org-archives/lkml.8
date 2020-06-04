Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73551C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 03:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0AB2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 03:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b1HX7q3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgFDDZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 23:25:36 -0400
Received: from mail-m973.mail.163.com ([123.126.97.3]:42902 "EHLO
        mail-m973.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgFDDZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 23:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=/zqF8
        1x8WepWZf34Ay0CjhkjkK5lBprvOvKC3m4ZGz0=; b=b1HX7q3NR6ft/Ho3G3sAf
        /DqbTw6FVMBVjbbGIM7j++5CstCxGV+HNKg8JQy5OXb/oJJgqG8+eST+/M9GSmAV
        QypLyWJLNMGdgEGNY+ytM9PdxT+zuS2rg1LgzZwozN9c6PjXpndyLRb2bCYO5PsK
        5CG6w13rrwbn9k8JoGPtGY=
Received: from [172.20.10.2] (unknown [114.242.249.96])
        by smtp3 (Coremail) with SMTP id G9xpCgDH1GyWadheSIGYAA--.53S2;
        Thu, 04 Jun 2020 11:25:10 +0800 (CST)
Subject: Re: [PATCH] function:stacktrace/mips: Fix function:stacktrace for
 mips
To:     "Maciej W. Rozycki" <macro@wdc.com>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     tsbogend@alpha.franken.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, liulichao@loongson.cn,
        "Maciej W. Rozycki" <macro@linux-mips.org>
References: <20200528123640.4285-1-yuanjunqing66@163.com>
 <11c90f15-0a25-e628-c8db-53343c351085@163.com>
 <43f35844-f78a-74a2-0e3d-184c3567d74f@xen0n.name>
 <alpine.LFD.2.21.2006040212460.9519@redsun52.ssa.fujisawa.hgst.com>
From:   yuanjunqing <yuanjunqing66@163.com>
Message-ID: <810cf1b6-ce59-7570-1a5e-4fac8992a99d@163.com>
Date:   Thu, 4 Jun 2020 11:25:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.2006040212460.9519@redsun52.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: G9xpCgDH1GyWadheSIGYAA--.53S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFW7AFWfXF15Jr1kAr4xZwb_yoW8Ww1fp3
        yDAFW7Ca1jqr4j9ry2qwn5AryaqrWDGa4UGw1kJrnIk3Z0gF1SkF4Iv3WY9rZYvrW8Ca4f
        ur15ZrZ0vr4vkFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSfOwUUUUU=
X-Originating-IP: [114.242.249.96]
X-CM-SenderInfo: h1xd0ypxqtx0rjwwqiywtou0bp/xtbBZAY5XFQHJrpfowABs1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2020/6/4 ÉÏÎç9:17, Maciej W. Rozycki Ð´µÀ:
> On Fri, 29 May 2020, WANG Xuerui wrote:
>
>> On 2020/5/29 17:29, yuanjunqing wrote:
>>
>>>> diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
>>>> index cff52b283e03..cd5545764e5f 100644
>>>> --- a/arch/mips/kernel/mcount.S
>>>> +++ b/arch/mips/kernel/mcount.S
>>>> @@ -87,8 +87,15 @@ EXPORT_SYMBOL(_mcount)
>>>>   	PTR_LA   t1, _etext
>>>>   	sltu     t3, t1, a0	/* t3 = (a0 > _etext) */
>>>>   	or       t1, t2, t3
>>>> +	PTR_LA	 t2, stlab-4 	/* t2: "function:stacktrace" return address */
>>>> +	move	 a1, AT		/* arg2: parent's return address */
>>>>   	beqz     t1, ftrace_call
>>>> -	 nop
>>>> +	 nop			/* "function:stacktrace" return address */
>>>> +stlab:
>>>> +	PTR_LA	t2, stlab-4
>>>> +	/* ftrace_call_end: ftrace_call return address */
>>>> +	beq	t2,ra, ftrace_call_end
>>>> +	nop
>  Broken delay slot indentation.

Thank you for your reply. For this question that you mentioned about the delay slot, I will modify my patch again.

>
>>>>   #if defined(KBUILD_MCOUNT_RA_ADDRESS) && defined(CONFIG_32BIT)
>>>>   	PTR_SUBU a0, a0, 16	/* arg1: adjust to module's recorded callsite */
>>>>   #else
>>>> @@ -98,7 +105,9 @@ EXPORT_SYMBOL(_mcount)
>>>>   	.globl ftrace_call
>>>>   ftrace_call:
>>>>   	nop	/* a placeholder for the call to a real tracing function */
>>>> -	 move	a1, AT		/* arg2: parent's return address */
>>>> +	move	ra, t2		/* t2: "function:stacktrace" return address */
>  Likewise.  NB I haven't investigated if the change makes sense.  A more 
> detailed explanation in the change description is certainly needed.

I will attach a specific description for further explanation about the second patch later.

>
>   Maciej

