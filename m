Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E14C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 564E120773
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1AhPU9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgFZPXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFZPXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:23:34 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81967C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:23:34 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c139so9062719qkg.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=AcfGMzYp7QqfA2+kE0gyDBm3KnBHvfAWT9HgF7mZJ8Y=;
        b=j1AhPU9qp6hE6bSHig7NwWJXhfyzdEkDs3C7God/Eh4gBV6HCsFAOUEJDrlfxb3XG2
         w3jie5LDsUHP5ks9naDcnHuDFpIiZ+Y0zAUT0iEGl5xrdwD6Aez4kNtfRPYMB+SkuWuL
         D4mCU2q7wcTS6tDaouTps7GUhbjlgIH31NV+Sfnvcbvzd380gdV9KMDFDNsSTLyApAl3
         MIEjT7fA+gG9dKIBf4GLSHvcLtZWVDR7rF/93pBUQqvNDsaRkG7lLAr8rnqz/UqkLSD1
         ALJqPF8k6omIKdzsQ89y4oLUjmhUi+AiuF89DOKEuBb6JAj1UOQE/6GWYyO1Z/dhi7cu
         JbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=AcfGMzYp7QqfA2+kE0gyDBm3KnBHvfAWT9HgF7mZJ8Y=;
        b=QtDrUtauVc5+V0k0gWAWk2Pe9fiRHSgFwNY1BhkX6Lm015kold0bX4PUCk74BJxCHx
         54A2NhLLMjj5bTbMooD7EOupjaHXGIoLJcsdt+Yp4pWawzB8uI+4ZLoJ8wTGczVE13h3
         vjAyet2hFtLE5E1S1evfcpjny7sNkE5B0s+A9VV0nNvKuxfRm41Z+Ih4+/GaXjJVPEWs
         /tKWT66kfieQOH9+Seg/bxBboMCcVv4pCZnRkkj1Aiq6SUD1LrPGKRbIZMkYnrOJvL6L
         pJ1chUShGISihDvSRo/dGLrTipqDblNzkCXR7wHYYV4Okl+mZn+tiS+nj7wRrakJhkIh
         Zl3w==
X-Gm-Message-State: AOAM533q6E1y74ZF7n0+mcbyBHo5hxm2F9xrLfTlpy7nnyHLQHVr8Bq4
        odtAU/dMxbFgxZKI7ZnvukU=
X-Google-Smtp-Source: ABdhPJyYqRHXlQ9Y8424iFw4ajWlqOYStgwldP/zJe3QQZ1Kbeq+GnV0kcw5Wo5sotNmovMyH3yqDg==
X-Received: by 2002:a37:c50:: with SMTP id 77mr933027qkm.445.1593185013732;
        Fri, 26 Jun 2020 08:23:33 -0700 (PDT)
Received: from LeoBras (200-236-242-115.dynamic.desktop.com.br. [200.236.242.115])
        by smtp.gmail.com with ESMTPSA id q47sm9765744qta.16.2020.06.26.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:23:33 -0700 (PDT)
Message-ID: <14da928d1cae8779a93228455c4873c127eeffa6.camel@gmail.com>
Subject: Re: [PATCH v2 5/6] powerpc/pseries/iommu: Make use of DDW even if
 it does not map the partition
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 26 Jun 2020 12:23:28 -0300
In-Reply-To: <20200624062411.367796-6-leobras.c@gmail.com>
References: <20200624062411.367796-1-leobras.c@gmail.com>
         <20200624062411.367796-6-leobras.c@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-24 at 03:24 -0300, Leonardo Bras wrote:
> As of today, if a DDW is created and can't map the whole partition, it's
> removed and the default DMA window "ibm,dma-window" is used instead.
> 
> Usually this DDW is bigger than the default DMA window, so it would be
> better to make use of it instead.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> ---

I tested this change with a 256GB DDW which did not map the whole
partition, with a MT27700 Family [ConnectX-4 Virtual Function].

I noticed the performance improvement is about the same as using DDW
with IOMMU bypass.

64 thread write throughput: +203.0%
64 thread read throughput: +17.5%
1 thread write throughput: +20.5%
1 thread read throughput: +3.43%
Averag
e write latency: -23.0%
Average read latency:  -2.26%


