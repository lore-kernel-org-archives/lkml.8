Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDD3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A87207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593167891;
	bh=nTmyetpX2DSHqGZlNT8qq+KzOvmkbbQPhdXbsONxvF8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=GE3OYN9HGAxXFk2XE4xuUy18am/IBeVOrv44VCwFyBmyTNNzrh2u6mfCNfgWV+Kqj
	 AanHMOUNYtz5rQ4TIeMKYHY6gVZEHubgZjc6Hu3apyR8hiSzmEdeA20xE/qkQ85UqV
	 KHqzTyWmt0GgDthIUoeiLm/fc9ln6t4Uve3lZUuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgFZKiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:38:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35071 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgFZKiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:38:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id e15so6540848edr.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 03:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fKYT0Cb/Mw0lXw+9QwEk9pePtgsJg/wq3Kdy3BsXFQI=;
        b=KcTDRhKkU1gI5dnsFbn4XyJVwEHikcq4NNI5p2HISHAXcMUFNtMbuHmzurltr155M7
         GBytdG5PiV6xtydzp5aDV0Y+QIZKhAL7XCwJO0UPhtg9W80FSg8A6bCzTpYvoLiKbD0n
         My/7veIOIqoG41iYgFAW2l0r9osvbmnVekyLisW3TJ0XeiHREquaLnhTWdKYuknTze7c
         FTJzgWw68NYgeOPnPjikfW8Gf/BB1nbyNmabUZOA13pComP46bFM09+55eskin811Zco
         2GGicnuC1ayuY9ZQvB+BkNCpdK3Y0z1R/7sU0F3OOlO3nSxXyO+g3iuJEXFmqG15Bvp9
         c5WQ==
X-Gm-Message-State: AOAM531fXNH2slZbvQvo/UiqQPNjUazv9z/lej+yt7rRsJmt32Oj4acz
        Ha5f9/c53YAnAA1RH8yWjig=
X-Google-Smtp-Source: ABdhPJx6WaxBJTotIA1jYf9FokXAy3/S+76hM9rg52kcxzqA4cSI/f7RwwLLbUWqa90ov9QwQEXwgw==
X-Received: by 2002:a05:6402:1244:: with SMTP id l4mr2711398edw.71.1593167885386;
        Fri, 26 Jun 2020 03:38:05 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id a1sm12722722ejk.125.2020.06.26.03.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 03:38:04 -0700 (PDT)
Subject: Re: [PATCH v0 1/5] Change/add data structures for SRG mouse reporting
To:     Tammo Block <tammo.block@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1593155911.git.tammo.block@gmail.com>
 <7e65f1f060c2b9b22a4a051d4afb605913dedf79.1593155911.git.tammo.block@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <96153556-9c04-a570-e8f3-0a6a66222537@kernel.org>
Date:   Fri, 26 Jun 2020 12:38:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <7e65f1f060c2b9b22a4a051d4afb605913dedf79.1593155911.git.tammo.block@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 06. 20, 9:22, Tammo Block wrote:
> This extends the data structures and defines needed for additional
> mouse reporting features. If URXVT and UTF8 reports should be supported
> in the future, vc_proto_mouse would need another bit.

Just a global remark: I have just rewritten a large part of the vt code.
You might need to rebase on the top of tty-next...

> Signed-off-by: Tammo Block <tammo.block@gmail.com>
> ---
>  include/linux/console_struct.h |  3 ++-
>  include/uapi/linux/tiocl.h     | 24 ++++++++++++++++--------
>  2 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
> index 24d4c16e3ae0..cfb581eb8b82 100644
> --- a/include/linux/console_struct.h
> +++ b/include/linux/console_struct.h
> @@ -122,7 +122,8 @@ struct vc_data {
>  	unsigned int	vc_priv		: 3;
>  	unsigned int	vc_need_wrap	: 1;
>  	unsigned int	vc_can_do_color	: 1;
> -	unsigned int	vc_report_mouse : 2;
> +	unsigned int	vc_report_mouse : 3;
> +	unsigned int	vc_proto_mouse  : 1;

bitfields... The generated code is so bad (it does masks, shifts and
ANDs in assembly), so please avoid them and define the new members the
standard way. I.e. unsigned char if 8 bits are enough, bool for one bit
and so on. The price is larger structure, but we can afford 5 more bits
per virt console, I think. Provided there is a very limited number them
-- this is not "struct page" after all :).

>  	unsigned char	vc_utf		: 1;	/* Unicode UTF-8 encoding */
>  	unsigned char	vc_utf_count;
>  		 int	vc_utf_char;
> diff --git a/include/uapi/linux/tiocl.h b/include/uapi/linux/tiocl.h
> index b32acc229024..df27608648f7 100644
> --- a/include/uapi/linux/tiocl.h
> +++ b/include/uapi/linux/tiocl.h
> @@ -3,13 +3,17 @@
>  #define _LINUX_TIOCL_H
>  
>  #define TIOCL_SETSEL	2	/* set a selection */
> -#define 	TIOCL_SELCHAR	0	/* select characters */
> -#define 	TIOCL_SELWORD	1	/* select whole words */
> -#define 	TIOCL_SELLINE	2	/* select whole lines */
> -#define 	TIOCL_SELPOINTER	3	/* show the pointer */
> -#define 	TIOCL_SELCLEAR	4	/* clear visibility of selection */
> -#define 	TIOCL_SELMOUSEREPORT	16	/* report beginning of selection */
> -#define 	TIOCL_SELBUTTONMASK	15	/* button mask for report */
> +#define		TIOCL_SELCHAR	0	/* select characters */
> +#define		TIOCL_SELWORD	1	/* select whole words */
> +#define		TIOCL_SELLINE	2	/* select whole lines */
> +#define		TIOCL_SELPOINTER	3	/* show the pointer */
> +#define		TIOCL_SELCLEAR	4	/* clear visibility of selection */
> +#define		TIOCL_SELMOUSEREPORT	16	/* send X10 mouse report */
> +#define		TIOCL_SELBUTTONMASK	15	/* button mask for X10 report */
> +#define		TIOCL_SELSRGREPORT	32	/* send SRG mouse report */
> +#define		TIOCL_SELSRGRELEASE	128	/* SRG report is release event */
> +#define		TIOCL_SELSRGMASK	(255 << 8)	/* mask for SRG report */

This right shift of all of them feels like too much right. Why do you do
it? And if you do it, do it in a separate patch. It makes this one
complicated to review.

> @@ -28,7 +32,11 @@ struct tiocl_selection {
>  
>  /* these two don't return a value: they write it back in the type */
>  #define TIOCL_GETSHIFTSTATE	6	/* write shift state */
> -#define TIOCL_GETMOUSEREPORTING	7	/* write whether mouse event are reported */
> +#define TIOCL_GETMOUSEREPORTING	7	/* write which mouse event to be reported */
> +#define		TIOCL_REPORTBTNPRESS	1	/* report button press only    "9" */
> +#define		TIOCL_REPORTRELEASE	2	/* report press and release "1000" */
> +#define		TIOCL_REPORTDRAG	5	/* report drag events       "1002" */
> +#define		TIOCL_REPORTANYMOVE	6	/* report any movement      "1003" */

Dtto.

>  #define TIOCL_SETVESABLANK	10	/* set vesa blanking mode */
>  #define TIOCL_SETKMSGREDIRECT	11	/* restrict kernel messages to a vt */
>  #define TIOCL_GETFGCONSOLE	12	/* get foreground vt */

thanks,
-- 
js
