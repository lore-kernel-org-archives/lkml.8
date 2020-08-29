Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACA5C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 06:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8984B20738
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 06:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgH2G7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 02:59:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34865 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgH2G7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 02:59:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id i10so1283665ljn.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 23:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DPbKEFaWNowFySa1ektYp+9sXLz/CsLAXB1avS4exuk=;
        b=l0+6esUHhvXdeD7lQE4SLnV5ivaCa6bjZQr7d+XZMwDum8KSWDjZ+UxZcnLN2uzUB+
         lVW+UTqOofbv/LZP++1uxDE+MneMML+D0z0Pp7rUe1ptZVqsrtWmsMVrOXn2XkEU0sGL
         FdGB2v0Q/JIKBLSIZgRBBTxoYPnzGrWS6xJG3Y+Umsx2eFoU/cfr2W2K6KkJnINpMwyK
         ZJ/FrwcXPpmeKpIbo+yEICVCiW/Jlj+Uko1ZFMNwXQyB6bpomKGP/rushnV6IiCrPT2X
         /qeaeB7mdGW13M1BkW3G0VWTGY6S4+OB4mm09pqshXkGxI7UCUekTpqwKAxoUO5hjB8d
         8xIg==
X-Gm-Message-State: AOAM532bwiZPerPGEuRqHSMMhOzEpqGR6VFl1+xaiBZUS3K5noCRxCTz
        GImYcDn5U9J6qpy4JRZwksaiQil7j0g=
X-Google-Smtp-Source: ABdhPJy42CpcQ/qpjdC+oUfS9EsRnIkMNuPLeUdwoApA09uiltImRQuTzmyV82Gp/rlv+h5D55rmQQ==
X-Received: by 2002:a2e:4c02:: with SMTP id z2mr996265lja.177.1598684351527;
        Fri, 28 Aug 2020 23:59:11 -0700 (PDT)
Received: from [192.168.1.8] ([213.87.147.111])
        by smtp.gmail.com with ESMTPSA id g19sm306193ljk.125.2020.08.28.23.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 23:59:11 -0700 (PDT)
Subject: Re: [PATCH] sysfs: Add sysfs_emit to replace sprintf to PAGE_SIZE
 buffers.
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org
References: <a96cdf07cd136d06c3cc1e10eb884caa7498ba72.1598654887.git.joe@perches.com>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Message-ID: <c77e83a0-7587-3e07-81cb-6b185d1ce6aa@linux.com>
Date:   Sat, 29 Aug 2020 09:59:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a96cdf07cd136d06c3cc1e10eb884caa7498ba72.1598654887.git.joe@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/29/20 1:52 AM, Joe Perches wrote:
> sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> used for outputting sysfs content requests and it's possible to
> overrun the buffer length.
> 
> Add a generic sysfs_emit mechanism that knows that the size of the
> temporary buffer and ensures that no overrun is done.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---


It could be a good idea to update the docs to, i.e.:
https://www.kernel.org/doc/html/latest/filesystems/sysfs.html


>  fs/sysfs/file.c       | 30 ++++++++++++++++++++++++++++++
>  include/linux/sysfs.h |  8 ++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index eb6897ab78e7..06a13bbd7080 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -707,3 +707,33 @@ int sysfs_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t kgid)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(sysfs_change_owner);
> +
> +/**
> + *	sysfs_emit - scnprintf equivalent, aware of PAGE_SIZE buffer.
> + *	@buf:	start of PAGE_SIZE buffer.
> + *	@pos:	current position in buffer
> + *              (pos - buf) must always be < PAGE_SIZE
> + *	@fmt:	format
> + *	@...:	arguments to format
> + *
> + *
> + * Returns number of characters written at pos.
> + */
> +int sysfs_emit(char *buf, char *pos, const char *fmt, ...)
> +{
> +	va_list args;
> +	bool bad_pos = pos < buf;
> +	bool bad_len = (pos - buf) >= PAGE_SIZE;
> +	int len;
> +
> +	if (WARN(bad_pos || bad_len, "(pos < buf):%d (pos >= PAGE_SIZE):%d\n",
> +		 bad_pos, bad_len))
> +		return 0;
> +
> +	va_start(args, fmt);
> +	len = vscnprintf(pos, PAGE_SIZE - (pos - buf), fmt, args);
> +	va_end(args);
> +
> +	return len;
> +}
> +EXPORT_SYMBOL_GPL(sysfs_emit);
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index 34e84122f635..5a21d3d30016 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -329,6 +329,8 @@ int sysfs_groups_change_owner(struct kobject *kobj,
>  int sysfs_group_change_owner(struct kobject *kobj,
>  			     const struct attribute_group *groups, kuid_t kuid,
>  			     kgid_t kgid);
> +__printf(3, 4)
> +int sysfs_emit(char *buf, char *pos, const char *fmt, ...);
>  
>  #else /* CONFIG_SYSFS */
>  
> @@ -576,6 +578,12 @@ static inline int sysfs_group_change_owner(struct kobject *kobj,
>  	return 0;
>  }
>  
> +__printf(3, 4)
> +static inline int sysfs_emit(char *buf, char *pos, const char *fmt, ...)
> +{
> +	return 0;
> +}
> +
>  #endif /* CONFIG_SYSFS */
>  
>  static inline int __must_check sysfs_create_file(struct kobject *kobj,
> 

Thanks,
Denis
