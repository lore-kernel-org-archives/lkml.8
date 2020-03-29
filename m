Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A965C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492642073B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UXmhU7T8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgC2QJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 12:09:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgC2QJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 12:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=19Szx/bVByD1ghQE1BjAko3auE4LJvT1UW4NfdM+INk=; b=UXmhU7T8G2RkDxr6KRK+J4nIXw
        w+T+Nau/44IRWZWA3n6teQCWFV76Xtrrn7hZSP5Wfgld+zZd4EJHxnF4quBm5kxxMtf+T1o5ZTz1V
        61bgGK+nJjhajcyxqbbqgjjwO0uO1OsnfWhfXN4rCND3DuroaFBjQZv6HqHMqsKrdOL1lP5ea/NeO
        822vbvyK2jc8pb7NDlouQwGjc/+D5aNnjp6ynED5xO9dC66nVoJzvlMchpEjoCFCxs7Eb7f5/8UQY
        28s8Jw4IiUW1prNk3RCwd48IuWygocFy9O3C3jlK4Gnm8PZude1vWyXYEN6ZrLKZevFNhhY4ojyTJ
        Os9ohYkw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIaUc-0007Nx-N8; Sun, 29 Mar 2020 16:08:58 +0000
Date:   Sun, 29 Mar 2020 09:08:58 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     walken@google.com, bp@suse.de, akpm@linux-foundation.org,
        srostedt@vmware.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
Subject: Re: [PATCH v3 2/2] mm: mmap: add trace point of vm_unmapped_area
Message-ID: <20200329160858.GV22483@bombadil.infradead.org>
References: <20200320055823.27089-1-jaewon31.kim@samsung.com>
 <CGME20200320055839epcas1p189100549687530619d8a19919e8b5de0@epcas1p1.samsung.com>
 <20200320055823.27089-3-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320055823.27089-3-jaewon31.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 02:58:23PM +0900, Jaewon Kim wrote:
> +	TP_printk("addr=%lx err=%ld total_vm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx\n",

Shouldn't addr be printed as 0x%lx?  I think it's arguable whether to print
len as %ld or 0x%lx.

