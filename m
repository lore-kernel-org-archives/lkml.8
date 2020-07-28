Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC90FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9370A20714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GMmYP0Rg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbgG1S05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 14:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgG1S04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 14:26:56 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1E7C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 11:26:56 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id l2so5090421pff.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 11:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kSvkGnY39j+b/0rwijvIf5YEcBtWpgBAqWZ+KBD9Cbc=;
        b=GMmYP0Rg9FH9f0uUhlwiH6FtHWwf6NDAbaY+Mq93TUGr/l0MwZOsXegtNqGqVWFsoR
         KPRM1NCeM8HSZls34xf5bNr//OGARUaDzV1ReFuNpBVmuHcjhox2x44ltRwjky3kkcBM
         KUMBKfk1GinpjvTvsl6tY24qF+qY77+uXXd5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kSvkGnY39j+b/0rwijvIf5YEcBtWpgBAqWZ+KBD9Cbc=;
        b=kxcEuHXja94fMpz+/brIkYxKR7ZVmAxr9/a5bMxum+pT3aMeObgHKZXRqiB8jpYAs5
         afmgVwb5dTo7W0L24n1FrYiInp1UPbutrUJxhCwwyEIFPIDXNPSqBinMnSqNINEHXFQz
         KvpZkZPwLY6wbqemhYo1Ehcish/R0GT1KfZ0qO3q9fzX2ptvhYIwi4xehEwCKh71LuRO
         nEOquJGDFsCESzuWzAVI7uvqfHMaLSAlo/iwq8AooB4TgHKpu1dNifukcrpuiKNoYmRm
         O0fABh6wMC35rrQiZcq1SXppnyoAlVcpqjWmdmlKhwOGp/Tz1EMHszGw7BFIB5/ZLapi
         KRoA==
X-Gm-Message-State: AOAM532JVGJvkUexBiL8Fk9pwYYaLZsshCWcMbG53sJBNseVL6YwNHPU
        cijdICaFkDJJRcZup0hcxD+7Ag==
X-Google-Smtp-Source: ABdhPJwY5WxpCDJz+0Hp3oUnwDWbCwLWPKET3oCnx7N7F/azUMPDy+piAIFL0i1UI5mUm4dtyGMycw==
X-Received: by 2002:aa7:82d5:: with SMTP id f21mr6544716pfn.222.1595960816373;
        Tue, 28 Jul 2020 11:26:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d29sm18147721pgb.54.2020.07.28.11.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 11:26:55 -0700 (PDT)
Date:   Tue, 28 Jul 2020 11:26:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] x86/kaslr: Remove bogus warning and unnecessary
 goto
Message-ID: <202007281126.A1AD5DE02@keescook>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727230801.3468620-3-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727230801.3468620-3-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 07:07:55PM -0400, Arvind Sankar wrote:
> Drop the warning on seeing "--" in handle_mem_options. This will trigger
> whenever one of the memory options is present in the command line
> together with "--", but there's no problem if that is the case.
> 
> Replace goto with break.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
