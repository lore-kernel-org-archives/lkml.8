Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF6AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5763420656
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="juh+QMp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgGPU5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgGPU5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:57:00 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D09C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 13:56:59 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 207so4262093pfu.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VhwUXS7xQLeI5A8zuKFyZny7IQHvIE+zP5ObVJhuh7o=;
        b=juh+QMp9iXE9jqDtJtdsumhrFyyJ4wGE7w2uxHCiQ4hgadiBuZzPhFjfXzE/UUX3ry
         zXHjDUciBIv+1/76l2skFse0Ks6ANgnaIfesAnXonjXm9WpbaenWt+bOkTHX+wYi3EwR
         K8GNbPPPqJ5re+9LirXkpX5Rk+EUm1YIoyL6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VhwUXS7xQLeI5A8zuKFyZny7IQHvIE+zP5ObVJhuh7o=;
        b=itIwNzzV0Be+cxdChnRF9exiHUZD8aAvR9RWqQm3hKg5Oa4sDQmztIckzOd0Q0D3/a
         qFv3+n8lEO6NYM8NR6cOXyVBN/DjlRqw8AQkf37lE7hsRYh3LexC7gTfHXrAGkh625sA
         WLBGtvNLPTC1Q+2wT+M5HTkDHRvj96/bVZ/tp6rrcTXGGPbkrcQTRRpsXM+HtnkHKI22
         xILL0kgDyIGucbGu76Qe1heaRCQeykiRHVdTa+4/a2tTfdZTpAOmO25ggLWXmSMVxyOI
         DWWlbC6RPUgKKhZAFe/8oyDtszYmSpyvUa7oalWkJNDKkOZzf+dlkqVfiomGsq+2Wyz3
         PDwQ==
X-Gm-Message-State: AOAM530/pnbsjryei5soPPStpHCKP+YKQCCqXsCcoBtaB5HOj77gV6Rv
        bMCo1qwPBHKxeH4ctCHrUR9zN3oSBcM=
X-Google-Smtp-Source: ABdhPJwMV2s/kQB+MFw/wcpWH6J0wsZn4KhmDPbLhSzK2FEmEK7+il1ocsbY/TenztYWogQxFnw2Lg==
X-Received: by 2002:aa7:8648:: with SMTP id a8mr5179085pfo.222.1594933019474;
        Thu, 16 Jul 2020 13:56:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b18sm839769pju.10.2020.07.16.13.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 13:56:58 -0700 (PDT)
Date:   Thu, 16 Jul 2020 13:56:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [patch V3 05/13] x86/entry: Consolidate check_user_regs()
Message-ID: <202007161356.5CD3A6ACE@keescook>
References: <20200716182208.180916541@linutronix.de>
 <20200716185424.442693273@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716185424.442693273@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 08:22:13PM +0200, Thomas Gleixner wrote:
> The user register sanity check is sprinkled all over the place. Move it
> into enter_from_user_mode().
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
