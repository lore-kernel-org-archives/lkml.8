Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A02C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369A3207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t5kbJ8vE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgERQm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgERQm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:42:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A24C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:42:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s8so12657169wrt.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l7z6K0amO/UJk176kcJX4YeJlctfObnJzJsw8pKe4sQ=;
        b=t5kbJ8vEQ29jXrypKtW3eJgqbsxD4z/bPK/nPLvx1ZJJGdVY79R33x66hal4j53Dr3
         wfI41HluahUWCRhpDePMjy/Fmt7gXAHOX2Vj+m7i6uT7LNk1CW2NuqBhL2wnPWG8M/K6
         ZfTiJ4TzIrY9qDOmQ6u+zRo0jx9Fz6R7MJeVPtAWDHtaQmY+j6ZA0GOIcc5EPHkRjJkv
         hrsONuz0sTr4YL0NvVUVKzFickAjmDOkC5vxwPnkTV0clhri3E1bXds2SZq6FLpTAzK1
         4wI1CT8Qwnamr/v2pa27pFL0xCHq5rDzQ0JNtjk1KZxr/ikAms2TvFDyiczEIdvmOlpT
         M9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l7z6K0amO/UJk176kcJX4YeJlctfObnJzJsw8pKe4sQ=;
        b=BTJW0Lh/gvN6/Yb8E++5XhKMZjM3JsmYbpu4SgmREagki6epLIDrmrzzLo4i0/LNoz
         qlzA4aF5MEzoTGsGWtnFDCIxfna1el2NZlE8KALbm+ic/wYlsi3CFENWRqooY/5wq2Ng
         UvIwwPV//viABWb28qLFqkFS/F00YAqieTZXLTjMutOxUoIOu3aM8V1a5yrnYPiDUQJV
         8bgCBCjSn7/7oImB4Q7Gn8Awvuiz166igCa6t4gqPlPCaCW+a0fsPG8uwz/ZLAC1SeXq
         1CVoHP4ka6JOJN437iTlBJmSM1B/2Ru8SxgSnt3JTYQUWv4ftFAqci2gvacjD99yDaH6
         WRPw==
X-Gm-Message-State: AOAM533G87KWQSU38DG8M/vS7NWAXCRNT8tjUUh/s2p3BE7kIhpwbbHm
        cqE1/Em4Sau3tbuGI4QwdNP3lg==
X-Google-Smtp-Source: ABdhPJx0XDQyf7zT0sv6Q3paDSxLsaxOBCpajY4Yvk08GG2KYWSgZT6Ac/ffdWmbevL3HdDikI5PEw==
X-Received: by 2002:a05:6000:1252:: with SMTP id j18mr10965847wrx.3.1589820175994;
        Mon, 18 May 2020 09:42:55 -0700 (PDT)
Received: from dbrazdil-macbookpro.roam.corp.google.com ([2a01:4b00:8523:2d03:4431:2de6:16f:7f90])
        by smtp.gmail.com with ESMTPSA id v24sm106645wmh.45.2020.05.18.09.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 09:42:55 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
X-Google-Original-From: David Brazdil <dbrazdil@dbrazdil-macbookpro.roam.corp.google.com>
Date:   Mon, 18 May 2020 17:42:54 +0100
To:     Andrew Scull <ascull@google.com>
Cc:     David Brazdil <dbrazdil@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/14] arm64: kvm: Add build rules for separate nVHE
 object files
Message-ID: <20200518164254.b26ankme6pb6ijqr@dbrazdil-macbookpro.roam.corp.google.com>
References: <20200515105841.73532-1-dbrazdil@google.com>
 <20200515105841.73532-5-dbrazdil@google.com>
 <20200518155553.GB147668@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518155553.GB147668@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 04:55:53PM +0100, Andrew Scull wrote:
> On Fri, May 15, 2020 at 11:58:31AM +0100, David Brazdil wrote:
> > diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> > index 7f06ad93fc95..13850134fc28 100644
> > --- a/arch/arm64/kernel/image-vars.h
> > +++ b/arch/arm64/kernel/image-vars.h
> > @@ -51,4 +51,16 @@ __efistub__ctype		= _ctype;
> >  
> >  #endif
> >  
> > +#ifdef CONFIG_KVM
> > +
> > +/*
> > + * KVM nVHE code has its own symbol namespace prefixed by __hyp_text_, to
> > + * isolate it from the kernel proper. The following symbols are legally
> > + * accessed by it, therefore provide aliases to make them linkable.
> > + * Do not include symbols which may not be safely accessed under hypervisor
> > + * memory mappings.
> > + */
> 
> nit: the prefix is not '__kvm_nvhe_' rather than '__hyp_text_'

Thanks, will fix in v3.
