Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813EEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3E8204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ik6IdO4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404736AbgFYMxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:53:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30320 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404125AbgFYMxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593089631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T4xXmPkIxrsPbm0aOu6L+HzsSO8+iKexW3Y4z1Z7tVY=;
        b=ik6IdO4jM6d/H4ImZGx80GUwnztr/e40XZ17xtuqf7o/njdI8gZSpCo5w0E3Ev0HfYdHcl
        a7p8xq5a90Iy5MrZ4BcVHW19TIskui20JR+Px5MWm/igh6VHivT942gbFt9RPvTouEr4uF
        BlfROxFpAczlbQeCKNc/gbdxVlmKPgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-GxNC2wlVONK4C4c8fNHE5A-1; Thu, 25 Jun 2020 08:53:49 -0400
X-MC-Unique: GxNC2wlVONK4C4c8fNHE5A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A22CE1005512;
        Thu, 25 Jun 2020 12:53:48 +0000 (UTC)
Received: from starship (unknown [10.35.206.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA3311010428;
        Thu, 25 Jun 2020 12:53:47 +0000 (UTC)
Message-ID: <855fea60f47c1a0dbcf0395a4cdbe5d9c57592c1.camel@redhat.com>
Subject: Re: Search function in xconfig is partially broken after recent
 changes
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 25 Jun 2020 15:53:46 +0300
In-Reply-To: <20200625131758.52dbdab7@coco.lan>
References: <a98b0f0ebe0c23615a76f1d23f25fd0c84835e6b.camel@redhat.com>
         <20200625125906.6b7688eb@coco.lan> <20200625131758.52dbdab7@coco.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-25 at 13:17 +0200, Mauro Carvalho Chehab wrote:
> Em Thu, 25 Jun 2020 12:59:15 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> 
> > Hi Maxim,
> > 
> > Em Thu, 25 Jun 2020 12:25:10 +0300
> > Maxim Levitsky <mlevitsk@redhat.com> escreveu:
> > 
> > > Hi!
> > > 
> > > I noticed that on recent kernels the search function in xconfig is partially broken.
> > > This means that when you select a found entry, it is not selected in the main window,
> > > something that I often do to find some entry near the area I would like to modify,
> > > and then use main window to navigate/explore that area.
> > > 
> > > Reverting these commits helps restore the original behavier:
> > > 
> > > b311142fcfd37b58dfec72e040ed04949eb1ac86 - kconfig: qconf: fix support for the split view mode
> > > cce1faba82645fee899ccef5b7d3050fed3a3d10 - kconfig: qconf: fix the content of the main widget
> > > 
> > > I have Qt5 5.13.2 from fedora 31 (5.13.2-1.fc31)
> > > 
> > > Could you explain what these commits are supposed to fix?
> > > I mostly use the split view mode too and it does appear to work for me with these commits reverted as well.
> > > 
> > 
> > There are three view modes for qconf:
> > 
> > 	- Single
> > 	- Split
> > 	- Full
> > 
> > those got broken when gconf was converted to use Qt5, back on Kernel 3.14.
> > Those patches restore the original behavior.
You mean xconfig/qconf? (gconf is another program that is GTK based as far as I know).

Could you expalin though what was broken? What exactly didn't work?
I do seem to be able to select menus on the left and the config items to the right,
change the config item values, etc, in the split mode at least with these commits reverted.

Could you check that you also have the issue with search in qconf/xconfig?

> > 
> > > Another question is do you know how to run the qconf standalone? It appears to crash when I attempt to do so,
> > > althought I checked that I pass correct command line to it, and use the same current directory.
> > > I guess PATH or something is set by the makefile, but I was unable yet to find out what exactly breaks it.
> > > 
> > > This is what I see:
> > > 
> > > [mlevitsk@starship ~/UPSTREAM/linux-kernel/src]$./scripts/kconfig/qconf Kconfig
> > > sh: /scripts/gcc-version.sh: No such file or directory
> > > init/Kconfig:34: syntax error
> > > init/Kconfig:33: invalid statement
> > > init/Kconfig:34: invalid statement
> > > sh: /scripts/ld-version.sh: No such file or directory
> > > sh: --version: command not found
> > > init/Kconfig:39: syntax error
> > > init/Kconfig:38: invalid statement
> > > sh: /scripts/clang-version.sh: No such file or directory
> > > init/Kconfig:49: syntax error
> > > init/Kconfig:48: invalid statement
> > > Recursive inclusion detected.
> > > Inclusion path:
> > 
> > It requires some environment vars. This would make it a little better:
> > 
> > 
> > 	export LD=$(which ldd); export CC=$(which gcc); export srctree=$(pwd); scripts/kconfig/gconf Kconfig
> > 	Recursive inclusion detected.
> > 	Inclusion path:
> > 	  current file : arch//Kconfig
> > 	  included from: arch//Kconfig:10
> > 
> > but it seems that something else is also needed.
> 
> This worked for me:
> 
> 	SRCARCH=x86 LD=$(which ldd) CC=$(which gcc) srctree=$(pwd) scripts/kconfig/gconf Kconfig

Thank you!
It does work for me as well (except using qconf of course).

Best regards,
	Maxim Levitsky


> 
> Thanks,
> Mauro
> 


