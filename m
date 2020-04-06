Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602BEC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 04:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBAE2074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 04:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDsfwluE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDFEUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 00:20:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38549 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgDFEUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 00:20:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id w3so5412075plz.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 21:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/HcoQgZiE9Pv1rBqK3LLTaPK3g2aKD5HOOnSnhG2gxw=;
        b=ZDsfwluEmMK067gw+2Je0s0vfQ/XUsMaIRb9LDK9nvdEf14r3PGX9eLKtSlUEjmocE
         0ytImzDDo08wtYIVUCRhhJ8vMavngxXSZWLHgHfkpDdnxMt6tkS3xlXDcsQuSkMvKeDz
         1RxRTdhFXv3fYadf9MWoeGNHhkyJFAxB2yRyfXE7bZ0uz+G8WrH/yvm+pT8wEMiqAPxO
         r8SHij9QSvJMHT2L0hxirj24S1Fgyr364zW32utrka1wOA+0X6KKx/nXajpRwMo2Y5MZ
         ifRS2EbVjGtO3K+rkH8HAc8e8Hij2eNV7D0r1hbbvUNAvWQarM10kNMvLv04XWGUKgFr
         0MRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/HcoQgZiE9Pv1rBqK3LLTaPK3g2aKD5HOOnSnhG2gxw=;
        b=kPraSUwZTQqfDnh8UqQlEWaaP8XZ7/f4VbEN/ZvFdRKkDreSJg9ip9dF3HUBssR9sI
         2vyBP+1F9NZ91kHAcjD6zSWYZH+FfyQQ1ah5xyjUv3JX7vFWDEdzVEfZKWjn7ZsUMSVw
         Nue7PwH8WYZYMDGADc0wtnq0YhL4Vr2pWBZOxVeOpcOBhN3+IUu202jNHbAWs0JI+QH8
         VEsuvtVyuycnKkzIIo0P0wBAn91Jojbg9YSq3OmqywBRnKr92YZNDEWVMSdxZKtSCCIA
         3LMdwFf4WHtwIuE8OynGcaKhkD11F/RW+ptayYUBO2963ZmESfgDsj3bSByXIUBxMO/K
         Yb/w==
X-Gm-Message-State: AGi0PubwB1I2o31QoZwDranZH87AqXsShbrtwwKQZTThLlE66uE8N2Ye
        MYa5jzFxB+LQiuPvRIwfpF5rBg==
X-Google-Smtp-Source: APiQypL+DURskNXslDx34UEjspJ3/iPYy2jfCqgiYyc9DYTgtIKJNU3ptIh+yrVdsV9Wg8Ttv2kR6Q==
X-Received: by 2002:a17:90a:a484:: with SMTP id z4mr24579608pjp.77.1586146819733;
        Sun, 05 Apr 2020 21:20:19 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 198sm10616957pfa.87.2020.04.05.21.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 21:20:19 -0700 (PDT)
Date:   Sun, 5 Apr 2020 21:20:18 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Waiman Long <longman@redhat.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data
 objects
In-Reply-To: <20200406023700.1367-1-longman@redhat.com>
Message-ID: <alpine.DEB.2.21.2004052119530.243304@chino.kir.corp.google.com>
References: <20200406023700.1367-1-longman@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Apr 2020, Waiman Long wrote:

> For kvmalloc'ed data object that contains sensitive information like
> cryptographic key, we need to make sure that the buffer is always
> cleared before freeing it. Using memset() alone for buffer clearing may
> not provide certainty as the compiler may compile it away. To be sure,
> the special memzero_explicit() has to be used.
> 
> This patch introduces a new kvfree_sensitive() for freeing those
> sensitive data objects allocated by kvmalloc(). The relevnat places
> where kvfree_sensitive() can be used are modified to use it.
> 
> Fixes: 4f0882491a14 ("KEYS: Avoid false positive ENOMEM error on key read")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/mm.h       | 17 +++++++++++++++++
>  security/keys/internal.h | 11 -----------
>  security/keys/keyctl.c   | 16 +++++-----------
>  3 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7dd5c4ccbf85..c26f279f1956 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -758,6 +758,23 @@ static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
>  
>  extern void kvfree(const void *addr);
>  
> +/**
> + * kvfree_sensitive - free a data object containing sensitive information
> + * @addr - address of the data object to be freed
> + * @len  - length of the data object
> + *
> + * Use the special memzero_explicit() function to clear the content of a
> + * kvmalloc'ed object containing sensitive data to make sure that the
> + * compiler won't optimize out the data clearing.
> + */
> +static inline void kvfree_sensitive(const void *addr, size_t len)
> +{
> +	if (addr) {

Shouldn't this be if (unlikely(ZERO_OR_NULL_PTR(addr))?

> +		memzero_explicit((void *)addr, len);
> +		kvfree(addr);
> +	}
> +}
> +
>  static inline int compound_mapcount(struct page *page)
>  {
>  	VM_BUG_ON_PAGE(!PageCompound(page), page);
> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index 6d0ca48ae9a5..153d35c20d3d 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -350,15 +350,4 @@ static inline void key_check(const struct key *key)
>  #define key_check(key) do {} while(0)
>  
>  #endif
> -
> -/*
> - * Helper function to clear and free a kvmalloc'ed memory object.
> - */
> -static inline void __kvzfree(const void *addr, size_t len)
> -{
> -	if (addr) {
> -		memset((void *)addr, 0, len);
> -		kvfree(addr);
> -	}
> -}
>  #endif /* _INTERNAL_H */
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index 5e01192e222a..edde63a63007 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -142,10 +142,7 @@ SYSCALL_DEFINE5(add_key, const char __user *, _type,
>  
>  	key_ref_put(keyring_ref);
>   error3:
> -	if (payload) {
> -		memzero_explicit(payload, plen);
> -		kvfree(payload);
> -	}
> +	kvfree_sensitive(payload, plen);
>   error2:
>  	kfree(description);
>   error:
> @@ -360,7 +357,7 @@ long keyctl_update_key(key_serial_t id,
>  
>  	key_ref_put(key_ref);
>  error2:
> -	__kvzfree(payload, plen);
> +	kvfree_sensitive(payload, plen);
>  error:
>  	return ret;
>  }
> @@ -914,7 +911,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
>  		 */
>  		if (ret > key_data_len) {
>  			if (unlikely(key_data))
> -				__kvzfree(key_data, key_data_len);
> +				kvfree_sensitive(key_data, key_data_len);
>  			key_data_len = ret;
>  			continue;	/* Allocate buffer */
>  		}
> @@ -923,7 +920,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
>  			ret = -EFAULT;
>  		break;
>  	}
> -	__kvzfree(key_data, key_data_len);
> +	kvfree_sensitive(key_data, key_data_len);
>  
>  key_put_out:
>  	key_put(key);
> @@ -1225,10 +1222,7 @@ long keyctl_instantiate_key_common(key_serial_t id,
>  		keyctl_change_reqkey_auth(NULL);
>  
>  error2:
> -	if (payload) {
> -		memzero_explicit(payload, plen);
> -		kvfree(payload);
> -	}
> +	kvfree_sensitive(payload, plen);
>  error:
>  	return ret;
>  }
> -- 
> 2.18.1
> 
> 
> 
