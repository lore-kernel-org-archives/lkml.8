Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E197C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7199820870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590475281;
	bh=/KcQnFwdAJ+sIoMb98uWlc+grDXqP2E+CmLa0QPSHPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J/4JDL/BOY5ZYjNjHEo9590Xw0QgizN5XNQy8JcanTUHqVSk5fUMNunNG6NqpHW0h
	 c+9JkNsGv26UPMIBz8t+Mdr5Mw6cxw69XQ202np4YQEVCRRdiBRm1eEX7FbbsrEXrh
	 Wpb7EdIR3CI5AO7LHPRietdCrJCiSMMIlsgns5Lw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgEZGlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 02:41:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbgEZGlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 02:41:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F8B6207D8;
        Tue, 26 May 2020 06:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590475280;
        bh=/KcQnFwdAJ+sIoMb98uWlc+grDXqP2E+CmLa0QPSHPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F197jqM5OaWsMIlwvEbirUAhp9rsbtmvqcMePf30YkfCebmnOXYlkYcK/LbELm/fg
         KeBPi9R5tPZzCcjOVGC1Gb0e0OGZUQs1XnwJPhlcQ10IaphtZQZDCv72moDTVGgJ5v
         P71z9djerfbdHPEqXca7Pli5XOhotuDN0T/3VT2w=
Date:   Tue, 26 May 2020 08:41:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Paraschiv, Andra-Irina" <andraprs@amazon.com>
Cc:     linux-kernel@vger.kernel.org,
        Anthony Liguori <aliguori@amazon.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Alexander Graf <graf@amazon.de>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Balbir Singh <sblbir@amazon.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stewart Smith <trawets@amazon.com>,
        Uwe Dannowski <uwed@amazon.de>, kvm@vger.kernel.org,
        ne-devel-upstream@amazon.com
Subject: Re: [PATCH v2 16/18] nitro_enclaves: Add sample for ioctl interface
 usage
Message-ID: <20200526064118.GA2580410@kroah.com>
References: <20200522062946.28973-1-andraprs@amazon.com>
 <20200522062946.28973-17-andraprs@amazon.com>
 <20200522070853.GE771317@kroah.com>
 <09c68ec6-f0fd-e400-1ff2-681ac51c568c@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09c68ec6-f0fd-e400-1ff2-681ac51c568c@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 11:57:26PM +0300, Paraschiv, Andra-Irina wrote:
> 
> 
> On 22/05/2020 10:08, Greg KH wrote:
> > On Fri, May 22, 2020 at 09:29:44AM +0300, Andra Paraschiv wrote:
> > > Signed-off-by: Alexandru Vasile <lexnv@amazon.com>
> > > Signed-off-by: Andra Paraschiv <andraprs@amazon.com>
> > I know I don't take commits with no changelog text :(
> 
> Included in v3 the changelog for each patch in the series, in addition to
> the one in the cover letter; where no changes, I just mentioned that. :)

But you didn't cc: me on that version :(

