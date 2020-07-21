Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F36C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F47B2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bu516rif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgGUVsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbgGUVsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:48:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B860FC0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:48:31 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t15so74775pjq.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I3Ujz+mGEEmYDtCY+li6aHvm42OcR56inDy8k+DDdmg=;
        b=Bu516rifBpuY5ZDwiN64YiR1VJ0K377jNrHj2J5rzO593y9MhlMUSYD/mQHhNGlp3Y
         ToxeSAWxN0/8+do3wrz37LZUiBjnCt/6rLw12ZC/S2NZ5JL8H/I3BwBRrHCzaNgdyqIW
         YcvWaGe9WchkSieuy1S39/LASSbGePbYl25IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I3Ujz+mGEEmYDtCY+li6aHvm42OcR56inDy8k+DDdmg=;
        b=PGLbXYG51epgWy1826CAUREAbiSlNWchJbq2U+U3I/nz5Ce8ku/pZ6bavsZF66KyQw
         2jSw5ZxFQf/wAqieHeyihabLiicfGLx2FaIiVmYvqUWACldNIQW8FZ5CHI/rGJsnD3AS
         h67LcoIMcCPTvUiU0oltQz6boyrWxEP+w1/AdGURUWcgy2hES5qjrOiNLzLWDLS+tRP7
         ea7MRcnHiRQrVzvMFu7dUTm0KW602XtuLRyy37WMrwr8TO1nDRqjPIDJMWVkk/rnX4TV
         J/Z8BC7M/pvX8Ybj1gU/nw1HsKE+SYaYJzXBTmzS5JLQBxqLBjW4JMW8xhSp3ivwlX1h
         uuzQ==
X-Gm-Message-State: AOAM531FKDzx7mWeONmlOO5YJqK4zx9c8QWyMGy/PmatNfhBLOt4gtcY
        e3xSlIo49aefwWRsjo9HqxRjUA==
X-Google-Smtp-Source: ABdhPJyfQSnwouxRVdXPtrJI1D17mvws8IaUEh7pE+T8DeNIXkEpBIHHleD4+rafpLBha5i4wBKHzQ==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr24276699plo.108.1595368111361;
        Tue, 21 Jul 2020 14:48:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w71sm21629848pfd.6.2020.07.21.14.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 14:48:30 -0700 (PDT)
Date:   Tue, 21 Jul 2020 14:48:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V4 12/15] x86/entry: Cleanup idtentry_entry/exit_user
Message-ID: <202007211448.A8AFA81@keescook>
References: <20200721105706.030914876@linutronix.de>
 <20200721110809.531305010@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721110809.531305010@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 12:57:18PM +0200, Thomas Gleixner wrote:
> Cleanup the temporary defines and use irqentry_ instead of idtentry_.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
