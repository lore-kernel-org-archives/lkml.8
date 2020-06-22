Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA078C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5CA520738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b3SrdlZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbgFVW5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbgFVW5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:57:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F3EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:57:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d12so2255271ply.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cdRwgYs2euyKw8bTCBrzUHli8NY3UiEE1Wa/LcdrQTo=;
        b=b3SrdlZMA3OwpMQIscFhEzhRPCuOr1V97xBfjXVZkYc3YMUDejQVPuRcdTtWIIw0Ff
         oy5WdYFKy5O7WwtUYju01f9ihLztFN6LmfBm8fHiye/gwLYOd/HQqsOw0/s9WT+eeE2e
         l7M7HMf/UigmLsKBZdm6hUoSt0smOEmplljEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cdRwgYs2euyKw8bTCBrzUHli8NY3UiEE1Wa/LcdrQTo=;
        b=mvnsaunPgfOg1zhAFB610xBcBHH+0Ulc0OxYKU5G8sZPTxZlLyweNdh4lFzBj4IsHF
         5NktDm1+RYcgN8KP6g2lz/GdqPfD10+c9x3cYUQoF0oW23D2lxtVHa2IgR43iaovMgW/
         i4dnxXSnoJAPFoywyWjr+EoZoUpf+0STzdZdor1KElpQnEeLMBcT5mfvurwv9xsUbk3+
         gkDDqpw6deMF6jHevKTzVxfVTOVRl6ljbsES9VH39dT8cUMsZwf76EsCLwMl38nsB9VB
         NdWBKFdBXalCxSDt+PHn2Tr6CdVLSbYoLZj6hZwntfwojmgg8l0QmOpI9bWKUDo3mup3
         90CA==
X-Gm-Message-State: AOAM530M87Tle7n1wKqZzK7Bmv4kIIDls7vH6hod0nynGNhPrAnT7Js7
        2+pJ4EsK+Sjle6SCBGMA3CJvNA==
X-Google-Smtp-Source: ABdhPJxHt+d/i2TgMC7fzru3DET7P1drdqzHtW0wcDybfG7Y0jQpbX0Jo8re+Cmd7+0MjviHMerFhQ==
X-Received: by 2002:a17:90a:db91:: with SMTP id h17mr20306954pjv.6.1592866643631;
        Mon, 22 Jun 2020 15:57:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w10sm12181783pgm.70.2020.06.22.15.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:57:22 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:57:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Message-ID: <202006221555.45BB6412F@keescook>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-2-keescook@chromium.org>
 <20200622220043.6j3vl6v7udmk2ppp@google.com>
 <202006221524.CEB86E036B@keescook>
 <20200622225237.ybol4qmz4mhkmlqc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622225237.ybol4qmz4mhkmlqc@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 03:52:37PM -0700, Fangrui Song wrote:
> > And it's not in the output:
> > 
> > $ readelf -Vs arch/x86/boot/compressed/vmlinux | grep version
> > No version information found in this file.
> > 
> > So... for the kernel we need to silence it right now.
> 
> Re-link with -M (or -Map file) to check where .gnu.version{,_d,_r} input
> sections come from?

It's not reporting it correctly:

.gnu.version_d  0x00000000008966b0        0x0
 .gnu.version_d
                0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o

.gnu.version    0x00000000008966b0        0x0
 .gnu.version   0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o

.gnu.version_r  0x00000000008966b0        0x0
 .gnu.version_r
                0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o

it just reports whatever file is listed on the link command line first.

> If it is a bug, we should probably figure out which version of binutils
> has fixed the bug.

I see this with binutils 2.34...

-- 
Kees Cook
