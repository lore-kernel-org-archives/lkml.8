Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BDDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA23020674
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VnyD5sE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgA3Ps2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:48:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44940 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgA3Ps1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 10:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gkmcA19dmheKO/JHYtjj5Ou65Kq3kHywN8tGMAK+PU0=; b=VnyD5sE4FCMuAHC+XD1p+hPPv
        pgxkWwwd40QnTUl7XIBoVqAg3NKiiNbJ0ZifmbPqtB4xFnB9v/cI21Vx6MA680U/O/K00IlvUNCrp
        svx+QN2pqxqJwYlB66IerhREpH6isOjkVWnNeyV2For9jiRPYZKrS2pA8JxT2NlaiirUCS6jbIjnu
        QnpIxqUFJ4sp/dZIqMOqT6ZJndMt3/Ry1iU3EZBOfo4ijoyHjDzYtqQ9mEF6cIGtpqfM7QLy8u8ni
        TmpFk4f/EL42bdiSW63EINoxza3UXeWP76qG+QePtsbx2bwxJzDOG4Yi5PBt514sDWl5o5HMYI2P8
        Sg/nZQNiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixC3D-0000h0-JI; Thu, 30 Jan 2020 15:48:15 +0000
Date:   Thu, 30 Jan 2020 07:48:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: fix uninitialized-variable warning
Message-ID: <20200130154815.GA2463@infradead.org>
References: <20200107214215.935781-1-arnd@arndb.de>
 <20200130150451.GA25427@infradead.org>
 <CAK8P3a0EgfQkrSr77jE12Wm_NKemEZ1rFZLMcVhkAuu1cwOOWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0EgfQkrSr77jE12Wm_NKemEZ1rFZLMcVhkAuu1cwOOWQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 04:36:48PM +0100, Arnd Bergmann wrote:
> > This one is just gross.  I think we'll need to find some other fix
> > that doesn't obsfucate the code as much.
> 
> Initializing the nvme_result in nvme_features() would do it, as would
> setting it in the error path in __nvme_submit_sync_cmd() -- either
> way the compiler cannot be confused about whether it is initialized
> later on.

Given that this is outside the hot path we can just zero the whole
structure before submitting the I/O.
