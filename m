Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF13C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0A02068D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kgOAm1Gz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFBSHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgFBSHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:07:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F47C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:07:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a45so1313890pje.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nZuxt92Kcd2Y/qYw09AKoILAu9ELH/jBsFNAqJwYZKc=;
        b=kgOAm1GzLZRyLUp10yxygCcG4pukATTKH0+7dsmEz51H7SRs3VPAPxlbuSHAimFMg1
         YbYbt7PlmwiosyIs3u7iclCtbtdPv3UxwLmDnwIpq6dyby8EeBzo2uQndfOVVSsnIfL7
         /fd/QKyRA6ePSKS9JhIoNQrUe7tAbZNjIr9D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nZuxt92Kcd2Y/qYw09AKoILAu9ELH/jBsFNAqJwYZKc=;
        b=KQuRKs3VqzqQseOiEGShBNIfVKXquoUNJhXivApbyqf/hDPvEujMBmofE7OSChybib
         30O3rK4jnViWhq5xpEOR6TJycEltHN9UyJwz8+W4UsSsaK6dfvNvO2jcsYXfxJ/7u4yM
         sLLwmt4jTxhUDpmRj383vknti0mEeesbFJYRKLQ95JjW64ElPqvWX7EBQtlRv8e2HQDu
         nvo9bBjrE3TevwQMaEUqtYCkctCK3Gl1kOyyt47RInLyikK3yyfUDJmRBKZzlyHt1Dqw
         KXtCquxcK9jEJfoV89qC7puIjD0BilHmPnMHl7V5pJL1a0GUwBc0b1yAwQPrNs5L7vRm
         /5yQ==
X-Gm-Message-State: AOAM531S1D84yraBz4zs+HIqukHtjUUi8XgqKXyypoZFZKHjFAFawcCw
        4/3M6nfvEiGPaH3GmBiGSCi7pqjgac+fWA==
X-Google-Smtp-Source: ABdhPJzEUslZe5YoFk8h2BNw75DPdSKiA0XcJWWZeenn05a2eH8KNtI/90cdMRKd7loJRFOSYCGjdA==
X-Received: by 2002:a17:90a:ce94:: with SMTP id g20mr386067pju.95.1591121244973;
        Tue, 02 Jun 2020 11:07:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j130sm2880287pfd.94.2020.06.02.11.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 11:07:24 -0700 (PDT)
Date:   Tue, 2 Jun 2020 11:07:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 2/2] lib/Kconfig.debug: Fix typo in the help text of
 CONFIG_PANIC_TIMEOUT
Message-ID: <202006021107.88E20B57@keescook>
References: <1591103358-32087-1-git-send-email-yangtiezhu@loongson.cn>
 <1591103358-32087-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591103358-32087-2-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 09:09:18PM +0800, Tiezhu Yang wrote:
> There exists duplicated "the" in the help text of CONFIG_PANIC_TIMEOUT,
> remove it.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks for catching that!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
