Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36642C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FAD52068F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ks2IMMSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgF3CNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgF3CNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:13:31 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E8FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 19:13:31 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p3so9203295pgh.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 19:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MF0tumyvJgF2EIXZ5PzsAvRuflwiBGHgtFazb+SuUko=;
        b=ks2IMMSAj5icRXiW6QCKN8i6yB/Zf3rYSqHgKQPp11BqkRTO33B8vGpq4rlDxEFqlM
         c0nO8/c7Yhq9WD1S6L+u0rc+Jzn3Aydcv3sV3smeGDD4GLWFNp7lb9fTap9QnkPOO5S0
         SgQDFpcP83zZ1SHbfcv6IrfMikKuTC8NBpAAiH1WSIMAipUvNZglh2VSW4AP+tS6I859
         m46RapogpuEPKKVOmB9GGlx/k9wJge6T2RezhGLVZdsuKSuAkvKF1NJ7i3VJufobL+fN
         xcCx4DT2MfNe9xTmMDww1JYwQQ2QAGB8yYkPTr8bIDrv8SmhHJv8UC2KuTFnfsVdVVeP
         NQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MF0tumyvJgF2EIXZ5PzsAvRuflwiBGHgtFazb+SuUko=;
        b=IbawD7tj4g4NCThhhmQS+bOfyiJOZVMpj+G3nQb/naHz6X+QLLVnlj8SIhL3nawvpm
         B1tK31LfOu3hQYYF4CjaijuH421JRrI6JB28YYM8RxB20McI+ra8k/eylfgD5qzku+Jt
         bl5yzaqklsPIZ89YNH/W307fkFIdXZ5HOjM6/aKBfkls9dm5u0+vb2i2rLfDLss0YHGU
         Hd/1KsccQHBKUO9jL6gAS/p1vOYtJAKbk23pT2JbqeuN7gwJxq1lorDxW9/RGEJW9GN5
         3aVuRhH2PknLZbp+6zZLRwpD0euBkGzAwdKNDjGWQSt5YfSdEORZtwGWoS3D93A46vup
         UU/g==
X-Gm-Message-State: AOAM533cVJKPRHaruB1hLC7yyz4UahzcNkeDKvytN0IzauY9xrPT+rwI
        VyBkbwEJ2r58qZ1YgYNU8UdPjQ==
X-Google-Smtp-Source: ABdhPJxGsYpxRXI7kPx2ZPOl5Jey6CBmjf/tVXRs+llJKu9reGs17JeQbwjqrJPhWtM4+XWKUcV5OA==
X-Received: by 2002:a65:51ca:: with SMTP id i10mr13324341pgq.115.1593483211317;
        Mon, 29 Jun 2020 19:13:31 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id s68sm650280pjb.38.2020.06.29.19.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 19:13:30 -0700 (PDT)
Date:   Mon, 29 Jun 2020 19:13:30 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mike Rapoport <rppt@linux.ibm.com>
cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: ERROR: "min_low_pfn" undefined!
In-Reply-To: <202006300524.y9r1ZSHI%lkp@intel.com>
Message-ID: <alpine.DEB.2.22.394.2006291911220.1118534@chino.kir.corp.google.com>
References: <202006300524.y9r1ZSHI%lkp@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020, kernel test robot wrote:

> Hi Alexander,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7c30b859a947535f2213277e827d7ac7dcff9c84
> commit: f220df66f67684246ae1bf4a4e479efc7c2f325a intel_th: msu-sink: An example msu buffer "sink"
> date:   11 months ago
> config: microblaze-randconfig-c023-20200629 (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    ERROR: "min_low_pfn" [drivers/rpmsg/virtio_rpmsg_bus.ko] undefined!
> >> ERROR: "min_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu_sink.ko] undefined!
>    ERROR: "min_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu.ko] undefined!
>    ERROR: "min_low_pfn" [drivers/mmc/core/mmc_core.ko] undefined!
>    ERROR: "min_low_pfn" [drivers/md/dm-crypt.ko] undefined!
>    ERROR: "min_low_pfn" [drivers/net/wireless/ath/ath6kl/ath6kl_sdio.ko] undefined!
>    ERROR: "min_low_pfn" [crypto/tcrypt.ko] undefined!
>    ERROR: "min_low_pfn" [crypto/asymmetric_keys/asym_tpm.ko] undefined!
> 

Looks like we have precedence for min_low_pfn failures and we can't blame 
this poor commit :)

I wonder why we don't simply do EXPORT_SYMBOL() in mm/memblock.c, 
non-microblaze architectures do this themselves because it doesn't get 
generically exported:

arch/ia64/kernel/ia64_ksyms.c:EXPORT_SYMBOL(min_low_pfn);       /* defined by bootmem.c, but not exported by generic code */
arch/sh/kernel/sh_ksyms_32.c:EXPORT_SYMBOL(min_low_pfn);

Adding Mike Rapoport.
