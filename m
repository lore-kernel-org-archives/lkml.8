Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15267C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE2021927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NOVgMyD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgCJRxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:53:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gsJiXKDgdx64keYqd+C7ZzwTP0EJv9K9edm2pSAF9ic=; b=NOVgMyD+Bsw2VXMFGBZZqz0e2S
        ngtOqp8pFH0vehs7/K3Fki0V964X3U+ITmYE2h0ibVHVAMuvX2/quaaNwVT/Zajw2W7baYyOwj/kA
        3z6vMvGa6RhJtrfe6QkKOiq2nd3u9jQgPKUrEah66VcGMaJjo0J2kNNb+QRqWP/8tFlLmrksBUIu3
        sOuDQfsHyIlXMMwpZqfrKzSoXeoM1m7nYEDB4gSrX7ipBsghAe0MbB7iFKAMOKgjkJ61kiKEuMClS
        ZiERpsm54ufMveiCQR1Co5QerfTACR0Ha/4EzZxT+YFgmm8LlemHovWWZdl2EbhoAc+RBEIf2I0kK
        jUXKy3jw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jBj4K-0002b3-Qh; Tue, 10 Mar 2020 17:53:28 +0000
Date:   Tue, 10 Mar 2020 10:53:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Prabhath Sajeepa <psajeepa@purestorage.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        roland@purestorage.com
Subject: Re: [PATCH] nvme-rdma: Avoid double freeing of async event data
Message-ID: <20200310175328.GA9203@infradead.org>
References: <1583788073-39681-1-git-send-email-psajeepa@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583788073-39681-1-git-send-email-psajeepa@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 03:07:53PM -0600, Prabhath Sajeepa wrote:
> The timeout of identify cmd, which is invoked as part of admin queue
> creation, can result in freeing of async event data both in
> nvme_rdma_timeout handler and error handling path of
> nvme_rdma_configure_admin queue thus causing NULL pointer reference.
> Call Trace:
>  ? nvme_rdma_setup_ctrl+0x223/0x800 [nvme_rdma]
>  nvme_rdma_create_ctrl+0x2ba/0x3f7 [nvme_rdma]
>  nvmf_dev_write+0xa54/0xcc6 [nvme_fabrics]
>  __vfs_write+0x1b/0x40
>  vfs_write+0xb2/0x1b0
>  ksys_write+0x61/0xd0
>  __x64_sys_write+0x1a/0x20
>  do_syscall_64+0x60/0x1e0
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Prabhath Sajeepa <psajeepa@purestorage.com>
> Reviewed-by: Roland Dreier <roland@purestorage.com>

This looks good as a hot fix:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But I really think we need to do something about init vs timeout
in the state machine.  Otherwise we're going to deal with racing
resource deallocation forever.
