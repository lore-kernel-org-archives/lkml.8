Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7555CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4450B2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PMP0ufkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgGUVr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgGUVr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:47:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DD5C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:47:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t15so74138pjq.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uq0Aq+GcsmVy3ZiohS7NTEe6z0eXz9cxjaRfYjEwnno=;
        b=PMP0ufkBBI/0n1brlASes3pVQK2FeofXL5D2cNR4NNDrIKCeTAfTtEi6hR8sHKIW9x
         KvymZb8ra4HK/OeQDQ6IE9M0E3cVlC6btD441Fnq9Pe0vg0f9hDcEKJ4n/Bq5uQW9GlV
         gclJFMiOJUpa41KhoSbJ4I7Etd4Zhs6cMaZ9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uq0Aq+GcsmVy3ZiohS7NTEe6z0eXz9cxjaRfYjEwnno=;
        b=K7MaJiYxTT8iGhTVIp2XGN7KfFO47ND4TgWAbVXBhUcRU4m2b3s+j86V498IFxuUIk
         1nst4hy5JKd+D2Ueo1rVIo8PVPAx+s7zom5+hCWHW9k+uFdRDHZ1Cfnw34ceLhHArM6W
         jANvIt3ilIDfn/2haUe/2wHyK1E61Lk8mWtq+2XtK1t+g73CAb1ZQqZ1c8rZgfZBCM54
         JiGLAdqTBE9y3VEmigpgYw9QOeadouZziGUbEykYdbb/p3YUihBH/fVI1fpXPdFGzeA0
         8lIfHz34EeRI1aQUmzroXai96lBOguK9LBMXjshs6M58u1zva7MQULcfRbIbvaUEercF
         U2BQ==
X-Gm-Message-State: AOAM533A5Na3+PGAjbTZJ5d5daaIxHOkw2KI6UXpO5akGOKezjFFm39d
        u0gXseXvHy9iKbd6J+zBrYxBBg==
X-Google-Smtp-Source: ABdhPJzIWR86OgW1YkqQCpbKimd/BCL0yL44kI4I/YgjKuNClofZhDSTwBuM2DWxXlJ0krV0jYl8iw==
X-Received: by 2002:a17:90a:987:: with SMTP id 7mr6334935pjo.186.1595368078049;
        Tue, 21 Jul 2020 14:47:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w1sm21824179pfq.53.2020.07.21.14.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 14:47:57 -0700 (PDT)
Date:   Tue, 21 Jul 2020 14:47:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V4 11/15] x86/entry: Use generic syscall exit
 functionality
Message-ID: <202007211447.8F89234@keescook>
References: <20200721105706.030914876@linutronix.de>
 <20200721110809.432210708@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721110809.432210708@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 12:57:17PM +0200, Thomas Gleixner wrote:
> Replace the x86 variant with the generic version. Provide the relevant
> architecture specific helper functions and defines.
> 
> Use a temporary define for idtentry_exit_user which will be cleaned up
> seperately.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
