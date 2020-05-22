Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D2BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A9F20757
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgEVF7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 01:59:04 -0400
Received: from nautica.notk.org ([91.121.71.147]:38062 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgEVF7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 01:59:04 -0400
X-Greylist: delayed 123720 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 May 2020 01:59:03 EDT
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 8C85FC009; Fri, 22 May 2020 07:59:02 +0200 (CEST)
Date:   Fri, 22 May 2020 07:58:47 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     jgross@suse.com, boris.ostrovsky@oracle.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, ericvh@gmail.com,
        lucho@ionkov.net,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2] 9p/xen: increase XEN_9PFS_RING_ORDER
Message-ID: <20200522055847.GA2833@nautica>
References: <20200521193242.15953-1-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200521193242.15953-1-sstabellini@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Stabellini wrote on Thu, May 21, 2020:
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> 
> Increase XEN_9PFS_RING_ORDER to 9 for performance reason. Order 9 is the
> max allowed by the protocol.
> 
> We can't assume that all backends will support order 9. The xenstore
> property max-ring-page-order specifies the max order supported by the
> backend. We'll use max-ring-page-order for the size of the ring.
> 
> This means that the size of the ring is not static
> (XEN_FLEX_RING_SIZE(9)) anymore. Change XEN_9PFS_RING_SIZE to take an
> argument and base the calculation on the order chosen at setup time.
> 
> Finally, modify p9_xen_trans.maxsize to be divided by 4 compared to the
> original value. We need to divide it by 2 because we have two rings
> coming off the same order allocation: the in and out rings. This was a
> mistake in the original code. Also divide it further by 2 because we
> don't want a single request/reply to fill up the entire ring. There can
> be multiple requests/replies outstanding at any given time and if we use
> the full ring with one, we risk forcing the backend to wait for the
> client to read back more replies before continuing, which is not
> performant.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>

LGTM, I'll try to find some time to test this by the end of next week or
will trust you if I can't make it -- ping me around June 1st if I don't
reply again until then...

Cheers,
-- 
Dominique
