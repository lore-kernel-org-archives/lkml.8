Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AADAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56662068D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UJulf+QV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UJulf+QV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgFBPZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 11:25:18 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46588 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgFBPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:25:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B689E8EE268;
        Tue,  2 Jun 2020 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1591111516;
        bh=9h1fCPan50/AtVC4RVH1VdFvVOUfimRNMHrA7y4N+zY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UJulf+QVb/cdiB7yVjHvLsl0JSvP6p3JItwvZpl4WJoyLJIcMUtzzKoisQnrRjBCl
         +otm5Mmq/+yAQ288lLQmoH/L5Oh3+pON9R9RCJCgDJ5/CkS0dXVAY9aQvb3iVgJIxb
         gyMihm1LzaSkjC9R4uGhN1K7XKCEiur3iViclHVs=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8ds-ZsA7ujHy; Tue,  2 Jun 2020 08:25:16 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D3E348EE0F8;
        Tue,  2 Jun 2020 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1591111516;
        bh=9h1fCPan50/AtVC4RVH1VdFvVOUfimRNMHrA7y4N+zY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UJulf+QVb/cdiB7yVjHvLsl0JSvP6p3JItwvZpl4WJoyLJIcMUtzzKoisQnrRjBCl
         +otm5Mmq/+yAQ288lLQmoH/L5Oh3+pON9R9RCJCgDJ5/CkS0dXVAY9aQvb3iVgJIxb
         gyMihm1LzaSkjC9R4uGhN1K7XKCEiur3iViclHVs=
Message-ID: <1591111514.4253.32.camel@HansenPartnership.com>
Subject: Re: kobject_init_and_add is easy to misuse
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Wang Hai <wanghai38@huawei.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        khlebnikov@yandex-team.ru, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Tue, 02 Jun 2020 08:25:14 -0700
In-Reply-To: <20200602121035.GL19604@bombadil.infradead.org>
References: <20200602115033.1054-1-wanghai38@huawei.com>
         <20200602121035.GL19604@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-02 at 05:10 -0700, Matthew Wilcox wrote:
> On Tue, Jun 02, 2020 at 07:50:33PM +0800, Wang Hai wrote:
> > syzkaller reports for memory leak when kobject_init_and_add()
> > returns an error in the function sysfs_slab_add() [1]
> > 
> > When this happened, the function kobject_put() is not called for
> > the
> > corresponding kobject, which potentially leads to memory leak.
> > 
> > This patch fixes the issue by calling kobject_put() even if
> > kobject_init_and_add() fails.
> 
> I think this speaks to a deeper problem with kobject_init_and_add()
> -- the need to call kobject_put() if it fails is not readily apparent
> to most users.  This same bug appears in the first three users of
> kobject_init_and_add() that I checked --
> arch/ia64/kernel/topology.c
> drivers/firmware/dmi-sysfs.c
> drivers/firmware/efi/esrt.c
> drivers/scsi/iscsi_boot_sysfs.c
> 
> Some do get it right --
> arch/powerpc/kernel/cacheinfo.c
> drivers/gpu/drm/ttm/ttm_bo.c
> drivers/gpu/drm/ttm/ttm_memory.c
> drivers/infiniband/hw/mlx4/sysfs.c
> 
> I'd argue that the current behaviour is wrong,

Absolutely agree with this.  We have a big meta pattern here where we
introduce functions with tortuous semantics then someone creates a
checker for the semantics and misuses come crawling out of the woodwork
leading to floods of patches, usually for little or never used error
paths, which really don't buy anything apart from theoretical
correctness.  Just insisting on simple semantics would have avoided
this.

>  that kobject_init_and_add() should call kobject_put() if the add
> fails.  This would need a tree-wide audit.  But somebody needs to do
> that anyway because based on my random sampling, half of the users
> currently get it wrong.

Well, the semantics of kobject_init() are free on fail, so these are
the ones everyone seems to be using.  The semantics of kobject_add are
put on fail.  The problem is that put on fail isn't necessarily correct
in the kobject_init() case: the release function may make assumptions
about the object hierarchy which aren't satisfied in the kobject_init()
failure case.  This argues that kobject_init_and_add() can't ever have
correct semantics and we should eliminate it.

James


