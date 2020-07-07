Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B296BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87FDB206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="H+n+9TP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgGGWGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGGWGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:06:03 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7FCC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 15:06:03 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n26so34403065ejx.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ZNdEvOeP3WuasriJp99yNmKAqGYs/GDNRQigz82k5M=;
        b=H+n+9TP7Ync3pQ943fEua/W14EUsU6cicDP7/YLJ/PRvM+mZjYM8zcWL39+gexyw2V
         FYSk06t7fNJmZ7TAJ4Np01W5P1ft/pW/2VJ86staRo4F0UxvW1RVoJsVKMje5ZQPFrrS
         DFbfikXXkva+7/BFNQeoi9OPJ24mrF56i1SSrkTTH0SEekL/cUi8xID9xXwTRNSZ7YCX
         zn/UKP8JGJegSSE1H2tUhQI9FIZFmp4TLPJmWGQ4U8tZr1i6dSOqD5P6owjw9XJVKd7T
         jlPTIIXDpImb2q/1BlQID8aF78voE5pAskTFgCkqeFf+tOMh+B2lAG0WbP88eif7jpLo
         Ra7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ZNdEvOeP3WuasriJp99yNmKAqGYs/GDNRQigz82k5M=;
        b=ESLL08r1XuZ81xBcG1bT03ESqYvNTq4FQ7zI0sh2qmCAviv0cBYHs/uToj/OI2JPEh
         1xJYyljUpcYn2mhf3hbBca9JB7mlLvoxwf+09tazChImHumylKXAPv5Fnr6aB9u1bG07
         NRmfszRZeKysxhDNprpPDlc671LuyMdB+wDBvsNjl0IQfXM9b7fK2yCTtzKSmFFljSEt
         P39on3iP0YcnexpHXgzNz1FUYZZTeLB5wj9ibWYfRsmyprVlYWoIx5uxcRgsc4HRLRcw
         LZgHgOygX9PRmPsh0LZ0PT5lOiOJlq7jVVmscLQtdx8cEEcZKETfUWMx/w7DUCFirsg/
         r33g==
X-Gm-Message-State: AOAM531/q2aLzk2wy3XiL/0Jz2JWc4iwam35iKpAD/g0T+rv2OGP37Nr
        kye3sI8s6QlG/2XyjlrDUywr1pMNlH6sWN5D8IdGsA==
X-Google-Smtp-Source: ABdhPJzxamlNKlD2fbS8kUI/eRgH4V8jHgv25Sc3W50tBjzP0xq+Ps6l4+gy8ejY3ioNAlrVUymfpv+0QpgeJdPW3+I=
X-Received: by 2002:a17:906:1a54:: with SMTP id j20mr48420370ejf.455.1594159562129;
 Tue, 07 Jul 2020 15:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200707055917.143653-1-justin.he@arm.com> <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz> <20200707121302.GB9411@linux.ibm.com>
 <474f93e7-c709-1a13-5418-29f1777f614c@redhat.com> <20200707180043.GA386073@linux.ibm.com>
In-Reply-To: <20200707180043.GA386073@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 Jul 2020 15:05:48 -0700
Message-ID: <CAPcyv4iB-vP8U4pH_3jptfODbiNqJZXoTmA6+7EHoddk9jBgEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, Jia He <justin.he@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kaly Xin <Kaly.Xin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 11:01 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Tue, Jul 07, 2020 at 02:26:08PM +0200, David Hildenbrand wrote:
> > On 07.07.20 14:13, Mike Rapoport wrote:
> > > On Tue, Jul 07, 2020 at 01:54:54PM +0200, Michal Hocko wrote:
> > >> On Tue 07-07-20 13:59:15, Jia He wrote:
> > >>> This exports memory_add_physaddr_to_nid() for module driver to use.
> > >>>
> > >>> memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> > >>> NUMA_NO_NID is detected.
> > >>>
> > >>> Suggested-by: David Hildenbrand <david@redhat.com>
> > >>> Signed-off-by: Jia He <justin.he@arm.com>
> > >>> ---
> > >>>  arch/arm64/mm/numa.c | 5 +++--
> > >>>  1 file changed, 3 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> > >>> index aafcee3e3f7e..7eeb31740248 100644
> > >>> --- a/arch/arm64/mm/numa.c
> > >>> +++ b/arch/arm64/mm/numa.c
> > >>> @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> > >>>
> > >>>  /*
> > >>>   * We hope that we will be hotplugging memory on nodes we already know about,
> > >>> - * such that acpi_get_node() succeeds and we never fall back to this...
> > >>> + * such that acpi_get_node() succeeds. But when SRAT is not present, the node
> > >>> + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback option.
> > >>>   */
> > >>>  int memory_add_physaddr_to_nid(u64 addr)
> > >>>  {
> > >>> - pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
> > >>>   return 0;
> > >>>  }
> > >>> +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> > >>
> > >> Does it make sense to export a noop function? Wouldn't make more sense
> > >> to simply make it static inline somewhere in a header? I haven't checked
> > >> whether there is an easy way to do that sanely bu this just hit my eyes.
> > >
> > > We'll need to either add a CONFIG_ option or arch specific callback to
> > > make both non-empty (x86, powerpc, ia64) and empty (arm64, sh)
> > > implementations coexist ...
> >
> > Note: I have a similar dummy (return 0) patch for s390x lying around here.
>
> Then we'll call it a tie - 3:3 ;-)

So I'd be happy to jump on the train of people wanting to export the
ARM stub for this (and add a new ARM stub for phys_to_target_node()),
but Will did have a plausibly better idea that I have been meaning to
circle back to:

http://lore.kernel.org/r/20200325111039.GA32109@willie-the-truck

...i.e. iterate over node data to do the lookup. This would seem to
work generically for multiple archs unless I am missing something?
