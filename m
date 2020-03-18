Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2FCC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52642076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhUGXkr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgCRLHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:07:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:60303 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726733AbgCRLHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584529634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GJuHIBrfqORNK8Nk//tvsHAKGs0fyhu6IzH+S6F8COs=;
        b=HhUGXkr7trnQMPN3WqkOZ6MJ75YbdY+NWJLi0hRrPNgnVUmeMLEt8PoVRNjwkwseISNYJR
        5QNwkopcRj+yLkr5+WbtKulgp2gZbrAUqIOwCNvKeW6lDhKjIX2Vy1ve2Szx78vzlELyow
        S6HVXwgfImkkXFr0ijaSRWp9KK8zT64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-iNAxtlBPM4-TwZXDc3dohQ-1; Wed, 18 Mar 2020 07:07:10 -0400
X-MC-Unique: iNAxtlBPM4-TwZXDc3dohQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B06E3477;
        Wed, 18 Mar 2020 11:07:07 +0000 (UTC)
Received: from krava (unknown [10.40.195.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D74F894956;
        Wed, 18 Mar 2020 11:07:01 +0000 (UTC)
Date:   Wed, 18 Mar 2020 12:06:59 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        John Garry <john.garry@huawei.com>,
        Enrico Weigelt <info@metux.net>, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] perf symbols: Consolidate symbol fixup issue
Message-ID: <20200318110659.GA845874@krava>
References: <20200306015759.10084-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306015759.10084-1-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 09:57:58AM +0800, Leo Yan wrote:
> After copying Arm64's perf archive with object files and perf.data file
> to x86 laptop, the x86's perf kernel symbol resolution fails.  It
> outputs 'unknown' for all symbols parsing.
> 
> This issue is root caused by the function elf__needs_adjust_symbols(),
> x86 perf tool uses one weak version, Arm64 (and powerpc) has rewritten
> their own version.  elf__needs_adjust_symbols() decides if need to parse
> symbols with the relative offset address; but x86 building uses the weak
> function which misses to check for the elf type 'ET_DYN', so that it
> cannot parse symbols in Arm DSOs due to the wrong result from
> elf__needs_adjust_symbols().
> 
> The DSO parsing should not depend on any specific architecture perf
> building; e.g. x86 perf tool can parse Arm and Arm64 DSOs, vice versa.
> And confirmed by Naveen N. Rao that powerpc64 kernels are not being
> built as ET_DYN anymore and change to ET_EXEC.
> 
> This patch removes the arch specific functions for Arm64 and powerpc and
> changes elf__needs_adjust_symbols() as a common function.
> 
> In the common elf__needs_adjust_symbols(), it checks an extra condition
> 'ET_DYN' for elf header type.  With this fixing, the Arm64 DSO can be
> parsed properly with x86's perf tool.
> 
> Before:
> 
>   # perf script
>   main  3258          1          branches:                 0 [unknown] ([unknown]) => ffff800010c4665c [unknown] ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c46670 [unknown] ([kernel.kallsyms]) => ffff800010c4eaec [unknown] ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c4eaec [unknown] ([kernel.kallsyms]) => ffff800010c4eb00 [unknown] ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c4eb08 [unknown] ([kernel.kallsyms]) => ffff800010c4e780 [unknown] ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c4e7a0 [unknown] ([kernel.kallsyms]) => ffff800010c4eeac [unknown] ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c4eebc [unknown] ([kernel.kallsyms]) => ffff800010c4ed80 [unknown] ([kernel.kallsyms])
> 
> After:
> 
>   # perf script
>   main  3258          1          branches:                 0 [unknown] ([unknown]) => ffff800010c4665c coresight_timeout+0x54 ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c46670 coresight_timeout+0x68 ([kernel.kallsyms]) => ffff800010c4eaec etm4_enable_hw+0x3cc ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c4eaec etm4_enable_hw+0x3cc ([kernel.kallsyms]) => ffff800010c4eb00 etm4_enable_hw+0x3e0 ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c4eb08 etm4_enable_hw+0x3e8 ([kernel.kallsyms]) => ffff800010c4e780 etm4_enable_hw+0x60 ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c4e7a0 etm4_enable_hw+0x80 ([kernel.kallsyms]) => ffff800010c4eeac etm4_enable+0x2d4 ([kernel.kallsyms])
>   main  3258          1          branches:  ffff800010c4eebc etm4_enable+0x2e4 ([kernel.kallsyms]) => ffff800010c4ed80 etm4_enable+0x1a8 ([kernel.kallsyms])
> 
> v3: Changed to check for ET_DYN across all architectures.
> 
> v2: Fixed Arm64 and powerpc native building.
> 
> Reported-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

