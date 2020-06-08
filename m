Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3FDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0712076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591656942;
	bh=lmj78NsywzOH58ADrFq/+/zw3NLJPj16X1Kl9wTzZlA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=v1nYWdbaDr52XaFvOszuyGWQTvykxGDmnfm9CAoDnTrcrEzmb1ieYS0pkqWRsKEuS
	 RxT80OguppTUMKXiGPqCiCyCZZdCuEhTwI7ZAHJaeJqB4ZY13n/L2KWxcp9opNu+is
	 YLqoQVgF+7lGlcOy791Rbnuq9w+tTB1zJlNM6WQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgFHWzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgFHWzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:55:40 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7B8206D5;
        Mon,  8 Jun 2020 22:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591656940;
        bh=lmj78NsywzOH58ADrFq/+/zw3NLJPj16X1Kl9wTzZlA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=vxd2TBISH8H0Cfr4Y2boYussvZELUi1dGQYCN0391gCqf+M+zEHTxMJ3eiBCXwo/m
         Qcaay/hGXQIgfxgQfJp6K0fsW1H0JquhtId6jMP4h7XA9wKQlvbZd8pIDvL8CaAR+0
         VU9uq18isLanuFMVY8NzMiP+1IEas3OaCgSqXiUI=
Date:   Mon, 8 Jun 2020 15:55:39 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@infradead.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        tamas@tklengyel.com, roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 03/11] swiotlb-xen: add struct device* parameter to
 xen_phys_to_bus
In-Reply-To: <20200608070507.GB15742@infradead.org>
Message-ID: <alpine.DEB.2.21.2006081539550.2815@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s> <20200603222247.11681-3-sstabellini@kernel.org> <20200608070507.GB15742@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020, Christoph Hellwig wrote:
> On Wed, Jun 03, 2020 at 03:22:39PM -0700, Stefano Stabellini wrote:
> > From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> > 
> > The parameter is unused in this patch.
> > No functional changes.
> 
> This looks weird.  I'm pretty sure you are going to use it later, but
> why not just add the argument when it actually is used?

It is just a matter of taste. Xen reviewers tend to ask for splitting
patches into small chunks, especially large verbose non-functional
changes like renaming or adding parameters. It is supposed to make it
easier to review, to make it easier not to get distracted by
renaming/non-functional changes while looking at the important changes.
As a contributor, I am happy either way.
