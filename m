Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D29AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBD92071A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594966251;
	bh=p3w7MmLzhsONixfPGctqesqj6GZahjGHqxwSsvcG/us=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=s8jjwnr7F+71iCttjOO3Uofv8PwjwLMaiGkodcLyQmOjBr/hxG7RflwjFdSPV3i2v
	 WJHkxw7xpwF8+eJgZc/A/DzKeiTPKAVZWSjE29L87hdtSHbEGcyjcjMpZfIOAcHHY0
	 7XsY4+221fQsthwT9xW1vmJDOE+tJvZmX8LsfoVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgGQGKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:10:49 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:40840 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgGQGKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:10:49 -0400
Received: by mail-ej1-f66.google.com with SMTP id o18so9542442eje.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 23:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SHN9xF1KUVsYmDolf6cwDeEWhx9LYQGmOBxF5+idG4g=;
        b=hrERJ0lGaRlZ3YObXSkt9zGbbbTIa+BiE1TW3kVnS2iRrRaDfXPra5dA4t2HZhruBk
         2SuX0voarV2/6gcshGjDxtcM8G+ohOsL8RmqxMUwuJwYDBaHX8diuoMeWCkMKiF78ANZ
         30pf7surqd3iSM3aHUO+GBiS8hgvRac+9Ez4oESZPeKHRbkufcYZHDCMRTkR/1mXL79K
         wiyEYdJWSj1lGTalyeoXkY3eMEk0udgJUh1ip8ruFsLS8Fp9ezPhrTJBgHkzW6V693lZ
         9l9DteHp3E2/0jUBITkTf7kYLQnCZD1w2+FDTReBF0Kjhkjg4S6jrAIhYETr1ch3oBhb
         +aKg==
X-Gm-Message-State: AOAM531+CYbHQBbbD2iAxuqWLjf+MZ91GkMe+ATU6SWThWf5xreSfG+R
        72m+iPeW4aNsX3Gvl+rYLLtHztlK
X-Google-Smtp-Source: ABdhPJxITh33yCD0YussRqgbYsRJkCoe3NR8Hq/HrYL3577lkUaBYm4OQOYTBnUuAY3TWZjVNqW4bg==
X-Received: by 2002:a17:906:430b:: with SMTP id j11mr7070912ejm.270.1594966246977;
        Thu, 16 Jul 2020 23:10:46 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id o21sm7023192eja.37.2020.07.16.23.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 23:10:46 -0700 (PDT)
Subject: Re: [PATCH][next] tty: Avoid the use of one-element arrays
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200716180858.GA30115@embeddedor>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <f8aa0762-4af2-54a2-c9e8-8023a4b7aed5@kernel.org>
Date:   Fri, 17 Jul 2020 08:10:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716180858.GA30115@embeddedor>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16. 07. 20, 20:08, Gustavo A. R. Silva wrote:
> One-element arrays are being deprecated[1]. Replace the one-element arrays
> with simple value types 'char reserved_char' and 'compat_int_t reserved'[2],
> once it seems these are just placeholders for alignment.
> 
> Also, while there, use the preferred form for passing a size of a struct.
> The alternative form where struct name is spelled out hurts readability
> and introduces an opportunity for a bug when the variable type is changed
> but the corresponding sizeof that is passed as argument is not.
> 
> Lastly, fix the checkpatch.pl warnings below:
> 
> ERROR: code indent should use tabs where possible
> +        char    reserved_char;$
> 
> WARNING: please, no spaces at the start of a line
> +        char    reserved_char;$
> 
> ERROR: code indent should use tabs where possible
> +        compat_int_t    reserved;$
> 
> WARNING: please, no spaces at the start of a line
> +        compat_int_t    reserved;$

May I ask you to send a follow-up patch to fix the whole structure's
indentation?

> [1] https://github.com/KSPP/linux/issues/79
> [2] https://github.com/KSPP/linux/issues/86
> 
> Tested-by: kernel test robot <lkp@intel.com>
> Link: https://github.com/GustavoARSilva/linux-hardening/blob/master/cii/0-day/tty-20200716.md
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs
