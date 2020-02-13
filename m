Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC4EC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A095E21734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbwTOUfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgBMFwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 00:52:40 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37641 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgBMFwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 00:52:40 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so1902385plz.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 21:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+1S9sNHPw62IiDHN8eBPg+LrMJ2ouKwr3VAKbMRF980=;
        b=JbwTOUfDNCW8qkY/K2fwPjqrNqbtdzFFdI4/KN8PtrzOmCcy9ldaaldRrev+2hewUs
         N4tqjWYrZZlQsZx0itOo/1N7IKBSDRrEMIWqskzXqPFVJvSV8i+kfhjhMsu1c9MfQwGP
         90OXGjLAoHpFUs4sbbvWCmR2YXWtHeu+EtFiDbz8VYIBl+8S9kk7HFvjaCFnoqKZQ0O/
         IrUo2NJAskpjveNynLwGiJU788Ydk655SFHz3o3FfB8tan8yIBx74/WgkEBDvZEXaTHN
         h2t1rDSXVGj/GtKVk9DeAoxb4sddDKNnZOA7jM0KHQXjMNZCrhAIveBDmmgwdUCUSuJz
         ceXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+1S9sNHPw62IiDHN8eBPg+LrMJ2ouKwr3VAKbMRF980=;
        b=hiFLo2xVUqD5pdl4oRT2KVYgI5128cCeeYk4hFf9P8Kpq5Qobpj4snBYCk2WlEtZ1l
         Jl6GKhrz6hUbswn81GWXaunAdYGKC9DP/rxT/jJLTa0ALlqbPBtM0kqfOjIIB5CE+aHi
         BuR5nICY0khJrIjWk0PuzZGCUXz3VBD1O4wjKRZYrb2OgPHMqwB7q1d/cb5gJH9XiWQy
         hTdAy7LvkzFOFanBHvL9GC2afeNkyHMGa9obVpC0PSiXjuWNpohdBpY9fxoE4/RPQQqx
         Ovf2xHMSVe5JnH3ybwLc4FUEQ21IxIp/egQn43SxCb+z/5PaHUlIdNZuvor7PX+CUGEh
         sKug==
X-Gm-Message-State: APjAAAXm0qFEnTCmq+8gnz/Ah4Lg7/2zd2OiOmsLE0L2QX2BcfnVQP8s
        XNHZvHlnLWt5YaPANGEdwSY=
X-Google-Smtp-Source: APXvYqwEUOhsEe9x5FKfzhw+SMi+PEv2ID9VU2z6+xNAsqbLEa4uiOg5pUBE46wVc+0mOK7RiwIXDA==
X-Received: by 2002:a17:90a:3243:: with SMTP id k61mr3295357pjb.43.1581573159839;
        Wed, 12 Feb 2020 21:52:39 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id m187sm1028142pga.65.2020.02.12.21.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 21:52:38 -0800 (PST)
Date:   Thu, 13 Feb 2020 14:52:36 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] printk: Fix preferred console selection with
 multiple matches
Message-ID: <20200213055236.GE13208@google.com>
References: <97dc50d411e10ac8aab1de0376d7a535fea8c60a.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97dc50d411e10ac8aab1de0376d7a535fea8c60a.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/06 15:02), Benjamin Herrenschmidt wrote:
[..]
>  static int __add_preferred_console(char *name, int idx, char *options,
> -				   char *brl_options)
> +				   char *brl_options, bool user_specified)
>  {
>  	struct console_cmdline *c;
>  	int i;
> @@ -2131,6 +2131,8 @@ static int __add_preferred_console(char *name, int idx, char *options,
>  		if (strcmp(c->name, name) == 0 && c->index == idx) {
>  			if (!brl_options)
>  				preferred_console = i;
> +                       if (user_specified)
> +                               c->user_specified = true;
>  			return 0;
>  		}
>  	}
> @@ -2140,6 +2142,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
>  		preferred_console = i;
>  	strlcpy(c->name, name, sizeof(c->name));
>  	c->options = options;
> +	c->user_specified = user_specified;
>  	braille_set_options(c, brl_options);
>  
>  	c->index = idx;
> @@ -2194,7 +2197,7 @@ static int __init console_setup(char *str)
>  	idx = simple_strtoul(s, NULL, 10);
>  	*s = 0;
>  
> -	__add_preferred_console(buf, idx, options, brl_options);
> +	__add_preferred_console(buf, idx, options, brl_options, true);
>  	console_set_on_cmdline = 1;
>  	return 1;
>  }
> @@ -2215,7 +2218,7 @@ __setup("console=", console_setup);
>   */
>  int add_preferred_console(char *name, int idx, char *options)
>  {
> -	return __add_preferred_console(name, idx, options, NULL);
> +	return __add_preferred_console(name, idx, options, NULL, false);
>  }

A silly question:

Can the same console first be added by
	console_setup()->__add_preferred_console(true)
and then by
	add_preferred_console()->__add_preferred_console(false)

	-ss
