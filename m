Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96687C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA6120663
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="jTDI3vA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgCZXhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:37:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55661 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbgCZXhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:37:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id z5so9611651wml.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 16:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bl0+vJNfCoY5kjjukF9IvmgCMV7IGJTdpr7+T2BKH+s=;
        b=jTDI3vA7hyZfk0Cd3IimayHkTQcp+aZkYYClVxxz7eW5OS+dYZW3MBWSgwrgerE8sG
         x2br5o7Q2eA2jgnWao88NDpn9np3TeWk6UzGQSrRtvWLF1zd0pNDJXeVo038tDNNH97z
         fT3FGYP/ERZS0fgAoDbcyCYorD0yzjeX4y3xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bl0+vJNfCoY5kjjukF9IvmgCMV7IGJTdpr7+T2BKH+s=;
        b=hFoFoaB/0iI/JHErG01mSUN9pdvqnY55ApK88MaJbkxbPKEppL5JkjxJuFNYJr/649
         +5nMWg21uH6e0gMYxPYow+XDP42x0qG0Kv2vCiJsJNFzcmlzXB1LwEQrvmA6Xo3GZ+6V
         kkxuA5WN2teKQWeppfhawGnLiZCgfR9weEsiurFK+WI8wOdX3An/p7tFYYebmx7oG3dc
         a0wrTJAQGDcFE7dvVa8GkY/Lp1qCSgVzRDwUIF2LKA0xnarJUNgbVbWHO45X4C+cZKTj
         DRiEzeF2ydBYuNbG5fUEOSTSQ2DCeQHgvrvIg8eoHEvQmmwey8/svaQ7CBBASl8qj2MT
         oAxw==
X-Gm-Message-State: ANhLgQ1QTicsCFjAejjaK16txYZajc6kreaV9KHjz+t3GoL5rKJzOZ1g
        7OOZqZ1lhIKke0/P1AwubiAPOQ==
X-Google-Smtp-Source: ADFU+vueItE8s5eqdU5PCp6BKHNmz7e/pY4izLP7WhMkxNEQUzsYOswqk6D9eV5eAXuc3kFzar7lhA==
X-Received: by 2002:adf:fece:: with SMTP id q14mr472938wrs.300.1585265857865;
        Thu, 26 Mar 2020 16:37:37 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-116-45.cgn.fibianet.dk. [5.186.116.45])
        by smtp.gmail.com with ESMTPSA id h29sm6230069wrc.64.2020.03.26.16.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 16:37:37 -0700 (PDT)
Subject: Re: [RESEND][PATCH v3 14/17] static_call: Add static_cond_call()
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
References: <20200324135603.483964896@infradead.org>
 <20200324142246.127013582@infradead.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <10ef25bf-87df-6917-1d50-c29ece442766@rasmusvillemoes.dk>
Date:   Fri, 27 Mar 2020 00:37:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200324142246.127013582@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2020 14.56, Peter Zijlstra wrote:
> Extend the static_call infrastructure to optimize the following common
> pattern:
> 
> 	if (func_ptr)
> 		func_ptr(args...)
> 

> +#define DEFINE_STATIC_COND_CALL(name, _func)				\
> +	DECLARE_STATIC_CALL(name, _func);				\
> +	struct static_call_key STATIC_CALL_NAME(name) = {		\
> +		.func = NULL,						\
> +	}
> +
>  #define static_call(name)						\
>  	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_NAME(name).func))
>  
> +#define static_cond_call(name)						\
> +	if (STATIC_CALL_NAME(name).func)				\
> +		((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_NAME(name).func))
> +

What, apart from fear of being ridiculed by kernel folks, prevents the
compiler from reloading STATIC_CALL_NAME(name).func ? IOW, doesn't this
want a READ_ONCE somewhere?

And please remind me, what is the consensus for sizeof(long) loads: does
static_call() need load-tearing protection or not?

Rasmus
