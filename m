Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0955C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D0C207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUCcan+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgERP4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgERP4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:56:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB3EC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 08:56:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i15so12436431wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PtEh/eqO/jcM1mnHH6fVjI/HimaXnKzbvkPLBE0BPVI=;
        b=jUCcan+Nms1s70qgGIq39zMEO6T5qEC+yiZdoFL9PBCRCkQs5AUHTbRiAcAhI0lZ5y
         2+Xqnr+pY68Sd5tq2onYhMA4ykp8LFiKYIRuP62Tjcyht8aAEHNMnfZpwNkyY8DQ/ZaM
         8E2Tp0Xk9TIV1TBt455W9oAIvkpV7TtDj0yaluNRAygGidNh5suWfslpRiEe2ie6rdqw
         pPWH5//rz9ABUSurZU0iRUWSSwBn6VuDmMOOLPgzRndHHNsX1Ea7lwYtnxR3ZDqKdEBc
         PRz+Yvvizttbarx8SUIfvLvxYIyB29jqXPparoMQreul88KBAGoPE/XtONTIkm0DNYj0
         lFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PtEh/eqO/jcM1mnHH6fVjI/HimaXnKzbvkPLBE0BPVI=;
        b=MUU5EPE7yLiS4MqBNYFx//s+yoxruVSe2pUjIttvfK+IrrM6vrQugoMEQvFf0ZQlyC
         KHSOSMbGHTYUQ2MX63Q2bpHpIeuum+x2KCGQEOnwVqCLIeewNEmXMHXGP5mQ0k7k33XC
         1sID5NpuqWtO46p8MkRzeyIGAuz/coyCmft12RfSqWZlRqtAJfh6sRW3vD+3WgwdWzIG
         Tk/BMZYMVqgQQ1bVgCEj+YFNHS5xtHAagQAekABc3zbyPVnDy63oSQAVqTHjjBVeHWt9
         90GVy4xzMlpA3zoZUdL31v+nnG9zrUA8uMXlUdLiJs5oFM5At/SI1wWYfk31r3P0i3l+
         1Xkw==
X-Gm-Message-State: AOAM5300YF9/F8KHsvnI/9OnqvCPNCl0RZDOOXUK4JFXeBsFf9I2/S5d
        yTAB0mjB1hPe3WmOQjI+6V4GYA==
X-Google-Smtp-Source: ABdhPJxt1Zaz2JVaB0TU+GicXYJwo+95dXbld8dQov8mZpcW9twBDQrd3PgWr5SfeOkk5/wD0DEL0A==
X-Received: by 2002:adf:cd88:: with SMTP id q8mr20999524wrj.67.1589817358531;
        Mon, 18 May 2020 08:55:58 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:109:355c:447d:ad3d:ac5c])
        by smtp.gmail.com with ESMTPSA id v126sm13452wmb.4.2020.05.18.08.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:55:57 -0700 (PDT)
Date:   Mon, 18 May 2020 16:55:53 +0100
From:   Andrew Scull <ascull@google.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/14] arm64: kvm: Add build rules for separate nVHE
 object files
Message-ID: <20200518155553.GB147668@google.com>
References: <20200515105841.73532-1-dbrazdil@google.com>
 <20200515105841.73532-5-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515105841.73532-5-dbrazdil@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 11:58:31AM +0100, David Brazdil wrote:
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> index 7f06ad93fc95..13850134fc28 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -51,4 +51,16 @@ __efistub__ctype		= _ctype;
>  
>  #endif
>  
> +#ifdef CONFIG_KVM
> +
> +/*
> + * KVM nVHE code has its own symbol namespace prefixed by __hyp_text_, to
> + * isolate it from the kernel proper. The following symbols are legally
> + * accessed by it, therefore provide aliases to make them linkable.
> + * Do not include symbols which may not be safely accessed under hypervisor
> + * memory mappings.
> + */

nit: the prefix is not '__kvm_nvhe_' rather than '__hyp_text_'
