Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6197C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6F821D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l9ylsw/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgCJQDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:03:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34963 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgCJQDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:03:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id u68so5971650pfb.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wwGc0oRDc/k4j8dUulkmD33XhvnOrfO8OIhB6LZI2jI=;
        b=l9ylsw/ixks81AJpnbmc8J+73sawmAHNRQMPOJKxMqauFU8kei3T6iBEc7rQ7+a/SI
         ARHhb1/kuk9qadkP58QuAVttYc+4w/TzDyC7D6MMJjRBYdgJvWPQ4pvfptEofG6oefTv
         nIAmfIRKLK/OZOAThI/0ivf33C2pe7leLiVLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wwGc0oRDc/k4j8dUulkmD33XhvnOrfO8OIhB6LZI2jI=;
        b=naGdgAhhyd4ZAAo7kcn+ec5A67zH3Pa6fk2o7YdOtA3Vh3kAN3rxfPlS6uHzcv8EPU
         2Ny3/qrBkCBeY6hlh0C2zW2uhBjyqm8ff0nah5x8QmgEMf6gBjYP3lY06eo8H/+K0zOy
         r+b069B7m/rL/s+Y2LOsi4CrVLus2Lyt+Sc5PX6j7kn+xspVdL8Vz0R/0MX01pZTHish
         VmnwiB70WmDvqqO4gIreVW2S/b7o5xbl7lIGpcArYAj/794+CW1EybarGoUYI9ClGRLw
         +NAFL0P9ATgmgbWRYM3O+0zmDTFgbejh4xOoUJcgmlmZQrJbjY4j3LqrZ+kKF3TKpccO
         4rlw==
X-Gm-Message-State: ANhLgQ1gFdSq8gLBP8E/RvUro8a7AeHO+SKwwvIKsHyXSs5v7sydJEu/
        Ov67T5QPHT+8R19iERWDn6FV1A==
X-Google-Smtp-Source: ADFU+vszzIfipcQ5Qgm0xpwLBMeyCO9hXzu3nVnQnDe8BXVcBpz50hEXTvbCf+lmtyG/99sKZRInhg==
X-Received: by 2002:a63:408:: with SMTP id 8mr21206486pge.285.1583856199208;
        Tue, 10 Mar 2020 09:03:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l21sm2786015pjt.7.2020.03.10.09.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 09:03:18 -0700 (PDT)
Date:   Tue, 10 Mar 2020 09:03:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-doc@vger.kernel.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, swood@redhat.com, mcgrof@kernel.org,
        yzaikin@google.com, mingo@kernel.org, kernel@gpiccoli.net
Subject: Re: [PATCH] Documentation: Better document the softlockup_panic
 sysctl
Message-ID: <202003100903.572B9C543@keescook>
References: <20200310151503.11589-1-gpiccoli@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310151503.11589-1-gpiccoli@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 12:15:03PM -0300, Guilherme G. Piccoli wrote:
> Commit 9c44bc03fff4 ("softlockup: allow panic on lockup") added the
> softlockup_panic sysctl, but didn't add information about it to the file
> Documentation/admin-guide/sysctl/kernel.rst (which in that time certainly
> wasn't rst and had other name!).
> 
> This patch just adds the respective documentation and references it from
> the corresponding entry in Documentation/admin-guide/kernel-parameters.txt.
> 
> This patch was strongly based on Scott Wood's commit d22881dc13b6
> ("Documentation: Better document the hardlockup_panic sysctl").
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  Documentation/admin-guide/kernel-parameters.txt |  6 +++---
>  Documentation/admin-guide/sysctl/kernel.rst     | 13 +++++++++++++
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c07815d230bc..adf77ead02c3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4515,9 +4515,9 @@
>  
>  			A nonzero value instructs the soft-lockup detector
>  			to panic the machine when a soft-lockup occurs. This
> -			is also controlled by CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC
> -			which is the respective build-time switch to that
> -			functionality.
> +			is also controlled by kernel.softlockup_panic sysctl
> +			and CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC, which is the
> +			respective build-time switch to that functionality.
>  
>  	softlockup_all_cpu_backtrace=
>  			[KNL] Should the soft-lockup detector generate
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index def074807cee..95b2f3256323 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -95,6 +95,7 @@ show up in /proc/sys/kernel:
>  - shmmax                      [ sysv ipc ]
>  - shmmni
>  - softlockup_all_cpu_backtrace
> +- softlockup_panic
>  - soft_watchdog
>  - stack_erasing
>  - stop-a                      [ SPARC only ]
> @@ -1029,6 +1030,18 @@ NMI.
>  1: on detection capture more debug information.
>  
>  
> +softlockup_panic:
> +=================
> +
> +This parameter can be used to control whether the kernel panics when
> +a soft lockup is detected.
> +
> +0: don't panic on soft lockup
> +1: panic on soft lockup
> +
> +This can also be set using the softlockup_panic kernel parameter.
> +
> +
>  soft_watchdog:
>  ==============
>  
> -- 
> 2.24.1
> 

-- 
Kees Cook
