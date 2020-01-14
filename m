Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE1CC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C12222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="KfMcqSca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgANTKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:10:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46581 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgANTKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:10:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id n9so7013391pff.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 11:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jh4MVY28TLmOvtnKjMwqmE9PCs0MNoKAOnUNKma/4Ys=;
        b=KfMcqScafpLXwRh02Sj7gQrwWIejqGLu3q1y31aNIF+59v/iI+I5sw3GcTfwXDJXWH
         2pV0Q0rkADPn5yhaIlLrgmbE4IbFaPCdu2PCN+M0SaFfUXxdKYYSFH2o/53yzovJ1zs5
         mvQ9aKhOHHRhc32FHcEjcf0C56od2hW1+ksC8mw4Skeejz2qgVgYdp0dQqiX2TEWeYis
         aOC7s5urnDeJ9wFCMVEP1RVHR6UXpDCl5cUxt6Qa+Jv5C9fxuqeZfZTq5Fb8Jorl8392
         vwzKtf0AoIKGYQM7GyKaqw/LALBj/x+SO7Bnz8kKudchYOIXeWFoOmLzPSUKKWXdpEEK
         GiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jh4MVY28TLmOvtnKjMwqmE9PCs0MNoKAOnUNKma/4Ys=;
        b=qyRc/Aw2AoHdv8XSY0+Bd2dhdlJMn0ZsiH/G/dnFEGKCEo9KSHmEr3GcO2K8Lz34j5
         kSG/zL8a2ke4uFHeGIgCfeEXfi8WNHAkfc1adoYCdT7p8lM4TwkH4w3MTy2+3v/pr2Eg
         1pelrwmh/Zhrh8B9FdiOmkMgVYP+8MT5G2LCLvn04qE0ETSiCRx1+Ts6XN93G/XYqJoK
         gJzVCm1ukTaKQxs+RLeg4wMfFno4tm5CZ8ta1Ri3XYpbPtgBfCbvgix9FvtlmuVc6c4Q
         LD0DhTfY4fTIB1V0tYHPQv51SQlwsdb+0dfGZydEzMyc22hn8Sd6uiT+VJ9r+1ykhgeM
         xbTQ==
X-Gm-Message-State: APjAAAWvgA7mYcrW+vJhe28Bxc9GaICj3o3Vbb6v46WcHkx8fo1k3nvF
        PB2CWq1baHT2t9YXXxzp1FZ0kA==
X-Google-Smtp-Source: APXvYqyCMudVIu/tZb/LWHyQ/ln+ti2nF0ZnV1cD1dFatM2ksK89jpS5Ad0uvf1N0JK4hRJC5YGrLw==
X-Received: by 2002:a63:2fc4:: with SMTP id v187mr28115896pgv.55.1579029051987;
        Tue, 14 Jan 2020 11:10:51 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o134sm19598426pfg.137.2020.01.14.11.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 11:10:51 -0800 (PST)
Subject: Re: [PATCH-next 3/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
References: <20200109215444.95995-1-dima@arista.com>
 <20200109215444.95995-4-dima@arista.com> <20200110164643.GB1822445@kroah.com>
 <a6a3ee46-9537-c287-b366-797c787c28b6@arista.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <41435a7b-48a2-438c-998a-14481fbc3a1a@arista.com>
Date:   Tue, 14 Jan 2020 19:10:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <a6a3ee46-9537-c287-b366-797c787c28b6@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/20 10:32 PM, Dmitry Safonov wrote:
> On 1/10/20 4:46 PM, Greg Kroah-Hartman wrote:
> [..]
>>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>>> index 6ac9dfed3423..f70eba032d0b 100644
>>> --- a/drivers/tty/serial/serial_core.c
>>> +++ b/drivers/tty/serial/serial_core.c
>>> @@ -3081,6 +3081,38 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
>>>  }
>>>  EXPORT_SYMBOL_GPL(uart_insert_char);
>>>  
>>> +const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
>>> +
>>> +static void uart_sysrq_on(struct work_struct *w)
>>> +{
>>> +	sysrq_toggle_support(1);
>>> +	pr_info("SysRq is enabled by magic sequience on serial\n");
>>
>> Do we want to say what serial port it is enabled on?
> 
> Makes sense, will add.

Ah, I've managed to forget to mention that I didn't add the port name
into the message in v2. I experimented a bit - it's getting a bit
complicated how-to protect (char *name) for just this message.
Like, SysRq can be theoretically enabled on two serials at the same
moment - so some locking is needed to make the printed name sane.

As sysrq_toggle_support() is a global-enable knob for sysrq (also can be
switched in /proc/sys/kernel/sysrq) I'm not sure if it's worth to
complicate code to print through which serial console SysRq has been
enabled.

I can still do it in v3 if you insist.

And sorry about forgetting to mention this - thought I'll write reply
after I send v2 and somehow it slipped my mind.

Thanks,
           Dmitry
