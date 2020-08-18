Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439FEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5802075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QyAICf9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHRT17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgHRT16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:27:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25144C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:27:58 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t6so2895pjr.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OKHnQstXsjpvLQxUlisdTJtu9Dd8qDjYq5doku9nVeE=;
        b=QyAICf9KgEuQclheMs291Y2a3FseDYQnvIJBXSVKceC05GiYVUH/tD1F9dAAB5jkXy
         Me3o5mBj6v6tVYtlZzju1/QJkfKLhC8WNZX9tDDnxjAN8yhxm10fq7Jif8C/bBou8u+w
         jcMFSVqMPG6wDNRIQNDJc3hml8vNrisx1y6/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OKHnQstXsjpvLQxUlisdTJtu9Dd8qDjYq5doku9nVeE=;
        b=hdEUac8r3f5O86XcwQ5K8ta6PlLnnjhFsamRpZHPwGgEueEQRBmyxJKXWZ1OOvpgvN
         xydqatbDNUqY24PR0XVKEUjZkP4mqHqlPKrgoopvPm8a5YhYhpNX249W2UmK4cJ2xxLU
         /GtmR9UVvrhf3pqEuJfCfLD8WVpRxk3oAq2ucbniIxSJe0G9LEBztyn2MPEZchOo6oVN
         AXhvAfQ760G6y9PsWLVMfWR9u7Z20dsa2Jd/wRKbL3AIxvRpzupXlV+sUJbLNpcz7PFQ
         8YG214czvsAuFaXVQtAAHkrjdSMK/NwhftGx4gcUt1fct82ml3+LtKpqR0WNlTQtBFN0
         2POg==
X-Gm-Message-State: AOAM533A8R3uPRFUSUHsGh8AFwT11pTHLmgsLW6HG1huVkgRM2KxLIz/
        ztow8Lf6L9prOxvzbh6G7v+iQQ==
X-Google-Smtp-Source: ABdhPJxbgaFuRtRGjA2NiMRtgl4s0aHVu6/1aAGF8JszULXuHhAcX2HCnNgmwLKolI+rcXeKrqOhSg==
X-Received: by 2002:a17:90a:8904:: with SMTP id u4mr1182215pjn.87.1597778877709;
        Tue, 18 Aug 2020 12:27:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y19sm24777979pfn.77.2020.08.18.12.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:27:56 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:27:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/11] x86: move PAGE_OFFSET, TASK_SIZE & friends to
 page_{32,64}_types.h
Message-ID: <202008181227.C3A84957AD@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817073212.830069-8-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 09:32:08AM +0200, Christoph Hellwig wrote:
> At least for 64-bit this moves them closer to some of the defines
> they are based on, and it prepares for using the TASK_SIZE_MAX
> definition from assembly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
