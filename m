Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8FBC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FAC20720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3mbCsFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgBGNIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:08:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43128 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBGNIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:08:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id p11so974532plq.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 05:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z3DaoOJkhTG6G3BmjkBdZhMduYvYgvSmSTWWEthlkSk=;
        b=q3mbCsFHzqyeqCJYLMglgwLFkVQ5mI7OMEB82wzE62obxmgZyo65BZlaOsUCDTv6Nu
         kRnhvLFZBTulcUKzB90AiP86bJ9FOC7Lb6fEEZmsQ3XsfxT9aeQhLutvYHfw5KYKC/6r
         aYDYXrDSWqkWyG0KJ+6xEyOjyW9W527U63CPdbqwXfSUrsDCA1O6gaoxxbzY8iqYpx1l
         SG8zv1SBFVCkaB/58pZIKQo9NjrMVcmOtSOUuE9OEJZhuzETd1WMA0rlZL8QCWHr7Hry
         1YuQZnpzVZQvuxHJ7A5HIaqECZ1HygnQ2qAN6OCM+i8IWriBmJVHNNwYwxdznBk3r3XP
         ja7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z3DaoOJkhTG6G3BmjkBdZhMduYvYgvSmSTWWEthlkSk=;
        b=dSF3hv+f67DrKhE7HtKcBrWQ2F/yM/P+PgmemYqNpfpE/XS7st9gqRVHZ7vb3VbnTp
         FvwbEPythjVX6LnC1YjnR1XEnBUPuZqXCPH6410u+ymugDJj5o0fhUlyVru46KGmzXLT
         MEkXTr89F0g2xnh2ZsRw+VOCZMMXFJ0OK/N7eDupg2maGq8XNAXTqx+n+4aXL/xH/P3S
         q3zr6LF58szvdrbfCO1fU4vd5BUL3Fmm+6qaP2zk1lEJBVCL5GDsgREGJ882YF0w0o/Q
         I/77TLSKuCbpYzOn1pPP6YgKhC9c5lRvI9WIVP/eGMVpnvpcwkQWo5eCWG/AHd64t4Ew
         b+aQ==
X-Gm-Message-State: APjAAAXDVUeeJHK8aAIFCldFmahHQoL5li4jVOCB+HHJE6obVI7cRYWQ
        m43bwep5f5YArMgMDqgY6VU=
X-Google-Smtp-Source: APXvYqwk8HrzennbNw/RIl9zKUEV7VY8jBDjhQsLTxfvUQMy8RkJMoubgl4aCH6DLaBXk1SQQcZZrQ==
X-Received: by 2002:a17:902:b110:: with SMTP id q16mr9434632plr.289.1581080893188;
        Fri, 07 Feb 2020 05:08:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d14sm3244514pfq.117.2020.02.07.05.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 05:08:12 -0800 (PST)
Subject: Re: [PATCH v5 17/17] powerpc/32s: Enable CONFIG_VMAP_STACK
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, dja@axtens.net
References: <cover.1576916812.git.christophe.leroy@c-s.fr>
 <2e2509a242fd5f3e23df4a06530c18060c4d321e.1576916812.git.christophe.leroy@c-s.fr>
 <20200206203146.GA23248@roeck-us.net>
 <c6285f2a-f8f5-0d97-2d80-061da1f1a7fc@c-s.fr>
 <0f866131-4292-a66b-2637-c34139277486@c-s.fr>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <551bad84-3e80-265b-93ab-25eae4aa9807@roeck-us.net>
Date:   Fri, 7 Feb 2020 05:08:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0f866131-4292-a66b-2637-c34139277486@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/20 12:28 AM, Christophe Leroy wrote:
> 
> 
> On 02/07/2020 06:13 AM, Christophe Leroy wrote:
>>
>>
>> Le 06/02/2020 à 21:31, Guenter Roeck a écrit :
>>> On Sat, Dec 21, 2019 at 08:32:38AM +0000, Christophe Leroy wrote:
>>>> A few changes to retrieve DAR and DSISR from struct regs
>>>> instead of retrieving them directly, as they may have
>>>> changed due to a TLB miss.
>>>>
>>>> Also modifies hash_page() and friends to work with virtual
>>>> data addresses instead of physical ones. Same on load_up_fpu()
>>>> and load_up_altivec().
>>>>
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>
>>> This patch results in qemu boot failures (mac99 with pmac32_defconfig).
>>> Images fail silently; there is no console output. Reverting the patch
>>> fixes the problem. Bisect log is attached below.
>>>
>>> Assuming this was tested on real hardware, am I correct to assume that qemu
>>> for ppc32 (more specifically, qemu's mac99 and g3beige machines) no longer
>>> works with the upstream kernel ?
>>
>> Before submitting the series, I successfully tested:
>> - Real HW with powerpc 8xx
>> - Real HW with powerpc 832x
>> - Qemu's mac99
>>
>> I'll re-check the upstream kernel.
>>
> 
> This is still working for me with the upstream kernel:
> 

Interesting. What is your kernel configuration, your qemu version, and
your qemu command line ?

It works for me with CONFIG_VMAP_STACK=n, but not with pmac32_defconfig.

Thanks,
Guenter
