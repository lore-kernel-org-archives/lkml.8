Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A98C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CB82082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580442782;
	bh=6YOS1TzHipW9uaUsftfB2UIk0lglYFMmhV7D3s6N+PA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gdr1LlefQZPoLk9SxmiiKtX7Xm7LvX3QW9vyBby983E1jQxNRbAmOwVcgAgsB6zsO
	 g8bm/RUMYJEQoqr/Z88tTHIk8VK1XqETY1wgsFFHBW2pBklRhV6OFkH66H3itFr6ix
	 /XVDmYQwWGM7O+xqq4v76wS1LKCTK1ZPOABD3OLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgAaDxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 22:53:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbgAaDxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 22:53:01 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 085C920705;
        Fri, 31 Jan 2020 03:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580442779;
        bh=6YOS1TzHipW9uaUsftfB2UIk0lglYFMmhV7D3s6N+PA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y9iEqdTLYa4B914rpbwC+c5Gregjh8Iz30jxyjm4mT0cv4Cxve3RBTPGVxwWwJNAC
         rBkazFM5o06MQEk52Dra7RO9nigS8NQy2BLFyiswuQIBLH6QSe55P+ncufxQGuI2qL
         bxJrEoirPlptW+WMF28nv408z+PsKRwLXIozepLg=
Date:   Thu, 30 Jan 2020 19:52:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Bob Picco <bob.picco@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v2 0/3] mm: fix max_pfn not falling on section boundary
Message-Id: <20200130195258.6609880ac35f27f29238f804@linux-foundation.org>
In-Reply-To: <20191211163201.17179-1-david@redhat.com>
References: <20191211163201.17179-1-david@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 17:31:58 +0100 David Hildenbrand <david@redhat.com> wrote:

> Playing with different memory sizes for a x86-64 guest, I discovered that
> some memmaps (highest section if max_mem does not fall on the section
> boundary) are marked as being valid and online, but contain garbage. We
> have to properly initialize these memmaps.
> 
> Looking at /proc/kpageflags and friends, I found some more issues,
> partially related to this.

We're still showing very little (ie no) review activity on this
patchset.

