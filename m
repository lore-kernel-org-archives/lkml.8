Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F95C35249
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 23:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2E220643
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 23:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgBAXge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 18:36:34 -0500
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]:46016 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726487AbgBAXge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 18:36:34 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B4860837F24A;
        Sat,  1 Feb 2020 23:36:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: level58_1bec00691dd04
X-Filterd-Recvd-Size: 2157
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat,  1 Feb 2020 23:36:31 +0000 (UTC)
Message-ID: <5ac73de311101754a25aaeac3df1aca23dbaf2af.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: rectify radix-tree testing entry in XARRAY
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 01 Feb 2020 15:35:23 -0800
In-Reply-To: <alpine.DEB.2.21.2002012231410.5859@felia>
References: <20200201180234.4960-1-lukas.bulwahn@gmail.com>
         <alpine.DEB.2.21.2002012231410.5859@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-02-01 at 22:35 +0100, Lukas Bulwahn wrote:
> 
> On Sat, 1 Feb 2020, Lukas Bulwahn wrote:
> 
> > The initial commit 3d5bd6e1a04a ("xarray: Add MAINTAINERS entry")
> > missed a trailing slash to include all files and subdirectory files.
> > Hence, all files in tools/testing/radix-tree were not part of XARRAY,
> > but were considered to be part of "THE REST".
> > 
> > Rectify this to ensure patches reach the actual maintainer.
> > 
> > This was identified with a small script that finds all files only
> > belonging to "THE REST" according to the current MAINTAINERS file, and I
> > acted upon its output.
> > 
> > Fixes: 3d5bd6e1a04a ("xarray: Add MAINTAINERS entry")
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Matthew, please pick this small fixup patch.
> > 
> > applies cleanly on current master and next-20200131
> > 
> 
> Matthew, Joe Perches just informed me that get_maintainers.pl is smart
> enough to handle the case below and does not strictly need a further 
> trailing slash.
> 
> Please ignore this patch; the commit message is actually wrong.

While the commit message may be inexact,
I think the actual change is good and
could/should still be applied.

The "Fixes:" tag is unnecessary though.


