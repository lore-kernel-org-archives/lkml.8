Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52A8C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A855720CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580436975;
	bh=tyJKzLA16be5mNz2EBj3faXgdYPo6KX3V43I+YCflTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KfJQB0uNOTn+ZeO4pHnQgNH/kdVhFeYdYbQnsyPsB5AEC5DNXkjh1CrA97Iz/MtRL
	 KPim+kJCfjGgedeROFwx+yCIh8V82PKZnpMrXPwLJgLp7ke8+xFoQSAsRl2XTn5Mff
	 Ay+ISkWi/UFgcgHncmlWVIZZIMc9FkM6cMQNkr8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgAaCQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 21:16:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:49636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbgAaCQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 21:16:14 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3E66206F0;
        Fri, 31 Jan 2020 02:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580436974;
        bh=tyJKzLA16be5mNz2EBj3faXgdYPo6KX3V43I+YCflTI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=naQx0E8TmVLVXc/yB0+otsJ3q2KIhHCnxBgDTYtppdT5Y26k7wkvZykakj9qBy608
         g2ovdKkyHPtcL2CzV5Ue0H58FpBp6X7DhhCv8iVr8JTITI5ba7U+7mBY/SB8LjC3TI
         32/VezsBlEl54vLgzoFT4LRgjVRBHlK8PnH/PgPs=
Date:   Thu, 30 Jan 2020 18:16:13 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v4 2/2] kasan: add test for invalid size in memmove
Message-Id: <20200130181613.1bfb8df8e73a280512cab8ef@linux-foundation.org>
In-Reply-To: <1580355838.11126.5.camel@mtksdccf07>
References: <20191112065313.7060-1-walter-zh.wu@mediatek.com>
        <619b898f-f9c2-1185-5ea7-b9bf21924942@virtuozzo.com>
        <1580355838.11126.5.camel@mtksdccf07>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020 11:43:58 +0800 Walter Wu <walter-zh.wu@mediatek.com> wrote:

> On Fri, 2019-11-22 at 06:21 +0800, Andrey Ryabinin wrote:
> > 
> > On 11/12/19 9:53 AM, Walter Wu wrote:
> > > Test negative size in memmove in order to verify whether it correctly
> > > get KASAN report.
> > > 
> > > Casting negative numbers to size_t would indeed turn up as a large
> > > size_t, so it will have out-of-bounds bug and be detected by KASAN.
> > > 
> > > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > 
> > Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> 
> Hi Andrey, Dmitry, Andrew,
> 
> Would you tell me why this patch-sets don't merge into linux-next tree?
> We lost something?
> 

In response to [1/2] Andrey said "So let's keep this code as this" and
you said "I will send a new v5 patch tomorrow".  So we're awaiting a v5
patchset?

