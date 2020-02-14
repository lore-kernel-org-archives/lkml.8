Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44716C3B18F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B916218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581651046;
	bh=aFQRRLHK13G2Rjem5lu7RUnx1XJ4v3sf+59aIsC7W8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=D2yT6DBPyfchwOQZkUUz27EVzGM6h0XJCxyacv/+m84492TyNQSHifa36jI4qRuWg
	 kAOpPna2qn8ZoDtpxERvvslBvtntnx3B1wP21L0Bnpe63EBzQdACA8bK8PbuBWJxNi
	 mB/tsrJt5jpdeISj9gi8EnWtgPLDnDJ1WBJbsi8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgBNDap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 22:30:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbgBNDan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 22:30:43 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF652187F;
        Fri, 14 Feb 2020 03:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581651041;
        bh=aFQRRLHK13G2Rjem5lu7RUnx1XJ4v3sf+59aIsC7W8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oNh3d4AMWGrA4wkm2ejT6IZuARkPaxnL9eDVkAzcBcW22gWjuHCXMXE6a8J3VesZd
         jeCoiZJMdzu0c+AHcLSZNF+tLag39se5FXFphLdU7pCiNWqnSmsfFGJukQigmTDxjq
         AdaupZ8a0EunQAVjEctWnMC/fYxV88bMhGD84tCQ=
Date:   Thu, 13 Feb 2020 19:30:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        "Herton R. Krzesinski" <herton@redhat.com>, arnd@arndb.de,
        catalin.marinas@arm.com, malat@debian.org, joel@joelfernandes.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        ioanna.alifieraki@gmail.com
Subject: Re: [PATCH] Revert
 "ipc,sem: remove uneeded sem_undo_list lock usage in exit_sem()"
Message-Id: <20200213193040.c269a2958ec926de740dc1fd@linux-foundation.org>
In-Reply-To: <CAOLeGd3BY+pd7e2hnqAfwKZgfoEM22de1uhDdYC5H46DipgjDA@mail.gmail.com>
References: <20191211191318.11860-1-ioanna-maria.alifieraki@canonical.com>
        <d66d41fe-212f-effd-905a-5966a96ddb6e@colorfullife.com>
        <20191217211745.GT7463@unknown>
        <07d574be-0d97-d0f8-8f22-017abebc6b6d@colorfullife.com>
        <CAOLeGd3BY+pd7e2hnqAfwKZgfoEM22de1uhDdYC5H46DipgjDA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 16:24:16 +0000 Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com> wrote:

> This patch is still not merged in mainline (sits in linux-next having lost
> 5.5 rc window and 5.6 merge window).
> Is there any reason for that? Anything else needs to be done?
> It's a simple fix and we have users that are hitting this bug.

sorry, I mistakenly thought this was unreviewed.  Shall send it to
Linus in the next batch, with a cc:stable.

