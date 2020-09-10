Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E44C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E88A206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SNolI5tB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgIJTY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbgIJTYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:24:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF22C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:24:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gf14so504353pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FkYwcqaujYl8Ejp6IH18C1VM5DA688qGJ31jyQe3zNk=;
        b=SNolI5tB1c2YF96HVllUWHxTLGv7Zrq0RPo2hdTDaiBrDMNazosMg3QlsdbZN3CvNX
         Gi7UCW8fTnWSgwk/P9E1YlvtO1d6A5HMyEExFrdcz0IBPxYy5Ue5P82r++1oSqe9kzhm
         fW31GN9iF41aHSu/Cd6eWBP9VzDA6Uq3F24FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FkYwcqaujYl8Ejp6IH18C1VM5DA688qGJ31jyQe3zNk=;
        b=Gaj6mkDDKyUhuJ1wXw/SWn/pbBo4eCWZSbbiASUBtRBbyQcHBinJqckCgZqSJUCJcl
         SmVjrYGtv7P51E/pnC7dPfIGCK6isrRUi4GflHYhdjmUKfNprxB99axMYNQPEifku7C/
         QdfDxmBkDdDgLkV8WA25E3XTKS09wIAHTXjVDKb2/v3fXuLdgnGUD5GnezxFjZ1iR44Q
         z7IdDZAnmkbyu0X4GG4mxTENsHHaiCD5tee5uIXElD2YS97UVRRFYkAiA1q4oe0CwX4T
         4JW2/u12C4F4U4nhUESgOsoxPxo0DOKbT//6YW2m9Id6haqI5Bl6tPZ+wJ87NmPz9aou
         3NaQ==
X-Gm-Message-State: AOAM531ZrHsfqKs3XJ4aWyUSfNkofePaIy0O7imkX0/r8njTMSexaAx1
        5fpHs5Sw+m9Ri9NXloWJq7eFHA==
X-Google-Smtp-Source: ABdhPJwd92dO/Vi55tXeWKshXioGVzJbEP+SBhgxWzUUEbCrzPfwi5q7s3UCuHGAqPygh8sMz0HREA==
X-Received: by 2002:a17:90a:c505:: with SMTP id k5mr1329474pjt.188.1599765852381;
        Thu, 10 Sep 2020 12:24:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gb19sm2631729pjb.38.2020.09.10.12.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:24:11 -0700 (PDT)
Date:   Thu, 10 Sep 2020 12:24:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     davem@davemloft.net, viro@zeniv.linux.org.uk, mingo@kernel.org,
        ardb@kernel.org, will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: Fix some broken comments
Message-ID: <202009101224.5DB89D4B14@keescook>
References: <20200910090524.5147-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910090524.5147-1-linmiaohe@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 05:05:24AM -0400, Miaohe Lin wrote:
> Fix some weird and confusing comments.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
