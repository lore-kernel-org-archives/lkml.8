Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F172DC11D3D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF40420732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4o+TwQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgBXX2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:28:04 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34986 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgBXX2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:28:04 -0500
Received: by mail-oi1-f196.google.com with SMTP id b18so10733834oie.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 15:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TPDmqqc3T4bvngZN/YKdkDbHxV5bVjmqfQ9sRt+vMck=;
        b=N4o+TwQw5tGeML/iB5VTggO+t0n55fMTtafyIPDjQ49HxPNKhftC/NH245tqS9D+p9
         YArS7CizCrq5+kCzLf7agfwy3KLgSnios6NDvFD5YSRjQ4vEd3d4yAZTpL/VuHgSuNEb
         5HPgi/UjpjJncMJmtCBizTyBzgMC7o3TmGq7zfjuuymLqJjslI3WWdAlX1TfYHMVUT5L
         9EG7gbyuDS/FhhIiIqMMqObDLGZbvxK2YJmhNy1OsHh8sQCkBF2Xv0+oQap8rIv24lJe
         avtGAU0AUwwfj22S0JzAyO4F8Pm8ETAWCVDmvyhgd3jLpiDUh3oMLkIvjr+aTWC9t2kP
         QZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TPDmqqc3T4bvngZN/YKdkDbHxV5bVjmqfQ9sRt+vMck=;
        b=B0n6e0dpwlkwU7/6wnN5j+Zd6cJQLpnxfRPkP/9PjQ81eDwtqnfbVSAz+o2M9o6IQC
         86HTCVCO+KU1qVCZW89gf6SGwJaAiQuXQjTui6wwgh2ZtLrT5hel0qjyw2bVSwplk3+n
         Mj2BevQp7TUMvEgDErAGscGJFiUudNQmIZVljCLueY15xQdFFmqleMbwTjsYc3oYAO0l
         5Ig6zPwvudg+xMntRS6m33vnXyWLZXWTXIW4nnu+WAJwLrCuDh6dLoZgJDmgDNvsoZpP
         Rsl3zDDPt8sfwpkEJIuwC/uS+6TSoT/Cwg/kdid7kjO7t/sAkGohoCm7s7p1kesGM7+I
         qpag==
X-Gm-Message-State: APjAAAVCjqhBKeWxtusM9jdjBeKg1+abGUfGoGjeTGpMytAOZmUj3AlA
        95mYALyh4QCBlnE/pnUUXOo=
X-Google-Smtp-Source: APXvYqwCXVQL1nd8CFYENyPMYxCPF0+QzjMEJ4eso3GyPbopfWvYrxiHUWCrR4i3OteiIJ8lUN3dpg==
X-Received: by 2002:a05:6808:b13:: with SMTP id s19mr1148274oij.119.1582586883129;
        Mon, 24 Feb 2020 15:28:03 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id y14sm4534705oih.23.2020.02.24.15.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 15:28:02 -0800 (PST)
Date:   Mon, 24 Feb 2020 16:28:01 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 2/2] arch/x86: Drop unneeded linker script discard of
 .eh_frame
Message-ID: <20200224232801.GA31729@ubuntu-m2-xlarge-x86>
References: <CAKwvOdn6cxm9EpB7A9kLasttPwLY2csnhqgNAdkJ6_s2DP1-HA@mail.gmail.com>
 <20200224232129.597160-3-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224232129.597160-3-nivedita@alum.mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 06:21:29PM -0500, Arvind Sankar wrote:
> Now that we don't generate .eh_frame sections for the files in setup.elf
> and realmode.elf, the linker scripts don't need the /DISCARD/ any more.
> 
> Remove the one in the main kernel linker script as well, since there are
> no .eh_frame sections already, and fix up a comment referencing .eh_frame.
> 
> Update the comment in asm/dwarf2.h referring to .eh_frame so it continues
> to make sense, as well as being more specific.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

My previous review conments still stand,

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
