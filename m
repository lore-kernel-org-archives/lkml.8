Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F82C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E1E20791
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exJz/odP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgH2Kyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 06:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH2KvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:51:19 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ADCC061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 03:51:19 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u24so2975444oic.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 03:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KvyskJqqctuilg5K6B7ivW/tu8NbcRZlLPbLA094dgs=;
        b=exJz/odPOJBlb6JQhv+k4ICurPyWcyz3F0V/Sb2ul/zBgA0ZD1DTZ4CWAcdYPw5uzL
         p91OWciSWz3Nu5cWlF/xqa6UceXdu+U9UMEWkLz6ArPKEE4M/becW43L+4Br4qC7tXlI
         kTmke8jBft8pfa0j0MEdY3rg34T71TCtFp7B9eQYCLjgYmJhqUaoZhXtzDh60OBMEI8A
         MoXMA21G+pNuDykXvCgnIyiQCL1x83spp1SgqiuVXj9Fkm2s3IRmyEmiXT8qbfm6UvSj
         NIFZCaG45/sZPqop9b5zIWM+U05zOL6Xp9ctek3d4KQDh3LW9/r9ZJxmBjq/UKv3PqyG
         IdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KvyskJqqctuilg5K6B7ivW/tu8NbcRZlLPbLA094dgs=;
        b=sXYKSM6a06kOXuCnU2RIG9EpCj5x3HNW8R5H1d5HeL3Y+M1TvDyjXGGVUtnaB5GUPR
         zMR7eRP6TbVXWskfQaqwHf4xdcUWp1/fzw649BFqn3WSCFo7kGZAaJmuvl+gb2yuiz0B
         eiZdYAMQ/XTKVNn6/wX+aQMqnnK0lWyEtY6wbFcQLTA18/h4H632eUgFborilGE2dnK8
         pNncpc6am00aFZMFfPKfELLx/UnAAKnzj/h628RH4WVK8IeU6nKtT3roYU+3ourh6fmH
         7oWx7G+cDqJ1pW9W6y5AQKJQ2r/YuMYdKbSu0TkwWYzRlRIenZ1DtRu0l6jgYQuSs6td
         w4AA==
X-Gm-Message-State: AOAM531x1mDAMOd2mY3cQEL9weuPC/6hSv2p0zu6kFRME5SurCJ7IiC/
        kbt45rxlxIsrOiDZ0rzxKeT8Y6Ysqpw=
X-Google-Smtp-Source: ABdhPJyCLhFARiJbhB6bpXQ4eSLxJUJuxwU3Sn/yV2brgqBH1q0H6A1ngQdPzXRO+EwmIBTeUsQbSQ==
X-Received: by 2002:aca:afc3:: with SMTP id y186mr1655045oie.94.1598698278470;
        Sat, 29 Aug 2020 03:51:18 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g4sm490635otq.33.2020.08.29.03.51.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Aug 2020 03:51:17 -0700 (PDT)
Date:   Sat, 29 Aug 2020 03:51:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] kernel.h: Silence sparse warning in lower_32_bits
Message-ID: <20200829105116.GA246533@roeck-us.net>
References: <20200828071125.GA18772@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828071125.GA18772@gondor.apana.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 05:11:25PM +1000, Herbert Xu wrote:
> I keep getting sparse warnings in crypto such as:
> 

This patch results in the following compile error when compiling 
ppc:mpc85xx_defconfig.

Error log:
In file included from ./include/linux/list.h:9,
                 from ./include/linux/module.h:12,
                 from drivers/dma/fsldma.c:23:
drivers/dma/fsldma.h: In function 'fsl_ioread64':
./include/linux/kernel.h:189:37: error: invalid operands to binary & (have 'const u64 *' {aka 'const long long unsigned int *'} and 'unsigned int')
  189 | #define lower_32_bits(n) ((u32)((n) & 0xffffffff))
      |                                     ^
drivers/dma/fsldma.h:208:17: note: in expansion of macro 'lower_32_bits'
  208 |  u32 fsl_addr = lower_32_bits(addr);
      |                 ^~~~~~~~~~~~~
drivers/dma/fsldma.h: In function 'fsl_ioread64be':
./include/linux/kernel.h:189:37: error: invalid operands to binary & (have 'const u64 *' {aka 'const long long unsigned int *'} and 'unsigned int')
  189 | #define lower_32_bits(n) ((u32)((n) & 0xffffffff))
      |                                     ^
drivers/dma/fsldma.h:222:17: note: in expansion of macro 'lower_32_bits'
  222 |  u32 fsl_addr = lower_32_bits(addr);
      |                 ^~~~~~~~~~~~~
make[2]: *** [drivers/dma/fsldma.o] Error 1

Bisct log attached.

Guenter

---
# bad: [4d41ead6ead97c3730bbd186a601a64828668f01] Merge tag 'block-5.9-2020-08-28' of git://git.kernel.dk/linux-block
# good: [15bc20c6af4ceee97a1f90b43c0e386643c071b4] Merge tag 'tty-5.9-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect start 'HEAD' '15bc20c6af4c'
# good: [5ec06b5c0d259a8c7c4376b121b2f62dfbfe57ef] Merge tag 'drm-fixes-2020-08-28' of git://anongit.freedesktop.org/drm/drm
git bisect good 5ec06b5c0d259a8c7c4376b121b2f62dfbfe57ef
# bad: [326e311b849426a95cac0149406efb2bbd13fa65] Merge tag 'pm-5.9-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad 326e311b849426a95cac0149406efb2bbd13fa65
# good: [e30942859030199dab5ad73f95faac226133c639] Merge tag 'writeback_for_v5.9-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
git bisect good e30942859030199dab5ad73f95faac226133c639
# bad: [96d454cd2c1668010406ea4c28ab915bcbb747f4] Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect bad 96d454cd2c1668010406ea4c28ab915bcbb747f4
# good: [e9ee186bb735bfc17fa81dbc9aebf268aee5b41e] KVM: arm64: Add kvm_extable for vaxorcism code
git bisect good e9ee186bb735bfc17fa81dbc9aebf268aee5b41e
# good: [71a7f8cb1ca4ca7214a700b1243626759b6c11d4] KVM: arm64: Set HCR_EL2.PTW to prevent AT taking synchronous exception
git bisect good 71a7f8cb1ca4ca7214a700b1243626759b6c11d4
# bad: [ef91bb196b0db1013ef8705367bc2d7944ef696b] kernel.h: Silence sparse warning in lower_32_bits
git bisect bad ef91bb196b0db1013ef8705367bc2d7944ef696b
# first bad commit: [ef91bb196b0db1013ef8705367bc2d7944ef696b] kernel.h: Silence sparse warning in lower_32_bits
