Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148B1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9C12146E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583219733;
	bh=jxKuKOeAmBDdtgTeQzbyInETLmP9jokCNCrrFLdEEOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Y7izEYF8ZJmo62oFGr5tVzxIxUXmtWQ6QCbYBrQRJxO6I8/Jc8L7+cPlh6t4ZzanF
	 XcCyn5u0O0h9Q4FTJMjQTUxoY5IKXYRsTyQputppImgUAwQojNsKL8p6kqXlc/rhSk
	 LAMuXq7pPD7SWVZAlpz4Jv1z6Evf4wObDZaRkBKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgCCHPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:15:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727609AbgCCHPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:15:30 -0500
Received: from onda.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE45720CC7;
        Tue,  3 Mar 2020 07:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583219730;
        bh=jxKuKOeAmBDdtgTeQzbyInETLmP9jokCNCrrFLdEEOY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q4+ebcjd7C41Wt9WmIlnrm2QaREJEDndQGNY7rnLH2xvk1XAzOq5xZnCRAeBx4Eqe
         gl4cQZUuqq+mBp10JFWQTpkaf3v6F/6OnC7216uwRJKJPhqsSdZIbn+4mBWRdfhByU
         alSR1EPB4/kTg29yMeRcnH+9Jv/yo2o6CFI9SkGM=
Date:   Tue, 3 Mar 2020 08:15:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 07/12] docs: dt: convert of_unittest.txt to ReST
Message-ID: <20200303081526.609a2d53@onda.lan>
In-Reply-To: <13c4a1d3-9d12-9085-8e05-218a7ab511c1@gmail.com>
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
        <09f0a0877184ecdff1df1f6f6d38c164c6bdd8f6.1583135507.git.mchehab+huawei@kernel.org>
        <13c4a1d3-9d12-9085-8e05-218a7ab511c1@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 2 Mar 2020 15:11:42 -0600
Frank Rowand <frowand.list@gmail.com> escreveu:

> On 3/2/20 1:59 AM, Mauro Carvalho Chehab wrote:
> > - Add a SPDX header;
> > - Adjust document and section titles;
> > - Adjust numerated list markups;
> > - Some whitespace fixes and new line breaks;
> > - Mark literal blocks as such;
> > - Add it to devicetree/index.rst.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/devicetree/index.rst            |   1 +
> >  .../{of_unittest.txt => of_unittest.rst}      | 186 +++++++++---------
> >  2 files changed, 98 insertions(+), 89 deletions(-)
> >  rename Documentation/devicetree/{of_unittest.txt => of_unittest.rst} (54%)
> > 
> > diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
> > index 308cac9d7021..ca83258fbba5 100644
> > --- a/Documentation/devicetree/index.rst
> > +++ b/Documentation/devicetree/index.rst
> > @@ -12,3 +12,4 @@ Open Firmware and Device Tree
> >     booting-without-of
> >     changesets
> >     dynamic-resolution-notes
> > +   of_unittest
> > diff --git a/Documentation/devicetree/of_unittest.txt b/Documentation/devicetree/of_unittest.rst
> > similarity index 54%
> > rename from Documentation/devicetree/of_unittest.txt
> > rename to Documentation/devicetree/of_unittest.rst
> > index 9fdd2de9b770..dea05214f3ad 100644
> > --- a/Documentation/devicetree/of_unittest.txt
> > +++ b/Documentation/devicetree/of_unittest.rst
> > @@ -1,9 +1,13 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +==================================
> >  Open Firmware Device Tree Unittest
> > -----------------------------------
> > +==================================
> >  
> >  Author: Gaurav Minocha <gaurav.minocha.os@gmail.com>
> >  
> >  1. Introduction
> > +===============
> >  
> >  This document explains how the test data required for executing OF unittest
> >  is attached to the live tree dynamically, independent of the machine's
> > @@ -11,8 +15,8 @@ architecture.
> >  
> >  It is recommended to read the following documents before moving ahead.
> >  
> > -[1] Documentation/devicetree/usage-model.rst
> > -[2] http://www.devicetree.org/Device_Tree_Usage
> > +(1) Documentation/devicetree/usage-model.rst
> > +(2) http://www.devicetree.org/Device_Tree_Usage  
> 
> You caught this in 03/13.  The file has moved to:
> 
>    https://elinux.org/Device_Tree_Usage
> 

Thanks for noticing. I'll move patch 03/12 to the end and fix all those
references altogether there.

Regards,
Mauro
