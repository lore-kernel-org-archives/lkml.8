Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E055C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06DAD20675
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390435AbgFYHtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:49:13 -0400
Received: from smtprelay0248.hostedemail.com ([216.40.44.248]:33488 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390237AbgFYHtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 03:49:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 2E10A837F24D;
        Thu, 25 Jun 2020 07:49:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stove73_501568826e4b
X-Filterd-Recvd-Size: 1548
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jun 2020 07:49:11 +0000 (UTC)
Message-ID: <027076b1335f3b48307c78a3d6d1573fa8975822.camel@perches.com>
Subject: Re: cocci script from 2016 - assignment in if ?
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Kris Borer <kborer@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 25 Jun 2020 00:49:10 -0700
In-Reply-To: <alpine.DEB.2.22.394.2006250848260.3692@hadrien>
References: <3af82c36a9e7477566bf3c2e6ce013cd@perches.com>
         <alpine.DEB.2.22.394.2006250848260.3692@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-25 at 08:49 +0200, Julia Lawall wrote:
> 
> On Wed, 24 Jun 2020, joe@perches.com wrote:
> 
> > https://lore.kernel.org/patchwork/patch/649705/
> > 
> > Any particular reason this wasn't applied?
> > 
> > I ask because I added something similar recently to checkpatch.
> 
> It probably slipped through the cracks at the time the Coccinelle
> scripts maintainer disappeared.  I can check and see if it does anything
> more than your script.

The checkpatch thing only works on single lines,
so this cocci script looks more whitespace robust
but this script doesn't appear to handle code like

	if (!(foo = bar(...)))
		baz;

where the checkpatch thing converts it OK.
		

