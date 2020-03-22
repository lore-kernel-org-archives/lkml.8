Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED077C4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C8920722
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgCVPLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 11:11:17 -0400
Received: from smtprelay0151.hostedemail.com ([216.40.44.151]:36538 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725785AbgCVPLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 11:11:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id EEC47181D2FE4;
        Sun, 22 Mar 2020 15:11:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: talk44_7f4b0ad682943
X-Filterd-Recvd-Size: 1813
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sun, 22 Mar 2020 15:11:14 +0000 (UTC)
Message-ID: <e40d49aaa96a61019804255c2990d229b2eef7dc.camel@perches.com>
Subject: Re: [Outreachy kernel] [PATCH 01/11] Staging: rtl8188eu: hal_com:
 Add space around operators
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Date:   Sun, 22 Mar 2020 08:09:26 -0700
In-Reply-To: <20200322112744.GC75383@kroah.com>
References: <cover.1584826154.git.shreeya.patel23498@gmail.com>
         <19950c71482b3be0dd9518398af85e964f3b66b1.1584826154.git.shreeya.patel23498@gmail.com>
         <20200322112744.GC75383@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-03-22 at 12:27 +0100, Greg KH wrote:
> On Sun, Mar 22, 2020 at 03:51:13AM +0530, Shreeya Patel wrote:
> > Add space around operators for improving the code
> > readability.
> > Reported by checkpatch.pl
> > 
> > git diff -w shows no difference.
> > diff of the .o files before and after the changes shows no difference.
> 
> There is no need to have these two lines on every changelog comment in
> this series :(

In my opinion, there's no need for a series here.

Whitespace only changes _should_ be done all at once.

Whitespace changes _could_ have changed string constants.

So noting that the patch in only whitespace and that
there isn't a difference in object files is useful as
it shows any change has been compiled and tested.


