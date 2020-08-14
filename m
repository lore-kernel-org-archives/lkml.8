Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32180C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 20:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BDBA206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 20:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597435838;
	bh=V1LBnLR6GD/H9lBrBNExcAJGbLLMmg8AfmNutpx8vGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Bkdh/sKIfuDL2sh0mE3JiOVuUPl3uk53QfZwkHcJyBmrg0vOh9g9xSQ+Eu4dznDDl
	 zNVWO3kpaBJfhnWl/62vSDqjTknWTHKpK1+rJMOo1r8V5JEy5MgxOadQcqcz4k+8l2
	 14AvcZC67LI6QOPM447kP1B8AuBSVSzHqBPsaxjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgHNUKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgHNUKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 16:10:35 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 601C2206B2;
        Fri, 14 Aug 2020 20:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597435835;
        bh=V1LBnLR6GD/H9lBrBNExcAJGbLLMmg8AfmNutpx8vGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XubzUq1kxjyC5SQygeG3LR9yJ8DHHjdN1/M3aSrVHWlCJtG+SSfQyWOM8RzGMwgpa
         jb0rRWtCr9/lIactA/ZevYNzPnoeK+pl6wOpiQmtcg83y5wcJCcB+zpDmRuuq58m8V
         oK0vXvWx3EjM51MLhf4amqoc+oh3gST4/TgjbTqY=
Date:   Fri, 14 Aug 2020 13:10:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Roman Gushchin <klamm@yandex-team.ru>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm : sync ra->ra_pages with bdi->ra_pages
Message-Id: <20200814131034.f71a91c6827904e12a629e04@linux-foundation.org>
In-Reply-To: <1597395824-3325-1-git-send-email-zhaoyang.huang@unisoc.com>
References: <1597395824-3325-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 17:03:44 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> Some system(like android) will turbo read during startup via expanding the
> readahead window and then set it back to normal(128kb as usual). However, some
> files in the system process context will keep to be opened since it is opened
> up and has no chance to sync with the updated value as it is almost impossible
> to change the files attached to the inode(processes are unaware of these things)

How about making VM_READAHEAD_PAGES a variable?  Provide a kernel boot
parameter to alter the default setting.  Userspace can then restore the
usual value later in boot?

