Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE87C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B210920787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q+l7XoBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgGPV0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgGPV0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:26:32 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8472BC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:26:32 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cv18so3368453pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S4tbpXgCt+LdJ7QuTPeRA+fObQgUcTw9DSUS/65F4MU=;
        b=Q+l7XoBw5f2LK3rM1sQJQWnlL3rB9WlWIlGX8wcJliWkCXL7b/An6ORKoVML1/iblt
         rN/fJIeuSz/JvolvEkoVoW8pY5n3Vr8gKwzIkpHcWsy+TOAgfExnstbA35+Oq042eszL
         svBipPMeqYFFQ3ZXDRC+lwf74Ck1bA1CuSV4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S4tbpXgCt+LdJ7QuTPeRA+fObQgUcTw9DSUS/65F4MU=;
        b=XC3zGzka7MQIs2JS+7POxQe7ZAtErfsTXeF5qJJxRPMBymIoK5t9s9kZm9uhLqO8TB
         Y76f7xZC6UOTRrl3Un7av2dq0XujS4JroX65HeQtyMShJ60/lw64Vejl/E1q/0HXTOYx
         ZQKcycDK33/P6bIOvH4H6MfSeVTpTWyOTToHanem4ZH89CJdCdDC3MLe1vQLljDKV32o
         7YqEXe39+0O+DUcBE0JjHN4XmvrDRmFIvGZxRKoBNF/ePmRSrt0wltQcvsPh7TEt3DvM
         pHmcQFVRyQfzfRoVA/98lKNtpAyUbTM/vXlduJPo8lWjcvNog9pC7n4Y2gZJEpvg15d7
         XSnw==
X-Gm-Message-State: AOAM531h0BzprtVaDn0Qyp26RUfOXO3Os81w1xGXb82xaduXv+b/9MzY
        pE0DMbkWazx4cuPbCrv4959pmg==
X-Google-Smtp-Source: ABdhPJzrR0RdcBtZJSJRLiBbFdf7dfQKH7/AVbiFSUYlX6SFDScxPUr+kPCMIrhmfNQXH2Ai6JS71w==
X-Received: by 2002:a17:902:9692:: with SMTP id n18mr5018526plp.86.1594934792122;
        Thu, 16 Jul 2020 14:26:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u26sm5700644pfn.54.2020.07.16.14.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 14:26:31 -0700 (PDT)
Date:   Thu, 16 Jul 2020 14:26:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel@collabora.com, luto@kernel.org, gofmanp@gmail.com,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v4 1/2] kernel: Implement selective syscall userspace
 redirection
Message-ID: <202007161425.3D9B91DB6@keescook>
References: <20200716193141.4068476-1-krisman@collabora.com>
 <20200716193141.4068476-2-krisman@collabora.com>
 <20200716210601.GN12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716210601.GN12769@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:06:01PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 16, 2020 at 03:31:40PM -0400, Gabriel Krisman Bertazi wrote:
> > selector is an optional pointer to a char-sized userspace memory region
> > that has a key switch for the mechanism. This key switch is set to
> > either PR_SYS_DISPATCH_ON, PR_SYS_DISPATCH_OFF to enable and disable the
> > redirection without calling the kernel.
> > 
> > The feature is meant to be set per-thread and it is disabled on
> > fork/clone/execv.
> 
> Disabled on exec.  Disabled in the child on clone/fork (and vfork, I
> think).
> 
> That means we don't need to worry about it interacting badly with
> a setuid program, right?

Right, that's the intention.

-- 
Kees Cook
