Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F60C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8F32072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaYvlAi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgBXMeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:34:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36746 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXMeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:34:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so10196102wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 04:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YsyHMGLT1kWo5YixySq4Ncge1TA1bP8HOjZ5/uDC2V0=;
        b=WaYvlAi+1e/82tblH+OGfN5A+rBla6IK9WHA5RFJiR2hBxk8FRuKxcLNKXexgy1Fze
         TxRITbfKr1g956AdE0Bcq2q8AwU94UBiXw7o7Ttm3E0+qTp0tWQBr5qzYtltAbP10Gwc
         vSiCdPLlI/5prvJN/VSvJhXLofpnrZ/qB+ORo2CMdzCNtfvgJuOISqHAnjobsLLhw5QY
         U7TjL24cqDZwpnMBcuN4Vzs9vddw6dRqdA2UgCvQvvKWemWlqY5/WfNTQ7DV9yCDVDUL
         n8y4t7tyoWWJ3G0qCYQMexeknuPeWJBT1jHclUW75Cl+vj0gXkZ637aVAGBz62WlZA0v
         rHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YsyHMGLT1kWo5YixySq4Ncge1TA1bP8HOjZ5/uDC2V0=;
        b=g4xtfSq7UDd31yahRe/plgu//BCNk4wcImzQ/TZRZbCDyAhsYF5ZjErvmJFfJWhOVz
         T0VID+ECY9F+u1saC7+ck4HLg/YjDvjPtpRMOXCjV/Tg0cfTtSjtoJqQ6R+4BD8tBh5s
         Jnc94DN43PxHtcE+3f5JZltc7xG2G5qmm3zvOsrPxMThaqjexNFxp/PgIRI4VcSg2nI6
         v1dGYHh2IzoB2CjQHVVZ2kaCD6HARlJOVovm1ZHxJj/C6Wy6hrXWPTn5UoKaZhAkpSi+
         4KLuEiJW6oC1fc/Qkaz5go7Vjpsi3u5S2/DZ7wE0/GoLU9SgROPIBMIABf/YO0UnrUMp
         IzPQ==
X-Gm-Message-State: APjAAAXMhQp/W6inBvqlp/a9aEolkp7NlAl6yGHxAxHGh3ofjk9jipjb
        PlZbxw23bMTbxyCYg/iHshJiZcIs5l8=
X-Google-Smtp-Source: APXvYqw4B2ZyNX7HQsew9G7peWOh/KR3gX7BaGUMh/dFyOA2I7XsjQo17MQ5v7RrSzaCXLLJTINLbw==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr65761060wru.353.1582547654858;
        Mon, 24 Feb 2020 04:34:14 -0800 (PST)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id z6sm19032323wrs.96.2020.02.24.04.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 04:34:14 -0800 (PST)
Date:   Mon, 24 Feb 2020 12:34:12 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ppdev: Distribute switch variables for initialization
Message-ID: <20200224123412.bo6e5yfjtinqzhle@debian>
References: <20200220062311.69121-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200220062311.69121-1-keescook@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:23:11PM -0800, Kees Cook wrote:
> Variables declared in a switch statement before any case statements
> cannot be automatically initialized with compiler instrumentation (as
> they are not part of any execution flow). With GCC's proposed automatic
> stack variable initialization feature, this triggers a warning (and they
> don't get initialized). Clang's automatic stack variable initialization
> (via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
> doesn't initialize such variables[1]. Note that these warnings (or silent
> skipping) happen before the dead-store elimination optimization phase,
> so even when the automatic initializations are later elided in favor of
> direct initializations, the warnings remain.
> 
> To avoid these problems, move such variables into the "case" where
> they're used or lift them up into the main function body.
> 
> drivers/char/ppdev.c: In function ‘pp_do_ioctl’:
> drivers/char/ppdev.c:516:25: warning: statement will never be executed [-Wswitch-unreachable]
>   516 |   struct ieee1284_info *info;
>       |                         ^~~~
> 
> [1] https://bugs.llvm.org/show_bug.cgi?id=44916
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Greg, Can you please take it in your tree...

--
Regards
Sudip
