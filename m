Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81C6C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E02520771
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587092668;
	bh=t1Gf3OX3PZDXPx83cmiGcGH79UfIdFNHEiWH/rKEXWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=U0yk7fNBcgcHGhf9JlvstGKok4hBHYDLkMB67ZsfAbdkgzqe1rw9H+oC1yKSrArku
	 myFS3bOE0gvLbyS5zZRpsG7i36o8BA1qfrApa0xD2CM1D4PW9RYp2Zs6dqwp8TUcFM
	 Z2AXt1bFcwubJePBoMBojYfQQah0R9YyoyL/b6Xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgDQDE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 23:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgDQDE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 23:04:26 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD3B220771;
        Fri, 17 Apr 2020 03:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587092665;
        bh=t1Gf3OX3PZDXPx83cmiGcGH79UfIdFNHEiWH/rKEXWY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e/NWhcwAcuVugGEsODRztzM1QFXDsNs5WDL6qKsNu82oB5cZ1OHF80+ovyRxC8Y+Q
         AGPIMPo5RRcFjTNWtAFGX2nXpggo205t+asgtNi5GepnEcbDD31Wu1lf81GAM0ImPQ
         x6WBy3dqdihQSTkHu2gVdJNXw+eEUwQy3SpQMTZQ=
Date:   Thu, 16 Apr 2020 20:04:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: rename "catch" function argument
Message-Id: <20200416200424.55d0cf47de72efaac445f307@linux-foundation.org>
In-Reply-To: <20200416172155.GA2280@avx2>
References: <20200331210905.GA31680@avx2>
        <20200415210727.c0cf80b5a981292bb15d9858@linux-foundation.org>
        <20200416172155.GA2280@avx2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 20:21:55 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Wed, Apr 15, 2020 at 09:07:27PM -0700, Andrew Morton wrote:
> > On Wed, 1 Apr 2020 00:09:05 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > 
> > > "catch" is reserved keyword in C++, rename it to something
> > > both gcc and g++ accept.
> > 
> > Why? Is someone compiling the kernel with g++?
> 
> I do!
> https://marc.info/?l=linux-acpi&m=158343373912366&w=4
> 

Lol.  But why?
