Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13338C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB46F20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lx/v8g0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgCLOFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:05:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50379 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727123AbgCLOFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584021947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/QcQ9yaW2B9Sro10c4GCfJinEur6UPsaYYhw3gFWCo=;
        b=Lx/v8g0ZmmS9fWJIHfhGvdt+Wev6XPfDW7y8Ngs7idBWgEJKEpD7rU3o9Txk0wy5LlmCnv
        gOIiWTtvS6kX/+DFsj1TNmJK0rjRLiFUYhrW5mzPNdn2FYtjg7dapxgtQAevEcjNC5RTuB
        IXPSwxq0vcsvCjx95SEPnA7Byzi245s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-BiYepfqXPZqMvN-aDNzq4w-1; Thu, 12 Mar 2020 10:05:45 -0400
X-MC-Unique: BiYepfqXPZqMvN-aDNzq4w-1
Received: by mail-wr1-f71.google.com with SMTP id h14so1971952wrv.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T/QcQ9yaW2B9Sro10c4GCfJinEur6UPsaYYhw3gFWCo=;
        b=SzOMXTzaQklCdRcDoscwetfH7DH4PYzkG47Tey3nYtgCEjyS0sxxpC92LlIYOyXZln
         GOu/+MOCS3pXca4FdT5usJCO1TFSYUdfG5xy0F0T2+Emm/tPx3cx8igNyWuI4j4vNV5V
         o1Vb01iZ3QFjQ7r8rthcAPh8MGBRCvCjFIGUHENd+EjTtJZDkP1JWUfQvdskr8+kM80O
         9yyfdomkGQf8FvhLy1XG0e+O0/Bgw88AQe8EnO0j/y4HTPCxMSf81zeV5hO8Adwe9LAv
         kzxD7s3zNBU6hh38LxUP83sI86Eh4Ltal1YKlAumZa2WeFWb/8xvk/JB+waBDtL6N+X9
         zHXw==
X-Gm-Message-State: ANhLgQ3WywCKoSLmoZ08Ct+zoWZYCUsqKl9P1k0HAh8QvB5qrS4BT6ju
        0QUQgPmJ9ryfDUuiLuLHvBcLtedGjwb2454Uzrwop6lYHuJKmfcGTqxK6FAq7XK1GyC7ADxy5bK
        32+qmSocQ0RCRZz3hCsDph2ZQ
X-Received: by 2002:a1c:26c4:: with SMTP id m187mr4956711wmm.43.1584021940431;
        Thu, 12 Mar 2020 07:05:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs4Ui/zFpmKBS9lbKSRR8lfOVrW1lT7LfaM80YHNXUVW7ArWydh/3x3vNaetG6WKUr0t32dAw==
X-Received: by 2002:a1c:26c4:: with SMTP id m187mr4956687wmm.43.1584021940203;
        Thu, 12 Mar 2020 07:05:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id k133sm12979071wma.11.2020.03.12.07.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 07:05:39 -0700 (PDT)
Subject: Re: [tip: irq/core] x86: Select HARDIRQS_SW_RESEND on x86
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
References: <20200123210242.53367-1-hdegoede@redhat.com>
 <158396292503.28353.1070405680109587154.tip-bot2@tip-bot2>
 <CACRpkdYPy93bDwPe1wHhcwpgN9uXepKXS1Ca5yFmDVks=r0RoQ@mail.gmail.com>
 <1cb0397f-e583-3d7e-dff3-2cc916219846@redhat.com>
 <CACRpkdb7vxSaK1Df6gNX_Kq-LF=S1qx2iKdmBy1Ku0vEpDVPbA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <231875e7-fc72-edb4-a4de-fc7cfc3cdca3@redhat.com>
Date:   Thu, 12 Mar 2020 15:05:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdb7vxSaK1Df6gNX_Kq-LF=S1qx2iKdmBy1Ku0vEpDVPbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/12/20 3:02 PM, Linus Walleij wrote:
> On Thu, Mar 12, 2020 at 2:49 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 
> [Me]
>>> I see that ARM and ARM64 simply just select this. What
>>> happens if you do that and why is x86 not selecting it in general?
>>
>> Erm, "selecting it in general" (well at least on x86) is what
>> this patch is doing.
> 
> Sorry that I was unclear, what I meant to say is why wasn't
> this done ages ago since so many important architectures seem
> to have it enabled by default.
> 
> I suppose the reason would be something like "firmware/BIOS
> should handle that for us" and recently that has started to
> break apart and x86 platforms started to be more like ARM?

That (x86 becoming more like ARM, sorta, kinda) as well as
that turning it on on x86 was not safe until Thomas wrote
the 2 patches which are marked as dependencies in the commit
message for this patch.

Regards,

Hans

