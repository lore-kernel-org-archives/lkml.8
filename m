Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F0DC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F2CC20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="HcmtsGhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgEKL0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:26:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35281 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728638AbgEKL0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:26:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49LJYN0Wgxz9sV6;
        Mon, 11 May 2020 21:26:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1589196409;
        bh=4NvXf9toL+4UXpT6HxsGqGALQmokSTs3VQyX07XztTk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HcmtsGhW3vvibCLKVXSur3CJ6fDr8ntOm4mcDszKPhs4GTP737/Wdfw0z6huCxBCe
         HVcsEEd/MTSe9PIvxR4g1mJyWlY9pNfzuhdWrgSLDvrxv0HoV0uCl81kNTDqjk5Cxc
         TgCZNgAde0FVNfAZ4JhAxZ7N9PiEsN+zjxPDzb7Rc4uXtU4HmRtqRWhhDdLzWuCB8l
         GZBwk+W4cMwAKVsgp5G9PAyRFVaBbJ0zWJP9A9TDVJYCcc8SUNVV+6i8c+OlC0UZIZ
         A+Tdq4kCohHBk3kW2wY1c8d3rP7bLfFFQlHv8A/x1THr3dNj5iLBtWGWEfQ2IcZBQ0
         S3FUgyHwBmyow==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Christopher Lameter <cl@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/3] powerpc/numa: Set numa_node for all possible cpus
In-Reply-To: <20200508132130.GC1961@linux.vnet.ibm.com>
References: <20200501031128.19584-1-srikar@linux.vnet.ibm.com> <20200501031128.19584-2-srikar@linux.vnet.ibm.com> <alpine.DEB.2.21.2005022254170.28355@www.lameter.com> <20200508132130.GC1961@linux.vnet.ibm.com>
Date:   Mon, 11 May 2020 21:27:07 +1000
Message-ID: <87v9l2btkk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> * Christopher Lameter <cl@linux.com> [2020-05-02 22:55:16]:
>
>> On Fri, 1 May 2020, Srikar Dronamraju wrote:
>> 
>> > -	for_each_present_cpu(cpu)
>> > -		numa_setup_cpu(cpu);
>> > +	for_each_possible_cpu(cpu) {
>> > +		/*
>> > +		 * Powerpc with CONFIG_NUMA always used to have a node 0,
>> > +		 * even if it was memoryless or cpuless. For all cpus that
>> > +		 * are possible but not present, cpu_to_node() would point
>> > +		 * to node 0. To remove a cpuless, memoryless dummy node,
>> > +		 * powerpc need to make sure all possible but not present
>> > +		 * cpu_to_node are set to a proper node.
>> > +		 */
>> > +		if (cpu_present(cpu))
>> > +			numa_setup_cpu(cpu);
>> > +		else
>> > +			set_cpu_numa_node(cpu, first_online_node);
>> > +	}
>> >  }
>> 
>> Can this be folded into numa_setup_cpu?
>> 
>> This looks more like numa_setup_cpu needs to change?
>
> We can fold this into numa_setup_cpu().
>
> However till now we were sure that numa_setup_cpu() would be called only for
> a present cpu. That assumption will change.
> + (non-consequential) an additional check everytime cpu is hotplugged in.
>
> If Michael Ellerman is okay with the change, I can fold it in.

Yes I agree it would be better in numa_setup_cpu().

cheers
