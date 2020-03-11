Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294EAC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED3421D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583927861;
	bh=X8vrm2ss5Ba+8w1C2C3dnf7dinwdRSWZ4ySZTkEtdD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qoCmYvsXeayq3QogMMY54rk4gDYmulIHyGj8zejBm/Sel7YmiZL+nM8c/BKhdxUs7
	 mt3EM1Urliz2QgN+aPxfC7XyMxelTo3gyG+/o9Iw0312WWnbJoqJorTPueetW5Eegy
	 F4mEgw02jvXbdJ9OEppLf24Pukh0WCeWQUFHNf/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgCKL5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:57:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55339 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbgCKL5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:57:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id 6so1762119wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 04:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tZ17rEf6Xvksk/thMYpVF8wPE/d3WH4FVyx1lotSqqk=;
        b=h/TUCiJk5eB1MVioqm40qjYY3FFY86FzGpnHgcjva0b8Kf569pEavtv39N17X3E2dA
         BVFmx9gPinyYjwp/EtHJkjuzHoFqx7YW7LP/gF7JVZsOtiMISaV14PBX0MAD9jiDBFFA
         JgQzch/8jqQPjhaq54wVA2yxFg3GZ40coF4HwH8lnQmAnajyxD+2NzTvmtopnB20tP8H
         J5LE4EvsFIyVlQGBMC52ogsguE/Xt2mfQ4irhJIitMqO/b8IjLFvG3Jj/bKULWG46lwC
         DFj++idOM50pAk5pcecMI/ksDbftwcW8SAsWBTTiqU1i+31Mt93OjqukNgSaLNVfO+8I
         UPyQ==
X-Gm-Message-State: ANhLgQ0xoyX8kGFrqhJ0+yCLsDg9vo50bOfVzA+GJir9K8yAvQClxnvK
        Rrf25zmvFsQeD5up6Il0KVMnalP/
X-Google-Smtp-Source: ADFU+vvESGFZ1n4LLTj2JSRkMK7+3YcfWoI1XMkLFpJ1FrM0KfhtH1XEz0eUrZeFKyHCNhX1niYzAA==
X-Received: by 2002:a7b:c082:: with SMTP id r2mr3683800wmh.177.1583927857619;
        Wed, 11 Mar 2020 04:57:37 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id w19sm8004689wmi.0.2020.03.11.04.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 04:57:36 -0700 (PDT)
Date:   Wed, 11 Mar 2020 12:57:35 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Christopher Lameter <cl@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] powerpc/numa: Set numa_node for all possible cpus
Message-ID: <20200311115735.GM23944@dhcp22.suse.cz>
References: <20200311110237.5731-1-srikar@linux.vnet.ibm.com>
 <20200311110237.5731-2-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311110237.5731-2-srikar@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-03-20 16:32:35, Srikar Dronamraju wrote:
> A Powerpc system with multiple possible nodes and with CONFIG_NUMA
> enabled always used to have a node 0, even if node 0 does not any cpus
> or memory attached to it. As per PAPR, node affinity of a cpu is only
> available once its present / online. For all cpus that are possible but
> not present, cpu_to_node() would point to node 0.
> 
> To ensure a cpuless, memoryless dummy node is not online, powerpc need
> to make sure all possible but not present cpu_to_node are set to a
> proper node.

Just curious, is this somehow related to
http://lkml.kernel.org/r/20200227182650.GG3771@dhcp22.suse.cz?

> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
> Cc: Christopher Lameter <cl@linux.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/numa.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 8a399db..54dcd49 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -931,8 +931,20 @@ void __init mem_topology_setup(void)
>  
>  	reset_numa_cpu_lookup_table();
>  
> -	for_each_present_cpu(cpu)
> -		numa_setup_cpu(cpu);
> +	for_each_possible_cpu(cpu) {
> +		/*
> +		 * Powerpc with CONFIG_NUMA always used to have a node 0,
> +		 * even if it was memoryless or cpuless. For all cpus that
> +		 * are possible but not present, cpu_to_node() would point
> +		 * to node 0. To remove a cpuless, memoryless dummy node,
> +		 * powerpc need to make sure all possible but not present
> +		 * cpu_to_node are set to a proper node.
> +		 */
> +		if (cpu_present(cpu))
> +			numa_setup_cpu(cpu);
> +		else
> +			set_cpu_numa_node(cpu, first_online_node);
> +	}
>  }
>  
>  void __init initmem_init(void)
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
