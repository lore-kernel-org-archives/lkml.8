Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F4FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65BAC2076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591045587;
	bh=JKKCcPSQ16JBYHZKrRYFmH1gNliKgP1BlndNb+gssBE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=0UlxHIHCiZJklBcotMelhJbnpkrgrEKfXb4R9RfryF+YdzyXlBNrTKe7M9LUs02fd
	 SVAob0o6OMtzH0lQuUm56Zg1fqgrpK9kIYFTmjkXqkpyJAWLIGAF86bThiW+tCv2HA
	 3pCkAgLR23r/oZpbw4b2IP4RF2IiGp+nnqu9VCvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgFAVG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbgFAVG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:06:26 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 563D32073B;
        Mon,  1 Jun 2020 21:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591045585;
        bh=JKKCcPSQ16JBYHZKrRYFmH1gNliKgP1BlndNb+gssBE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=uCJYQiXodj60WSq0CnVF3iKVwa43WprWs1BZN9WRewFczGAqrs7i+Q3E8PaleOJyx
         HCN1p+zAxD9n38xJHpHaRnuIh13HMwwwprOxYhBIBOB2rAeU5sh0m29J2LC39rmfQQ
         CH8NGKE3y5IS9mlEOa72REboICezVZJ3c/cVcrxA=
Date:   Mon, 1 Jun 2020 14:06:24 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Dominique Martinet <asmadeus@codewreck.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        ericvh@gmail.com, lucho@ionkov.net,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2] 9p/xen: increase XEN_9PFS_RING_ORDER
In-Reply-To: <20200522055847.GA2833@nautica>
Message-ID: <alpine.DEB.2.21.2006011406100.12801@sstabellini-ThinkPad-T480s>
References: <20200521193242.15953-1-sstabellini@kernel.org> <20200522055847.GA2833@nautica>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

n Fri, 22 May 2020, Dominique Martinet wrote:
> Stefano Stabellini wrote on Thu, May 21, 2020:
> > From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> > 
> > Increase XEN_9PFS_RING_ORDER to 9 for performance reason. Order 9 is the
> > max allowed by the protocol.
> > 
> > We can't assume that all backends will support order 9. The xenstore
> > property max-ring-page-order specifies the max order supported by the
> > backend. We'll use max-ring-page-order for the size of the ring.
> > 
> > This means that the size of the ring is not static
> > (XEN_FLEX_RING_SIZE(9)) anymore. Change XEN_9PFS_RING_SIZE to take an
> > argument and base the calculation on the order chosen at setup time.
> > 
> > Finally, modify p9_xen_trans.maxsize to be divided by 4 compared to the
> > original value. We need to divide it by 2 because we have two rings
> > coming off the same order allocation: the in and out rings. This was a
> > mistake in the original code. Also divide it further by 2 because we
> > don't want a single request/reply to fill up the entire ring. There can
> > be multiple requests/replies outstanding at any given time and if we use
> > the full ring with one, we risk forcing the backend to wait for the
> > client to read back more replies before continuing, which is not
> > performant.
> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> 
> LGTM, I'll try to find some time to test this by the end of next week or
> will trust you if I can't make it -- ping me around June 1st if I don't
> reply again until then...

Ping :-)
