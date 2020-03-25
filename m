Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA007C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B96620775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585132532;
	bh=1A6rNb4E0Q0pJQguCVoz1LWxBQra8oiCyqNMfB8hxtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ey9YxYLy56mM5lm+EUbERglTm+Bv5OTxKrhqL6MB6NHy8JIMdI41Q1nMBCW841I//
	 8Dp439/Kdyyjx+7O/mVqjRA45iM6VQgDnhzEplpaGRzZwZK5rHUhl8tMuCVz2HeIVv
	 PQs/71Sz2e6ly1XEMmtWtWSkSfTqmafvH6Skrwi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCYKfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgCYKfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:35:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF2020772;
        Wed, 25 Mar 2020 10:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585132528;
        bh=1A6rNb4E0Q0pJQguCVoz1LWxBQra8oiCyqNMfB8hxtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRnMLl/GAv74bb4G1X8jwJAlgaSVgcA51h2S7Mt4rvWW2me1iTeYXclfwgZGMmGa4
         kYbvWxPDdTL7VRRP3b8bdYD92yN11+If8wwXhAPNorVh3YRvMB4PDPGMWC/dBEK5i6
         S2wU7OKKbMSwXB5iHNFYxz9JCBkQVY4djMpr3HiE=
Date:   Wed, 25 Mar 2020 11:35:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-spdx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] .gitignore: add SPDX License Identifier
Message-ID: <20200325103525.GA3086352@kroah.com>
References: <20200303133600.9263-1-masahiroy@kernel.org>
 <20200303133600.9263-2-masahiroy@kernel.org>
 <CAK7LNARZUpDKXpniNZ+_=G5Gskebc0HEHT5TKbaz2Xs_Ni6u4g@mail.gmail.com>
 <20200325101838.GA3084128@kroah.com>
 <CAK7LNAQtxwXzmHXr6GMm_BrEvittoUHJkrROVFX02if5BTCgGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQtxwXzmHXr6GMm_BrEvittoUHJkrROVFX02if5BTCgGw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 07:21:39PM +0900, Masahiro Yamada wrote:
> On Wed, Mar 25, 2020 at 7:18 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Mar 25, 2020 at 07:10:03PM +0900, Masahiro Yamada wrote:
> > > On Tue, Mar 3, 2020 at 10:36 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > Add SPDX License Identifier to all .gitignore files.
> > > >
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > >
> > >
> > > Ping?
> >
> > Ah, I just assumed you would take these through your tree, sorry about
> > that.
> >
> > Both look find:
> >
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > Or do you want me to take these?
> >
> 
> Yes.
> That is why I sent this to linux-spdx ML,
> which seems a valid path.

Ok, will take this now, thanks for the ping.

greg k-h
