Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5FEC4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F482084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582708223;
	bh=oVj0LaNGQGlh+No97i4+dbTBsCITOd4Xl4LRGJgwbf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ngfU3NvoQJqKR+gPSLyviCzgQCsetg3EPyw+yCz3rITh1aPKN+9XrSVNeCCmtD7ru
	 q82z263SiS+nsN1hR+3QEEgwk5+3T+huQY78rwSYyHdMw4mYKQQYeGMmIw/vyaNLxS
	 aj4zQdJKXzlakH4fu+qkv9XqkXdgaGjS6evk5uY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgBZJKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:10:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45458 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgBZJKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:10:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id v2so906495wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 01:10:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zezVHIKVsEy23WKIqEBxre7fTjr4AovI4tGuQWgev8E=;
        b=Oi8uMxn8BzRjuLXyMN/vpy5czRj20jszLRzHyjgK4LwxmabaIpG4jn1L3ePC/YdHHE
         cH9PGglleYHpCrqox+1+sCwisC4tDDuqqozRNGYbZRkLC6LcDxGRuWniDet0TRRopLM0
         NDve0v6UmRUiB9Sr/G/3fwQjCKU5lgvw2gOBv3e6P+V0UTJlXioNaZtgi0bz0jgGOjAB
         bbSyOWwWg7IIVATDGvoT3jHkjCfX/P+INeEsA7T7kfdm5Gfsbm8HHOJGcMwjNjfBt5ge
         07/M6seMDRQsit1j7m3gxPBoX+aGLBDT73fGH/rh2ipTE50rtfKccnRRZNgzh7SUPgA2
         2i+g==
X-Gm-Message-State: APjAAAV9NgCfsukEk4e+8bUBJFvY2tFNaVQVmbQviDXVyXZ5GCwAyzVW
        2fTV3kbQwlvYfbmESnts0go=
X-Google-Smtp-Source: APXvYqw/czrxlpJt+0m/pwY5+5eu0JP3G4Ay0V1rlzLaOX87KhdbgdFeZv7KVTjsnC0eFISKxrILng==
X-Received: by 2002:adf:dfcc:: with SMTP id q12mr4235815wrn.171.1582708220424;
        Wed, 26 Feb 2020 01:10:20 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id x6sm2387649wrr.6.2020.02.26.01.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 01:10:19 -0800 (PST)
Date:   Wed, 26 Feb 2020 10:10:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 4/7] mm/sparse.c: only use subsection map in VMEMMAP
 case
Message-ID: <20200226091018.GD3771@dhcp22.suse.cz>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-5-bhe@redhat.com>
 <20200225095713.GL22443@dhcp22.suse.cz>
 <20200226035336.GF24216@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226035336.GF24216@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-02-20 11:53:36, Baoquan He wrote:
> On 02/25/20 at 10:57am, Michal Hocko wrote:
> > On Thu 20-02-20 12:33:13, Baoquan He wrote:
> > > Currently, subsection map is used when SPARSEMEM is enabled, including
> > > VMEMMAP case and !VMEMMAP case. However, subsection hotplug is not
> > > supported at all in SPARSEMEM|!VMEMMAP case, subsection map is unnecessary
> > > and misleading. Let's adjust code to only allow subsection map being
> > > used in VMEMMAP case.
> > 
> > This really needs more explanation I believe. What exactly happens if
> > somebody tries to hotremove a part of the section with !VMEMMAP? I can
> > see that clear_subsection_map returns 0 but that is not an error code.
> > Besides that section_deactivate doesn't propagate the error upwards.
> > /me stares into the code
> > 
> > OK, I can see it now. It is relying on check_pfn_span to use the proper
> > subsection granularity. This really begs for a comment in the code
> > somewhere.
> 
> Yes, check_pfn_span() guards it. People have no way to hot add/remove
> on non-section aligned block with !VMEMMAP.
> 
> I have added extra comment to above section_activate() to note this,
> please check patch 5/7. Let me see how to add words to reflect the
> check_pfn_span() guard thing.

An explicit note about check_pfn_span gating the proper alignement and
sizing sounds sufficient to me.
-- 
Michal Hocko
SUSE Labs
