Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9445C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8F22080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G61Kd4ZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgCaTdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:33:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34823 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgCaTdP (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:33:15 -0400
Received: by mail-qt1-f193.google.com with SMTP id e14so19498077qts.2
        for <Linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UY9X0MKS0KRbxCZiJKr9L0SAunbkTQb1LGpb32vbozs=;
        b=G61Kd4ZB1RUNmQrEWfEEnBIoCKAusRPGlVHEg0DXRuTXhos3pSPF21PMcJy72vHEhw
         wh/wqr/Pm6GGa3uYKAZxi/TJZOd8Af+AD5bHIbXXnaJC78GGjMSn8bEivg403lGkD0sW
         S1fWsZe2fgLLtHcChBl1QcbpDyP6LvpObfdVZsJFES8JV4hfGcgJ6+E/UJS/BeOQgnq7
         NaW0UN5n9M1XW6pJXlOFSp0WRSrvPzUvVpNYCEuHPAQ6aunFmtpTD5xiWjeAd9tAiIzp
         YpJovUPofl3KGv8lR4e6WtLxqcJv3+bx2UQP/fFTp4jAO9i9uYaA8Ss92TpXIPb7ovCs
         bmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UY9X0MKS0KRbxCZiJKr9L0SAunbkTQb1LGpb32vbozs=;
        b=QBoouzwaFAzOBuOqX5yMWfVqpMJn8rICToD+hfQGyFit060hHuEwBgyIJhidond99O
         yww50GfD6/uhDOoEKpuMAbD4pm5+CWU2TgqVS1wV8RZqF3YYx7jILMqzTCmzxzVFC4w+
         ImATP95I+PIaolBh7eDB/YByMXzBmU7DBGvqTCoFAT7nRKMGUW3VV/YLSJjVvm1Iq3YO
         A7LNB6FMUYvAKDnbXzI+q3t/5ZivvbdrroLmZWt8sew+Rwnw2HyWB+RBw5cpHkHri7ki
         7Z9LixK7KYiQ4dxs+jWP3uJhHa9+U6wIIWmfq9jCe8EK1BpmRSN5H62WP3E3Dj/2h8aP
         cmDw==
X-Gm-Message-State: ANhLgQ24FPbAygQSZupSL7UvpcK6tYBHw3dI448igWjfDEd1xwxsQTHw
        rOquQI5ith1cWdit5bLBf2w=
X-Google-Smtp-Source: ADFU+vtg1YapJq5vkHadcUIc/g/tecV2BNECymNBXHjDHZqqCuKoP/k74MgJwwmqNJlXit8Pp7mTZg==
X-Received: by 2002:ac8:7b2f:: with SMTP id l15mr6690666qtu.320.1585683193906;
        Tue, 31 Mar 2020 12:33:13 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id o11sm14211328qtb.24.2020.03.31.12.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:33:13 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E4FC7409A3; Tue, 31 Mar 2020 16:33:10 -0300 (-03)
Date:   Tue, 31 Mar 2020 16:33:10 -0300
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf/x86/pmu-events: Use CPU_CLK_UNHALTED.THREAD in
 Kernel_Utilization metric
Message-ID: <20200331193310.GO9917@kernel.org>
References: <20200309013125.7559-1-yao.jin@linux.intel.com>
 <3e2ee47f-d351-64c3-b547-993a2b65f871@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e2ee47f-d351-64c3-b547-993a2b65f871@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 31, 2020 at 03:30:25PM -0400, Liang, Kan escreveu:
> 
> 
> On 3/8/2020 9:31 PM, Jin Yao wrote:
> > The kernel utilization metric does multiplexing currently and is somewhat
> > unreliable. The problem is that it uses two instances of the fixed counter,
> > and the kernel has to multipleplex which causes errors. So should use
> > CPU_CLK_UNHALTED.THREAD instead.
> > 
> > Before:
> > 
> >    # perf stat -M Kernel_Utilization -- sleep 1
> > 
> >    Performance counter stats for 'sleep 1':
> > 
> >            1,419,425      cpu_clk_unhalted.ref_tsc:k
> >        <not counted>      cpu_clk_unhalted.ref_tsc	(0.00%)
> > 
> > After:
> > 
> >    # perf stat -M Kernel_Utilization -- sleep 1
> > 
> >    Performance counter stats for 'sleep 1':
> > 
> >              746,688      cpu_clk_unhalted.thread:k #      0.7 Kernel_Utilization
> >            1,088,348      cpu_clk_unhalted.thread
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied.

- Arnaldo
