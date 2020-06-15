Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E253EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7CE20714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="js9BStWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgFOLwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729660AbgFOLwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:52:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074A9C061A0E;
        Mon, 15 Jun 2020 04:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YnvyX0I5otDowmfgXTPmGop1JAv0+IfTt+WsS0B/4C8=; b=js9BStWAXx3urINYI75BkgItmQ
        LJW1F8iGAlCkBySvVdTbhU5Siw3MOzyz+BMFTrgOYR42/boDw+sYugHTVbFFLjlxZNHxgIeA5YnLN
        +etqRTMztWhRuF0XthxQflby46wQMHZngt7filNCVbFZAZZTx3nbWJaRJmeYjxUXMElkxPp9tjyLd
        iSw7CD5mkyuk8ngH6BFxyBZs43i1dYC5mRT643hz0jRp7KvXRclVDALRfou8lYSwVi2ayhkISvKle
        jqbaYpwLycOAgQvoMiQOlq4vc+sKpfyyHgcKp4FGrzh8NPX9nx/BdgLpR1H8w+dNMTrVsTPrRyy5n
        kq0XmTJQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jknfD-0001aX-J6; Mon, 15 Jun 2020 11:52:31 +0000
Date:   Mon, 15 Jun 2020 04:52:31 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Will Deacon <will@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 17/29] docs: hugetlbpage.rst: fix some warnings
Message-ID: <20200615115231.GR8681@bombadil.infradead.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
 <59f1aeae4839528046fd46408081fd70d53e15a6.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59f1aeae4839528046fd46408081fd70d53e15a6.1592203542.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 08:46:56AM +0200, Mauro Carvalho Chehab wrote:
> @@ -100,38 +100,49 @@ with a huge page size selection parameter "hugepagesz=<size>".  <size> must
>  be specified in bytes with optional scale suffix [kKmMgG].  The default huge
>  page size may be selected with the "default_hugepagesz=<size>" boot parameter.
>  
> -Hugetlb boot command line parameter semantics
> +Hugetlb
> +	boot command line parameter semantics

That's not right.  This is a single sentence, not something being defined.

