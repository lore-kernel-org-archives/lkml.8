Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E500C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 05:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F213C24825
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 05:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J5tY3LO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgFUFzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 01:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgFUFzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 01:55:02 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF24C061794
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 22:55:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k1so6046791pls.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 22:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fp1yhxbUQVqGMjbtesUXXr7LQLSJ1BhmPsusmU+xy/c=;
        b=J5tY3LO6Q+K3Xld9I1MMGINGYQQtP3oFF0WuvhPIJGtZNAO3zi/n7/8kTC9Jj5ACPD
         o2+KUl223iSMQSw3AsD8j6AN5QWVHAeKwZreoRQYddt5mgfyyspWosNDG7k8tXlNiwST
         mTNCUnlbs3AXMdHCijBSGXVjYYzrKSMcJo0wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fp1yhxbUQVqGMjbtesUXXr7LQLSJ1BhmPsusmU+xy/c=;
        b=XqkSOcfKCbMPabl+B/4n+t3G68cI58j1Gwl29C5uNmAz/4q/XHKV5tJ5FY3tAALRN4
         l51JgRvhlefvUm3QKWZ1dIA3YVT5OhZbfFu5q4a/YFMVXQRHz2anRhqikmPJUpUsBs0b
         nuDVlAgF3GQXW44aFbBJq7se+O5LME3r/cLXClERYCrdLtPW+ZmCO14C/bhHVs+FSMBG
         zpEviMPVnUop2JYnH8kI3lXj1hXHYT0Hl9H3hHjgUsUeZu34nZwrHPQ7GiDIAkBD19G3
         /6x0Gry8TGFodc8RU6QHy5NqmMVx6wcUvcr3ZonazpZJN9782hTyN2OCdV7+I19ia2GH
         HZew==
X-Gm-Message-State: AOAM530slOZ5EcOfYz10PBlempJybxKk8EcHEb7nnmoUgvl6agGMqYc0
        /XBP2JGImYbMfADviZ5b8jrr/w==
X-Google-Smtp-Source: ABdhPJxvY4OVyl0lv5X8JtsLexFws1cbb/KusaHRuHvTB/gyhAyGf8e964DzPZMjfhI4Lba3++6Fsw==
X-Received: by 2002:a17:902:6b45:: with SMTP id g5mr5675575plt.3.1592718901055;
        Sat, 20 Jun 2020 22:55:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i5sm9762730pjd.23.2020.06.20.22.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 22:55:00 -0700 (PDT)
Date:   Sat, 20 Jun 2020 22:54:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: fix the key_permission LSM hook function type
Message-ID: <202006202254.D6B60F2@keescook>
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

David, James? Can someone please take this?

-- 
Kees Cook
