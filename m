Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B04C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 150F0206CB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593606077;
	bh=YmeQj2ek9BtbblPqlRU5NBs+n/XWsgeIt7zBBBKihCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pqZlMJ756cLA664ARpHq7P6ncPekQuPqLzfLhBwf7EzSgIsvucwaQkOawG+mwJmjv
	 JByiBGVVVAY7O47jduuztoH8sIs+i9CCmPJuliNAWlRNTO37XtfCGk2HxcwtQb2m9z
	 feCwSrsGaSDMX5kbFJLkDPlIXshPZ4zX+VKTfRUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgGAMVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:21:15 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:42227 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgGAMVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:21:14 -0400
Received: by mail-ej1-f66.google.com with SMTP id i14so24373727ejr.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/b+RUGrUg/ntsSCxKL5s82gEiDaQbG8Ituvi60lGYAk=;
        b=PlSMl+pWdvVGRpW2Lq4tLhkOhgs3bVW221IOkblfRgodHnpNW2vwo5kOZVf2wphMIy
         emyWdQ2GiIAiDA1mwgox6HmEY5BuIHfqDwAIBPEZocBJNuyQaRTo9dDXYHFQBY+Fyqww
         PSytcOwbhZUi49smmjT59bIl6irt3CnWu3U/B8W/I3mtk8Iaxra+HQxLJuDDSrye33Zp
         6kNswU201Xp7lWT6NxhC+zvxwDlQtjF6vcXXQ0IJZNlNu+Q+RDowkR3SpcHxOsI6g5Q4
         wH+4inaAPsd6okkZVO7nkCXCBzhWBzvwFAF3p5ow+DV1mxjxzuWtcoP2J2zbPFzWxqJ/
         DQzA==
X-Gm-Message-State: AOAM530i5OCfmaCpxpp1Nm6h1dLxhfPT4xLW/SK3s1IZUxQjtIV+Qrcg
        p0dnUKrttOqTe0VcRHTUJn4=
X-Google-Smtp-Source: ABdhPJwM754Glk3zEURKp6Dq0/LYW01GCSOKp40qjwm++RUI94oVQJQMVXVZpTlIQFzY4qbxuk1WUA==
X-Received: by 2002:a17:906:1a54:: with SMTP id j20mr22242582ejf.455.1593606072668;
        Wed, 01 Jul 2020 05:21:12 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id di20sm6311781edb.26.2020.07.01.05.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:21:11 -0700 (PDT)
Date:   Wed, 1 Jul 2020 14:21:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Christopher Lameter <cl@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
Message-ID: <20200701122110.GT2369@dhcp22.suse.cz>
References: <20200624092846.9194-1-srikar@linux.vnet.ibm.com>
 <20200624092846.9194-4-srikar@linux.vnet.ibm.com>
 <20200701084200.GN2369@dhcp22.suse.cz>
 <20200701100442.GB17918@linux.vnet.ibm.com>
 <184102af-ecf2-c834-db46-173ab2e66f51@redhat.com>
 <20200701110145.GC17918@linux.vnet.ibm.com>
 <0468f965-8762-76a3-93de-3987cf859927@redhat.com>
 <12945273-d788-710d-e8d7-974966529c7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12945273-d788-710d-e8d7-974966529c7d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-07-20 13:30:57, David Hildenbrand wrote:
> On 01.07.20 13:06, David Hildenbrand wrote:
> > On 01.07.20 13:01, Srikar Dronamraju wrote:
> >> * David Hildenbrand <david@redhat.com> [2020-07-01 12:15:54]:
> >>
> >>> On 01.07.20 12:04, Srikar Dronamraju wrote:
> >>>> * Michal Hocko <mhocko@kernel.org> [2020-07-01 10:42:00]:
> >>>>
> >>>>>
> >>>>>>
> >>>>>> 2. Also existence of dummy node also leads to inconsistent information. The
> >>>>>> number of online nodes is inconsistent with the information in the
> >>>>>> device-tree and resource-dump
> >>>>>>
> >>>>>> 3. When the dummy node is present, single node non-Numa systems end up showing
> >>>>>> up as NUMA systems and numa_balancing gets enabled. This will mean we take
> >>>>>> the hit from the unnecessary numa hinting faults.
> >>>>>
> >>>>> I have to say that I dislike the node online/offline state and directly
> >>>>> exporting that to the userspace. Users should only care whether the node
> >>>>> has memory/cpus. Numa nodes can be online without any memory. Just
> >>>>> offline all the present memory blocks but do not physically hot remove
> >>>>> them and you are in the same situation. If users are confused by an
> >>>>> output of tools like numactl -H then those could be updated and hide
> >>>>> nodes without any memory&cpus.
> >>>>>
> >>>>> The autonuma problem sounds interesting but again this patch doesn't
> >>>>> really solve the underlying problem because I strongly suspect that the
> >>>>> problem is still there when a numa node gets all its memory offline as
> >>>>> mentioned above.

I would really appreciate a feedback to these two as well.

> >>>>> While I completely agree that making node 0 special is wrong, I have
> >>>>> still hard time to review this very simply looking patch because all the
> >>>>> numa initialization is so spread around that this might just blow up
> >>>>> at unexpected places. IIRC we have discussed testing in the previous
> >>>>> version and David has provided a way to emulate these configurations
> >>>>> on x86. Did you manage to use those instruction for additional testing
> >>>>> on other than ppc architectures?
> >>>>>
> >>>>
> >>>> I have tried all the steps that David mentioned and reported back at
> >>>> https://lore.kernel.org/lkml/20200511174731.GD1961@linux.vnet.ibm.com/t/#u
> >>>>
> >>>> As a summary, David's steps are still not creating a memoryless/cpuless on
> >>>> x86 VM.
> >>>
> >>> Now, that is wrong. You get a memoryless/cpuless node, which is *not
> >>> online*. Once you hotplug some memory, it will switch online. Once you
> >>> remove memory, it will switch back offline.
> >>>
> >>
> >> Let me clarify, we are looking for a node 0 which is cpuless/memoryless at
> >> boot.  The code in question tries to handle a cpuless/memoryless node 0 at
> >> boot.
> > 
> > I was just correcting your statement, because it was wrong.
> > 
> > Could be that x86 code maps PXM 1 to node 0 because PXM 1 does neither
> > have CPUs nor memory. That would imply that we can, in fact, never have
> > node 0 offline during boot.
> > 
> 
> Yep, looks like it.
> 
> [    0.009726] SRAT: PXM 1 -> APIC 0x00 -> Node 0
> [    0.009727] SRAT: PXM 1 -> APIC 0x01 -> Node 0
> [    0.009727] SRAT: PXM 1 -> APIC 0x02 -> Node 0
> [    0.009728] SRAT: PXM 1 -> APIC 0x03 -> Node 0
> [    0.009731] ACPI: SRAT: Node 0 PXM 1 [mem 0x00000000-0x0009ffff]
> [    0.009732] ACPI: SRAT: Node 0 PXM 1 [mem 0x00100000-0xbfffffff]
> [    0.009733] ACPI: SRAT: Node 0 PXM 1 [mem 0x100000000-0x13fffffff]

This begs a question whether ppc can do the same thing?

I would swear that we've had x86 system with node 0 but I cannot really
find it and it is possible that it was not x86 after all...
-- 
Michal Hocko
SUSE Labs
