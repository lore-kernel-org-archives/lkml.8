Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FECC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA6C2067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eHah8lXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbgFITPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgFITPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:15:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD692C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:15:05 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b5so10490130pfp.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tGGQ3VocRYuP1AxRJCcf0YOuFdAQhDzmAD+bQaR7nDA=;
        b=eHah8lXm/9NdioI0IQB1zdteauOgwpHoUWv7l0ccJihSiEXHjtaYGtLsa46BXQHRf7
         Yv5rlSSlQSgQ0xLs6A13uJrWkHUd4+wvxefc11Rip7Zheaq+tjhgPtKEc60jT/XwgsLw
         pO9xQmpan/wYr/eEowfxeA5uFIlinxoaAc56M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tGGQ3VocRYuP1AxRJCcf0YOuFdAQhDzmAD+bQaR7nDA=;
        b=cp+ROQ/Lh+wVdA7FBGyH/LPbexRuTVLVfEL9uwdMUfDfY5pWEsgk2oR9zp9tUbHBP6
         u/VMFbo3igzAj81brWWPP9tWmfvAA+Etma1WgVKaH/jhS5lF6e4I0SlFMtStuVp4Yt2m
         +aGdp2UyT/Qk+LkxrH3Z7KJEF3wc0UduXTnRUwbi1hCl+IZAnrVIMcE3n/e1HrEVRBZt
         x//5oPcfwzqZzWIkqF/5ZIxBE2qvZ3TrPEF4kqV34MZMOB0T1HIwQqycWuuX7UbaK/Lz
         8bDBFe433I+JsazZ6wm9z9mDQSUlepL59ZEg9fgjvM3zQga1WLHvlHVoydtUGWi0fEk4
         twSA==
X-Gm-Message-State: AOAM532Jc0RHS4DgVmY0tMwbTEsWEu8VsmTJHuk5StUxSdv5Pu3rPdvL
        Tc6QiT2nC5jpcYSfTSeoadxJHA==
X-Google-Smtp-Source: ABdhPJyMccFgBeerGRwQ2wfXEHGAf89Obho1rWhLY+bGl8E1JBTsrHPd/c8CjkZ038Wze8SEwIszmQ==
X-Received: by 2002:a63:2248:: with SMTP id t8mr25901047pgm.113.1591730105075;
        Tue, 09 Jun 2020 12:15:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q18sm8933851pgn.34.2020.06.09.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:15:04 -0700 (PDT)
Date:   Tue, 9 Jun 2020 12:15:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Emese Revfy <re.emese@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Alexander Monakov <amonakov@ispras.ru>,
        Mathias Krause <minipli@googlemail.com>,
        PaX Team <pageexec@freemail.hu>,
        Brad Spengler <spender@grsecurity.net>,
        Laura Abbott <labbott@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel-hardening@lists.openwall.com, linux-kbuild@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org, notify@kernel.org
Subject: Re: [PATCH 0/5] Improvements of the stackleak gcc plugin
Message-ID: <202006091210.C139883AB@keescook>
References: <20200604134957.505389-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604134957.505389-1-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 04:49:52PM +0300, Alexander Popov wrote:
> In this patch series I collected various improvements of the stackleak
> gcc plugin.

Thanks!

> Alexander Popov (5):
>   gcc-plugins/stackleak: Exclude alloca() from the instrumentation logic
>   gcc-plugins/stackleak: Use asm instrumentation to avoid useless
>     register saving

These look like they might need tweaks (noted in their separate
replies).

>   gcc-plugins/stackleak: Add 'verbose' plugin parameter
>   gcc-plugins/stackleak: Don't instrument itself

If you wanted to reorder the series and move these first, I could take
these into my tree right away (they're logically separate from the other
fixes).

>   gcc-plugins/stackleak: Don't instrument vgettimeofday.c in arm64 VDSO

This seems good -- though I'm curious about 32-bit ARM and the other
HAVE_GCC_PLUGINS architectures with vDSOs (which appears to be all of
them except um).

-- 
Kees Cook
