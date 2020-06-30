Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECADC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C062067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593503733;
	bh=ffg5/LswWVXGgVOLOl5Wv2iNNvrTSpOWjpWqb/i6rWw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=AsfQ+CpKOTxN/3LPhiom79vfH4iAP09WJlWFVLaXYaaj7ty2OApNWMuFzoPocJTRt
	 CKYzMPwfc9VOaKB31N4U2bYq8oN+8xwALGzMmL7ZJK+E1MKDGwRXTsci9A5W3S2Jr+
	 dXZm4uhtHxmMwCcLHJ6cNV8+ITxQonLHZdzAdRR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgF3Hzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:55:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46464 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgF3Hzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:55:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id dm19so9001672edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V1bLhkiGPt6XHgl4JbVg1NlUfJvh8q0QPOSgnDayaZE=;
        b=casVe4TBTciEUwYQcz0xR56fPw5JSgR6H2h57TKo7ZE0m3TYOiy24t0CkP5lTLEsmi
         fAsNyocwiV5ml6q2Hw74/jK3JgBKxfWBDzQMUNSK/brk1Gg3Pg0fYefTKCt4eJLmo6Tj
         PHbRhXoCxoNGbqS7u0xOyK3HYevjZaEy/cZAHXq1XsztgNmsHbHzoBOVygui9XASPDl7
         Fb86z4KkNy0xpsXH8xJbwTcyJ5hZz74dT9sE2T2CD2IXyPAGYWZ3WqpTLdEnFjZuorlV
         LHjkG47rLet9zYTV2j4r8pElnOpcc9l0NsoIbOYC+sP1NiDvmiq+sRmB8C2+2exND14g
         9Ubw==
X-Gm-Message-State: AOAM531irjKFEy9pTUwwTMUlZqNUAjeITLdI0/fSeSsKy0AyxoIEIK9B
        IN0r10xqRyHZMaCKcGsI1T9gidz+
X-Google-Smtp-Source: ABdhPJzwdkfDeHtnq0CAyJMmKai4G1AaORHVEzQLU6uQpzDmORwybQh+naJ7BMTW6lzcOEyYF3Zx8Q==
X-Received: by 2002:a05:6402:1b94:: with SMTP id cc20mr21237854edb.177.1593503729133;
        Tue, 30 Jun 2020 00:55:29 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id b6sm1937008eds.64.2020.06.30.00.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 00:55:28 -0700 (PDT)
Subject: Re: [PATCH v1 1/6] tiocl.h: Change/Add defines for mouse report
To:     Tammo Block <tammo.block@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1593499846.git.tammo.block@gmail.com>
 <159375ce8dcdbcada6fa079f0a120765b10a84a7.1593499846.git.tammo.block@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <f00141ec-5da4-2743-7064-8094d7915f7c@kernel.org>
Date:   Tue, 30 Jun 2020 09:55:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159375ce8dcdbcada6fa079f0a120765b10a84a7.1593499846.git.tammo.block@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 06. 20, 9:10, Tammo Block wrote:
> Add additional defines for mouse event types. The change of the value
> of TIOCL_SELBUTTONMASK deserves a bit more explanation :
> 
> The old value of 15 uses the first 4 bits and sends them unchanged back
> to userspace if requested by an application. But in fact only the first
> two bits have ever been used by any daemon or useful at all, as the
> kernel already knows the status of the shift and alt keys encoded in
> bits 3 and 4. On the other hand we *do* want to know the status of bits
> 6-8, encoding button values >3 and mouse move and drag operations.
> 
> This change is up- and downwards compatible by masking all spourious
> bits and leaving only the undisputed parts (bits 1 and 2) untouched.
> 
> Signed-off-by: Tammo Block <tammo.block@gmail.com>
> ---
>  include/uapi/linux/tiocl.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/tiocl.h b/include/uapi/linux/tiocl.h
> index b32acc229024..c862053041e4 100644
> --- a/include/uapi/linux/tiocl.h
> +++ b/include/uapi/linux/tiocl.h
> @@ -9,7 +9,7 @@
>  #define 	TIOCL_SELPOINTER	3	/* show the pointer */
>  #define 	TIOCL_SELCLEAR	4	/* clear visibility of selection */
>  #define 	TIOCL_SELMOUSEREPORT	16	/* report beginning of selection */
> -#define 	TIOCL_SELBUTTONMASK	15	/* button mask for report */
> +#define 	TIOCL_SELBUTTONMASK	227	/* button mask for report */

0xe3 is more obvious (can be in-brain translated to bits).

If C only had 0b prefix like perl has...

>  /* selection extent */
>  struct tiocl_selection {
>  	unsigned short xs;	/* X start */
> @@ -28,7 +28,11 @@ struct tiocl_selection {
>  
>  /* these two don't return a value: they write it back in the type */
>  #define TIOCL_GETSHIFTSTATE	6	/* write shift state */
> -#define TIOCL_GETMOUSEREPORTING	7	/* write whether mouse event are reported */
> +#define TIOCL_GETMOUSEREPORTING	7	/* write which mouse event are reported */

s/event/&s/

> +#define		TIOCL_REPORTBTNPRESS	1	/* report button press only    "9" */
> +#define		TIOCL_REPORTRELEASE	2	/* report press and release "1000" */
> +#define		TIOCL_REPORTDRAG	3	/* report drag events       "1002" */
> +#define		TIOCL_REPORTANYMOVE	4	/* report any movement      "1003" */
>  #define TIOCL_SETVESABLANK	10	/* set vesa blanking mode */
>  #define TIOCL_SETKMSGREDIRECT	11	/* restrict kernel messages to a vt */
>  #define TIOCL_GETFGCONSOLE	12	/* get foreground vt */
> 

thanks,
-- 
js
suse labs
