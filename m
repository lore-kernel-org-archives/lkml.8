Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E740CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1754206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593097552;
	bh=HUIa5W8BQyI2mVxKYGLfPfSoyGiLZXGG05wNOEu4ytU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qrM3F0yxIx8jzHZvO7DxPGL6tETZVV9xfnCsW7Ivbkp0WKLG6N+mpGOT9LEdgbopb
	 BUiuyek7FRe3FYSeEDnkOrcI24zF9ShSHpEnSzmj3JFMdShs5OLUSDNr0g80dsFx9Y
	 nw/Zh607V2uNEhiEx0hCsOoLgpgeoYO7ybru2Y/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405718AbgFYPFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405309AbgFYPFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:05:50 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26750206C0;
        Thu, 25 Jun 2020 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593097549;
        bh=HUIa5W8BQyI2mVxKYGLfPfSoyGiLZXGG05wNOEu4ytU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2AMWOUIcpjm16QOF2AQKu18GUqYA/Uqwdo9ZbY/RKruCY/eepP4qTr8ALbDBK6584
         XfjYxz8ayOVV3rTJc8/sjFi2gpBfgloTs37IW/pz/umb8sXxMA5upgLrpUE7Q/xxbf
         gvQ74fyzP7V/MbO4Gu+XALTo+DgvNXKmVP7g8E3o=
Date:   Thu, 25 Jun 2020 17:05:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Search function in xconfig is partially broken after recent
 changes
Message-ID: <20200625170546.270cf5fc@coco.lan>
In-Reply-To: <855fea60f47c1a0dbcf0395a4cdbe5d9c57592c1.camel@redhat.com>
References: <a98b0f0ebe0c23615a76f1d23f25fd0c84835e6b.camel@redhat.com>
        <20200625125906.6b7688eb@coco.lan>
        <20200625131758.52dbdab7@coco.lan>
        <855fea60f47c1a0dbcf0395a4cdbe5d9c57592c1.camel@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 25 Jun 2020 15:53:46 +0300
Maxim Levitsky <mlevitsk@redhat.com> escreveu:

> On Thu, 2020-06-25 at 13:17 +0200, Mauro Carvalho Chehab wrote:
> > Em Thu, 25 Jun 2020 12:59:15 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> >   
> > > Hi Maxim,
> > > 
> > > Em Thu, 25 Jun 2020 12:25:10 +0300
> > > Maxim Levitsky <mlevitsk@redhat.com> escreveu:
> > >   
> > > > Hi!
> > > > 
> > > > I noticed that on recent kernels the search function in xconfig is partially broken.
> > > > This means that when you select a found entry, it is not selected in the main window,
> > > > something that I often do to find some entry near the area I would like to modify,
> > > > and then use main window to navigate/explore that area.
> > > > 
> > > > Reverting these commits helps restore the original behavier:
> > > > 
> > > > b311142fcfd37b58dfec72e040ed04949eb1ac86 - kconfig: qconf: fix support for the split view mode
> > > > cce1faba82645fee899ccef5b7d3050fed3a3d10 - kconfig: qconf: fix the content of the main widget
> > > > 
> > > > I have Qt5 5.13.2 from fedora 31 (5.13.2-1.fc31)
> > > > 
> > > > Could you explain what these commits are supposed to fix?
> > > > I mostly use the split view mode too and it does appear to work for me with these commits reverted as well.
> > > >   
> > > 
> > > There are three view modes for qconf:
> > > 
> > > 	- Single
> > > 	- Split
> > > 	- Full
> > > 
> > > those got broken when gconf was converted to use Qt5, back on Kernel 3.14.
> > > Those patches restore the original behavior.  
> You mean xconfig/qconf? (gconf is another program that is GTK based as far as I know).

Yeah, I meant the Qt one (qconfig).

> Could you expalin though what was broken? What exactly didn't work?

Try to switch between the several modes and switch back. There used to
have several broken things there, because the Qt5 port was incomplete.

One of the things that got fixed on the Qt5 fixup series is the helper
window at the bottom. It should now have the same behavior as with the
old Qt3/Qt4 version.

Basically, on split mode, it should have 3 screen areas:

	+------------+-------+
	|            |       |
	| Config     |  menu |
	|            |       |
	+------------+-------+
	|                    |
	| Config description +
	|                    |
	+--------------------+

The contents of the config description should follow up any changes at 
the "menu" part of the split mode, when an item is selected from "menu",
or follow what's selected at "config", when the active window is "config".

The Kernel 3.14 conversion broke the "config description", and caused
several other issues.

When the config description area got fixed, I had to fix each of the
modes, for all of them to update the right area at the screen, as they
were pointing to the wrong places on several parts of the code.

> I do seem to be able to select menus on the left and the config items to the right,
> change the config item values, etc, in the split mode at least with these commits reverted.

You should also be able to see the helper window at the bottom changing
as modes change.

Anyway, the patch I just sent should fix it.

> Could you check that you also have the issue with search in qconf/xconfig?

Yeah, before that patch, search was working only on the two other
modes.

Btw, I'm also using Fedora here (Fedora 32). So, I should have a
result close to what you would be experiencing.

Thanks,
Mauro
