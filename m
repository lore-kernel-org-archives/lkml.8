Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B90EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0781B2065F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SdUds60V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgFQSPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgFQSPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:15:08 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF50C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:15:08 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g12so1300288pll.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RdqXevPl9uJkE3HCx2/ZTZ7Vh1kelDtYj8huy4vkv0A=;
        b=SdUds60VPFAsN4bvveQ4jp5InHf0ZUUz99xRZhRp+41UMQMhVcoiKwCBGDJIHZscBK
         lx55XnwUC1mpIChq7Ak6UivUmeED3KnMSVgfzqfMaYH+MWJtecnmKZJZJc4BiMoRn0wU
         Amjjdv31jrGXmKUOkF/93WsA6oExSqQUwhLVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RdqXevPl9uJkE3HCx2/ZTZ7Vh1kelDtYj8huy4vkv0A=;
        b=fT+aIIbaU/Jk0uqkTKaxDF3pussEZC6eHgy7zNp+Izzj/nHkDRiu6oJx0kHsb8wqcr
         4X7sA2arQUC8IKtvDZAEtCiYhs3ksUocNGKx2/NMbfMKegePI6L2HZIhdBZJD63cfknz
         ERCmVwGDfgR4EOnDMQXx5oSPmkrZtGsIwWXb6lAuNsttPb6zuKj8Ud1SRzVHNec9+a7m
         /xswlLFutWvGH7/tv9YbRdy3ngQ1s4UJmFh0cIwfL4XHr2I5r9tRav3tt6Kt7h39MM4A
         DEDzNfffhD8u4j9tlqFLZdgJOKoy24E/aY8J/KIdNaLanAxtkoOSGzIaeZh+WOL1Kb5b
         KKGQ==
X-Gm-Message-State: AOAM532wJNGoHmlqZ8h9pwGrbPWqQbxNjQxV3yX7XnH1LQ0EIL/8/awv
        ZUuYSboM43LCxYohIoQR+fJ+BhH0AiE=
X-Google-Smtp-Source: ABdhPJxTzLtLJsscJ1qfMfUDlWH0JrF41Ue4dtI+ASH3RecBTT03vfvBuhXEXW6KMgo01pRZpUjNeA==
X-Received: by 2002:a17:90a:7c48:: with SMTP id e8mr264393pjl.235.1592417707785;
        Wed, 17 Jun 2020 11:15:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m22sm498891pfk.216.2020.06.17.11.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 11:15:06 -0700 (PDT)
Date:   Wed, 17 Jun 2020 11:15:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Denis Efremov <efremov@linux.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] coccinelle: misc: add array_size_dup script to detect
 missed overlow checks
Message-ID: <202006171103.327F86B1C@keescook>
References: <20200615102045.4558-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615102045.4558-1-efremov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 01:20:45PM +0300, Denis Efremov wrote:
> +@as@
> +expression E1, E2;
> +@@
> +
> +array_size(E1, E2)

BTW, is there a way yet in Coccinelle to match a fully qualified (?)
identifier? For example, if I have two lines in C:

A)
	array_size(variable, 5);
B)
	array_size(instance->member.size, 5);
C)
	array_size(instance->member.size + 1, 5);
D)
	array_size(function_call(variable), 5);


This matches A, B, C, and D:

@@
expression ARG1;
expression ARG2;
@@

array_size(ARG1, ARG2);


This matches only A:

@@
identifier ARG1;
expression ARG2;
@@

array_size(ARG1, ARG2);


How do I get something to match A and B but not C and D (i.e. I do not
want to match any operations, function calls, etc, only a variable,
which may be identified through dereference, array index, or struct
member access.)


-- 
Kees Cook
