Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627D4C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D3B21556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OIpufyJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbgBYTjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:39:51 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54593 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgBYTju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:39:50 -0500
Received: by mail-pj1-f65.google.com with SMTP id dw13so152589pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 11:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0uZBykAXAO6jD5DASmZ5tKSqeRVuomezEv1o1XMOkAw=;
        b=OIpufyJefzUuIE7EA+vuCdCBPFeaGA+AMgAzJCqQxV/f7sEdIWzaqMl7kL2+83hCgS
         hQtguyMbdtvRAi0gwq8uh4N+z60MLiNwyVSBuxL+q5v2Fy/6skR+l3LTBvpr0kTuIdvx
         MW3pAjX8d1AQxA9asqm59YyFka0LDCMVWROEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0uZBykAXAO6jD5DASmZ5tKSqeRVuomezEv1o1XMOkAw=;
        b=Ou7Nmr8FlbN5/4QR/Tk/ffnpvzZK4tCX0jzZbc0bhnUmtUHT9g7YPmmSPXEQQiyAC7
         1zy0IbFwiiAFLS8PgkZXkbGuRZbFriVmbthk6rvpd8eF131ZL6rm+FIK32FaZt0tsWgp
         uqL/87ZcVBeq5QpOjFBj9oVhaLrWzms/1V3y2M7YEuBIg/hZMLBA81ubpHKATZvJH6WP
         lhrHkMZAqOcRAkufqf4TLvWOLDkEIdNk6gjp/fy+a7cFuKWpEuFkOApraPTTow10OS/8
         64FY3NDNmM4uQyM3xV7MVvErSQNF2K/bRVOKBrcKjHuwhgcCr33jWfqLjQOZxn77YhNr
         pdzg==
X-Gm-Message-State: APjAAAUIEmD5wklBEgZiFYyRxMA5+8257b1v6xTj24evLAeQzXC3Jh/H
        yAX9/josmjTZYRVLDe70vGpyEQ==
X-Google-Smtp-Source: APXvYqwpdQfkaCcBM5JlG7S4uokaXnpoAWqNofj2820k+ou8GtEmHOSAx7+JVN5Zi3OVDMkBJyavVw==
X-Received: by 2002:a17:90a:98d:: with SMTP id 13mr694690pjo.102.1582659589946;
        Tue, 25 Feb 2020 11:39:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y5sm18562579pfr.169.2020.02.25.11.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 11:39:49 -0800 (PST)
Date:   Tue, 25 Feb 2020 11:39:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Vasily Averin <vvs@virtuozzo.com>, joelaf@google.com
Cc:     linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2] pstore: pstore_ftrace_seq_next should increase
 position index
Message-ID: <202002251136.3816A79E@keescook>
References: <4e49830d-4c88-0171-ee24-1ee540028dad@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e49830d-4c88-0171-ee24-1ee540028dad@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[merged threads]

On Tue, Feb 25, 2020 at 11:11:20AM +0300, Vasily Averin wrote:
> In Aug 2018 NeilBrown noticed 
> commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
> "Some ->next functions do not increment *pos when they return NULL...
> Note that such ->next functions are buggy and should be fixed. 
> A simple demonstration is
> 
> dd if=/proc/swaps bs=1000 skip=1
> 
> Choose any block size larger than the size of /proc/swaps.  This will
> always show the whole last line of /proc/swaps"
> 
> /proc/swaps output was fixed recently, however there are lot of other
> affected files, and one of them is related to pstore subsystem.
> 
> If .next function does not change position index, following .show function
> will repeat output related to current position index.
> 
> There are at least 2 related problems:
> - read after lseek beyond end of file, described above by NeilBrown
>   "dd if=<AFFECTED_FILE> bs=1000 skip=1" will generate whole last list
> - read after lseek on in middle of last line will output expected rest of
>   last line but then repeat whole last line once again.
> 
> If .show() function generates multy-line output
> (like pstore_ftrace_seq_show() does ?)
> following bash script cycles endlessly
> 
>  $ q=;while read -r r;do echo "$((++q)) $r";done < AFFECTED_FILE
> 
> Unfortunately I'm not familiar enough to pstore subsystem and was unable to
> find affected pstore-related file on my test node.
> 
> If .next function does not change position index,
> following .show function will repeat output related
> to current position index.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code ...")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206283
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  fs/pstore/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index 7fbe8f0..ea8799b 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -87,11 +87,11 @@ static void *pstore_ftrace_seq_next(struct seq_file *s, void *v, loff_t *pos)
>  	struct pstore_private *ps = s->private;
>  	struct pstore_ftrace_seq_data *data = v;
>  
> +	(*pos)++;
>  	data->off += REC_SIZE;
>  	if (data->off + REC_SIZE > ps->total_size)
>  		return NULL;
>  
> -	(*pos)++;
>  	return data;
>  }
>  
> -- 
> 1.8.3.1
> 

I think this make sense, but I figured I'd check with Joel first. Does
this look sane for how ftrace will merge records?

-- 
Kees Cook
