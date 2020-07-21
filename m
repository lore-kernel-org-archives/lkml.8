Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD41C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592DC20729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fxicQTWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbgGUVVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730930AbgGUVVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:21:11 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599F4C0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:21:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s189so44632pgc.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wo2KSkt2uKsTjaxUKUx/AXgKzZQLVgE9fv7oC1pgM9U=;
        b=fxicQTWxrU2WqFRihd/VZT/MbC0QG/JVXizq/OhLoM/dTFzG3ztptOTItob3McBPXl
         s/8rfUZi4yvPRDPzB4x1DM25Qk+bOwKx9ZxSOBscZuk4ExZ2eBtnhHe9rpBAjbWdJNu3
         j1RWLpTE+MfqYyimAtHkTaWYpckroafRcSc40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wo2KSkt2uKsTjaxUKUx/AXgKzZQLVgE9fv7oC1pgM9U=;
        b=dkJqRizNa3NXcrP3LCMZoet0aGtzCp8HL0cKKEb5E+RjdObBVFQNfoQdwcuMqFXTfC
         J0zyVqax52XuJd059YQNVKvLxsH5luI6fNxc2uoE0TIeFewizlKoZx9/P5y4opZijTIs
         1Z/MiMpdZ91lk4HcqqHWvJ+seamItm927IzzdWlNH5QsxqisJTU8poWmxxQYf9a0LReW
         ROPShvqE/xxh/W8DGcQ5bRjdT9NeyeOORb7OgrwxHQGJzGjzDTr015AXi76EgSC9Zfor
         70ihteyx2RKf6mkJ6RGTV4rokBqZGX+YsYdq1YavYq0WpvtZpPu9uln+Cp8tjYYotDQv
         lRgw==
X-Gm-Message-State: AOAM531H9KdQzRGIxQpFqM28lqgWuMtYtyXWCmC05RVrauyuKrSgP1XQ
        kIhm+N6iVpir/9a7U9TXJv4RHGojQvY=
X-Google-Smtp-Source: ABdhPJxDDnyEVXIY4rLb+RsPBAy4yKWxQVpSGTnpY8gFur3vVyP2p27baBMA8SghPFnQbtOFo9/T2w==
X-Received: by 2002:a62:6305:: with SMTP id x5mr26195638pfb.81.1595366470930;
        Tue, 21 Jul 2020 14:21:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 66sm21380770pfg.63.2020.07.21.14.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 14:21:10 -0700 (PDT)
Date:   Tue, 21 Jul 2020 14:21:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V4 01/15] seccomp: Provide stub for __secure_computing()
Message-ID: <202007211421.FE862FEE@keescook>
References: <20200721105706.030914876@linutronix.de>
 <20200721110808.348199175@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721110808.348199175@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 12:57:07PM +0200, Thomas Gleixner wrote:
> To avoid #ifdeffery in the upcoming generic syscall entry work code provide
> a stub for __secure_computing() as this is preferred over
> secure_computing() because the TIF flag is already evaluated.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
