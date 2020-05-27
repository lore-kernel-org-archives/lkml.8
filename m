Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778D5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B8820899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590556747;
	bh=+Gu7Ms819qce1QK403qJCBSwes3RbCCCLDAY5Pq8X2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bXI1cR8yfYOTWkDfrp3ya1CWhXBovSLAqs/VdCLs5/cy2uFkCeEvZiAjYp6CLq+HW
	 hvn/fA2xaQwLSY8DwPAcZRhI4fnx6nXRUNJhBoU8l46/KXTstOitohc91VGXRT/v5k
	 fTG/5bMgfW/dFxO8/JWA0KlzykkeydUqvN8tHOKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgE0FTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 01:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgE0FTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:19:06 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87BE0207E8;
        Wed, 27 May 2020 05:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590556745;
        bh=+Gu7Ms819qce1QK403qJCBSwes3RbCCCLDAY5Pq8X2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7384c9qF9IFuyKS/iMi2tBagpNmaWjiDU1TY32lRPvM1CulVTZoqeY7zkRwEHesc
         V44k6+Kvdw252EsRRXIt8MolSdYOGEg1KwjNWHuOQsIX9optA3gYpuMWEfj3p+bB30
         aWKSYEGPAaVIA3MCWu73f6clJVTow1ynWJ9lRVD8=
Date:   Wed, 27 May 2020 14:18:56 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dongli Zhang <dongli.zhang@oracle.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        axboe@fb.com, sagi@grimberg.me
Subject: Re: [PATCH 1/1] nvme-pci: avoid race between
 nvme_reap_pending_cqes() and nvme_poll()
Message-ID: <20200527051856.GB24949@redsun51.ssa.fujisawa.hgst.com>
References: <20200527004955.19463-1-dongli.zhang@oracle.com>
 <20200527050559.GA16317@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527050559.GA16317@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: fa46c6fb5d61 ("nvme/pci: move cqe check after device shutdown")
