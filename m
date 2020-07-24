Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29986C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 02:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9DB8206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 02:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAoD8qC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgGXCML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 22:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgGXCML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 22:12:11 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3796C0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 19:12:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mn17so4330170pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 19:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n1r9gs/1oOlKdtxJmiDpQ0ejqypIDVtgS1hLMNr7XyI=;
        b=HAoD8qC1Rru49WhhH5abOrYnmKvKiPuolGMKLb/kh+ixiZjKcOOrrkFLKoyu3r39GR
         yjwQiqKDaCcY8SGNlkcizpsJuY4Ty09FvNBlfok+TMbg4wvjakp1jzNAGKZ0OUwCXcEF
         Tn0AfJwHFUaUIGb1gGCM03YxcgLHSshfVijhhbpw/kni6bQ0PscDTFyaTbls2AD6zFE2
         +nsB/rTcJXcfjI2yC26W5/C0SA7nAXEB9fBpJiSrtyzUvMRTw2cRcO8vPrxg8Dl0JIkV
         nvJ2gvAjcjjLaRcrewRt1OKu0Jp5E75Dbl8XodiGW6/aXj71fCMFW9j7wixjq3XjqKw2
         yFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=n1r9gs/1oOlKdtxJmiDpQ0ejqypIDVtgS1hLMNr7XyI=;
        b=lxVySPOuKW6Ua8rZZ0pYhz7MACMkGnK/NDL1RPHPMxK3uMWTakKcTmBot9kD9uIu2M
         E8jqzd0TUkDGGKPSY6bTbcR+HgT0T/H39RrhCDnDrmiDFOIuxFKkhneiq2pjBr0IBC0k
         FwqHEyabZMUY7cVDOiyH0/3Zg4VvySWwg+y/V/WvV3Yy3XpqlWr6PpDbUm/PXdxaan8r
         sizk6aaP5B1BlbUCvW3a6/e/B2wx53k0c/Arm6nYuy8ZSUrUGSQML4xb64xLf12d1R3t
         KvyEuXGzBuhrUCCDZScY8II0ceVuqNdGWbdWP8R3JZ7hJiS7kBu0SUQque6wy9hVBQQF
         AhKA==
X-Gm-Message-State: AOAM530UNX4rtJd+UE2HbJ5qg4ZjCCLDAdteN9dlqm57GPjKZTPtYLj2
        0LMKtFqRZPZTdzYNzSsQKEq3YyB2
X-Google-Smtp-Source: ABdhPJxI/WrRBGDgLWWPSdgHmmN603cHfLbNzjXrX+kZOrUJj5NTE11kEjLkQh7IKDO++uTHmMHh9w==
X-Received: by 2002:a17:902:a713:: with SMTP id w19mr6385711plq.146.1595556730582;
        Thu, 23 Jul 2020 19:12:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t137sm4553440pgc.32.2020.07.23.19.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 19:12:10 -0700 (PDT)
Subject: Re: [PATCH 2/2] lib/test_lockup.c: Fix return value of
 test_lockup_init()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
References: <1595555407-29875-1-git-send-email-yangtiezhu@loongson.cn>
 <1595555407-29875-2-git-send-email-yangtiezhu@loongson.cn>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <6916d710-9cfb-bea5-9464-4c2d8aa140f2@roeck-us.net>
Date:   Thu, 23 Jul 2020 19:12:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595555407-29875-2-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/20 6:50 PM, Tiezhu Yang wrote:
> Since filp_open() returns an error pointer, we should use IS_ERR() to
> check the return value and then return PTR_ERR() if failed to get the
> actual return value instead of always -EINVAL.
> 
> E.g. without this patch:
> 
> [root@localhost loongson]# ls no_such_file
> ls: cannot access no_such_file: No such file or directory
> [root@localhost loongson]# modprobe test_lockup file_path=no_such_file lock_sb_umount time_secs=60 state=S
> modprobe: ERROR: could not insert 'test_lockup': Invalid argument
> [root@localhost loongson]# dmesg | tail -1
> [  126.100596] test_lockup: cannot find file_path
> 
> With this patch:
> 
> [root@localhost loongson]# ls no_such_file
> ls: cannot access no_such_file: No such file or directory
> [root@localhost loongson]# modprobe test_lockup file_path=no_such_file lock_sb_umount time_secs=60 state=S
> modprobe: ERROR: could not insert 'test_lockup': Unknown symbol in module, or unknown parameter (see dmesg)
> [root@localhost loongson]# dmesg | tail -1
> [   95.134362] test_lockup: failed to open no_such_file: -2
> 
> Fixes: aecd42df6d39 ("lib/test_lockup.c: add parameters for locking generic vfs locks")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  lib/test_lockup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/test_lockup.c b/lib/test_lockup.c
> index bd7c7ff..e720276 100644
> --- a/lib/test_lockup.c
> +++ b/lib/test_lockup.c
> @@ -512,8 +512,8 @@ static int __init test_lockup_init(void)
>  	if (test_file_path[0]) {
>  		test_file = filp_open(test_file_path, O_RDONLY, 0);
>  		if (IS_ERR(test_file)) {
> -			pr_err("cannot find file_path\n");
> -			return -EINVAL;
> +			pr_err("failed to open %s: %ld\n", test_file_path, PTR_ERR(test_file));
> +			return PTR_ERR(test_file);
>  		}
>  		test_inode = file_inode(test_file);
>  	} else if (test_lock_inode ||
> 

