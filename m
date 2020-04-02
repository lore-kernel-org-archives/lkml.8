Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB09C18E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED512080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585814510;
	bh=oNYD5ahhWjF63u39Uh8uxNxOhgOkmZwwjdOyz2LM16E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jDwlJoqdI2nd/qGP4gvRa+9LMqTvqK8BkacjIeRH5vtqe8LX6VrY5srEFKoCTTVES
	 uFUrhroMjG2eGlowN27CwMV30X9jK3dObGILLZOivTWhgegRWDngNKLkeCAMR0gE5j
	 32sM03apXTtqxC6JRihR/EWwsnpBJM/CYqdRquaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387681AbgDBIBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:01:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52817 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387403AbgDBIBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:01:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id t8so2346786wmi.2;
        Thu, 02 Apr 2020 01:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UrBSIQuzAujdG2IKZQy1WDw2nZSqWHmIp0pyFUuT55I=;
        b=LrggHGRMVSGYe3cA9hzSQ9/2bZIts+IiiLjba5rhCXl6Cm1YiC6zpadBohM4floUPE
         6ZM98hVNKBNijEnd4t0Ldy0WAS2bw2VNrLTEEED6inMji83qPVWCzea0gkIgkLQwqYu6
         cLzqu+XddQ89E3RZ+fdpak571z5N0joWyLooWiiI3Yjs8l0qP9L+C1tzYrfsxm6ZvVEO
         TsvJ4jf9CU7BaywTGIsZCUZbT3DKzhhLYv10Y86Ua7mvoMDlJPy2D+o72zqC0u3e48kA
         +bL+xjCYuAus2Qm4CJv6XFZCJTlbIORMhn97eWEc7qo1KvDqL6WUKtvSVMhFXwi38euk
         Rzsg==
X-Gm-Message-State: AGi0Pua694FIJ8XxF6lH1ijv65yZ6DDKtSSGumPvY0WBssKLv4ai6/wx
        qnuCqoe1nzDJJHmTCz4udxs=
X-Google-Smtp-Source: APiQypLKMYqb9qsRd12t2lZK0oNaHQe5op/Ct4om+69/3ikerP3v6RKRd1oyx6YEyyBTpuIaTaPA/w==
X-Received: by 2002:a1c:4d16:: with SMTP id o22mr2320220wmh.56.1585814506667;
        Thu, 02 Apr 2020 01:01:46 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id v21sm5906815wmh.26.2020.04.02.01.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 01:01:45 -0700 (PDT)
Date:   Thu, 2 Apr 2020 10:01:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Baoquan He <bhe@redhat.com>,
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
Subject: Re: [PATCH RFC] mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP (was: Re:
 [PATCH v3 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA)
Message-ID: <20200402080144.GK22681@dhcp22.suse.cz>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200330074246.GA14243@dhcp22.suse.cz>
 <20200330092127.GB30942@linux.ibm.com>
 <20200330095843.GF14243@dhcp22.suse.cz>
 <20200331215618.GG30942@linux.ibm.com>
 <20200401054227.GC2129@MiWiFi-R3L-srv>
 <20200401075155.GH30942@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401075155.GH30942@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-04-20 10:51:55, Mike Rapoport wrote:
> Hi,
> 
> On Wed, Apr 01, 2020 at 01:42:27PM +0800, Baoquan He wrote:
[...]
> > From above information, we can remove HAVE_MEMBLOCK_NODE_MAP, and
> > replace it with CONFIG_NUMA. That sounds more sensible to store nid into
> > memblock when NUMA support is enabled.
>  
> Replacing CONFIG_HAVE_MEMBLOCK_NODE_MAP with CONFIG_NUMA will work, but
> this will not help cleaning up the whole node/zone initialization mess and
> we'll be stuck with two implementations.

Yeah, this is far from optimal.

> The overhead of enabling HAVE_MEMBLOCK_NODE_MAP is only for init time as
> most architectures will anyway discard the entire memblock, so having it in
> a UMA arch won't be a problem. The only exception is arm that uses
> memblock for pfn_valid(), here we may also think about a solution to
> compensate the addition of nid to the memblock structures. 

Well, we can make memblock_region->nid defined only for CONFIG_NUMA.
memblock_get_region_node would then unconditionally return 0 on UMA.
Essentially the same way we do NUMA for other MM code. I only see few
direct usage of region->nid.
-- 
Michal Hocko
SUSE Labs
