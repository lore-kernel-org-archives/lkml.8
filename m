Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8297C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A3520656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j+jpFrFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgG1UNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgG1UNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:13:53 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C03C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:13:52 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u185so11621453pfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GUGq9o6dBiXsIcvPN0xvh0KVFpMCLExttXK003WiTkk=;
        b=j+jpFrFaCnHHYNU23TSLdCCXdZGUSpEQRQq6fpxpu0rQT70/xTZe47+lh4YdT86wwW
         B4rO3L4Ha84q6uZFMH9rFByWQMwF9tqACggZMoGvQRMzRrz4YVG8yxU0fXZLqXu2wCCF
         fj5KPhJJyLJ0xUu5I7O1A0JdzxedcE4TqFzoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GUGq9o6dBiXsIcvPN0xvh0KVFpMCLExttXK003WiTkk=;
        b=lds8neEHD46wzBxSHtJhUXVcbYAQCchrtJKusaSuqcI+QiWGqCktsjbSdfcjqBi4K9
         06spAQjWEReuCMFHSHYxl2lVwAWPzJntk0Eyq++jDLDRrUCbbcoh8CRf8aiZ4EwcE9kH
         gPXg8iwAYTT91mwyIp8VkXsGGCcEHyHSe+rRRm3UwzWLeUztZv/6MxneH5td6SlfmIuP
         f0CMIoFxugq0Or69NHknVgsJS3D8vo4111dvFt5tXsgz7+Ph2EXFQSZ9GwDaSfv/NVQq
         I/SbO7SN+XyCX3mefQdUmOTcQF9VpCLcAooE4RUHKb2xwDaLhiVIdVqvODZnCRxurjBT
         rCsw==
X-Gm-Message-State: AOAM530KhS9gyazPZqmzY0RowpmQ06bt5GyyH865vWxEKxiTWiZENCA2
        84VCEVIWkpgXWNWfKJ0KLpvcfA==
X-Google-Smtp-Source: ABdhPJxZlXlA+o86dFzVP7fJ4h4Y9s9NA6CWrv0lWk05v6VUe4EblWytk81iQ8NgQuv3Uendd5104g==
X-Received: by 2002:a63:ee0c:: with SMTP id e12mr24290690pgi.83.1595967232539;
        Tue, 28 Jul 2020 13:13:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w17sm18909752pge.10.2020.07.28.13.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 13:13:51 -0700 (PDT)
Date:   Tue, 28 Jul 2020 13:13:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] x86/kaslr: Simplify process_gb_huge_pages
Message-ID: <202007281313.0C95B091@keescook>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727230801.3468620-7-nivedita@alum.mit.edu>
 <202007281225.C24B966D7@keescook>
 <20200728194511.GB4150860@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728194511.GB4150860@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 03:45:11PM -0400, Arvind Sankar wrote:
> But the IS_ENABLED check allows the compiler to eliminate the entire
> function at compile time.

Ah, I thought it'd be a const false, which would do the same...

-- 
Kees Cook
