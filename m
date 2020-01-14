Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2430AC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0268F24672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="TKUHo+Aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgANRrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:47:45 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37472 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbgANRro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:47:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so6928497pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 09:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z9aCEz62eIPqWkYEPAzhYqTb9kjUCL1iJhBD8cNYmdQ=;
        b=TKUHo+Aj+kjlb0uBHNvMRHf96HpPIqHIz1NEDF6qdrcFrQpab8pKYemOjkp7TDEg4r
         bhRcb2VIyazAzu91LL2ZXAsDfHqKJIH6uEH+pEZmIe+CPLagKF9sT0MFv5Xiq9etS718
         Ix4PuSdqA+XARcCW+Ltu8W5IwF15C601fs5w0Yn5cjAC33IVyD4RugQDCEatuFz/XqKK
         qdwy5o32UB42RYMHTYOa+a5U7kLKdpizAaTHJsFt9gYyOi71GmImsusXBEylF9YNaUnJ
         c//8GsFVK31Sy9zMCUc413rEcn1+7CqWMEAwCEtu6pLF0+4gWFi4Mc61bu8UJbjer+4p
         KvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z9aCEz62eIPqWkYEPAzhYqTb9kjUCL1iJhBD8cNYmdQ=;
        b=pW/8Gmsq0c2ls204DYEug+0myAd8MxxKf/zcwrV8QmnWvmM2RUhWi4cKL9a/rM/Mlz
         sggtnD24seU0vFG1asK4fOxYDLHp/3nGJ4QW3mH+KkewZbq47y3nMh9bSrWM2GBO2s+3
         BOuy8ELf/hYamPqAIc9BJNr/VbtFw8nJtVPTllLdMHsBtQYcBJW6kEPEVhzftFcZbzi0
         fm4G5FLVtX6iXvJGUX3OBfzzFVjX7IZVKaPDzQroM18adHfkB3g6vXWLdBAv3dqbtyoP
         9RasNMn9mGldqBo7aQF3b2zGML4f9pnwPw/GsyrvQY2nTOrzELCFMZor9/B8xi+IHeFZ
         fkzw==
X-Gm-Message-State: APjAAAWzPe6vI2Q/hi+8nee3wDIKKmzWKN8yk2zwdvR+bWPeq482zLJ9
        tGZ9xqWnlRAQPzjebFMZCD85ug==
X-Google-Smtp-Source: APXvYqwnchpKqWx5Af5jtLb3j7AjRAMRcr8Fe+OyyZ4zNhY7wOSoZMhRY/MAJG4BvswFYaXVQSLMbg==
X-Received: by 2002:aa7:9ab6:: with SMTP id x22mr26088212pfi.260.1579024064093;
        Tue, 14 Jan 2020 09:47:44 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id a185sm18511401pge.15.2020.01.14.09.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 09:47:43 -0800 (PST)
Subject: Re: [PATCHv2-next 3/3] serial_core: Remove unused member in uart_port
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
References: <20200114171912.261787-1-dima@arista.com>
 <20200114171912.261787-4-dima@arista.com>
 <e1b3cccb0814ba4b0c99592715776ed48f343795.camel@perches.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <8f11e2fa-495d-fe25-f5e4-52c9580240d7@arista.com>
Date:   Tue, 14 Jan 2020 17:47:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <e1b3cccb0814ba4b0c99592715776ed48f343795.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/20 5:36 PM, Joe Perches wrote:
> On Tue, 2020-01-14 at 17:19 +0000, Dmitry Safonov wrote:
>> It should remove the align-padding before @name.
> []
>> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> []
>> @@ -247,7 +247,6 @@ struct uart_port {
>>  
>>  	unsigned char		hub6;			/* this should be in the 8250 driver */
>>  	unsigned char		suspended;
>> -	unsigned char		unused;
> 
> I suggest this not be applied as this is just to let
> readers know that there is an unused 1 byte alignment
> hole here that could be used for something else.

Heh, 2/3 adds another `unsigned char`, so the neighbours look like:

: unsigned long sysrq;		/* sysrq timeout */
: unsigned int	sysrq_ch;	/* char for sysrq */
: unsigned char	has_sysrq;
: unsigned char	sysrq_seq;	/* index in sysrq_toggle_seq */
:
: unsigned char	hub6;		/* this should be in the 8250 driver */
: unsigned char	suspended;
: unsigned char	unused;
: const char	*name;		/* port name */

So the hole became 4 bytes on 64-bit.

I can make it unused[4], but..

Separated the patch per Greg's review and I think it makes sense to have
it separately from 2/3 because last time I've touched it, it actually
was in use by drivers (regardless the name).

Thanks,
          Dmitry
