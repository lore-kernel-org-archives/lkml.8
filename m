Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362ECC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11AB8207F9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591113310;
	bh=PRxYptlqDh/ho5Adpy8HLDZHSmhfvJbp9cjTmMciy58=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=BXnMs788meoCz2PkrNY94fx3+9VanW6+ip6vvmfmSld1UufLrCWDnjoZ9PXI6vjCl
	 xXTtGPnRnA43veOLA9fsAh/CTpdXj2kHYgoUKmemfpuzxB5NBuo9s5pH37XWwC9Yni
	 eLGssVsmzV6p6ci+Jx9hkVpXgzQXfaIihXZdm6Hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgFBPzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 11:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgFBPzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:55:08 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CDFD2067B;
        Tue,  2 Jun 2020 15:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591113308;
        bh=PRxYptlqDh/ho5Adpy8HLDZHSmhfvJbp9cjTmMciy58=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=rqolI2+cJdcgCjFb938OQrKwiPnmVdg09hq9mw0rg3s/2xntd5muOFt2qIOjCU6yt
         JL5oyl+4M1uHTMXcV7sDlr3yTxMpdCvOXSYOxOHXfujuQRMO5vZEztUqutLOtD3Atb
         GDB+AIu2CqT/LfTdGrDSRzpjlKflJrrfpVV6Seho=
Date:   Tue, 2 Jun 2020 08:55:07 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Dominique Martinet <asmadeus@codewreck.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        ericvh@gmail.com, lucho@ionkov.net,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2] 9p/xen: increase XEN_9PFS_RING_ORDER
In-Reply-To: <20200602060246.GA16791@nautica>
Message-ID: <alpine.DEB.2.21.2006020855010.12801@sstabellini-ThinkPad-T480s>
References: <20200521193242.15953-1-sstabellini@kernel.org> <20200522055847.GA2833@nautica> <alpine.DEB.2.21.2006011406100.12801@sstabellini-ThinkPad-T480s> <20200602060246.GA16791@nautica>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020, Dominique Martinet wrote:
> Stefano Stabellini wrote on Mon, Jun 01, 2020:
> > > LGTM, I'll try to find some time to test this by the end of next week or
> > > will trust you if I can't make it -- ping me around June 1st if I don't
> > > reply again until then...
> > 
> > Ping :-)
> 
> I actually did think about this patch this weekend! . . .but didn't
> quite make it :/
> Anyway, as promised pushed to linux-next, I'll submit this for 5.8

Thank you!
