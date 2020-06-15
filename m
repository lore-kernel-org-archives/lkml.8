Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E047CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6EE220707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZbaK4P3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbgFOSVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgFOSVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:21:11 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869AFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:21:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b16so8151468pfi.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LemJIWusSKTs9kB/F9oxsCC3XddFJYsF1dwWH4aB1F4=;
        b=ZbaK4P3Hx9xthr2Qfvlbkdn21ETo+ds9I8Li31Dtpx7O3FLtxpS3690+xjpgt3DD79
         mRJ48GsWFsGlU67p0rYiusy/1LL0XjM2GVe3HyodomQeWo9s2js49R5ttjUQX64iPbto
         wPVfxdeuz81MjY7bhV8ymnTDGXi82DjCqguEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LemJIWusSKTs9kB/F9oxsCC3XddFJYsF1dwWH4aB1F4=;
        b=jQWgTvX0FD+bAZMGke4Zk5kPofOfA7CYC/6fkmSj7OzET70pFsHG+KynqV5YB2Dube
         i3tEEBVoDIXV6dMXV46lws4t11f1Cx+wb9xWptfU5OSzBSZRnWxGFLTQSdCqyQq6jorw
         dPXrgFxrx0mGzXUPDwm/aOeKiZlpjilwXoVGnQ73Ie3QD+PQwGpoMkcyR5FZBSQQut6X
         qH0wI6nVil5Kran8q+qmOdONI1pzHLjV8Ecc+P0VsK1euPGGQ9vnWTPsm5ey7BX6sYur
         4xHCKJ8Ovph/jeL8LJtYYSK/ijUNgAwwPwonTyHJ2VtaCBtw5iX+BTRW70RvlhlPwg4r
         HZtA==
X-Gm-Message-State: AOAM5321bSlTg5IRh68LvS7TsjnIB2amKLcBpKdaAqmDVAreuEaD0yIg
        W6nfnE6GXdtK7aq0T2VLm4rACg==
X-Google-Smtp-Source: ABdhPJz1VWT1ICjKnxr7IKozb15LX6UR7WKJzLND1onLz9T6AYcDwKMPx1AX35yafQAuV3Qe5RH8fQ==
X-Received: by 2002:a63:ea02:: with SMTP id c2mr15929639pgi.66.1592245269889;
        Mon, 15 Jun 2020 11:21:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4sm181377pjm.55.2020.06.15.11.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 11:21:09 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:21:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>,
        James Morris <jamorris@linux.microsoft.com>
Cc:     David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] security: fix the key_permission LSM hook function type
Message-ID: <202006151113.7A2F638A7@keescook>
References: <20200615181232.119491-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615181232.119491-1-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:12:32AM -0700, Sami Tolvanen wrote:
> Commit 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather than
> a mask") changed the type of the key_permission callback functions, but
> didn't change the type of the hook, which trips indirect call checking with
> Control-Flow Integrity (CFI). This change fixes the issue by changing the
> hook type to match the functions.
> 
> Fixes: 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather than a mask")
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Thanks for fixing this!

Acked-by: Kees Cook <keescook@chromium.org>

I wonder if there is any compiler option we can turn on to catch the
implicit enum/int casting that would help for these kinds of things
without absolutely exploding the build warnings.

I see -Wenum-conversion, but that seems to be between enums, not between
int.

I see this, but it's external:
https://noamlewis.wordpress.com/2017/10/05/type-safe-enums-in-c-using-a-clang-plugin/

-Kees

> ---
>  include/linux/lsm_hook_defs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 6791813cd439..24f6683f1cfc 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -360,7 +360,7 @@ LSM_HOOK(int, 0, key_alloc, struct key *key, const struct cred *cred,
>  	 unsigned long flags)
>  LSM_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
>  LSM_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred *cred,
> -	 unsigned perm)
> +	 enum key_need_perm need_perm)
>  LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **_buffer)
>  #endif /* CONFIG_KEYS */
>  
> 
> base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
> -- 
> 2.27.0.290.gba653c62da-goog
> 

-- 
Kees Cook
