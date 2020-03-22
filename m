Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B928C4332D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 08:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D290206F8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 08:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="xA9t41iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgCVIdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 04:33:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38385 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgCVIdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 04:33:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id w1so11106550ljh.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 01:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GYodu1hNAeAFvsnGp4c01oeXRlI7ca0lNBKuCrt4USY=;
        b=xA9t41iwzU3rmuI25Ttw6r0xiC/AkGVhv2DijmSzsj8OvXACJUJ23FTgsgcgnod1c/
         e3q+mRPx6Lhr4FIkaLnzxWjCp05TFrx4mjWhsPWhpas0AFonhcI8TwMMTJz5izVE2fjR
         jrkk/4ciPyk/4dVj8G2B/LYhUzEHXktfQ2TOo3nuHqjbUCpwDvHkSzmTnzxrkk0eDEOc
         p+ekQiVSMWezqPdJlM3dOrin1KVYvYkuKxfPIe2LqEPvONtxEWvZM7FcHqGZZVmLTznd
         IBW6hps1AsKbeQgJ7q+sQwxe9pKkmj/o8DoggCVmzd3ROM31RvG/inq3k7LMdHrbe+3a
         eiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GYodu1hNAeAFvsnGp4c01oeXRlI7ca0lNBKuCrt4USY=;
        b=Kb6S4w6cL0VgU0fM+aVkejRpOpmsNG0kv/2xQD+52F06WOqzfUBky2u4M7I+7VvrLC
         +oohLOhnGNonGfqfSwHykndl07Qh9jZ5vY3j8UyhiQJIOPttMTirks0iPVifgOzP53bQ
         vQmtV1oQAFpI1X3eLw6zl1T5p3xHABYRWO1bEnlhPTfXskB3A8yiRSSH4/zdW4cRL7lr
         xo9VQ8YnWGRh/3ZZZTlmvp6ikdwoQ+fkAIs8oikl4KTyOPmsXZYGI//8ndErphMVxKWh
         oIyZb2CiASz2y1wUvuERxAnCf9xpIrsnS0n11zNM0dttIz+Tizw2vTkUsUCsSXsfSZGE
         YkNA==
X-Gm-Message-State: ANhLgQ0fTwgDFl3A/w/G9KQXei9wc+mpShZ37RqcuUjghrzOw+p0K8oU
        bJvfVUfLXLifS4dsfFMK0076JXehFjgOvA==
X-Google-Smtp-Source: ADFU+vuI5Tkw5meA3Xbn2em83MyEo8gnVpoDHqSWCfvI72ZfI0JP4vg3rOr+eXuzCdAf0NHXrwRHXg==
X-Received: by 2002:a05:651c:106c:: with SMTP id y12mr2510877ljm.170.1584866030990;
        Sun, 22 Mar 2020 01:33:50 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:4416:1ee0:bdcc:9012:53a3:648d? ([2a00:1fa0:4416:1ee0:bdcc:9012:53a3:648d])
        by smtp.gmail.com with ESMTPSA id d26sm7993714lfm.0.2020.03.22.01.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2020 01:33:50 -0700 (PDT)
Subject: Re: [PATCH] getauxval.3: MIPS, AT_BASE_PLATFORM passes ISA level
To:     YunQiang Su <syq@debian.org>, mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200322053916.391906-1-syq@debian.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <4d4b7b0f-7e55-c400-3b5f-5c9a04bac40f@cogentembedded.com>
Date:   Sun, 22 Mar 2020 11:33:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200322053916.391906-1-syq@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 22.03.2020 8:39, YunQiang Su wrote:

> Since Linux 5.7, on MIPS, we use AT_BASE_PLATFORM to pass ISA level.
> The values may be:
>    mips2, mips3, mips4, mips5,
>    mips32, mips32r2, mips32r6,
>    mips64, mips64r2, mips64r6.
> 
> This behaivor is different with PowerPC.

    Behavior.

> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=e585b768da111f2c2d413de6214e83bbdfee8f22
> Signed-off-by: YunQiang Su <syq@debian.org>
> ---
>   man3/getauxval.3 | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/man3/getauxval.3 b/man3/getauxval.3
> index 456371c6a..518faf5d3 100644
> --- a/man3/getauxval.3
> +++ b/man3/getauxval.3
> @@ -60,9 +60,10 @@ values are present on all architectures.
>   The base address of the program interpreter (usually, the dynamic linker).
>   .TP
>   .BR AT_BASE_PLATFORM
> -A pointer to a string identifying the real platform; may differ from
> -.BR AT_PLATFORM
> -(PowerPC only).
> +A pointer to a string (PowerPC and MIPS only).
> +On PowerPC, this identifys the real platform; may differ from

    Identifies.

> +.BR AT_PLATFORM "."
> +On MIPS, this identifys the ISA level (Since 5.7).

    Same here.

[...]

MBR, Sergei
