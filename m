Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA487C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 06:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB5D9207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 06:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597647196;
	bh=7kKYad4sIMfFe22O071PLENbYoCswa7DBLzhl6VdZII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xRjX194pFOAuGEfqY0jYZAOcvD0Bs2ggiQsR322UFLFlKNUaXFzRLHc3XIcMNqVo9
	 kXMfzbVPTXfnseA+7IzDC9vHeQ2K1bBfGsWgKMfMnqQLV28U3XM6kbQb61N14vajL8
	 9t1uu71KEZfmwpqScmuRgOOnqrlhSKqHyn3wAkrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgHQGxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 02:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgHQGxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 02:53:14 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0802420772;
        Mon, 17 Aug 2020 06:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597647194;
        bh=7kKYad4sIMfFe22O071PLENbYoCswa7DBLzhl6VdZII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXxVUOAm/PJU+AEkNCX8uW4ZBi42ZQNaCL7ktyTKMDeGcdYc2VDRDd2Rwo/6PFYeq
         OY3V42w04yml9yHvXPfonrMD95wTDOa9hxED5kNScBOpCVMoFBGehP/2osNI/39lP/
         JmdcIAfZGfXjU3EtF4pHlk+VqjSPKaOq1qGGp/q8=
Date:   Mon, 17 Aug 2020 09:53:08 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Helge Deller <deller@gmx.de>,
        linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Pekka Enberg <penberg@kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] parisc: fix PMD pages allocation by restoring
 pmd_alloc_one()
Message-ID: <20200817065308.GL752365@kernel.org>
References: <20200816142403.15449-1-rppt@kernel.org>
 <20200816144209.GH17456@casper.infradead.org>
 <20200816174343.GK752365@kernel.org>
 <CAHk-=wiPUKCC490nd6Y5A1Sq=VpTpO=Li5cYb0iztp-x19nqiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiPUKCC490nd6Y5A1Sq=VpTpO=Li5cYb0iztp-x19nqiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 10:52:21AM -0700, Linus Torvalds wrote:
> On Sun, Aug 16, 2020 at 10:43 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > I presume this is going via parisc tree, do you mind fixing up
> > while applying?
> 
> I'll take it directly to not miss rc1, and I'll fix up the typo too.

Thanks!

>               Linus

-- 
Sincerely yours,
Mike.
