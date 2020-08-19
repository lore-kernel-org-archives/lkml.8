Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6E5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BCBD2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597867936;
	bh=wCiqSWw7+dELXrP0i9ukDIaG6ZmIp6AkyvOOF38BHhE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=H5W6ncageQuENgLipV/Cebn/Z9u5y8ZR2DRr7HPuCVKNBYnVcCubEnQo+3SvQy0eK
	 hES0K+6O8faAbBv4Tcf+YNdy5BmPrdhAGzPHIeSqhY1a8FCGHrsD6NEcufExSX1lbM
	 I4tBAPQCFl7J0NS9lluZO2lVqayBqfNbXMj1A0Sc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgHSUMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgHSUML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 16:12:11 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60F7C2078D;
        Wed, 19 Aug 2020 20:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597867931;
        bh=wCiqSWw7+dELXrP0i9ukDIaG6ZmIp6AkyvOOF38BHhE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fJn0qJu+brZMju6egaLEThAXIfIpqw+HI2cdO85N+QLjA8pTMhMzxD+EcD0kyLtCF
         CzUbgTsJGGXpdpSWLFyvrGIsHJvPrAx/Skq5fVj259IuWkDmkyBYkE9qdfHUvHuutN
         2YoHbMEPsjDuhAONpVpfC2oytz3MIYXF3Ie/oXyY=
Date:   Wed, 19 Aug 2020 13:12:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/mmap: rename __vma_unlink_common() to
 __vma_unlink()
Message-Id: <20200819131210.dc5c045a626d1bf4475214d1@linux-foundation.org>
In-Reply-To: <20200809232057.23477-1-richard.weiyang@linux.alibaba.com>
References: <20200809232057.23477-1-richard.weiyang@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020 07:20:56 +0800 Wei Yang <richard.weiyang@linux.alibaba.com> wrote:

> __vma_unlink_common() and __vma_unlink() are counterparts. Since there is

I assume you meant "__vma_link()" here?

> not function named __vma_unlink(), let's rename it to __vma_unlink() to
> make the code more self-explain and easy for audience to understand.
> 
> Otherwise we may expect there are several variants of vma_unlink and
> __vma_unlink_common() is used by them.
