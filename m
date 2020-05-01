Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480CFC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 09:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23A252173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 09:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WgXOCclT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgEAJTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 05:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgEAJTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 05:19:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2CBC035495
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 02:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BZ4Ad/d1aSVu6gEi6Ay6gMOz386r1wTGu5+DXuek8aw=; b=WgXOCclTS0nBGm5Zf2MOFfRtNl
        YOv6++VdrVqW0o/O1/zOJ+jSSfV5IkRN0PJNL28ZInz6FzyQf9brsodj3m9+IqJwpqeQtl1669nkA
        QDuXDrc/XZGsZ8DfBrKyAeJcX5pr7sWK/9Fv7WSHfDNuh8SzhfOu7abcUUsajQwHufkwgdt9X+mz2
        60uRKl83xoUxfyb/i4n1MdDA1NyvYU+/3loWFg9qDQewdTazfjyYABUbyAe6ZBHPncgpgX+Pc+G00
        5797eCIV9CrPpMreWlKz4z8h5MVXuefxtiwYh1xEhBmmY6R7/xXUJxjhpMc/GAz4sRriRFeaqCEEv
        sQFMxS6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jURpV-0000xh-1D; Fri, 01 May 2020 09:19:33 +0000
Date:   Fri, 1 May 2020 02:19:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, ira.weiny@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Subject: Re: xtensa question, was Re: [PATCH V1 00/10] Remove duplicated kmap
 code
Message-ID: <20200501091933.GA3084@infradead.org>
References: <20200430203845.582900-1-ira.weiny@intel.com>
 <20200501084634.GH27858@infradead.org>
 <CAMo8Bf+Mvvg_f1-33iQhTqZPVw1civX94KS2mf4uSkcpEVx55Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8Bf+Mvvg_f1-33iQhTqZPVw1civX94KS2mf4uSkcpEVx55Q@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 02:02:19AM -0700, Max Filippov wrote:
> Hi Christoph,
> 
> On Fri, May 1, 2020 at 1:46 AM Christoph Hellwig <hch@infradead.org> wrote:
> > any idea why xtensa uses PAGE_KERNEL_EXEC instead of PAGE_KERNEL
> > for kmap_prot?  Mapping all mapped highmem as executable seems rather
> > dangerous.
> 
> I sure do: to allow instruction cache flushing when writing to high user
> pages temporarily mapped with kmap. Instruction cache management
> opcodes that operate on virtual addresses would raise an exception if
> the address is not executable.

Seems like this should use kmap_atomic_prot with PAGE_KERNEL_EXEC just
for that case.  Which of course didn't exist on xtensa so far, but with
this series will.
