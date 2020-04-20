Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0C3C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0569620B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WaKFtBNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgDTWfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgDTWe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:34:59 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93455C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:34:59 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o185so5273518pgo.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gHx7qgEhMfCeRi4LwRcBINau80f3lsbADPFxDRDnQX8=;
        b=WaKFtBNjxAG6922c9M7PS6Sr9GtIoZi+Bab8wtI8WphnYmTcq8s4ZSzd4luipXOLU4
         jf4QK74nyiAcI85rmEUYpbI/hBAhRHU50KzAVjDVdJlDL1gU+m4RHq55dCtYvfJ4lxlT
         nAFclQvexr0WpO9w144f4pIlUT9r5MqSnjeTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gHx7qgEhMfCeRi4LwRcBINau80f3lsbADPFxDRDnQX8=;
        b=kFp/qFE8nmhqZaBQGBcXF6afZ5rrW45hH4WFQJSUO+C6IPcLj8ALDTQD2WZ2Z0KcdC
         B60Ll8hYbVxCE9XsAvC9ZESIf7GiwvrV3OFkzH9lfl99CznbHDxpBpfpfKk+zD8F9JnP
         kSaDa+Hj625HlCMBh/NvOWhnB6Ec6rvOlq62vb6B9c4UUE2RlcpB+2JKY1PWwzTxt4lN
         JKf67crWWC8tVvCMr7hhYuiWJ72WtbFEDkrMZlS+Xe+fq5YGJZWXYAYj295tf1AfA+Js
         St7pf963kVGZ/KXiNFjBb9KKuonj6bx5Ir1m0UqyTAwhDNZwSgNHBjQsxntW1/ixey1H
         F5BA==
X-Gm-Message-State: AGi0PuYhSs7doSOTRIUVtxTdYkZ0GMIEv89vvBXl9FTIHuxUVVjJYUub
        +TY2CITo6dlaQKZWq/AYb3VH1g==
X-Google-Smtp-Source: APiQypKAcbw6yPUzbM4nMMNMJKcG2W4526Isd/VpAs6Bq80MioCbLHvZ9ufOTrlBeRJfVRW8JpiX/g==
X-Received: by 2002:a63:602:: with SMTP id 2mr18621933pgg.383.1587422099130;
        Mon, 20 Apr 2020 15:34:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x10sm373971pgq.79.2020.04.20.15.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:34:58 -0700 (PDT)
Date:   Mon, 20 Apr 2020 15:34:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] arm64: entry: Enable random_kstack_offset support
Message-ID: <202004201529.BB787BB@keescook>
References: <20200324203231.64324-1-keescook@chromium.org>
 <20200324203231.64324-6-keescook@chromium.org>
 <20200420205458.GC29998@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420205458.GC29998@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 09:54:58PM +0100, Will Deacon wrote:
> On Tue, Mar 24, 2020 at 01:32:31PM -0700, Kees Cook wrote:
> > +	/*
> > +	 * Since the compiler chooses a 4 bit alignment for the stack,
> > +	 * let's save one additional bit (9 total), which gets us up
> > +	 * near 5 bits of entropy.
> > +	 */
> > +	choose_random_kstack_offset(get_random_int() & 0x1FF);
> 
> Hmm, this comment doesn't make any sense to me. I mean, I get that 0x1ff
> is 9 bits, and that is 4+5 but so what?

Er, well, yes. I guess I was just trying to explain why there were 9
bits saved here and to document what I was seeing the compiler actually
doing with the values. (And it serves as a comparison to the x86 comment
which is explaining similar calculations in the face of x86_64 vs ia32.)

Would something like this be better?

/*
 * Since the compiler uses 4 bit alignment for the stack (1 more than
 * x86_64), let's try to match the 5ish-bit entropy seen in x86_64,
 * instead of having needlessly lower entropy. As a result, keep the
 * low 9 bits.
 */

-- 
Kees Cook
