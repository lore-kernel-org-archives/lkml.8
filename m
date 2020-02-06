Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BC2C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F2821741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZGi2BML2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBFUUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:20:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgBFUUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rjvBCgQG7PCKo30bNWy0wd3PGVZSHpsi4wor0rOBgAc=; b=ZGi2BML2CU17sq6hY7F3ILOGkv
        c/kLQ0QaLgaEMpVhUWFAIemXaBw2BO1DbXwzDWMuGDE4St66KbdnVITd49zhhLZ/hMhomYa3THPjR
        LmaMH9Ji4IehU7vzAQWyRyp8cANkv/87f6SOWANwPK2tiKsFvKipVnvZ6ap1F3os2Pkuqj9gFXCwI
        DxMypz8aNDozSey/EkLU9T1iXZCLzz507UtB1DRfJnXScrHJviqhucPP/vqVOngGKb45hXIsgdclA
        uTyiLeEs0HH+6ZK7UHeE5ORUP7dwqFvPNpkJ8oIYUpqOdjiHEVKxtFgMw9Nlzc0Wi5K0UrwPnYCOz
        YPc4+pvQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iznd7-0005az-Hc; Thu, 06 Feb 2020 20:20:05 +0000
Date:   Thu, 6 Feb 2020 12:20:05 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, elver@google.com, jhubbard@nvidia.com,
        ira.weiny@intel.com, dan.j.williams@intel.com, jack@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] mm: mark an intentional data race in
 page_zonenum
Message-ID: <20200206202005.GY8731@bombadil.infradead.org>
References: <20200206183000.913-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206183000.913-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 01:30:00PM -0500, Qian Cai wrote:
> Both the read and write are done only with the non-exclusive mmap_sem
> held. Since the read only check for a specific bit range (up to 3 bits)
> in the flag but the write here never change those 3 bits, so load
> tearing would be harmless here. Thus, just mark it as an intentional
> data races using the data_race() macro which is designed for those
> situations [1].

This changelog makes me think you don't really understand the situation.

A page never changes its zone number.  The zone number happens to be
stored in the same word as other bits which are modified, but the zone
number bits will never be modified by any other write.  So we can accept
a reload of the zone bits after an intervening write and we don't need
to use READ_ONCE().
