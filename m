Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F25DC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EA62072A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVv0BoVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCCEbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:31:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43114 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726859AbgCCEbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 23:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583209883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G7PTv7USExYEn8kuZRYNfAsmaeP7hh+IuVMoTsdTys0=;
        b=HVv0BoVSirTjsKnuQequpaiMqjxLkSz65Fn2sLod+QPL2gngbuSQTK8t9BcV5CvQ6+IPuc
        AN4NU0Mf5Fi3XTQN/sabcmr1guYcrzN65Zi8NbBPelMlWYwwwiJL2hQjy1HYI4PH4pMCyr
        8ohf63MUO/1DM5LEkt+XNKsjdTq3cI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-ATO5EeQENWy1aM7HvrAlrw-1; Mon, 02 Mar 2020 23:31:19 -0500
X-MC-Unique: ATO5EeQENWy1aM7HvrAlrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98B7D8017DF;
        Tue,  3 Mar 2020 04:31:17 +0000 (UTC)
Received: from t490s (ovpn-116-88.phx2.redhat.com [10.3.116.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 301501001B2C;
        Tue,  3 Mar 2020 04:31:16 +0000 (UTC)
Date:   Mon, 2 Mar 2020 23:31:13 -0500
From:   Rafael Aquini <aquini@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Jon Masters <jcm@jonmasters.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Michal Hocko <mhocko@kernel.org>, QI Fuli <qi.fuli@fujitsu.com>
Subject: Re: [PATCH 2/3] arm64: select CPUMASK_OFFSTACK if NUMA
Message-ID: <20200303043113.GB94763@t490s>
References: <20200223192520.20808-1-aarcange@redhat.com>
 <20200223192520.20808-3-aarcange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223192520.20808-3-aarcange@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 02:25:19PM -0500, Andrea Arcangeli wrote:
> It's unclear why normally CPUMASK_OFFSTACK can only be manually
> configured "if DEBUG_PER_CPU_MAPS" which is not an option meant to be
> enabled on enterprise arm64 kernels.
> 
> The default enterprise kernels NR_CPUS is 4096 which is fairly large.
> So it'll save some RAM and it'll increase reliability to select
> CPUMASK_OFFSET at least when NUMA is selected and a large NR_CPUS is
> to be expected.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0b30e884e088..882887e65394 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -955,6 +955,7 @@ config NUMA
>  	bool "Numa Memory Allocation and Scheduler Support"
>  	select ACPI_NUMA if ACPI
>  	select OF_NUMA
> +	select CPUMASK_OFFSTACK
>  	help
>  	  Enable NUMA (Non Uniform Memory Access) support.
> 

Acked-by: Rafael Aquini <aquini@redhat.com>

