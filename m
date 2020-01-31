Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181CCC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 07:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1C920705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 07:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcVYhGHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgAaHCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 02:02:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45462 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgAaHCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 02:02:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so2820596pfg.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 23:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wOI7hqK3fz5FOatl+JgLstEmzwY5hPCxPwdC6f4htY0=;
        b=gcVYhGHFtpUbCqyKbhsgy051T79MxaD0OdnjtYqfqze1AvFsz1IsXJQLrWD0Gg4KOX
         J2DsQGRsQ6WoO3xOmJp2umB2AWLPJ5FR5KkAsAeBptRvLpxCvhvY9RKPjJCI8zskqw00
         ZunZhSWNWIi9qFAqnip93r1/chopEhiogdWsuG1pCjMYTfbPF4irJTdGs1hC+qQpwGOl
         MWXzaWUcWmY/mJp4G/UUx/oGmcY0HMQI7ereUN7p4PQ7V15zj2M6k2/bhck2sfgBkC7S
         d7c2puw/9abml2Z4h87xT3hYJsSYYJa0hUBwmiHfDHwRQs4uUhg0ZT2WqI0XM2p8AqlP
         nV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wOI7hqK3fz5FOatl+JgLstEmzwY5hPCxPwdC6f4htY0=;
        b=RHxJQo7I71q3iaxP52LkjJzMj9M8uJk+5adwWEioHAysHGJTDR9aV4njM3oXcLnE7w
         ZR9WUVIDbaqN7Lc+DcizgU38lympvqL+HLmCtEHsr5z8bDTi9NEh6/3TQKN4eauc5nDo
         g/qxuJ5v8C90EsDWpePmTwo6S8McHIcp+tJ/0QhRFd3VBgZNl1pDxvCguCloASN5pRZl
         VfsZ0Lhs6CycSg8x+z2WiJxgbOamCRm4gA5N3ruSexEYXwpk9+I3VlrwEVKn6r3pxkqW
         OHrzrToKwxoPEu+VRbdLReKZVLJEI9c4DOstRvymG5FSjYgIQxoKpiI9zfJPzHgc5VI+
         ZChw==
X-Gm-Message-State: APjAAAWahD37lwlMg0IzoZuhbFdj+xj6mjR7kZVGKKyQrKljyVEISSR5
        6/Jg2wGvFcTUDymv0bQH4vE=
X-Google-Smtp-Source: APXvYqzrf9HXTuJ47vRwuDdXyk6Q7rha2caXtba6GCDo4v9fEuaTCO33fzUk4AwnphPzGbYBjgI/jw==
X-Received: by 2002:a63:28a:: with SMTP id 132mr8654803pgc.165.1580454161600;
        Thu, 30 Jan 2020 23:02:41 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id gc1sm8305293pjb.20.2020.01.30.23.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 23:02:40 -0800 (PST)
Date:   Fri, 31 Jan 2020 16:02:37 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] printk: Convert a use of sprintf to snprintf in
 console_unlock
Message-ID: <20200131070237.GB240941@google.com>
References: <20200130221644.2273-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130221644.2273-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/30 15:16), Nathan Chancellor wrote:
> When CONFIG_PRINTK is disabled (e.g. when building allnoconfig), clang
> warns:
> 
> ../kernel/printk/printk.c:2416:10: warning: 'sprintf' will always
> overflow; destination buffer has size 0, but format string expands to at
> least 33 [-Wfortify-source]
>                         len = sprintf(text,
>                               ^
> 1 warning generated.
> 
> It is not wrong; text has a zero size when CONFIG_PRINTK is disabled
> because LOG_LINE_MAX and PREFIX_MAX are both zero. Change to snprintf so
> that this case is explicitly handled without any risk of overflow.

We probably can add a note here that for !CONFIG_PRINTK builds
logbuf overflow is very unlikely.

Otherwise,
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
