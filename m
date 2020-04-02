Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1606EC10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82A620719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NEr/HOuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbgDBHzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:55:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41420 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgDBHzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:55:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id b1so1474888pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cNKPt9zws6tETOtG4clSFgvYQggRaWY4PbOPgRy3R/Q=;
        b=NEr/HOuFOs50bDB/L0pQZVsoQ+Nyg7UDyLD4S8+MDPajx7NSq21pauFLuu8fuuS5HT
         dA7TbZA2aW9xfHzx8uCcccW9e7W+yaqO5sU6kFMZUqI2AY+iLus6FD4e+eesLB4+PTnk
         oebi07I1vQWsVfSymxAqSpu68Tvq2bSlWm8+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cNKPt9zws6tETOtG4clSFgvYQggRaWY4PbOPgRy3R/Q=;
        b=qJlFMjdkxDTBmjvC4YipAskKH3pvyxWmfAOlA4D0fbhcpp/OB2Uel72cxeY6voZGZF
         zsV0ypKZv+mRZLvKDbiZanpN3/CrTgXHgE8fFgNTynf2ifvzbdHmHeJ2ZL6xg9/MhaET
         rHCfe689frwjHfhmaEqRDxRHKa4YwtB0N12mXRa2smd6RWPbWY4BmYpKwl/dJ9D3bdwS
         SJ+3cpWPmfjVruTU7DOcuJ4jKnI89EQYWmvA5Gl2Bbc/RW/srHhJFKrJsNLTYJxABaFK
         bt20LvWr66wRf7iaExT7Var13xlf4FDdgX8Fc1Fy2H2f2qSZNVHw8xEptuSC9xYmKSuQ
         hvFQ==
X-Gm-Message-State: AGi0PubK4qIKgwRiAczPPLTtsS4ML/bmJQky5JH9k7kHOOUO0GBtNgWI
        LvtUHkXXwpfUpSf06VGEJNiBPQ==
X-Google-Smtp-Source: APiQypLB2ZurOAtjAAZY1rw1Oc9/IReJTqNfIyojiVL6ct3p3zeLZXi1W1njrDdywOR0TVbU9jwgMA==
X-Received: by 2002:a62:1c4c:: with SMTP id c73mr1880326pfc.64.1585814134808;
        Thu, 02 Apr 2020 00:55:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u21sm3185973pjy.8.2020.04.02.00.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 00:55:34 -0700 (PDT)
Date:   Thu, 2 Apr 2020 00:46:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie,
        daniel@ffwll.ch, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
Message-ID: <202004020046.96A2D21F@keescook>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 07:34:16AM +0000, Christophe Leroy wrote:
> Some architectures like powerpc64 have the capability to separate
> read access and write access protection.
> For get_user() and copy_from_user(), powerpc64 only open read access.
> For put_user() and copy_to_user(), powerpc64 only open write access.
> But when using unsafe_get_user() or unsafe_put_user(),
> user_access_begin open both read and write.
> 
> Other architectures like powerpc book3s 32 bits only allow write
> access protection. And on this architecture protection is an heavy
> operation as it requires locking/unlocking per segment of 256Mbytes.
> On those architecture it is therefore desirable to do the unlocking
> only for write access. (Note that book3s/32 ranges from very old
> powermac from the 90's with powerpc 601 processor, till modern
> ADSL boxes with PowerQuicc II modern processors for instance so it
> is still worth considering)
> 
> In order to avoid any risk based of hacking some variable parameters
> passed to user_access_begin/end that would allow hacking and
> leaving user access open or opening too much, it is preferable to
> use dedicated static functions that can't be overridden.
> 
> Add a user_read_access_begin and user_read_access_end to only open
> read access.
> 
> Add a user_write_access_begin and user_write_access_end to only open
> write access.
> 
> By default, when undefined, those new access helpers default on the
> existing user_access_begin and user_access_end.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Link: https://patchwork.ozlabs.org/patch/1227926/
> ---
> Resending this series as I mistakenly only sent it to powerpc list
> begining of February (https://patchwork.ozlabs.org/patch/1233172/)
> 
> This series is based on the discussion we had in January, see
> https://patchwork.ozlabs.org/patch/1227926/ . I tried to
> take into account all remarks, especially @hpa 's remark to use
> a fixed API on not base the relocking on a magic id returned at
> unlocking.
> 
> This series is awaited for implementing selective lkdtm test to
> test powerpc64 independant read and write protection, see
> https://patchwork.ozlabs.org/patch/1231765/
> 
>  include/linux/uaccess.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 67f016010aad..9861c89f93be 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -378,6 +378,14 @@ extern long strnlen_unsafe_user(const void __user *unsafe_addr, long count);
>  static inline unsigned long user_access_save(void) { return 0UL; }
>  static inline void user_access_restore(unsigned long flags) { }
>  #endif
> +#ifndef user_write_access_begin
> +#define user_write_access_begin user_access_begin
> +#define user_write_access_end user_access_end
> +#endif
> +#ifndef user_read_access_begin
> +#define user_read_access_begin user_access_begin
> +#define user_read_access_end user_access_end
> +#endif
>  
>  #ifdef CONFIG_HARDENED_USERCOPY
>  void usercopy_warn(const char *name, const char *detail, bool to_user,
> -- 
> 2.25.0
> 

-- 
Kees Cook
