Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4A4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD9820772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593606239;
	bh=Q9CJu4/bA4tXljW0aFOLG1vuZ8KJtvTX7ZdAFH5LN+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yu1IVZ6wewkdhlou0VOq6xV7nehWqF15zGmQtnaXMAQDm0bJ63IBmePK+61WBZXJY
	 r3vpvutO29SiO2g/6iOHbCGvadGrxAgB+R3H107KPKK7miAPi39Io9LDHzQtVe5xly
	 w4NVyoi+88VRfL0sGt7y4cmxlIOcFP2vsVtTT1nQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgGAMX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:23:57 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:43663 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbgGAMX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:23:57 -0400
Received: by mail-ej1-f67.google.com with SMTP id l12so24337482ejn.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EguftjtGqWh5VAdFTqBrZSaGbeDOMAHvC0KwPTJHn/U=;
        b=QR4YqyhykckEGVX2lnnAa2SbYPFLykGysqrUo1gL4f3fm5DNNGD6Z1lSkABNNps7PG
         iNEWC5ywy2cim09AXcmcCF7QAVTpJnrrdqr3rLJNjlhFSRI1v1Gwmeeu4mPitfeTbswE
         A6wu3u9Oi0ZzpN66zGsXj+7ui5u2e6NBUJvX4ytz29lfQsuD+Q0RbRELmO382jX8LaDU
         2Sva3XKaFXe2iEGuAIDZr4pL+ezrilUGLwhey1XrYytOpIl3btO25yyNBqLpgJe3Uu4v
         XzTVqGfsKtUZolCYJ/+367Ntgn17zRi2qq1W/JYU5CkB2Gm1bQF4HyxSgQMAKjEMd6dw
         OSlw==
X-Gm-Message-State: AOAM533v/Er/Rn24zNEtMHvtJ3MUN/MYKho0zxkImdHWxB4lcuOI0wbf
        6bS0A2bb+u1hEIPFAILI4K4=
X-Google-Smtp-Source: ABdhPJy/WXxww9ppUfxQzV+W46iCW3wMVCFfGKiry/c38Bk6UeJk9x0MK1Dyt9SBwv8ixfZZXNWBfQ==
X-Received: by 2002:a17:906:284e:: with SMTP id s14mr21684652ejc.498.1593606235211;
        Wed, 01 Jul 2020 05:23:55 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id q3sm2881770eds.41.2020.07.01.05.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:23:54 -0700 (PDT)
Date:   Wed, 1 Jul 2020 14:23:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Christopher Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
Message-ID: <20200701122353.GU2369@dhcp22.suse.cz>
References: <20200624092846.9194-1-srikar@linux.vnet.ibm.com>
 <20200624092846.9194-4-srikar@linux.vnet.ibm.com>
 <alpine.DEB.2.22.394.2006291456550.27163@www.lameter.com>
 <20200630040125.GA31617@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630040125.GA31617@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-06-20 09:31:25, Srikar Dronamraju wrote:
> * Christopher Lameter <cl@linux.com> [2020-06-29 14:58:40]:
> 
> > On Wed, 24 Jun 2020, Srikar Dronamraju wrote:
> > 
> > > Currently Linux kernel with CONFIG_NUMA on a system with multiple
> > > possible nodes, marks node 0 as online at boot.  However in practice,
> > > there are systems which have node 0 as memoryless and cpuless.
> > 
> > Maybe add something to explain why you are not simply mapping the
> > existing memory to NUMA node 0 which is after all just a numbering scheme
> > used by the kernel and can be used arbitrarily?
> > 
> 
> I thought Michal Hocko already gave a clear picture on why mapping is a bad
> idea. https://lore.kernel.org/lkml/20200316085425.GB11482@dhcp22.suse.cz/t/#u
> Are you suggesting that we add that as part of the changelog?

Well, I was not aware x86 already does renumber. So there is a certain
precendence. As I've said I do not really like that but this is what
already is happening. If renumbering is not an option then just handle
that in the ppc code explicitly. Generic solution would be preferable of
course but as I've said it is really hard to check for correctness and
potential subtle issues.

-- 
Michal Hocko
SUSE Labs
