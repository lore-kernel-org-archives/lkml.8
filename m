Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0218EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE942075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eab3V0ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgESSVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgESSVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:21:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AAAC08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:21:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n18so298301pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q5UHC553rY05IEMbXCgL1ZU4LhfKGIJXOMI9F65WCM0=;
        b=Eab3V0aeJWywuatvac89Xj4XfyMtuFx+KgHTWt/TJ0ol7YVVNUJR29bRRwtmUXTfNv
         TJanh8oN4Dslf95TZKpQ7qOUzyj/NLKttxV/yLvC5qRMUVUm1q23QwzohNMEBsTQIMPe
         5G/981yXHcsvGBAwRdLh/CFiEL2sWB7oDcJDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q5UHC553rY05IEMbXCgL1ZU4LhfKGIJXOMI9F65WCM0=;
        b=WkEJ9wzusdr/YML6oNYn+5rkS2GeGDatDDinuqdhbP8oGQuJ3fPNz542uvyfaBDi71
         6iTpprJTTMJt+tVn+sBgmrnOyy6nmMiuVWRBdh6cM9V4n/s2Rds9+/nEOWj6YYQZZ2I2
         6nLofkknCN/9UUCHkIVJdykCpIpX4S9QFV4dVfUa34Vj+pMj0pWuxJFO9KRCdVMCvwJL
         qEkBJk8I4BI7GSbk0Ic8zPWEMi006Iku8AcCddjFslLKZ1sP8TNmuEEUAdFYVZlv6xEq
         YassfoYXTlObG9S18DvHEkRhHYIDB1BDhNuzh0YjZE9zhhv+KA3Urr0slOaWBbEGQUCh
         vo3Q==
X-Gm-Message-State: AOAM532ZFTJZ2xnR88jrTHO5kLTkGDQJrdQq9fT1KAIo/mYk9a+51Vc/
        O8bhzSf0OSoynVhRsA12kc3RfmcF2h2Wjg==
X-Google-Smtp-Source: ABdhPJzynbql9pKULdgukQFTy4Z4t7DJQ/sjiUfpzwdYxlnUTNW41tR9eCeNK8c47FummadelJ5jQw==
X-Received: by 2002:a63:1451:: with SMTP id 17mr472860pgu.242.1589912496698;
        Tue, 19 May 2020 11:21:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d184sm147336pfc.130.2020.05.19.11.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:21:35 -0700 (PDT)
Date:   Tue, 19 May 2020 11:21:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 3/8] exec: Convert security_bprm_set_creds into
 security_bprm_repopulate_creds
Message-ID: <202005191111.9B389D33@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87o8qkzrxp.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8qkzrxp.fsf_-_@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 07:31:14PM -0500, Eric W. Biederman wrote:
> 
> Rename bprm->cap_elevated to bprm->active_secureexec and initialize it
> in prepare_binprm instead of in cap_bprm_set_creds.  Initializing
> bprm->active_secureexec in prepare_binprm allows multiple
> implementations of security_bprm_repopulate_creds to play nicely with
> each other.
> 
> Rename security_bprm_set_creds to security_bprm_reopulate_creds to
> emphasize that this path recomputes part of bprm->cred.  This
> recomputation avoids the time of check vs time of use problems that
> are inherent in unix #! interpreters.
> 
> In short two renames and a move in the location of initializing
> bprm->active_secureexec.

I like this much better than the direct call to the capabilities hook.
Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

One nit is a bikeshed on the name "active_secureexec", since
the word "active" isn't really associated with any other part of the
binfmt logic. It's supposed to be "latest state from the binfmt loop",
so instead of "active", I considered these words that I also didn't
like: "current", "this", "recent", and "now". Is "latest" better than
"active"? Probably not.

> [...]
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index d1217fcdedea..8605ab4a0f89 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -27,10 +27,10 @@ struct linux_binprm {
>  	unsigned long argmin; /* rlimit marker for copy_strings() */
>  	unsigned int
>  		/*
> -		 * True if most recent call to cap_bprm_set_creds
> +		 * True if most recent call to security_bprm_set_creds
>  		 * resulted in elevated privileges.
>  		 */
> -		cap_elevated:1,
> +		active_secureexec:1,

Also, I'd like it if this comment could be made more verbose as well, for
anyone trying to understand the binfmt execution flow for the first time.
Perhaps:

		/*
		 * Must be set True during the any call to
		 * bprm_set_creds hook where the execution would
		 * reuslt in elevated privileges. (The hook can be
		 * called multiple times during nested interpreter
		 * resolution across binfmt_script, binfmt_misc, etc).
		 */


-- 
Kees Cook
