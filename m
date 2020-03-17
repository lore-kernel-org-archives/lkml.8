Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49026C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 20:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DA92073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 20:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jJwCjEtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCQUWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 16:22:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38004 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgCQUWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 16:22:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id x7so12346076pgh.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 13:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EAIJCbc9UnYGBhZAgTxjslTz10fA3gHJNpsPT5X0d/0=;
        b=jJwCjEtHgr13odNFCH9H9QGOK6qYtGJmi3Lff6ROgfMdrMnLhXjkrg29YHbzWopzmS
         02WMyKj3xIe8PhZaCZpLLVBE0XdXPKQtF/G5BDTxtU+8CD4Ixet9A3DgT/fPVZ7CrFBF
         rpsE+tU61HmBnrjEDwRzixtEsw65RA/HGhmhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EAIJCbc9UnYGBhZAgTxjslTz10fA3gHJNpsPT5X0d/0=;
        b=HeJrjFHcnl6+ywdQm8zs2Vywawl6epmo27U78B/fE3UDTUZyHxCu7pa2aP7utIX/0F
         5JPSlkhjAqmkuAIGgekzYYiqSlYOORqzCccbZErCavA4e9VjHFAOs4v4bhHtv95JFx+2
         jv8L5XXymXomcHKOoyhtCrh9DvP2O/uprroY83kbWoOtthCqJgJfy9aNJ3uODP9o4ibi
         xboSRUgfdhKHFibN+60wfWr/vCwBaTFa0IUWGAH4kFXe40B7DaDYuk0RMZqnZ5WnuQsk
         TfC7qvm6oaau350Pff5TDge5/BYNIHg032x5dLtDbca9Hd/YRknQYx1gCweK+0g+mmcS
         6bmg==
X-Gm-Message-State: ANhLgQ3xHqYRMvY6dkLpu3yQhd6Smvg2pah+2Yv5y12Q3k2Dm32UwSw0
        pQsReGjDpDHttLJlCJ9MIJyYOw==
X-Google-Smtp-Source: ADFU+vsgTPKpKOop85D3za3E34mi1V5jczJYrDVYLZp5wxLbhQu4/38ysB16lWDoiJeHKHqWdqEuEg==
X-Received: by 2002:a63:6944:: with SMTP id e65mr1017514pgc.406.1584476569477;
        Tue, 17 Mar 2020 13:22:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x189sm3965762pfb.1.2020.03.17.13.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 13:22:48 -0700 (PDT)
Date:   Tue, 17 Mar 2020 13:22:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, Tim.Bird@sony.com
Subject: Re: [PATCH v3 2/6] kselftest: factor out list manipulation to a
 helper
Message-ID: <202003171322.19433D7@keescook>
References: <20200316225647.3129354-1-kuba@kernel.org>
 <20200316225647.3129354-3-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316225647.3129354-3-kuba@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 03:56:42PM -0700, Jakub Kicinski wrote:
> Kees suggest to factor out the list append code to a macro,
> since following commits need it, which leads to code duplication.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/testing/selftests/kselftest_harness.h | 42 ++++++++++++---------
>  1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 5336b26506ab..aaf58fffc8f7 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -631,6 +631,29 @@
>  	} \
>  } while (0); OPTIONAL_HANDLER(_assert)
>  
> +/* List helpers */
> +#define __LIST_APPEND(head, item) \
> +{ \
> +	/* Circular linked list where only prev is circular. */ \
> +	if (head == NULL) { \
> +		head = item; \
> +		item->next = NULL; \
> +		item->prev = item; \
> +		return;	\
> +	} \
> +	if (__constructor_order == _CONSTRUCTOR_ORDER_FORWARD) { \
> +		item->next = NULL; \
> +		item->prev = head->prev; \
> +		item->prev->next = item; \
> +		head->prev = item; \
> +	} else { \
> +		item->next = head; \
> +		item->next->prev = item; \
> +		item->prev = item; \
> +		head = item; \
> +	} \
> +}
> +
>  /* Contains all the information for test execution and status checking. */
>  struct __test_metadata {
>  	const char *name;
> @@ -665,24 +688,7 @@ static int __constructor_order;
>  static inline void __register_test(struct __test_metadata *t)
>  {
>  	__test_count++;
> -	/* Circular linked list where only prev is circular. */
> -	if (__test_list == NULL) {
> -		__test_list = t;
> -		t->next = NULL;
> -		t->prev = t;
> -		return;
> -	}
> -	if (__constructor_order == _CONSTRUCTOR_ORDER_FORWARD) {
> -		t->next = NULL;
> -		t->prev = __test_list->prev;
> -		t->prev->next = t;
> -		__test_list->prev = t;
> -	} else {
> -		t->next = __test_list;
> -		t->next->prev = t;
> -		t->prev = t;
> -		__test_list = t;
> -	}
> +	__LIST_APPEND(__test_list, t);
>  }
>  
>  static inline int __bail(int for_realz, bool no_print, __u8 step)
> -- 
> 2.24.1
> 

-- 
Kees Cook
