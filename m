Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94377C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635E62078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CzwRDrj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbgDAHez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:34:55 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40034 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731910AbgDAHez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:34:55 -0400
Received: by mail-pj1-f67.google.com with SMTP id kx8so2321964pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 00:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e9j0gXLS8BiPnG8hg4KhkQMvt4m3nuldxIMCe99NUSM=;
        b=CzwRDrj2h0sa5kX72PUVDeT6L3fY9qudsdi8KkOaBKK9gQI9Rk35RY8a+tf/7T/90X
         Zl5oGkGuBSVb657tgNqL16cqTQjKM3o1b6z/xqQcfhcf5YAqC/8MEoQ6vJl0xnuS4T1p
         bLhOvG+N19w8AdK3xAI90GJXQBJzHg/Idzk0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e9j0gXLS8BiPnG8hg4KhkQMvt4m3nuldxIMCe99NUSM=;
        b=PhVzvr2Z+20McWwCMSAqF5jJGs7W2iiXVpCeqIvalPAXRZ4X8AfRACkBkp2DKOh3YN
         6rsPD0zyF5hhjWHDAsFk+qLWQvDG/JxAlyr9iWa4FuGBdBGkUgWNzpi6qFp0tqdEjUPx
         IxbNMX13l1GRncF/ScdUooB99+hD/KBJE7HlFf0G2YE9V+2RyIntQpI9w4ds8HHJYhVr
         L3uLNzlqxz4gkxOXU8PQCKfQN440PXu3Iz06GyxNp4nHVLDZtVOBEXN3ByqJsdgTtptU
         eyMul13elqmjzCgCocdJhLBUZnBfIYuvLBCdMqHKLUIbP+4OwkCIHBYlXtaJyigxSUpR
         aZVg==
X-Gm-Message-State: AGi0PuZvoe6nHkLtj4Vt+FJizMfAA5vNJWk1tWsIM9BEoaXYUO5dxwZA
        HM0iOadNSj6JR7IAxsPSYD0YXA==
X-Google-Smtp-Source: APiQypJDNRDZ33Sc9rxPUXsp2xFXUXbugulWQqiDDPonuNaxSEsO5TuU3WlX80cycoM1zufaEYn2wA==
X-Received: by 2002:a17:902:6acc:: with SMTP id i12mr7180158plt.61.1585726494195;
        Wed, 01 Apr 2020 00:34:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w74sm948693pfd.112.2020.04.01.00.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 00:34:53 -0700 (PDT)
Date:   Wed, 1 Apr 2020 00:34:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Slava Bacherikov <slava@bacher09.org>
Cc:     andriin@fb.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        jannh@google.com, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net, kernel-hardening@lists.openwall.com,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
Message-ID: <202004010033.A1523890@keescook>
References: <20200331215536.34162-1-slava@bacher09.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331215536.34162-1-slava@bacher09.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 12:55:37AM +0300, Slava Bacherikov wrote:
> Currently turning on DEBUG_INFO_SPLIT when DEBUG_INFO_BTF is also
> enabled will produce invalid btf file, since gen_btf function in
> link-vmlinux.sh script doesn't handle *.dwo files.
> 
> Enabling DEBUG_INFO_REDUCED will also produce invalid btf file, and
> using GCC_PLUGIN_RANDSTRUCT with BTF makes no sense.
> 
> Signed-off-by: Slava Bacherikov <slava@bacher09.org>
> Reported-by: Jann Horn <jannh@google.com>
> Reported-by: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
> Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info for vmlinux")
> ---
>  lib/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f61d834e02fe..9ae288e2a6c0 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -223,6 +223,7 @@ config DEBUG_INFO_DWARF4
>  config DEBUG_INFO_BTF
>  	bool "Generate BTF typeinfo"
>  	depends on DEBUG_INFO
> +	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED && !GCC_PLUGIN_RANDSTRUCT
>  	help
>  	  Generate deduplicated BTF type information from DWARF debug info.
>  	  Turning this on expects presence of pahole tool, which will convert

Please make this:

depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
depends on COMPILE_TEST || !GCC_PLUGIN_RANDSTRUCT

-Kees

-- 
Kees Cook
