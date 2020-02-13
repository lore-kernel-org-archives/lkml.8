Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42541C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1431F20848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="QijSSUZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgBMJhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:37:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37135 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMJht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:37:49 -0500
Received: by mail-lj1-f196.google.com with SMTP id v17so5799107ljg.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=abAWSR2K9H6Y7+jBghj7Y02LAAu4P/DFtVh1G9MzXxs=;
        b=QijSSUZmAvV9r/UmfLRddFu/lj5MAcoPgRZbVa3v9j5jiiATXWzyL/BvURW3lz3KW7
         iMjlFqEHYvawzlPHLR/6TBOqcOgIPA8kR1X2nWq5kW9cvm8JEMkz8Q9hVcUSVr23HHE4
         ZwjkFtmmfIky8bGKUhfgRMyi8KT/hNbFyFmrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=abAWSR2K9H6Y7+jBghj7Y02LAAu4P/DFtVh1G9MzXxs=;
        b=pb7f7lJ2iytifF23NY5hGI+8T5eJ3I2GEy6T+Z60UtzfzezeM5oVCTaem10NI2Icgi
         Xw9TVPW7XNQDfIzdPKGA4pPYMToyZNap0uIMfzUwK1KjbQ4ZPRwjz+0HbKWoeM+eM4ok
         kFW0lg+NPUnbbY45IxFM73CqA+pjBY8IQfXhfli00ZPbF9UuslILvxxyAYl+9Uqx1qa0
         3IRH7k+2QDgu0lVBgJ0xyEPvjw5Aq2MWgswUlZHn8weZlgcGAF9YWb3YlaCI7uOFB+ex
         P6viD4DMv4qQQGUrFu6aUDKJPgjfmof6FwOjxu89lULLJjtL0MTLJ/QuyRUGqzUKnunu
         0GKQ==
X-Gm-Message-State: APjAAAUZWio81vK88D2uApxfwRgBUK2iLpSuYmwNKvavGJWO7sjMWgDt
        osQ+ea03S7i1NSQKwPzqb3BJHg==
X-Google-Smtp-Source: APXvYqyZFOrtSR7eABF1EXRChiVl4lCT5gyFw0WU8p2xdTyGdZA18sFRm59BfuNt7mQK9C5WtPUKtw==
X-Received: by 2002:a05:651c:232:: with SMTP id z18mr11013557ljn.85.1581586666416;
        Thu, 13 Feb 2020 01:37:46 -0800 (PST)
Received: from [172.16.11.50] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r9sm1151939lfc.72.2020.02.13.01.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 01:37:45 -0800 (PST)
Subject: Re: [Regression 5.6-rc1][Bisected b6231ea2b3c6] Powerpc 8xx doesn't
 boot anymore
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Wood <oss@buserror.net>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <0d45fa64-51ee-0052-cb34-58c770c5b3ce@c-s.fr>
 <aee10440-c244-7c93-d3bb-fd29d8a83be4@c-s.fr>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <59487f8a-fd2e-703d-d954-d263f756a3a0@rasmusvillemoes.dk>
Date:   Thu, 13 Feb 2020 10:37:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <aee10440-c244-7c93-d3bb-fd29d8a83be4@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2020 15.50, Christophe Leroy wrote:
> 
> 
> On 02/12/2020 02:24 PM, Christophe Leroy wrote:

>> In your commit text you explain that cpm_muram_init() is called via
>> subsys_initcall. But console init is done before that, so it cannot work.
>>
>> Do you have a fix for that ?
>>
> 
> The following patch allows powerpc 8xx to boot again. Don't know if
> that's the good place and way to do the fix though.
> 
> ---
> diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> index 4cabded8390b..341d682ec6eb 100644
> --- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> @@ -1351,6 +1351,7 @@ static int __init cpm_uart_console_setup(struct
> console *co, char *options)
>          clrbits32(&pinfo->sccp->scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
>      }
> 
> +    cpm_muram_init();
>      ret = cpm_uart_allocbuf(pinfo, 1);
> 
>      if (ret)

Hmm, that seems to be a somewhat random place, making it hard to see
that it is indeed early enough. Would it work to put it inside the
console_initcall that registers the cpm console? I.e.

static int __init cpm_uart_console_init(void)
{
+       cpm_muram_init();
        register_console(&cpm_scc_uart_console);
        return 0;
}

console_initcall(cpm_uart_console_init);

Rasmus
