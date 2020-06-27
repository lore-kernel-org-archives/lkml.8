Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9788C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 03:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD9C20CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 03:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593229313;
	bh=Ali5IZNLTIW8llvxQDSSeqrZ636VTDReJzcRNiixCTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UWo8c7rjKUsxYthn8e+jH1UyTnszwPvwWAG2zNyR4d3CRdZCgVeXsFAMFjP9YlwV/
	 WXbrwcrSWi/tduSI3DtiX8R8Pa610hTzzUU8PA5bAB/LdRAjG8rRcvFjPSUfOvu5Qt
	 KNAJQniuxUe34qzIGYKdPF6ZoHJPNTMYmyttLoPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgF0Dlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 23:41:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgF0Dlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 23:41:51 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 679D520857;
        Sat, 27 Jun 2020 03:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593229310;
        bh=Ali5IZNLTIW8llvxQDSSeqrZ636VTDReJzcRNiixCTI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aYgiC1Cmppmj+lWV8ausXHZpLkIb+IgodES53DwyIvVVnwsgutwPqyuqj1OU0f6Av
         Ft7CT76o3C9myEmF/idXHzZk0aN9LpIc+UD86qfFy32f5YEnrjx30YBIoE8Iw3nEb0
         /FEvX8jGyVucATfpIHWtMsBVvO9AhBEurlojSejM=
Date:   Fri, 26 Jun 2020 20:41:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: mmotm 2020-06-25-20-36 uploaded (mm/memory-failure.c)
Message-Id: <20200626204148.6c8c3c359e8baa310ecb744f@linux-foundation.org>
In-Reply-To: <700cf5c7-6e8c-4c09-5ab6-5f946689b012@infradead.org>
References: <20200626033744.URfGO%akpm@linux-foundation.org>
        <700cf5c7-6e8c-4c09-5ab6-5f946689b012@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 15:09:08 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> On 6/25/20 8:37 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-06-25-20-36 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> > 
> 
> when CONFIG_MIGRATION is not set/enabled:
> 
> ../mm/memory-failure.c: In function ‘new_page’:
> ../mm/memory-failure.c:1692:9: error: implicit declaration of function ‘alloc_migration_target’; did you mean ‘alloc_migrate_target’? [-Werror=implicit-function-declaration]
>   return alloc_migration_target(p, (unsigned long)&mtc);
>          ^~~~~~~~~~~~~~~~~~~~~~
>          alloc_migrate_target
> ../mm/memory-failure.c:1692:9: warning: return makes pointer from integer without a cast [-Wint-conversion]
>   return alloc_migration_target(p, (unsigned long)&mtc);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thanks.

Appears to be due to Joonsoo Kim's "mm/migrate: make a standard
migration target allocation function".

