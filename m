Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C4C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7048A20848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581586678;
	bh=49hw5hzgKeeMHsoFQJZteWk9tcEUCIwjBoGiPs0EZrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JxCCouaxknfwrATeJr9pSqtiNIBwqBqjJPGCtGvZziVk1IV/ROFhFDgToaUQv0iNx
	 x03Ahq1OisxI/u+GQZJ+AmoS+YFIgT8TYxPQ/5axGUnp+5sH0QK+J2+Q8HAdHwEl7G
	 lfmTn8VLyjNPxOXP4IGIoJ/6YXeZK5/IXJl6D+Gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgBMJh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:37:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36320 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMJh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:37:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so5789453wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h+Vyr3wbXZdrL7js2MVthsgN+SvJforSfaGeRgZJbho=;
        b=g08Wqa5q4x/9J7wSqkOc+rjP4ziI3N0xyd/rSYD1wZIJQADKx36UZmgEERnOapb3i7
         TkfaeKx1QGNrhKhLE9kfTjH8LLFCgMi7IGft9ps0BiByygvO3oY1NLD7t0JXFkwcARKj
         MPL7XF6riqKatYo2UnupEyx5ZXDmWPPEMx0SVZx/teVg6Cw46TqxEnuQ9KCWZmJ9wWQp
         CE7taknqbwCsV6rZvPbGVpBtO/Fj1UElMGpJZDDlG46ZZc+RNPuoWFZw7gUjV9bsLCea
         hz9RXEnE4LPgllAnDJZ7EjFIfv2DgdBA1nqWQjfZLOTs0BAQDs5bddcsMwCLWcUiCrq4
         FTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=h+Vyr3wbXZdrL7js2MVthsgN+SvJforSfaGeRgZJbho=;
        b=OymOpcUIyXKI1Pnfr+ony8tDoh3Ty29bJc1BjhTIFX3RpGFdS4ixxihmKibdx9D1kU
         +4z0CfvxQW2k98ainobijOlA7dBAw5ZcVUL+2wxMWiLXeuPhuEpAnGfoRSCsTCxtgvHH
         L/DrmhdFk13aDy4ANsvE2g2tSRhSFf4d/gF3zz91z/THZSiyUgUEvSY6cjQXVc1o5yrl
         +2B0I9htgyIp79tSJaA2N4jmhhrXkews5G4kjuJ7LhJYuw1VGSgLoN6H6sIko6WsdWdi
         BFbKxlIYwOhdFkSM2MTuBDPHuD2JpWd8yXwsgBAY44hoRtTMEX8zf8n1ra65SRic7gh8
         xDdA==
X-Gm-Message-State: APjAAAWmFgHDq7rv2czE7K7P61DUkMftBCjHELOLbMp2BXkUFHzT8nd6
        Pd79RDyX6egwa+sSx08NiZI=
X-Google-Smtp-Source: APXvYqxwoGKaMsWL2wnKe/IRRL/CBJ3mfrPEGF2PZ9bp2mxF7wP4t8ap9tXXLFMmVmqbp9n2aogPjg==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr19850159wrv.86.1581586675119;
        Thu, 13 Feb 2020 01:37:55 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x17sm2007821wrt.74.2020.02.13.01.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 01:37:54 -0800 (PST)
Date:   Thu, 13 Feb 2020 10:37:52 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        kbuild test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Hocko <mhocko@suse.com>,
        Paul Mackerras <paulus@samba.org>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>, X86 ML <x86@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH v4 0/6] Memory Hierarchy: Enable target node lookups for
 reserved memory
Message-ID: <20200213093751.GC90266@gmail.com>
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4j8ouOpaAEXELzKdr1m6cPWw=XOeRg4FqXPAgV3ZqUJoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4j8ouOpaAEXELzKdr1m6cPWw=XOeRg4FqXPAgV3ZqUJoA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Jan 21, 2020 at 7:20 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Changes since v3 [1]:
> > - Cleanup numa_map_to_online_node() to remove redundant "if
> >   (!node_online(node))" (Aneesh)
> >
> > [1]: http://lore.kernel.org/r/157954696789.2239526.17707265517154476652.stgit@dwillia2-desk3.amr.corp.intel.com
> >
> > ---
> >
> > Merge notes:
> >
> > x86 folks: This has an ack from Rafael for ACPI, and Michael for Power.
> > With an x86 ack I plan to take this through the libnvdimm tree provided
> > the x86 touches look ok to you.
> 
> Ping x86 folks. There's no additional changes identified for this
> series. Can I request an ack to take it through libnvdimm.git? Do you
> need a resend?
> 
>     x86/mm: Introduce CONFIG_KEEP_NUMA
>     x86/numa: Provide a range-to-target_node lookup facility

If the minor complaints I outlined are addressed:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
