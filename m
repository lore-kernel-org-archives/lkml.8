Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57CFC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6174B20714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FBK+zwVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgBZSku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:40:50 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46638 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgBZSkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:40:49 -0500
Received: by mail-pf1-f196.google.com with SMTP id k29so191461pfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 10:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4GGF4l4U7/kbDXUUFjPa2eu/bqf5F6upzrLkHeQe7FY=;
        b=FBK+zwVyEoLgoQ57CVtZtTPJfi9gje5UsBooroCLV59Ab/5wgZsun0pvJpO4LI9qyu
         Vzum3mDZd+PdAkWuMNyQT3MrGeXUDFZu+ixd0Ck48CQgZLgiM8cqbMW8stDZ3vvIhP2g
         OyI3g2oG+vvDUSlxmbnkew1X1i79ylNpdA8qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4GGF4l4U7/kbDXUUFjPa2eu/bqf5F6upzrLkHeQe7FY=;
        b=hMgXiuJr87yAvLRikOKorVOBo3FHaozNk09drSzu4hu8VSP9KwmvUecey08VMtvKuL
         d2HRIYbRBvcddv1xY/qaEl3khBLcgHsA/nARbkz5F3q19iKLfHWjBF2OFrUHCYxqRjnY
         8RS43oXz2QImaa07miV1My2rJ8lly5xDbK1gRprLodd/CCXBe4h5Y/DV4xeLtmdTCU3g
         o5CUUhyg2U4zw93nNhHWc+5DjcuF7fxUbV1TPv1kwvIbiAdx5sPXlBeA1PosNLylfTeC
         7fA/vjnH4fwrzOu/AyxFcLkpFdwo6KGK2EfTduu15fA1gn4M7bVRJLjP15DgiqamFU96
         M5yQ==
X-Gm-Message-State: APjAAAUuq6TzOTyC8GTjd2IaLF0EyuINvWf9L7E+t/eJspYaRsFZ8HLk
        7Q9C+JiaL1eeRLuMbddWVHcqGXgK0Dg=
X-Google-Smtp-Source: APXvYqyac2WSpXZHHTN+EGyGVsYr4PLSd3n9K6QamkLWoVUX+67zyuQFAWpx7S/5klS1jYvy9OJN0A==
X-Received: by 2002:a65:40c8:: with SMTP id u8mr222956pgp.188.1582742448922;
        Wed, 26 Feb 2020 10:40:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 7sm4003285pfc.21.2020.02.26.10.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 10:40:48 -0800 (PST)
Date:   Wed, 26 Feb 2020 10:40:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2] pstore: pstore_ftrace_seq_next should increase
 position index
Message-ID: <202002261040.8F21715C@keescook>
References: <4e49830d-4c88-0171-ee24-1ee540028dad@virtuozzo.com>
 <202002251136.3816A79E@keescook>
 <CAJWu+oqZ+=Z1x0+Xm46Y90w=+dhub6dm+s=nU2-V9QeDn5AcrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oqZ+=Z1x0+Xm46Y90w=+dhub6dm+s=nU2-V9QeDn5AcrQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 01:36:45PM -0500, Joel Fernandes wrote:
> One thing I was not sure about is, if we move "pos" forward but still
> return NULL from next(), then does show() need to check if data is
> NULL? As below. Otherwise the suggested patch looks sane to me.
> 
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index 7fbe8f0582205..e3e7370b1a34d 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -101,6 +101,9 @@ static int pstore_ftrace_seq_show(struct seq_file
> *s, void *v)
>         struct pstore_ftrace_seq_data *data = v;
>         struct pstore_ftrace_record *rec;
> 
> +       if (!data)
> +               return 0;
> +
>         rec = (struct pstore_ftrace_record *)(ps->record->buf + data->off);
> 
>         seq_printf(s, "CPU:%d ts:%llu %08lx  %08lx  %ps <- %pS\n",

Ah, good point. I'm not sure, but it's worth checking I think. :)

-- 
Kees Cook
