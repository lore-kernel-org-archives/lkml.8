Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C20C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B47B82082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587567260;
	bh=q1QpVW6R7DMlsVtoi6fRF4m0TaPDKuXFC4jOXuBXoD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K9XB9eWyVeTTDQOzmh4k/6//eSwVOT/XMXie9+4L1btMRtv+VmmOXyyQpiRv1/ACP
	 0Ksj+uK/pwjeYnbxqJrffjHkY2e/1VicGmAq7vjn093z7RduHtdDXXBV29MrpqoONU
	 9npfH5i9PE52jTKXvLemFGIPf5KXpZZW9qesGgKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgDVOyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgDVOyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:54:19 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC2C12076E;
        Wed, 22 Apr 2020 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587567259;
        bh=q1QpVW6R7DMlsVtoi6fRF4m0TaPDKuXFC4jOXuBXoD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z5MysEaWg9+tyCG9nVbar+7g34DLzyfJ3nI6H/b2OkRe/Xa85WxmFmFixOkCA6Nbo
         fYPqv5oxT6HRJSEzSK8devspKpRevMzpxn2Z0rhv1O5StFK0PHnCiPij0LxuHvLgWB
         I+EjvieYE0IsgZqZ4bEdZA5Qr1dd/FTO1t6lO/jc=
Date:   Wed, 22 Apr 2020 15:54:13 +0100
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v4 08/11] READ_ONCE: Drop pointer qualifiers when reading
 from scalar types
Message-ID: <20200422145412.GD676@willie-the-truck>
References: <20200421151537.19241-1-will@kernel.org>
 <20200421151537.19241-9-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421151537.19241-9-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 04:15:34PM +0100, Will Deacon wrote:
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index e970f97a7fcb..233066c92f6f 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -210,6 +210,27 @@ struct ftrace_likely_data {
>  /* Are two types/vars the same type (ignoring qualifiers)? */
>  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>  
> +/*
> + * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
> + *			       non-scalar types unchanged.
> + *
> + * We build this out of a couple of helper macros in a vain attempt to
> + * help you keep your lunch down while reading it.
> + */
> +#define __pick_scalar_type(x, type, otherwise)					\
> +	__builtin_choose_expr(__same_type(x, type), (type)0, otherwise)
> +
> +#define __pick_integer_type(x, type, otherwise)					\
> +	__pick_scalar_type(x, unsigned type,					\
> +		__pick_scalar_type(x, signed type, otherwise))
> +
> +#define __unqual_scalar_typeof(x) typeof(					\
> +	__pick_integer_type(x, char,						\

Rasmus pointed out to me that 'char' is not __builtin_types_compatible_p()
with either 'signed char' or 'unsigned char', so I'll roll in the diff below
to handle this case.

Will

--->8

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 233066c92f6f..6ed0612bc143 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -220,9 +220,14 @@ struct ftrace_likely_data {
 #define __pick_scalar_type(x, type, otherwise)					\
 	__builtin_choose_expr(__same_type(x, type), (type)0, otherwise)
 
+/*
+ * 'char' is not type-compatible with either 'signed char' or 'unsigned char',
+ * so we include the naked type here as well as the signed/unsigned variants.
+ */
 #define __pick_integer_type(x, type, otherwise)					\
-	__pick_scalar_type(x, unsigned type,					\
-		__pick_scalar_type(x, signed type, otherwise))
+	__pick_scalar_type(x, type,						\
+		__pick_scalar_type(x, unsigned type,				\
+			__pick_scalar_type(x, signed type, otherwise)))
 
 #define __unqual_scalar_typeof(x) typeof(					\
 	__pick_integer_type(x, char,						\
