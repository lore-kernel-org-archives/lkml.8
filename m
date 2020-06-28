Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7E6C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 08:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEBD821531
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 08:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXekxstX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgF1IhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 04:37:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29652 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbgF1IhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 04:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593333433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mtkdcnfZsJvvv4MSXCrcyUM0NAmX9lvoPnQHqE8ITmU=;
        b=NXekxstXkeAU8WmerAGLaG8rQlKZWtNUaQAx14afEVxKKJuf2j2KMHZbxxI4I+ARua7J8N
        p2OQn8YQfhAy+6Wzk2X0dqhNOodudlpIP7Y6FPRjlMf0tHvxI09fJbDxDmRu2DmjcXj9wa
        /GlxAhfYkZA1+nEgVfhm5TD/FL4RFnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-snKXPAUnMEOEmJGT610pNA-1; Sun, 28 Jun 2020 04:37:12 -0400
X-MC-Unique: snKXPAUnMEOEmJGT610pNA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7676E1800D42;
        Sun, 28 Jun 2020 08:37:10 +0000 (UTC)
Received: from starship (unknown [10.35.206.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C43F19D71;
        Sun, 28 Jun 2020 08:37:09 +0000 (UTC)
Message-ID: <2d536ba419ffe76e031bd65375e5af6a401faec0.camel@redhat.com>
Subject: Re: Search function in xconfig is partially broken after recent
 changes
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 28 Jun 2020 11:37:08 +0300
In-Reply-To: <20200625170546.270cf5fc@coco.lan>
References: <a98b0f0ebe0c23615a76f1d23f25fd0c84835e6b.camel@redhat.com>
         <20200625125906.6b7688eb@coco.lan> <20200625131758.52dbdab7@coco.lan>
         <855fea60f47c1a0dbcf0395a4cdbe5d9c57592c1.camel@redhat.com>
         <20200625170546.270cf5fc@coco.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-25 at 17:05 +0200, Mauro Carvalho Chehab wrote:
> Em Thu, 25 Jun 2020 15:53:46 +0300
> Maxim Levitsky <mlevitsk@redhat.com> escreveu:
> 
> > On Thu, 2020-06-25 at 13:17 +0200, Mauro Carvalho Chehab wrote:
> > > Em Thu, 25 Jun 2020 12:59:15 +0200
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> > >   
> > > > Hi Maxim,
> > > > 
> > > > Em Thu, 25 Jun 2020 12:25:10 +0300
> > > > Maxim Levitsky <mlevitsk@redhat.com> escreveu:
> > > >   
> > > > > Hi!
> > > > > 
> > > > > I noticed that on recent kernels the search function in xconfig is partially broken.
> > > > > This means that when you select a found entry, it is not selected in the main window,
> > > > > something that I often do to find some entry near the area I would like to modify,
> > > > > and then use main window to navigate/explore that area.
> > > > > 
> > > > > Reverting these commits helps restore the original behavier:
> > > > > 
> > > > > b311142fcfd37b58dfec72e040ed04949eb1ac86 - kconfig: qconf: fix support for the split view mode
> > > > > cce1faba82645fee899ccef5b7d3050fed3a3d10 - kconfig: qconf: fix the content of the main widget
> > > > > 
> > > > > I have Qt5 5.13.2 from fedora 31 (5.13.2-1.fc31)
> > > > > 
> > > > > Could you explain what these commits are supposed to fix?
> > > > > I mostly use the split view mode too and it does appear to work for me with these commits reverted as well.
> > > > >   
> > > > 
> > > > There are three view modes for qconf:
> > > > 
> > > > 	- Single
> > > > 	- Split
> > > > 	- Full
> > > > 
> > > > those got broken when gconf was converted to use Qt5, back on Kernel 3.14.
> > > > Those patches restore the original behavior.  
> > You mean xconfig/qconf? (gconf is another program that is GTK based as far as I know).
> 
> Yeah, I meant the Qt one (qconfig).
> 
> > Could you expalin though what was broken? What exactly didn't work?
> 
> Try to switch between the several modes and switch back. There used to
> have several broken things there, because the Qt5 port was incomplete.
> 
> One of the things that got fixed on the Qt5 fixup series is the helper
> window at the bottom. It should now have the same behavior as with the
> old Qt3/Qt4 version.
> 
> Basically, on split mode, it should have 3 screen areas:
> 
> 	+------------+-------+
> 	|            |       |
> 	| Config     |  menu |
> 	|            |       |
> 	+------------+-------+
> 	|                    |
> 	| Config description +
> 	|                    |
> 	+--------------------+
> 
> The contents of the config description should follow up any changes at 
> the "menu" part of the split mode, when an item is selected from "menu",
> or follow what's selected at "config", when the active window is "config".

Dunno. with the 2 b311142fcfd37b58dfec72e040ed04949eb1ac86 and cce1faba82645fee899ccef5b7d3050fed3a3d10,
in split view, I wasn't able to make the 'config description' show anything wrong,
in regard to currently selected item in 'config' and in 'menu'
At that point this is mostly an academic interset for me since,
the patch that you sent fixes search. Thank you very much!

BTW, I re-discovered another bug (I have seen it already but it didn't bother me that much),
while trying to break the version with these commits reverted (but it happens 
with them not reverted as well):

When I enable 'show debug info' to understand why I can't enable/disable some config
option, the hyperlinks in the config description don't work - they make the config
window to be empty.

Best regards and thanks again,
	Maxim Levitsky

> 
> The Kernel 3.14 conversion broke the "config description", and caused
> several other issues.
> 
> When the config description area got fixed, I had to fix each of the
> modes, for all of them to update the right area at the screen, as they
> were pointing to the wrong places on several parts of the code.
> 
> > I do seem to be able to select menus on the left and the config items to the right,
> > change the config item values, etc, in the split mode at least with these commits reverted.
> 
> You should also be able to see the helper window at the bottom changing
> as modes change.
> 
> Anyway, the patch I just sent should fix it.
> 
> > Could you check that you also have the issue with search in qconf/xconfig?
> 
> Yeah, before that patch, search was working only on the two other
> modes.
> 
> Btw, I'm also using Fedora here (Fedora 32). So, I should have a
> result close to what you would be experiencing.
> 
> Thanks,
> Mauro
> 


