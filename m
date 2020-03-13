Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87B7C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765CE206F7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584068582;
	bh=MfD/el5E9LurZZaSPewSeycv8wSAS3R57zWeVs/eDn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=g8b+2HlVXOETY9K7DC39TTxKUAHLCGa4tvdNbEObkhu2bNy17yio49yvq5aVvm057
	 lFdeWd3G1gCxYADwklfln6aRb0nNGatHHV2v1ItuBjYXjqJ3cv3MI7cQB2lwE03MMA
	 kflyE18dvEViiaK0msTu5wMi8PaFs5fID/8vkwxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgCMDDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 23:03:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbgCMDDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 23:03:01 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 569AD206E2;
        Fri, 13 Mar 2020 03:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584068580;
        bh=MfD/el5E9LurZZaSPewSeycv8wSAS3R57zWeVs/eDn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ugq8qbdwRlDRYUE6VABOfQoKJks/BvDS0ZkVWlcSotdEyl45bnMZYGGR3reqsLd2K
         JHMz8OZMqnVoVhqLQQhKH8duhDQ+/D953aeF+bYMCVtpNZsHvTrhFFrVPZA2uzcO1O
         QuLTbMLJhLKH0/gThuELJJu+AOsf/e0BA5KUj1ag=
Date:   Thu, 12 Mar 2020 20:02:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     willy@infradead.org, walken@google.com, bp@suse.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com
Subject: Re: [PATCH v2 1/2] mmap: remove inline of vm_unmapped_area
Message-Id: <20200312200259.7b79b38341bde97609fde99a@linux-foundation.org>
In-Reply-To: <20200313011420.15995-2-jaewon31.kim@samsung.com>
References: <20200313011420.15995-1-jaewon31.kim@samsung.com>
        <CGME20200313011430epcas1p129e4033f12b9c02f71443e0b359a26e5@epcas1p1.samsung.com>
        <20200313011420.15995-2-jaewon31.kim@samsung.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 10:14:19 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:

> In prepration for next patch remove inline of vm_unmapped_area and move
> code to mmap.c. There is no logical change.
> 
> Also remove unmapped_area[_topdown] out of mm.h, there is no code
> calling to them.
> 

Patches seem reasonable.

> -extern unsigned long unmapped_area(struct vm_unmapped_area_info *info);
> -extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);

I believe these can now be made static to mmap.c


