Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68836C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414CA20709
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/VxyHE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbgGULGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgGULGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:06:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD011C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:06:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so2451089wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JitW8E/Uo2q1CMw7tRyORpusuSv9wng9iRv55mMDpbM=;
        b=B/VxyHE+rLfsoKJ8ka63SleoGdHvpRkyF3TPlMJr4lQ3bV1Un3j33BBXD/2PQvMEvF
         VQj56ZmISMzBYley/bDL40+gWhW5KSsNGMgAxmcw+jTW3Y3CewGYuPQH0q1Y7X3UDNRP
         eSfy33KTK0oULpx1QABgxb5wtSO0MlOGLe7A51hs/KSTr0zR1gyfmDNsT5pSUDhXuZaX
         VYsGbyMAcx0pu0nVfVlVy2A66G4XjAszNXvMiPKvx21XUS+sNQ8P16nS1Ki1XU+tTOzh
         CBB/upgPpAYQ/WpX5QUtMK5NakqgbXHyzMlWFTYT1si0PrDgDmHsDSkm1ifuEQpiU+cD
         caIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JitW8E/Uo2q1CMw7tRyORpusuSv9wng9iRv55mMDpbM=;
        b=i4zrnPQG7I/LanyZ3alZIwJKklZ55aSZwnU5t9lSvCUz8zbl8y0JUqJZGjVEufITIl
         0erQSX/1tPQodg6yk423q05G3QgCuZD0OACC9Sv3T0eo+aJF7pOXyrnh9Mq403tXMtTj
         4FSIqCiCsvy1q+k5VrmTPcqyfQx6IT7tcJ/qBZZM0iZ4gt3JM+6L5wg5zVJP9llYT6BG
         WH6nMjI3sKhbIw5wiCDEfqVjiu1ZF9xPXQXWyLMynMXgVOSN5bXT//fEwndrw21gB3vX
         gwO6fUTTlR36+vunhrh1ozRih8GnpN+W6iDA4n4k81aSOOMtQymqZCp9nSFNvYLndibL
         EqTA==
X-Gm-Message-State: AOAM531ndQVdWSZaDSHAyI6Am2xjk73U5RZPQF/qCHNl7Qv8UB7yTjjJ
        voagMTQpCpcusHGL2ZVOn0XpjQ==
X-Google-Smtp-Source: ABdhPJxQdglCU5W1O7rWIMy+ncr+WI4GmlDvpZQNlWXa/gjqC53IcptHZ0EoFkv8bXMa7IDxZX+0nA==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr3478083wmk.175.1595329568258;
        Tue, 21 Jul 2020 04:06:08 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id s8sm37009753wru.38.2020.07.21.04.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 04:06:07 -0700 (PDT)
Date:   Tue, 21 Jul 2020 13:06:02 +0200
From:   Marco Elver <elver@google.com>
To:     paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 5/8] kcsan: Test support for compound instrumentation
Message-ID: <20200721110602.GA3311326@elver.google.com>
References: <20200721103016.3287832-1-elver@google.com>
 <20200721103016.3287832-6-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721103016.3287832-6-elver@google.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 12:30PM +0200, Marco Elver wrote:
[...]
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index 3d282d51849b..cde5b62b0a01 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -40,6 +40,11 @@ menuconfig KCSAN
>  
>  if KCSAN
>  
> +# Compiler capabilities that should not fail the test if they are unavailable.
> +config CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE
> +	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-compound-read-before-write=1)) || \
> +		 (CC_IS_GCC && $(cc-option,-fsanitize=thread --param -tsan-compound-read-before-write=1))
> +
>  config KCSAN_VERBOSE
>  	bool "Show verbose reports with more information about system state"
>  	depends on PROVE_LOCKING

Ah, darn, one too many '-' on the CC_IS_GCC line.

	s/--param -tsan/--param tsan/

Below is what this chunk should have been. Not
that it matters right now, because GCC doesn't have this option
(although I hope it gains it eventually).

Paul, if you prefer v2 of the series with the fix, please let me know.
(In case there aren't more things to fix.)

Thanks,
-- Marco

------ >8 ------

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 3d282d51849b..f271ff5fbb5a 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -40,6 +40,11 @@ menuconfig KCSAN
 
 if KCSAN
 
+# Compiler capabilities that should not fail the test if they are unavailable.
+config CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE
+	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-compound-read-before-write=1)) || \
+		 (CC_IS_GCC && $(cc-option,-fsanitize=thread --param tsan-compound-read-before-write=1))
+
 config KCSAN_VERBOSE
 	bool "Show verbose reports with more information about system state"
 	depends on PROVE_LOCKING
