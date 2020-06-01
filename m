Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F305EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C712E20679
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgFAMo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:44:29 -0400
Received: from freki.datenkhaos.de ([81.7.17.101]:56964 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgFAMo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:44:28 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jun 2020 08:44:27 EDT
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id EABFD2B86B87;
        Mon,  1 Jun 2020 14:38:58 +0200 (CEST)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NULsTUv70MaJ; Mon,  1 Jun 2020 14:38:56 +0200 (CEST)
Received: from latitude (vpn150.rz.tu-ilmenau.de [141.24.172.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA;
        Mon,  1 Jun 2020 14:38:56 +0200 (CEST)
Date:   Mon, 1 Jun 2020 14:38:50 +0200
From:   Johannes Hirte <johannes.hirte@datenkhaos.de>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@elte.hu,
        irogers@google.com, kim.phillips@amd.com, jolsa@redhat.com
Subject: Re: [PATCH v2 1/5] perf/x86/rapl: move RAPL support to common x86
 code
Message-ID: <20200601123850.GA213137@latitude>
References: <20200527224659.206129-1-eranian@google.com>
 <20200527224659.206129-2-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200527224659.206129-2-eranian@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020 Mai 27, Stephane Eranian wrote:

...
> diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
> index 6f1d1fde8b2de..12c42eba77ec3 100644
> --- a/arch/x86/events/Makefile
> +++ b/arch/x86/events/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y					+= core.o probe.o
> +obj-$(PERF_EVENTS_INTEL_RAPL)		+= rapl.o
>  obj-y					+= amd/
>  obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
>  obj-$(CONFIG_CPU_SUP_INTEL)		+= intel/

With this change, rapl won't be build. Must be:

obj-$(CONFIG_PERF_EVENTS_INTEL_RAPL)                += rapl.o

-- 
Regards,
  Johannes Hirte

