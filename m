Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAFEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6419120829
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597236931;
	bh=mXly54u4w2qumR81YPrNyX0DA9vQM9xDXzjN+qh7F+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zEcRRtBP1OeWjN62XcrW/2Ojf24X6/jYKq3Sk/dZNo+Rf/5qv1WFAfzL9FrIKaZSf
	 9PpG+GBPOyzo19IWuD/8It8E/Rj4s0coOi/KIl48A5upEtbNRsv+jnfNgCgrNAfQqe
	 M2eGPgbtzcisfRkMFmfXfXXCYDK8qiZPzD1pAw6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHLMza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgHLMz3 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:55:29 -0400
Received: from quaco.ghostprotocols.net (179.176.8.134.dynamic.adsl.gvt.net.br [179.176.8.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6264204FD;
        Wed, 12 Aug 2020 12:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597236929;
        bh=mXly54u4w2qumR81YPrNyX0DA9vQM9xDXzjN+qh7F+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=warfki9YzH5ww6FY9WWd2nxmbzWymjWEO4CRUR6wHwiF9aLOSuyytKHvxSXSwcs5F
         KGqqfJylpp2wp2Q1hanHbx16ed+AeRW4kcB4Lneojvmg7SjB+rtFM7zefXYoKIFTf4
         5xNGAzG4pUHogVrf2mW6KFrD+Hnx+kfLJZoOIgCo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4A0C04097F; Wed, 12 Aug 2020 09:55:26 -0300 (-03)
Date:   Wed, 12 Aug 2020 09:55:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        like.xu@linux.intel.com
Subject: Re: [PATCH] perf parse-events: Set exclude_guest for user-space
 counting
Message-ID: <20200812125526.GM13995@kernel.org>
References: <20200812065953.22143-1-yao.jin@linux.intel.com>
 <20200812121504.GE13995@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812121504.GE13995@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 12, 2020 at 09:15:04AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Aug 12, 2020 at 02:59:53PM +0800, Jin Yao escreveu:
> > Currently if we run 'perf record -e cycles:u', exclude_guest is 0.
> > 
> > But it doesn't make sense that we request for user-space counting
> > but we also get the guest report.
> > 
> > To keep perf semantics consistent and clear, this patch sets
> > exclude_guest for user-space counting.
> 
> Applied, and also added this, that you should consider doing in the
> future (modulo the "Committer testing:" header :) ):
> 
> Committer testing:
> 
> Before:
> 
>   # perf record -e cycles:u
>   ^C[ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 1.231 MB perf.data (91 samples) ]
>   #
>   # perf evlist -v
>   cycles:u: size: 120, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ID|CPU|PERIOD, read_format: ID, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, freq: 1, sample_id_all: 1
>   <SNIP>
>   #
> 
> After:
> 
>   # perf record -e cycles:u
>   ^C[ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 1.263 MB perf.data (403 samples) ]
>   #
>   # perf evlist -v
>   cycles:u: size: 120, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ID|CPU|PERIOD, read_format: ID, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, freq: 1, sample_id_all: 1, exclude_guest: 1
>   #

Also, please run 'perf test', as this will require changes to some
expected perf_event_attr setups:

[root@quaco ~]# perf test "event definition"
 6: Parse event definition strings                        : FAILED!
[root@quaco ~]#

- Arnaldo
