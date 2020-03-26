Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9B3C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075182076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585217796;
	bh=UjzQJKrdxg+h+WBJiz53AwzH010pTehvGBm/BCsB614=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C7wYhIxSgm6aeqIxAyoCv6YZqzR8m4VX+DM+V9zyN3ODit+uwsRccrCTBRrF0Zt0n
	 67hbpsoZMMrOMAdiAnCs97/yOcx0pt1gcyD0pbCRuTIMC68zPfLW4X8nzL/eLKKyYJ
	 vcCeC7/QBDRaxYT0hkpD3cmPWPjUKMmQUFvNPaac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgCZKQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:16:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38983 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbgCZKQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:16:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so7004072wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 03:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vMy/PQ+ITtl8Oam8bs7Aqt9RXzUHCecRP8udelEpwUQ=;
        b=Hw3eLIYpFHdrPRq6rmMxTlKXyrR0jmgGi61zCC6cbsyyt4dnju5uJdK5ckoDMnlg+P
         OQ9M6CXmnrr9lVbCuMUyWE6v+oAFLkS997NqVjxHGVtQoLWyd2XyzPh4piSOh1SYg1Md
         NHy23/TpS358Mri4ARivF4aB+2P+xxck3exOpccISmWyKSc4ayZ6cdBi50zKLK+z7ooY
         XoQqeDSt3FLrbrxOZ3ds9lsp0kz6yJxRpYG85bYF+qwlHhpZPgn37m4Nq459z8GaJF5y
         YcfaaX88XEQgfgLIuRAHKcGXPwx8RrimJOB+uUmMD/QExB1l3Fs2Op/6tsuxxZIJ8LTr
         pwzQ==
X-Gm-Message-State: ANhLgQ3OC8fYbYMbZ820SoMIs0rtE5zXDODkod7vNpC8othlvGZ5aTvm
        GUjcMbyB4g4clBBoSW12rJGB85Xx
X-Google-Smtp-Source: ADFU+vtKi1ZhDFDWo9LbSV3RPeDQcM9EQGKR5wMjVNPm5S16Gh5Vh4Dgz3gQRLSPaf9dfo6a+rFnBg==
X-Received: by 2002:adf:83c4:: with SMTP id 62mr9011356wre.105.1585217793341;
        Thu, 26 Mar 2020 03:16:33 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id y200sm2857062wmc.20.2020.03.26.03.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 03:16:32 -0700 (PDT)
Date:   Thu, 26 Mar 2020 11:16:31 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, Baoquan He <bhe@redhat.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm/sparse: Fix kernel crash with pfn_section_valid check
Message-ID: <20200326101631.GJ27965@dhcp22.suse.cz>
References: <20200325031914.107660-1-aneesh.kumar@linux.ibm.com>
 <20200326094023.GG27965@dhcp22.suse.cz>
 <6ef554a6-313d-2b17-cee0-14078ed225f6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ef554a6-313d-2b17-cee0-14078ed225f6@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-03-20 15:26:22, Aneesh Kumar K.V wrote:
> On 3/26/20 3:10 PM, Michal Hocko wrote:
> > On Wed 25-03-20 08:49:14, Aneesh Kumar K.V wrote:
> > > Fixes the below crash
> > > 
> > > BUG: Kernel NULL pointer dereference on read at 0x00000000
> > > Faulting instruction address: 0xc000000000c3447c
> > > Oops: Kernel access of bad area, sig: 11 [#1]
> > > LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
> > > CPU: 11 PID: 7519 Comm: lt-ndctl Not tainted 5.6.0-rc7-autotest #1
> > > ...
> > > NIP [c000000000c3447c] vmemmap_populated+0x98/0xc0
> > > LR [c000000000088354] vmemmap_free+0x144/0x320
> > > Call Trace:
> > >   section_deactivate+0x220/0x240
> > 
> > It would be great to match this to the specific source code.
> 
> The crash is due to NULL dereference at
> 
> test_bit(idx, ms->usage->subsection_map); due to ms->usage = NULL;

It would be nice to call that out here as well

[...]
> > Why do we have to free usage before deactivaing section memmap? Now that
> > we have a late section_mem_map reset shouldn't we tear down the usage in
> > the same branch?
> > 
> 
> We still need to make the section invalid before we call into
> depopulate_section_memmap(). Because architecture like powerpc can share
> vmemmap area across sections (16MB mapping of vmemmap area) and we use
> vmemmap_popluated() to make that decision.

This should be noted in a comment as well.

> > > Fixes: d41e2f3bd546 ("mm/hotplug: fix hot remove failure in SPARSEMEM|!VMEMMAP case")
> > > Cc: Baoquan He <bhe@redhat.com>
> > > Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > > ---
> > >   mm/sparse.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/mm/sparse.c b/mm/sparse.c
> > > index aadb7298dcef..3012d1f3771a 100644
> > > --- a/mm/sparse.c
> > > +++ b/mm/sparse.c
> > > @@ -781,6 +781,8 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> > >   			ms->usage = NULL;
> > >   		}
> > >   		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> > > +		/* Mark the section invalid */
> > > +		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
> > 
> > Btw. this comment is not really helping at all.
> 
> That is marking the section invalid so that
> 
> static inline int valid_section(struct mem_section *section)
> {
> 	return (section && (section->section_mem_map & SECTION_HAS_MEM_MAP));
> }
> 
> 
> returns false.

Yes that is obvious once you are clear where to look. I was really
hoping for a comment that would simply point you to the right
direcection without chasing SECTION_HAS_MEM_MAP usage. This code is
subtle and useful comments, even when they state something that is
obvious to you _right_now_, can be really helpful.

Thanks!
-- 
Michal Hocko
SUSE Labs
