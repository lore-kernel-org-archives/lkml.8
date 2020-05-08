Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596C0C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F24218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588973369;
	bh=H/bz1eblIk60vKqEnoGfF0LsJdD8SpMoVFSecfHLkaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YYBy/e4t1/Sm/MJXSC8Do+dqvDgZR+1Vw+qfM6NOuP1dk3Gm6Y1weYTJ3jpCqGdiY
	 hT7VuR6e17rLgY9vkJ1LOR3z78gUc1jEE05yG2b0aKo6G3PEBQBjmu2LrDK9fqKGHQ
	 giqBg4pme+jWPsKSf8CszAl2iEQtWR/KrvJvJDnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgEHV32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgEHV32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:29:28 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E16D721582;
        Fri,  8 May 2020 21:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588973368;
        bh=H/bz1eblIk60vKqEnoGfF0LsJdD8SpMoVFSecfHLkaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bWoB8oeD7lJqyYcltRHsiPCIzHKtGZm3iczefTg2FQryJbSqfKWkHKczvRGxrOI3K
         007lWd3UYU14VuUh95E+Blzx5o3H6dZO0x0paKWTvVowSmhRYsqMvkhMaKjpDh/5R6
         0SowGIrI6rXwCkRmjwUxtbHv2pkxeFTnkTw7ZvdE=
Date:   Fri, 8 May 2020 14:29:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-Id: <20200508142927.eb07ecdf462f5287c221fa18@linux-foundation.org>
In-Reply-To: <20200508145123.GA1431382@iweiny-DESK2.sc.intel.com>
References: <20200507221721.0330271c@canb.auug.org.au>
        <20200508114338.02d2b843@canb.auug.org.au>
        <20200507190808.c6cdd5ffd68d0a154ef8ff18@linux-foundation.org>
        <20200508145123.GA1431382@iweiny-DESK2.sc.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 07:51:23 -0700 Ira Weiny <ira.weiny@intel.com> wrote:

> This should probably be squashed into that patch though...
> 
> Andrew do you want a V3.1?

Is OK, I'll always fold foo-fix.patch into foo.patch before sending it onwards.
