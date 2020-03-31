Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A410EC2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB642071A
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585664504;
	bh=3e4yfCq3SiMJAhsb+PNmLBJ6RbMYhm88+5Hk57q2zpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FJBs2YFwLGnLRArQyzNwa6yE6+Mn7z6FchvFcTixgczxgrCWiVoVSA2ccxeR6gw3d
	 7MTAdJHNU3ynMTgaE2AcrkboglydtMu61HV982qBO31QC/0ipK8kwttqHszIW+O9s0
	 qArJNAFOluUnypym+xPVtE1/UxxnRt5m3cyECHlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbgCaOVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:21:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42021 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbgCaOVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:21:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so26178253wrx.9;
        Tue, 31 Mar 2020 07:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wqixz+ZIYAqgoA7MPWIYOpEEYP0CoNu6CnseEEi5hws=;
        b=DsyXcH88Wt1uKyk4WnK7FiML7pHV/KZ4GujNwSsaNHwTENzOypEnKTJ9lmRz/XAf99
         ZGbpBwu2YT3wyTo7RHP+2PKl5KXnazntTxPfQ6Zi3xNEG5QnspNE47Y5BTwg0sJMrm1M
         MCu0khtfPO/McBMkC/i/U4ob5AEy0xhiSsunc0lvklP3c/CRAwhPAIdRwGWwBMTd8mu3
         6HhvyDcydT8QINPxcgLL2D74bkTa6fYI0/7ATd2b/xrwZX7Eb9O7wBomX/UW5Rd8uawI
         prZ+Do/fmGAE1Fqt88KF2JNqlNCdbhpplTSEGn1mSHz1g6WmO4N7oaa4S08px5H4LlPc
         OjJw==
X-Gm-Message-State: ANhLgQ0rxTiZ6AwKAkRsFO7eLurP6Y31LxHmmVeODHHYQXXbtQ90glur
        A86v8pne3zJ6joCOH8h5YHM=
X-Google-Smtp-Source: ADFU+vuyE5SEZ+dPIFAcnIpCK+KoCMyMOpra8z4yVhIRJ2B/XSHZ5tSKeX1VNNnmQoYfW1esDx7ZTg==
X-Received: by 2002:adf:eb0c:: with SMTP id s12mr20671936wrn.293.1585664500850;
        Tue, 31 Mar 2020 07:21:40 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id v7sm24508561wrs.96.2020.03.31.07.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 07:21:39 -0700 (PDT)
Date:   Tue, 31 Mar 2020 16:21:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Hoan Tran <Hoan@os.amperecomputing.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        lho@amperecomputing.com, mmorana@amperecomputing.com
Subject: Re: [PATCH v3 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by
 default for NUMA
Message-ID: <20200331142138.GL30449@dhcp22.suse.cz>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200330074246.GA14243@dhcp22.suse.cz>
 <20200330175100.GD30942@linux.ibm.com>
 <20200330182301.GM14243@dhcp22.suse.cz>
 <20200331081423.GE30942@linux.ibm.com>
 <20200331085513.GE30449@dhcp22.suse.cz>
 <20200331140332.GA2129@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331140332.GA2129@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-03-20 22:03:32, Baoquan He wrote:
> Hi Michal,
> 
> On 03/31/20 at 10:55am, Michal Hocko wrote:
> > On Tue 31-03-20 11:14:23, Mike Rapoport wrote:
> > > Maybe I mis-read the code, but I don't see how this could happen. In the
> > > HAVE_MEMBLOCK_NODE_MAP=y case, free_area_init_node() calls
> > > calculate_node_totalpages() that ensures that node->node_zones are entirely
> > > within the node because this is checked in zone_spanned_pages_in_node().
> > 
> > zone_spanned_pages_in_node does chech the zone boundaries are within the
> > node boundaries. But that doesn't really tell anything about other
> > potential zones interleaving with the physical memory range.
> > zone->spanned_pages simply gives the physical range for the zone
> > including holes. Interleaving nodes are essentially a hole
> > (__absent_pages_in_range is going to skip those).
> > 
> > That means that when free_area_init_core simply goes over the whole
> > physical zone range including holes and that is why we need to check
> > both for physical and logical holes (aka other nodes).
> > 
> > The life would be so much easier if the whole thing would simply iterate
> > over memblocks...
> 
> The memblock iterating sounds a great idea. I tried with putting the
> memblock iterating in the upper layer, memmap_init(), which is used for
> boot mem only anyway. Do you think it's doable and OK? It yes, I can
> work out a formal patch to make this simpler as you said. The draft code
> is as below. Like this it uses the existing code and involves little change.

Doing this would be a step in the right direction! I haven't checked the
code very closely though. The below sounds way too simple to be truth I
am afraid. First for_each_mem_pfn_range is available only for
CONFIG_HAVE_MEMBLOCK_NODE_MAP (which is one of the reasons why I keep
saying that I really hate that being conditional). Also I haven't really
checked the deferred initialization path - I have a very vague
recollection that it has been converted to the memblock api but I have
happilly dropped all that memory.
 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 138a56c0f48f..558d421f294b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6007,14 +6007,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  		 * function.  They do not exist on hotplugged memory.
>  		 */
>  		if (context == MEMMAP_EARLY) {
> -			if (!early_pfn_valid(pfn)) {
> -				pfn = next_pfn(pfn);
> -				continue;
> -			}
> -			if (!early_pfn_in_nid(pfn, nid)) {
> -				pfn++;
> -				continue;
> -			}
>  			if (overlap_memmap_init(zone, &pfn))
>  				continue;
>  			if (defer_init(nid, pfn, end_pfn))
> @@ -6130,9 +6122,17 @@ static void __meminit zone_init_free_lists(struct zone *zone)
>  }
>  
>  void __meminit __weak memmap_init(unsigned long size, int nid,
> -				  unsigned long zone, unsigned long start_pfn)
> +				  unsigned long zone, unsigned long range_start_pfn)
>  {
> -	memmap_init_zone(size, nid, zone, start_pfn, MEMMAP_EARLY, NULL);
> +	unsigned long start_pfn, end_pfn;
> +	unsigned long range_end_pfn = range_start_pfn + size;
> +	int i;
> +	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> +		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
> +		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
> +		if (end_pfn > start_pfn)
> +			memmap_init_zone(size, nid, zone, start_pfn, MEMMAP_EARLY, NULL);
> +	}
>  }
>  
>  static int zone_batchsize(struct zone *zone)

-- 
Michal Hocko
SUSE Labs
