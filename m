Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400A9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5D622BEA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gIRjHM+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbgGaQ4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbgGaQ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:56:52 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28BBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:56:51 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g26so29437404qka.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Oxr5YTGpl3qCmnQ7jzJ1mzURsOCkDMcn0o5yKiLVjHk=;
        b=gIRjHM+pqqI3fhGfhHetDCeS8wl+rUrVsc+3J0YFUBcz20bHIPwgLmOQY4NF2aH9r+
         w29TYsuxRB8kX1umvuRt8rgqgg+zLqbG0T5mn7qENr3b9j9L/3gou6LceoOVF2sJrr5g
         3cm8eJoDDyzXkAscEulakGjBhHgEyuCHQUHJbED5fbGyAMJ/Apcuv1UvzxpjL+krWgWk
         ecEppJXJ2FCKKi10ZOuySLhYaW23mxakZAkKdRqA6zovDr0sCMIMJIJtrK5//XBLInj6
         8/b80D3rcP4xfOyT82ZZ6OGyIq5yD3dNJG+dHFnEFFjDH3e8HxkAQ6d8ByfXja3H4fzq
         a5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oxr5YTGpl3qCmnQ7jzJ1mzURsOCkDMcn0o5yKiLVjHk=;
        b=YrCa2bkisBONrqbBjuz1bADTTZZBcMySmxM3H1A0quFQea/8M2u01VtcPprHPXRnWK
         o7/p16Qr1kJo9MU9Of36jKmM9Z+Jc7HofNBh4DYIr9Tz37ejfYcLiWNjvXT2CHPrGJcV
         ze95yWHx/gdYMUX1Oeu9bwxFG1m2BBYfjUTvu+284UGxFs2Z1GvwYISxRgRwmGG34nOx
         F4e2wNAzmeyrLWqCVBnJalBZ2Ddr7UvTv6eC3xtcR1DqdVVUZJoqQyLiq+C+XU0TGPb0
         VOKpBbm9WKcqSrEtBDEqZXZFYK/4+xf27wArcJUVeHbnDm5qMH+wMVpKuRx+gG9MsdTe
         csyg==
X-Gm-Message-State: AOAM530VX7BINc2T6hEtLK9VfRgSWIqqaPErQzFjyrmBfGfoUVadQedW
        omccHEJ+bTbQzro7GLWaTYoysw==
X-Google-Smtp-Source: ABdhPJwp4q4H+n2t8EwsSAIeoGxof5jqJr4YurxgVxQhOgcYX02rAHX3VKDNoNbEMZAJ+ao9mDe6Bg==
X-Received: by 2002:a37:de15:: with SMTP id h21mr4809113qkj.77.1596214611012;
        Fri, 31 Jul 2020 09:56:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id j16sm8994078qke.87.2020.07.31.09.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:56:50 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k1YKv-0027Bk-Hr; Fri, 31 Jul 2020 13:56:49 -0300
Date:   Fri, 31 Jul 2020 13:56:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <20200731165649.GG24045@ziepe.ca>
References: <20200730152250.GG23808@casper.infradead.org>
 <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
 <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
 <20200731152736.GP23808@casper.infradead.org>
 <9ba26063-0098-e796-9431-8c1d0c076ffc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ba26063-0098-e796-9431-8c1d0c076ffc@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 12:11:52PM -0400, Steven Sistare wrote:
> > Your preservation-across-exec use-case might or might not need the
> > VMA to be mapped at the same address.  
> 
> It does.  qemu registers memory with vfio which remembers the va's in kernel
> metadata for the device.

Once the memory is registered with vfio the VA doesn't matter, vfio
will keep the iommu pointing at the same physical pages no matter
where they are mapped.

Jason
