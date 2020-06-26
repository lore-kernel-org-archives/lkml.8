Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D02C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1F6206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEMYkxYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgFZRzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgFZRzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:55:55 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD33C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 10:55:55 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t11so2827259qvk.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 10:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=vbJSwJZjtdDURxHhSOHbJ4FVNNa89m/NxVA+tcIHMV4=;
        b=kEMYkxYnXu8l1k19YvYaordAe8ggm/SuTS8JBm/x5iX5HWzGdK9fKk4gnlqxGoolGT
         sEL6K/HPhTKZSFpmfEnTOSsbFLEJkWdDdBq3Rwok22rTzkxD1wpjg6nvTNgy/Hnl7z6c
         m1ukLvcxCMpKyxZCj4OjNKqjBJb8aMRNUBY5z2xAtCWh9bRKCbRm2kmIK6MloUgLy5/l
         tjde7eS2aGpHYzVo8fqWuoHd9QuYRbY3IVXu5SWRP8/ZTmFRyzsuiESUdD2fU8J4W3ZV
         FVZn1qX9tqFb9TotveOIXPYFQi4LBKjtkzlpCMeeGDMy1JrG0Qf5c7U6ePpzcPDWs3M/
         AbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=vbJSwJZjtdDURxHhSOHbJ4FVNNa89m/NxVA+tcIHMV4=;
        b=b5o4IGGjHCbn6GPXV58pPgAL8Gn0Uus8upweaZ6yswzM1GQ28mU6UAdGm9c37FKeQA
         ajzCHkgi8oREym1t4Zo3OLnW6PRbpoCb6hrANboqg7hTJIydnupC2bO5XbCl4D80a7p5
         alTrfnTaKdBXQTbhdKxokJyJNfx4nBXM3x/kXoq+t8n2+s/NE9H5lCl4A4b22H7dpK1a
         YKs+8bWfHS8hbK6qCtdwZ/ihmpTQv3+rj+Jld2RlFwMGBKeNSIzkielOSjhfjQ0lTv0t
         H9I+HSWGwKiyVDDwCAeQo6l4FEqB36mjzAS4NhoD7wiCScJ3lRdzeOL3bTzxYo1TVrN2
         fm8g==
X-Gm-Message-State: AOAM532itJ/6JQcvt7g5rhm39amWB07arYBTJkQOhoSS4vXzq3V+myl1
        TmR96eHf3m6rf21fRKC6zY9uHWc2
X-Google-Smtp-Source: ABdhPJyuyzA1nnZI8Q1DLNU6cc/82r+MSHrV/ixGeAuexUDpSqk05oz0uxYHO/xkNGqqIRlq0puLfg==
X-Received: by 2002:a0c:ba0e:: with SMTP id w14mr4357491qvf.222.1593194154665;
        Fri, 26 Jun 2020 10:55:54 -0700 (PDT)
Received: from LeoBras (200-236-242-115.dynamic.desktop.com.br. [200.236.242.115])
        by smtp.gmail.com with ESMTPSA id g145sm9046493qke.17.2020.06.26.10.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 10:55:53 -0700 (PDT)
Message-ID: <d58faed1e9e35becb80f2737ed4be3d422507d6e.camel@gmail.com>
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
Date:   Fri, 26 Jun 2020 14:55:41 -0300
In-Reply-To: <14da928d1cae8779a93228455c4873c127eeffa6.camel@gmail.com>
References: <20200624062411.367796-1-leobras.c@gmail.com>
         <20200624062411.367796-6-leobras.c@gmail.com>
         <14da928d1cae8779a93228455c4873c127eeffa6.camel@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-06-26 at 12:23 -0300, Leonardo Bras wrote:
> On Wed, 2020-06-24 at 03:24 -0300, Leonardo Bras wrote:
> > As of today, if a DDW is created and can't map the whole partition, it's
> > removed and the default DMA window "ibm,dma-window" is used instead.
> > 
> > Usually this DDW is bigger than the default DMA window, so it would be
> > better to make use of it instead.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > ---
> 
> I tested this change with a 256GB DDW which did not map the whole
> partition, with a MT27700 Family [ConnectX-4 Virtual Function].
> 
> I noticed the performance improvement is about the same as using DDW
> with IOMMU bypass.
> 
> 64 thread write throughput: +203.0%
> 64 thread read throughput: +17.5%
> 1 thread write throughput: +20.5%
> 1 thread read throughput: +3.43%
> Average write latency: -23.0%
> Average read latency:  -2.26%

The above improvements are based on the default DMA window, which is
currently used if DDW can't map the whole partition.

Those values are an average of 20 tests for each environment, 30
seconds each test.

I also did some intense testing, for 5 hour each:
64 thread write throughput 
64 thread read throughput

The throughput values are stable in the whole test, and I noticed no
error on dmesg / journalctl.

