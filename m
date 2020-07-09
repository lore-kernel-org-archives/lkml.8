Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8739DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 677E9206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XR04+03w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgGICNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgGICNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 22:13:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38444C061A0B;
        Wed,  8 Jul 2020 19:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qi5089B5TBHI+zy9mDefYNvDdHyy2eklBkVImsmfAA8=; b=XR04+03woT3Wc7Z/57jVKd4hjt
        3/E+cPTx2AQKCpc/7RreVQxlA9fQYhnyQYvjGihVTwBeUhMvD1az1bE+aXIowHLHsO4PPVi+sxQwA
        w3nQAbkppGId8GQAhA5vINNi51acayCJgaGvH8tDYh9hhuTWECwDBu6AGIzdVjzzQC3Zgoo+4Dbnz
        AZjcV2gbkzzZX2ShVFGcqhY1KThJMO/jobs64MREKH5Ezengt4WKDQkr3yw0rrWp+e+/1nIZ1URDR
        u8M4sp6A3rWRF3TEykU38Xw06lEG6SCF2w3ZwXpgRBaTt6syvQbk7T5XdAmus0UblYhhdytIy8B1y
        yTszHv4A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtM1h-0006v4-Cd; Thu, 09 Jul 2020 02:11:06 +0000
Date:   Thu, 9 Jul 2020 03:11:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v3 4/6] mm: don't export memory_add_physaddr_to_nid in
 arch specific directory
Message-ID: <20200709021104.GZ25523@casper.infradead.org>
References: <20200709020629.91671-1-justin.he@arm.com>
 <20200709020629.91671-5-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709020629.91671-5-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 10:06:27AM +0800, Jia He wrote:
> After a general version of __weak memory_add_physaddr_to_nid implemented
> and exported , it is no use exporting twice in arch directory even if
> e,g, ia64/x86 have their specific version.
> 
> This is to suppress the modpost warning:
> WARNING: modpost: vmlinux: 'memory_add_physaddr_to_nid' exported twice.
> Previous export was in vmlinux

It's bad form to introduce a warning and then send a follow-up patch to
fix the warning.  Just fold this patch into patch 1/6.
