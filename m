Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35206C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 09:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9A32073E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 09:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgF0JUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 05:20:19 -0400
Received: from smtprelay0206.hostedemail.com ([216.40.44.206]:58100 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgF0JUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 05:20:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 214C4837F24C;
        Sat, 27 Jun 2020 09:20:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: week56_580e02926e5c
X-Filterd-Recvd-Size: 3605
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sat, 27 Jun 2020 09:20:15 +0000 (UTC)
Message-ID: <3f3cc81521d405c62a83650c9315c9ddbf2135aa.camel@perches.com>
Subject: Re: [PATCH] staging: media: usbvision: removing prohibited space
 before ',' (ctx:WxW)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     B K KARTHIK PES2201800185STUDENT ECE DeptPESU EC
         Campus <bkkarthik@pesu.pes.edu>, devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Date:   Sat, 27 Jun 2020 02:20:14 -0700
In-Reply-To: <20200627084932.GA1560170@kroah.com>
References: <20200626143205.xns6nwggskssujao@pesu-pes-edu>
         <CAAhDqq0tSftPxMWGeVy3mp4DGDN3o0uQwTqVbjYUwjqzWpbibQ@mail.gmail.com>
         <20200627050745.GD226238@kroah.com>
         <f73c5a69-1bf9-d80d-2399-ef18ce78b8ac@xs4all.nl>
         <20200627084932.GA1560170@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-06-27 at 10:49 +0200, Greg Kroah-Hartman wrote:
> On Sat, Jun 27, 2020 at 10:28:31AM +0200, Hans Verkuil wrote:
> > On 27/06/2020 07:07, Greg Kroah-Hartman wrote:
> > > A: http://en.wikipedia.org/wiki/Top_post
> > > Q: Were do I find info about this thing called top-posting?
> > > A: Because it messes up the order in which people normally read text.
> > > Q: Why is top-posting such a bad thing?
> > > A: Top-posting.
> > > Q: What is the most annoying thing in e-mail?
> > > 
> > > A: No.
> > > Q: Should I include quotations after my reply?
> > > 
> > > http://daringfireball.net/2007/07/on_top
> > > 
> > > On Fri, Jun 26, 2020 at 11:42:49AM -0400, B K KARTHIK PES2201800185STUDENT ECE DeptPESU EC Campus wrote:
> > > > Oh, I'm sorry but wouldn't it be helpful if we had a file that lists
> > > > all drivers that are scheduled for removal?
> > > 
> > > The TODO file in the directory for the driver should have this
> > > information in it.  I don't know if all of the media drivers have this,
> > > if not, then there is no way you could have known this.
> > 
> > They have, and in addition the Kconfig entry will mention that the driver
> > is deprecated.
> > 
> > TODO of usbvision:
> > 
> > The driver is deprecated and scheduled for removal by the end
> > of 2020.
> > 
> > In order to prevent removal the following actions would have to
> > be taken:
> > 
> > - clean up the code
> > - convert to the vb2 framework
> > - fix the disconnect and free-on-last-user handling (i.e., add
> >   a release callback for struct v4l2_device and rework the code
> >   to use that correctly).
> 
> Ah, great, nevermind then!
> 
> B K, your wish is already granted, the text is present, you just needed
> to have noticed it :)
> 
> greg k-h

You should mark the entry in MAINTAINERS as obsolete
so checkpatch tells people not to send patches.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04fceaee5200..7c136018d153 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17906,7 +17906,7 @@ F:	include/uapi/linux/uvcvideo.h
 USB VISION DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
-S:	Odd Fixes
+S:	Odd Fixes / Obsolete
 W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/staging/media/usbvision/


