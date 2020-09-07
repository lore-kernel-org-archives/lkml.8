Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4130AC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E432080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599498908;
	bh=iVJ4oDTE3gYccFF+I2iu/ZdtCGQPx73HrYF3gXuC4M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yITDGZd0B5GK9jFHF3freYNUhT3xoYzMR7hWfZzlVRY/g+IFuVrzCyNqHxAECRNj8
	 dL7Dxqy9tuYye0NNM4eDlJhD+ziaxMzVS6W6WymrKbnI00/fMadR/kDnZTOcSET9yj
	 OAOfKvca81unUZR8DQYxTyUN6U/94ULHnrp2je7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbgIGRPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729783AbgIGOHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:07:50 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E38C520714;
        Mon,  7 Sep 2020 14:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599487669;
        bh=iVJ4oDTE3gYccFF+I2iu/ZdtCGQPx73HrYF3gXuC4M4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glkIdbX6CZZiAclL+SW/fAIYhujdUPu4LDZ4JR8ScNJL91L3PJ+3OvwpMh3VJSKki
         dHr3tXDaVE1WVoVz95yZMK8vy9yavYJsvfwRGPaIn5m1ICApC8/nOp2tFPO2Adhuad
         cs+HF1nnbe6EeSMYKN9Zs9QNptsa4InijNsjK2BI=
Date:   Mon, 7 Sep 2020 16:08:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Paraschiv, Andra-Irina" <andraprs@amazon.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Anthony Liguori <aliguori@amazon.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        David Duncan <davdunc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Alexander Graf <graf@amazon.de>, Karen Noel <knoel@redhat.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Balbir Singh <sblbir@amazon.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stewart Smith <trawets@amazon.com>,
        Uwe Dannowski <uwed@amazon.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm <kvm@vger.kernel.org>,
        ne-devel-upstream <ne-devel-upstream@amazon.com>
Subject: Re: [PATCH v8 17/18] nitro_enclaves: Add overview documentation
Message-ID: <20200907140803.GA3719869@kroah.com>
References: <20200904173718.64857-1-andraprs@amazon.com>
 <20200904173718.64857-18-andraprs@amazon.com>
 <20200907090126.GD1101646@kroah.com>
 <44a8a921-1fb4-87ab-b8f2-c168c615dbbd@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44a8a921-1fb4-87ab-b8f2-c168c615dbbd@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 04:43:11PM +0300, Paraschiv, Andra-Irina wrote:
> 
> 
> On 07/09/2020 12:01, Greg KH wrote:
> > 
> > On Fri, Sep 04, 2020 at 08:37:17PM +0300, Andra Paraschiv wrote:
> > > Signed-off-by: Andra Paraschiv <andraprs@amazon.com>
> > > Reviewed-by: Alexander Graf <graf@amazon.com>
> > > ---
> > > Changelog
> > > 
> > > v7 -> v8
> > > 
> > > * Add info about the primary / parent VM CID value.
> > > * Update reference link for huge pages.
> > > * Add reference link for the x86 boot protocol.
> > > * Add license mention and update doc title / chapter formatting.
> > > 
> > > v6 -> v7
> > > 
> > > * No changes.
> > > 
> > > v5 -> v6
> > > 
> > > * No changes.
> > > 
> > > v4 -> v5
> > > 
> > > * No changes.
> > > 
> > > v3 -> v4
> > > 
> > > * Update doc type from .txt to .rst.
> > > * Update documentation based on the changes from v4.
> > > 
> > > v2 -> v3
> > > 
> > > * No changes.
> > > 
> > > v1 -> v2
> > > 
> > > * New in v2.
> > > ---
> > >   Documentation/nitro_enclaves/ne_overview.rst | 95 ++++++++++++++++++++
> > >   1 file changed, 95 insertions(+)
> > >   create mode 100644 Documentation/nitro_enclaves/ne_overview.rst
> > A whole new subdir, for a single driver, and not tied into the kernel
> > documentation build process at all?  Not good :(
> > 
> 
> Would the "virt" directory be a better option for this doc file?

Yes.
