Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7614C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9199A24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrWlKhRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgBSLDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:03:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51594 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgBSLDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:03:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so138905wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 03:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QEtkVcpAx2ZxZ7MNrwEk5ZXQVDjVyr4qMG0Q4ZOigv8=;
        b=KrWlKhROLZIy3bJnBVo4CIWz1+wEm9gg/DIDymbgshyTSayyAANCPllz2NTx5w9Dwk
         kPLMZqC+oIGhMMc1wbI3ILv6JOPAU6UNCoXalanUyo9APblN2mAN9zPdL9NemJrMnD39
         Cj/WIVoasNvwy/Wdb1L5RBh/8zUHDwFg963nOLTKBqE5kDtl/paLVThsMXA+ZNjhwEhT
         +CoHtd5Gcl2l6mmakUiayttZHeKnZUMVswPyFDF+6U2olTYN8RRqUyzDDWsL+a+YBfUR
         DjWaalyQEdd7OOcijc03fsHiY6d9QOq4fesN1UOB/VyTiob9T6iBgiUABOR7GXu35bg2
         qxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QEtkVcpAx2ZxZ7MNrwEk5ZXQVDjVyr4qMG0Q4ZOigv8=;
        b=dTHeW/l5uU7txsXCjrJ7xE0ZBTPfsyhrZadCR7ZHUK19dyNBRfHMdl6dHIZlit/Hos
         lqr8FlRapmPJ7rwW3vDwAHl4shrstuEK5c6vhC+/I7Rlivlg3RlzvCFZNPNrXxiSkfPD
         M5ettEuFFmGSRy1mcdtSSkKW+ziELQuZt64LFqnt7GENBYeoY5yc6UQXjN/jKUrBD7oQ
         SVbEkxQSMpp/5QjXA/B0yrHHQiKtKkP41sKmh1YnWsL1m5Ii2EmzUGLk6aalStp/JpYp
         oApe5+mB8KXNK47JPesfT2MSajyj2ljeFinEg74luxKynYdYj3H7lO81Gg+esiVznCPx
         9B/Q==
X-Gm-Message-State: APjAAAV3FN4cjSljFrZU2WPNnpjFUxKf3xrcx2sblmQwcj2QxdO/KqsL
        /D8Px3SnTXDMvqavxU20hjGA8StpgUU=
X-Google-Smtp-Source: APXvYqwMYdIZmVFNmnf4n71hcbHMl8eANkLs0zLtqltq13EUmBO7zQTwOMEWFsLz2iu0S51pTyVCJg==
X-Received: by 2002:a1c:9849:: with SMTP id a70mr9156494wme.76.1582110211601;
        Wed, 19 Feb 2020 03:03:31 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id u14sm2468306wrm.51.2020.02.19.03.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 03:03:30 -0800 (PST)
Subject: Re: [RFC v4 2/6] Bindings: nvmem: add bindings for JZ4780 efuse
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-mips@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
References: <cover.1581958529.git.hns@goldelico.com>
 <86b78db4d607e0bdda6def018bc7f73207ce82e8.1581958529.git.hns@goldelico.com>
 <20200218212609.GA30081@bogus>
 <CFE9AEF5-FFF9-44A9-90D8-DE6AC7E7DD4F@goldelico.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <86f21eb8-b3f8-747f-c894-bd2a603562f3@linaro.org>
Date:   Wed, 19 Feb 2020 11:03:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CFE9AEF5-FFF9-44A9-90D8-DE6AC7E7DD4F@goldelico.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/02/2020 05:48, H. Nikolaus Schaller wrote:
>>> .../bindings/nvmem/ingenic,jz4780-efuse.txt     | 17 +++++++++++++++++
>>> 1 file changed, 17 insertions(+)
>>> create mode 100644 Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt
>> Please convert to a DT schema.
> Is there someone of you who can help to do that?
> 
> DT schemas are still like a Chinese dialect for me (i.e. I can decipher with help but neither speak nor write).


Have a look at an example here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml?h=v5.6-rc2

Some documentation:
https://lwn.net/Articles/771621/


--srini

> 
> BR and thanks,
> Nikolaus
> 
