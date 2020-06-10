Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC60C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF29B2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cg6ZckV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgFJMH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 08:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbgFJMH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 08:07:56 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78169C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 05:07:56 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id g7so860184qvx.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 05:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lro6qhLL0P88qN7ekMirUkTClLvqbIrZ+9sE8Oe/PY4=;
        b=cg6ZckV/Z2EIx+t+s118UZQfhcDtNQtRVo5hRWK0390A7cOKKmZ9afuS/hLhNpkzEA
         J/u3IzApEiFX3FulGKsCxqJGtjSMDUFKXn7nbMtI2kg2s2DrnfEfBniXGCnxclIdvad/
         oXyXigpG4sSHfnEy5EM1w/TidSnhfxDxA+gUtMZhxfFjzNloH7tj0FixiT3XxhL7wXqI
         EE6ZWSEFqSdEmMEPQ7KNvWdTqmlX/uiT0QfCNn3DjpqH+k96HTJ1UAGKAZK+gnHms6xU
         j+WFwrDSNlXzokpSV4c/bcmJBeHFSM8El1vRd0NI824WjqOInMQhH02riUvo4+Aj+wXo
         YGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lro6qhLL0P88qN7ekMirUkTClLvqbIrZ+9sE8Oe/PY4=;
        b=pzGLdf2TRCi2ILg2ohMiOn0wHIdTNPGRVlA62Hyi2XmlMb4fbAs5opKeBbMBbUr0ni
         XRxuOSq6+PquTO9CoImWq5DbbCx+w6gtASSNw2paV//ZSrzvM5c09pKlDAFWoiphIsYw
         s/MBLRdH6t1egi7cotITYIYxy1gdXLJoadDG766ITee4errn9SNwHu9+3nOPT8YsHjL+
         7q+g+xHEeDGuVEAmkjwn4BNJdRAuZAz8mXdKdaiKPTl4e4ffKEt85H6s/+VdY0DMnm4B
         7ScLNTeVihBi3UP3VmWiKRFKlLba0as0My4azeHSq3QGo5xEsgJcT6vO2MqhDXkfiodd
         kmLg==
X-Gm-Message-State: AOAM531KOz5AvrfkXyVm4iNFOeAVTlRQ54GWSzymg2plW/IWCtHLE5b7
        iLcSnQrkmFOlph7nMMGanTGDyQ==
X-Google-Smtp-Source: ABdhPJxb8/gCRbVz6ieNFA5DjYzSCSNnlTH0asHu842as71W+WpWLNO2QpDK1mRMvSt/9yx4ythZRg==
X-Received: by 2002:ad4:552b:: with SMTP id ba11mr1727278qvb.145.1591790875533;
        Wed, 10 Jun 2020 05:07:55 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l19sm12236941qtq.13.2020.06.10.05.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 05:07:54 -0700 (PDT)
Date:   Wed, 10 Jun 2020 08:07:48 -0400
From:   Qian Cai <cai@lca.pw>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: set NODES_SHIFT=0 when NUMA=n
Message-ID: <20200610120748.GA954@lca.pw>
References: <20200610014501.4268-1-cai@lca.pw>
 <20200610084553.GB4894@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610084553.GB4894@osiris>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 10:45:53AM +0200, Heiko Carstens wrote:
> On Tue, Jun 09, 2020 at 09:45:01PM -0400, Qian Cai wrote:
> > When NUMA=n and nr_node_ids=2, in apply_wqattrs_prepare(), it has,
> > 
> > for_each_node(node) {
> > 	if (wq_calc_node_cpumask(...
> > 
> > where it will trigger a booting warning,
> > 
> > WARNING: workqueue cpumask: online intersect > possible intersect
> > 
> > because it found 2 nodes and wq_numa_possible_cpumask[1] is an empty
> > cpumask. NUMA=y has no such problem because node_possible_map will be
> > initialized properly containing only node 0. Fix it by setting
> > NODES_SHIFT=0 when NUMA=n.
> > 
> > Fixes: 701dc81e7412 ("s390/mm: remove fake numa support")
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  arch/s390/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Thanks! However I committed a different solution. Hope you don't mind:

No problem with that at all.

> 
> From dd3f1f08f2317768b35b2df3ff8285185df7e195 Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> Date: Wed, 10 Jun 2020 10:36:05 +0200
> Subject: [PATCH] s390/numa: let NODES_SHIFT depend on NEED_MULTIPLE_NODES
> 
> Qian Cai reported:
> ---
> When NUMA=n and nr_node_ids=2, in apply_wqattrs_prepare(), it has,
> 
> for_each_node(node) {
>         if (wq_calc_node_cpumask(...
> 
> where it will trigger a booting warning,
> 
> WARNING: workqueue cpumask: online intersect > possible intersect
> 
> because it found 2 nodes and wq_numa_possible_cpumask[1] is an empty
> cpumask.
> ---
> 
> Let NODES_SHIFT depend on NEED_MULTIPLE_NODES like it is done
> on other architectures in order to fix this.
> 
> Fixes: 701dc81e7412 ("s390/mm: remove fake numa support")
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>  arch/s390/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 2167bce993ff..ae01be202204 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -462,6 +462,7 @@ config NUMA
>  
>  config NODES_SHIFT
>  	int
> +	depends on NEED_MULTIPLE_NODES
>  	default "1"
>  
>  config SCHED_SMT
> -- 
> 2.17.1
> 
