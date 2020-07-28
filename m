Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A879C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE5720714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ci9/YpXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbgG1S0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 14:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgG1S0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 14:26:25 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF25C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 11:26:25 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d1so10351627plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b0bvL7mYBtpI0A92lPILKZVdGEqF4BRMR7WB6iJB6T0=;
        b=ci9/YpXYz2M3DpT6RjQz7XXrezR8ClecCbEqW0bFP3YJsWxu/QvZu0Mcv1CmWGg0lm
         QohjPfKLhiXOEeFTNEsAzvSGzOxfiXDP+Nv8Y2tcqkgrf6Q8IbUvI1MsCxjXC0iBc0EL
         eDupJZQyIACuL/Brt7lJ8P+oOrtOn96m94B6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b0bvL7mYBtpI0A92lPILKZVdGEqF4BRMR7WB6iJB6T0=;
        b=kc52DlYmTSjARa8pdDYZw26OwvPGMBMj7OSf3+JxaHwTwzADxUShq07uOVsC/oumNY
         MB/vCYzxGX59vI6E8B9hY2e/onodWLZOkZam4Qj0dm21A8XTE+jukwRlGhdy/wP/JtPM
         ukr+OT4wCvP4Zz7RuD7euIjgT/vTfH28F3iPCZiB0nAY/lg+lyHhanRfXdSXFshNzNtZ
         QijgxW3cUb8jLAtl6P1ubb4lZkB87s4wCj1bxgbvKTFQK2ADR5utoBV1iBJ1bQEO2FLi
         DK8DikpLk8tITmyNLG3JJrNegCjXaiX+rVuHafaSXa9F6hgTAI8/CI41fJSubboUzTnh
         lIfg==
X-Gm-Message-State: AOAM5303Xd2NdEYPPgDExkG725B+fHGAP/eSo4oLfEJFPBNjjY9ix+GF
        qhmzADdWRNNBx2bgRhFfJiDRt2Jpps8=
X-Google-Smtp-Source: ABdhPJxu4jdNh9ZksFptU3H4kqpFNgF7SVvSbCxbsZPTBOiwQmTtbH5SXs1JbBcpI96XUeSBwreppQ==
X-Received: by 2002:a17:90a:178e:: with SMTP id q14mr5570643pja.80.1595960784615;
        Tue, 28 Jul 2020 11:26:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6sm2725195pfr.61.2020.07.28.11.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 11:26:23 -0700 (PDT)
Date:   Tue, 28 Jul 2020 11:26:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] x86/kaslr: Make command line handling safer
Message-ID: <202007281126.46C0C30C1@keescook>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727230801.3468620-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727230801.3468620-2-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 07:07:54PM -0400, Arvind Sankar wrote:
> Handle the possibility that the command line is NULL.
> 
> Replace open-coded strlen with a function call.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
