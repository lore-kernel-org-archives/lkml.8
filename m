Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6D6C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8382072F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXLY8qz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgCKSZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:25:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41023 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730703AbgCKSZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583951101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uaZ9c6mFKi33dS6s6gMieJUilQtBx6d2khI9AiP0fEw=;
        b=UXLY8qz/iNEK3qgOVaDqRRNpjKCBsnNwnmUOnm8Ze7kf4iZchQgE04xLM1Z3sesdeS4tNL
        S5lyaMfIv0WBc9wZXcoTw+OitZXFpwlRPidNnXxYafnGuOv9FrjAT+1rusHn1xaZDwKlG/
        OdPxHQ5QJnE8zF3hUyvokWi7fJBNqeE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-VNJ6haIENoCLoojk7TFfmA-1; Wed, 11 Mar 2020 14:25:00 -0400
X-MC-Unique: VNJ6haIENoCLoojk7TFfmA-1
Received: by mail-wr1-f70.google.com with SMTP id p11so1324796wrn.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 11:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uaZ9c6mFKi33dS6s6gMieJUilQtBx6d2khI9AiP0fEw=;
        b=QSg7bFsZG3ntylLa2yn6p9CZi6W6JmlKMEEFRfCgKIbFrpkPv8RntozF6Elw6HTR6x
         e3XSC0tkEhp5DInmdzJV7q8Gh49Ymsc0lY5bZ6cSRM+r5foZ0K61fqiQ9gzN+2SSh68S
         JsKTOWhQqsj5ws0Lf3l+TdFRfhF6ObPjyVKrvkxPEnQd0brMRSdz/cqbtWfC2eLrkZRh
         zBSurGosC/ycl0eIm1fIo5Eh4QuI+TpIch0xA8yqvZwPNbbxUF64dAzTU1xmx6v7c405
         vtZcmPKaF2fUbjFoFEopJMvOifJPElC69oefsjkfrLIFp/PvWYp5zivtZ0N9iY/ZX4D0
         gthQ==
X-Gm-Message-State: ANhLgQ1NObBf9jFkPkcnDtTd7Gk0TuX4fSNuFjsssUqhBLT8rRHhX5OJ
        Pws2IBrbJ2RCZtwbIa2l00pKnSpNR+WUHzts3p/WtUVLHDf1FkYQq2mfE1NfuNri7jZk4hWyo0m
        M/ERIltDWmn1MTNdlYjv7o6Vs
X-Received: by 2002:a5d:4683:: with SMTP id u3mr6044461wrq.251.1583951098564;
        Wed, 11 Mar 2020 11:24:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuFwa2rQIlp3Ndabf9/ozMQ9Cr3LXBZlBnnVx+Xl6lybR3w5KhAONmLioZJaJ7wCHoT+edMNw==
X-Received: by 2002:a5d:4683:: with SMTP id u3mr6044427wrq.251.1583951098327;
        Wed, 11 Mar 2020 11:24:58 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id 12sm9267987wmo.30.2020.03.11.11.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 11:24:56 -0700 (PDT)
Subject: Re: [RFC v2] x86: Select HARDIRQS_SW_RESEND on x86
To:     Thomas Gleixner <tglx@linutronix.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <87sgk4naqh.fsf@nanos.tec.linutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0e5b484d-89f5-c018-328a-fb4a04c6cd91@redhat.com>
Date:   Wed, 11 Mar 2020 19:24:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87sgk4naqh.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 1/24/20 4:19 PM, Thomas Gleixner wrote:
> Hans,
> 
> Hans de Goede <hdegoede@redhat.com> writes:
>>
>> The Intel GPIO controllers do not allow implementing irq_retrigger without
>> emulating it in software, at which point we are better of just using the
>> generic HARDIRQS_SW_RESEND mechanism rather then re-implementing software
>> emulation for this separately in aprox. 14 different pinctrl drivers.
> 
> Indeed.
> 
>> I'm sending this out as a RFC since I'm not %100 sure this is the best
>> solution and it seems like a somewhat big change to make.
> 
> It's not that bad. The only affected interrupt chips on x86 should be
> secondary interrupt chips like the GPIO controller.
> 
> ioapic/msi/... have irq_retrigger() functionality, so it won't do the
> software resend.
> 
> I just need to stare at the legacy PIC and the virt stuff.
> 
>> Also maybe we should add a Cc: stable@vger.kernel.org ??? This seems like
>> somewhat a big change for that but it does solve some real issues...
> 
> Yes. Let me stare at the couple of weird irqchips which might get
> surprised. I'll teach them not to do that :)

I know that you are very busy, still I'm wondering is there any progress
on this ?

Regards,

Hans

