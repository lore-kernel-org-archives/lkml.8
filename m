Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F0EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30ED92073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gimWoMj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbgFVWnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731363AbgFVWnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:43:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1EFC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:43:39 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j1so9099611pfe.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mOfL9Rbfa1j0SjGQbfLe+co+fpbObqYEOOANsb7QdZc=;
        b=gimWoMj2Ct00U6evnt7HxrSzc6GeTAvOoICOsHyx4pF6AbgddWeXDK5Q6KvH9IqNn2
         gHwo3IN3YST6IUoObLJdUmDfGXmKoHkIx1FNlHiVWRqXRSJNa9l+964dbINMSoNCS7OW
         1ITThEbh/ZfveaIpPagnSOlyLx7r5lAqYgzOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mOfL9Rbfa1j0SjGQbfLe+co+fpbObqYEOOANsb7QdZc=;
        b=l/PKwRLVlAG/09mEW94NS/K7VM1l9FW5swqyittll7EvSmxwFEa6ArrYn6slii43IZ
         /w12CYyRFXa0FmuzqDTKe16v93AVIL4x1HgBB4eH06UbduH/l2GlkPh6nUXaZxNwGoPx
         USTT8cgmtncZdWgz9TFUtPT+B2Cf7uvtWKWvuygRPy0ZvVIBZ+dHAe617lFH39upzFPh
         p1sZs3gOtrgi0bSpymuAtnq5fZsP+dT6dVmc0gxZGXZNfS7xxJyNWmXC+HAGLGFTWoPw
         zHVRPWkcyWhNvy3vON1FkCUThf9TqEWPQ2MQ5xLktbxUE6CavXqcjw8MXokVYgJeePBi
         vbzA==
X-Gm-Message-State: AOAM532TVBlflGdqZV5B1fpXbIVPwHxUbd9BeNucKMCe/AXyNqJVlUI+
        PoA+TMbe6AiIwVqL8/9W57g0vg==
X-Google-Smtp-Source: ABdhPJxpwKQPPN371n84T7aMTqaDCcT052EAqsIZT7sWeFEyvd4S8r6YbbsRta6X/rrFqFzDg24kNQ==
X-Received: by 2002:a62:ea0b:: with SMTP id t11mr9201925pfh.276.1592865818848;
        Mon, 22 Jun 2020 15:43:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i14sm14708966pfo.14.2020.06.22.15.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:43:38 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:43:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] x86/boot: Warn on orphan section placement
Message-ID: <202006221543.EA2FCFA2FF@keescook>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-4-keescook@chromium.org>
 <20200622220628.t5fklwmbtqoird5f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622220628.t5fklwmbtqoird5f@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 03:06:28PM -0700, Fangrui Song wrote:
> LLD may report warnings for 3 synthetic sections if they are orphans:
> 
> ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
> ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
> ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'
> 
> Are they described?

Perhaps:

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index db600ef218d7..57e9c142e401 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -792,6 +792,9 @@
 		.stab.exclstr 0 : { *(.stab.exclstr) }			\
 		.stab.index 0 : { *(.stab.index) }			\
 		.stab.indexstr 0 : { *(.stab.indexstr) }		\
+		.symtab 0 : { *(.symtab) }				\
+		.strtab 0 : { *(.strtab) }				\
+		.shstrtab 0 : { *(.shstrtab) }				\
 		.comment 0 : { *(.comment) }
 
 #ifdef CONFIG_GENERIC_BUG

-- 
Kees Cook
