Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD41C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E8821D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCJQ7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:59:05 -0400
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:55651 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726442AbgCJQ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:59:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 4BA3D100FBB16;
        Tue, 10 Mar 2020 16:59:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coat13_4ecf5281c8248
X-Filterd-Recvd-Size: 2756
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 10 Mar 2020 16:59:01 +0000 (UTC)
Message-ID: <3b19da8cb94aeb1e77452348dc528dd3b8a52a2a.camel@perches.com>
Subject: Re: [Outreachy kernel] [PATCH v2] Staging: rtl8188eu: rtw_mlme: Add
 space around operators
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>,
        Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, sbrivio@redhat.com,
        daniel.baluta@gmail.com, nramas@linux.microsoft.com,
        hverkuil@xs4all.nl
Date:   Tue, 10 Mar 2020 09:57:20 -0700
In-Reply-To: <alpine.DEB.2.21.2003101554530.26409@hadrien>
References: <20200310144702.14653-1-shreeya.patel23498@gmail.com>
         <alpine.DEB.2.21.2003101554530.26409@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-10 at 15:57 +0100, Julia Lawall wrote:
> On Tue, 10 Mar 2020, Shreeya Patel wrote:
> 
> > Add space around operators for improving the code
> > readability.
> > 
> > Reported by checkpatch.pl
> > 
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > ---
> > 
> > rtw_mlme_old.o - Previously produced object file before making any
> > changes to the source code.
> > rtw_mlme.o - Object file produced after compiling the changes done in source
> > file.
> > 
> > Following is the output of diff between the previously produced object
> > file and the object file produced after compiling the changes.
> > 
> > shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/core$ diff rtw_mlme_old.o rtw_mlme.o
> > shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/core$
> > 
> > Following output shows that there was no other change in the source
> > code except for whitespace.
> > 
> > shreeya@Shreeya-Patel:~git/kernels/staging$ git diff -w drivers/staging/rtl8188eu/core/
> > shreeya@Shreeya-Patel:~git/kernels/staging$
> 
> If this information is importamt, it should be above the line.  On the
> other hand, it is much too detailed, making it hard to figure out what is
> being said.  It would be better to just say diff of the .o files before
> and after the changes shows no difference.  Likewise git diff -w shows no
> difference.  That way one can quickly see what tests you did, without
> being distracted by the machine name, the directory name, etc.

Exactly right.

Keep at it Shreeya.  Almost done.

[It's also nice to trim your replies Julia]


