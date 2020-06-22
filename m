Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747DEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7072542E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="mPJZBVRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbgFVGwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 02:52:09 -0400
Received: from mout.web.de ([212.227.15.14]:53021 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbgFVGwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592808670;
        bh=9iOSO4KLAd/1THwTxg/hUqNUPF6Lv8cPp6yA4is/Ek0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mPJZBVRBPIw/aqyGan+EWfUl85rO33/SQnyTIRJLFdj/PCx4yVP3YcMnjrSqdEVZz
         CaTnpDxjW7rMEAYfZ58SxWcayOTRl8UuD3mUEBz69KOxuERXWkzpZsImuR9/SSDQiA
         fMV7H7sZVCkAFm5VNMgyJ4M9FZzMZLbBMFAWK2zY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.69.81]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LlsUC-1jECWk2Cky-00ZLby; Mon, 22
 Jun 2020 08:51:10 +0200
Subject: Re: [PATCH] arch/x86: Check return value from a notify_die() call
To:     Bo YU <tsu.yubo@gmail.com>, kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <ee99271a-6eb5-0dec-87d2-504b3ad4724d@web.de>
 <CAKq8=3LaX0tWs0BfdpCYvKRRz5Cqv4cOXo1wcVvpY72cQA8RGA@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <615f79c5-5ca8-9dad-9ef7-85d8513a3e1b@web.de>
Date:   Mon, 22 Jun 2020 08:50:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKq8=3LaX0tWs0BfdpCYvKRRz5Cqv4cOXo1wcVvpY72cQA8RGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:uZsiGn3jM1fIowQ+wi1x7tZpPlpcw1TAwvp8KTFCsN8Tvtcwzn+
 pcZEKJy9JfwY6hwJ1jJOmbjEx3Z8VSF6uq7ExEvMF+V0Yvsj3QdHOI61cUu6vKgdMvlsXdY
 Y1FlXCCGuOXKZlk0xPh65QJL9gC6KtlhMvcRbx90A+HU1i6msqngYG4iRRMoHKZhEhcpVCY
 HqkHrsHB6iMShNWBkHT4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H6iL6OPXA+A=:8HB+SajW6BivW0zJIcBvPu
 DWJboVWZq1xtdMuRs9VGZg+E5ToA9jXllnV9MyfYvay7cisy12xavde8/uTaXfTjBGRzr/Ijq
 uGBUc588sZ4+6AZBuZMGFu2U2xSv/o6y6+ZCVxPC3KB5i0XFwRVSHaFqU102Kx+hT3pJNtTjC
 9NeQHPk7KOTTYTUvCwlSxvtDMxoVjSmJtcr5cB/VML2sb5MTcZnuDkLraUs9mb2L4r+ARF6si
 hlY+jtXDtVs6EkWgBGyEb7Hr0sai+owyIXRGYy1TgwnEA4KyB5N/zXEZiID8KLiDEX3vOD4Ag
 GveMAQPuYOYS7nUY9q+y9uPcVkUz0Tkybnlc114vW5t2prmtlGDCosDWhUjdVZII/rUGXUuJY
 EGpCfkMSTECfA/7XY7DL9c55N8JC8LCzAWxxjtFqmHBD6ed7V8cwfGPFtDn8vbFFAjNw2Z0OW
 SuyRe4W4vO24kvi17Yt7bYcEKH09XgzOY53T/Uft/5oqA/994cQQsf7BtKLg+tIphNCGPtkFl
 yDUafCioFQIvNlm9+rUWkLDwjQPb2dvbdtK7J201gwYmq3x7S2jg1PlvRxEzerNt63siSWLkB
 cANfLN1V9j5cHGq/6URUP8erzW2bUR23w1NNXZDu3npWKCyV+b86IICdLbNEd7Gvnv7HO0wIf
 Ol+D/vvYrk9Z/lk7a44hPHGl74IHFUp1e7GzTv09WE4y/o73OvdIkqzH8mnB+JxX1Bq6QlY7M
 smda6GsTsOpPB+9alVxGKt+R4E8vQigd8985YWYgKoMNA5x/lGVQG0hg9NcxnrH9P3j0gqggm
 lYmwciNb4B0TeMPtofZ2cU88dM80K96Lotz3ugY3FWAM7EQ0kE1iHHShWqxsCHqdQl5NarmEQ
 fAOiaONiQSmZscaeza7sEYjgmR75igcfUam10gr+7V42h7zHO196lNq4tdoA/kzel0RywQYrq
 BRgq6PKXLkLzjEiG7LPnIdPfHx07ztR+pdr4Dz5xBEX+vKGI47vHAKwLiEU2B9IvKKhuxVq0P
 kRZ9zkNzWsrUZkRTTc4gSl0IanCjaexluqryHOpAmycS53bin8fUzZ2SyXPyGNe2ZQq55pzJ6
 Mh/i2bkOJ9BbgB0GyXO1MtB1KNL+1REFYagGaS4HCVYZSMfunfgT4P6qIarLg4xaBS4RmadfX
 nVssrp0XnOV4uCiqJZNcszy5DIIm2TpRD7u1HxE9uBYInsU3CFXJtIBNW4Qv+EpEVSqYdPX34
 ffmHkCsx27/VEd3h/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> This is detected by Coverity scan: #CID: 1464472(CHECKED_RETURN)

Can an additional imperative wording be helpful for the change description
(besides an adjusted patch subject)?


>>> FIXES: c94082656dac7(x86: Use enum instead of literals for trap values)
>>
>> Is the following tag specification more appropriate?
>>
>> Fixes: c94082656dac7 ("x86: Use enum instead of literals for trap values")
> Your description looks like more appropriate, thank you.

Thanks for your positive feedback.


> But I want to receive suggestions from other reviewers also. So I will
> send V2 patch as your point once got confirmed. Sorry.

Should the confirmation be sufficient from the available software documentation?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=625d3449788f85569096780592549d0340e9c0c7#n183

I am curious if this patch review will clarify more aspects.

Regards,
Markus
