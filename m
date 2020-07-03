Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33B4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F89820771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593751735;
	bh=qCwA4YWH7p37GAZMeu+hKOmjvj572O6tQitBU9AkFA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BzpnrCd6IJJvqoRA5DGKD4KuBXvsGjNAmtkqR2G84jxrw1c6o6tkjEEGOU9n9KgWe
	 yaqrdePqcD2reguTKtOhKRcXyjgsxNlOgn7SscVRt/Vhat2Ws6mInJuUTzRuAA6IBp
	 95WvbDOz5HpENYsyRECC2X0ZqcYIcYeCxbE6XL48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgGCEsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgGCEsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 00:48:54 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6540420760;
        Fri,  3 Jul 2020 04:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593751733;
        bh=qCwA4YWH7p37GAZMeu+hKOmjvj572O6tQitBU9AkFA8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tu1u0P0WWAPSlKRhONp69ryOgimZiASL7tdbV191VzQwJFsTuQHdnuMY0QNyJzODN
         GITk7H/2ElwWxOt5dvfAI2AMjUzs2rks/bAvD1NlqTS51CVe/LEDKB46tq5x6aEcOP
         nT4Ccl9OGEgmV5nZJEe3M9y8p1vx5OZ8u5tebPho=
Date:   Thu, 2 Jul 2020 21:48:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 1/2] mm/memblock: expose only miminal interface to
 add/walk physmem
Message-Id: <20200702214852.f6ab03dc8d072abf35359d3b@linux-foundation.org>
In-Reply-To: <9a6728b2-05d3-0e98-dc45-a3e4821e0539@redhat.com>
References: <20200701141830.18749-1-david@redhat.com>
        <20200701141830.18749-2-david@redhat.com>
        <20200701150643.GA2999146@linux.ibm.com>
        <20200701153157.GC5008@osiris>
        <9a6728b2-05d3-0e98-dc45-a3e4821e0539@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 09:23:10 +0200 David Hildenbrand <david@redhat.com> wrote:

> >>> ---
> >>>  arch/s390/kernel/crash_dump.c |  6 ++--
> >>>  include/linux/memblock.h      | 28 ++++++++++++++---
> >>>  mm/memblock.c                 | 57 ++++++++++++++++++-----------------
> >>>  3 files changed, 55 insertions(+), 36 deletions(-)
> > 
> > So I guess this should go via the s390 tree, since the second patch of
> > this series can go only upstream if both this patch and a patch which
> > is currently only on our features are merged before.
> > 
> > Any objections?
> 
> @Andrew, fine with you if this goes via the s390 tree?

Sure, please go ahead.
