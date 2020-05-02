Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452C0C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 22:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C0BC206B8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 22:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgEBWzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 18:55:17 -0400
Received: from gentwo.org ([3.19.106.255]:55930 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728576AbgEBWzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 18:55:17 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 28E4C3ED19; Sat,  2 May 2020 22:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 2680B3ED18;
        Sat,  2 May 2020 22:55:16 +0000 (UTC)
Date:   Sat, 2 May 2020 22:55:16 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/3] powerpc/numa: Set numa_node for all possible
 cpus
In-Reply-To: <20200501031128.19584-2-srikar@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.21.2005022254170.28355@www.lameter.com>
References: <20200501031128.19584-1-srikar@linux.vnet.ibm.com> <20200501031128.19584-2-srikar@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 May 2020, Srikar Dronamraju wrote:

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


Can this be folded into numa_setup_cpu?

This looks more like numa_setup_cpu needs to change?

