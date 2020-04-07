Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D278C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7DF20730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U0uX9mwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDGQpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:45:46 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33418 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgDGQpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:45:45 -0400
Received: by mail-pj1-f67.google.com with SMTP id cp9so1298872pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=m+hJokxaXXSZ8OwwEQfbCXMH/+uV7ncsulhI4Dexs6k=;
        b=U0uX9mwgjZ8Z7tvVVlcqWOg8SqCB2gnRkzslTEmDZ2qjc4Ms9ZkcKriL3MCXNV5wlb
         JMIpyAOgV9tKJOztaHKDFdSTlVqulrb8AjqCkSsq9GY1pBqmpULE6Uwx2usNj6g1vTYC
         8KdddIU5TGWH5T+OAxoPfNwHn3xQN2hJ0sNd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=m+hJokxaXXSZ8OwwEQfbCXMH/+uV7ncsulhI4Dexs6k=;
        b=FUxojbNvFY+i7D84W3VH8aQMmbQ/4mema+g1ny07dYduLrYdB9N5DAtIB3TZ2tgbRI
         VcWwFjxJEc1SsgzmA45ay0LjL6iBCVLwIenv8S25RBpnwhO5jaQVeBwX1bURcvD0zdpV
         pPbmd2sRgc7aRNSnVdOTW+dKr/qJI9HAO67Xd14IsdKFv2otQsd+Eue3QOR+4cEHBc1z
         umcYAXf4Sd6ps4u8yBslzUsS+/Fihg4bJHn8uiwAhXir501Mw5f0e0vsiyvUX7Z8EQuz
         k4tzuLEhsy+QduXSi89Gd/sBPOyunS74MRQeV6Rha5JJuSD4lUboVPzp3JggExSUY+Ea
         oOVg==
X-Gm-Message-State: AGi0PuaAj6yTpFHjsEKJDsPDDYqIaYIVYrO6vzZCtMF0Nc7Mur0qPbwi
        WTlN5TrF7H67tAToDu6OSPnkV3zY0vk=
X-Google-Smtp-Source: APiQypKW/Q8EwN9hhHyu+fZCl8T2W6FOcwUK5arUv+dyXqzBZ4dh7vIeqvQxlUsMtsmsd9A+WR3UNw==
X-Received: by 2002:a17:90a:30c3:: with SMTP id h61mr270738pjb.18.1586277944571;
        Tue, 07 Apr 2020 09:45:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v4sm14439233pfb.31.2020.04.07.09.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 09:45:43 -0700 (PDT)
Date:   Tue, 7 Apr 2020 09:45:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Fr=E9d=E9ric_Pierret_=28fepitre=29?= 
        <frederic.pierret@qubes-os.org>
Cc:     re.emese@gmail.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-common.h: 'params.h' has been dropped in GCC10
Message-ID: <202004070945.D6E095F7@keescook>
References: <20200407113259.270172-1-frederic.pierret@qubes-os.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200407113259.270172-1-frederic.pierret@qubes-os.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 01:32:59PM +0200, Frédéric Pierret (fepitre) wrote:
> Moreover, GCC10 complains about gimple definition. For example,
> doing a 'scripts/gcc-plugin.sh g++ g++ gcc' returns:
> 
> In file included from <stdin>:1:
> ./gcc-plugins/gcc-common.h:852:13: error: redefinition of ‘static bool is_a_helper<T>::test(U*) [with U = const gimple; T = const ggoto*]’
>   852 | inline bool is_a_helper<const ggoto *>::test(const_gimple gs)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ./gcc-plugins/gcc-common.h:125,
>                  from <stdin>:1:
> /usr/lib/gcc/x86_64-redhat-linux/10/plugin/include/gimple.h:1037:1: note: ‘static bool is_a_helper<T>::test(U*) [with U = const gimple; T = const ggoto*]’ previously declared here
>  1037 | is_a_helper <const ggoto *>::test (const gimple *gs)
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from <stdin>:1:
> ./gcc-plugins/gcc-common.h:859:13: error: redefinition of ‘static bool is_a_helper<T>::test(U*) [with U = const gimple; T = const greturn*]’
>   859 | inline bool is_a_helper<const greturn *>::test(const_gimple gs)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ./gcc-plugins/gcc-common.h:125,
>                  from <stdin>:1:
> /usr/lib/gcc/x86_64-redhat-linux/10/plugin/include/gimple.h:1489:1: note: ‘static bool is_a_helper<T>::test(U*) [with U = const gimple; T = const greturn*]’ previously declared here
>  1489 | is_a_helper <const greturn *>::test (const gimple *gs)
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> A hacky way for solving this is to ignore them for GCC10.

Hi! Thanks for the patch. I don't think this is a hack: it's the right
thing to do here, yes? GCC 10 includes this helper in gimple.h, so we
can ifdef it out in gcc-common.h.

-Kees

> 
> Signed-off-by: Frédéric Pierret (fepitre) <frederic.pierret@qubes-os.org>
> ---
>  scripts/gcc-plugins/gcc-common.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
> index 17f06079a712..9ad76b7f3f10 100644
> --- a/scripts/gcc-plugins/gcc-common.h
> +++ b/scripts/gcc-plugins/gcc-common.h
> @@ -35,7 +35,9 @@
>  #include "ggc.h"
>  #include "timevar.h"
>  
> +#if BUILDING_GCC_VERSION < 10000
>  #include "params.h"
> +#endif
>  
>  #if BUILDING_GCC_VERSION <= 4009
>  #include "pointer-set.h"
> @@ -847,6 +849,7 @@ static inline gimple gimple_build_assign_with_ops(enum tree_code subcode, tree l
>  	return gimple_build_assign(lhs, subcode, op1, op2 PASS_MEM_STAT);
>  }
>  
> +#if BUILDING_GCC_VERSION < 10000
>  template <>
>  template <>
>  inline bool is_a_helper<const ggoto *>::test(const_gimple gs)
> @@ -860,6 +863,7 @@ inline bool is_a_helper<const greturn *>::test(const_gimple gs)
>  {
>  	return gs->code == GIMPLE_RETURN;
>  }
> +#endif
>  
>  static inline gasm *as_a_gasm(gimple stmt)
>  {
> -- 
> 2.25.2
> 
> 

-- 
Kees Cook
