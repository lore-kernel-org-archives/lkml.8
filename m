Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8C4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D35D208A7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbgEVPkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 11:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgEVPkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:40:05 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC17C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 08:40:05 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jc9m5-00DZUn-KE; Fri, 22 May 2020 15:39:53 +0000
Date:   Fri, 22 May 2020 16:39:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ben Hutchings <bwh@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: Re: drivers/ide/ide-ioctls.c:15:24: sparse: sparse: incorrect type
 in initializer (different address spaces)
Message-ID: <20200522153953.GR23230@ZenIV.linux.org.uk>
References: <202005222050.mkKQBFyc%lkp@intel.com>
 <CAK8P3a3AvVuf6ADizEg6twExf_QwJarJ-1E7BUWUb7=Sw1e0Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3AvVuf6ADizEg6twExf_QwJarJ-1E7BUWUb7=Sw1e0Dw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 03:40:50PM +0200, Arnd Bergmann wrote:
> On Fri, May 22, 2020 at 2:24 PM kbuild test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   051143e1602d90ea71887d92363edd539d411de5
> > commit: 1df23c6fe5b0654ece219985a0c32e40b100bd9a compat_ioctl: move HDIO ioctl handling into drivers/ide
> > date:   5 months ago
> > config: xtensa-randconfig-s002-20200522 (attached as .config)
> > compiler: xtensa-linux-gcc (GCC) 9.3.0
> > reproduce:
> >         # apt-get install sparse
> >         # sparse version: v0.6.1-193-gb8fad4bc-dirty
> >         git checkout 1df23c6fe5b0654ece219985a0c32e40b100bd9a
> >         # save the attached .config to linux build tree
> >         make W=1 C=1 ARCH=xtensa CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> >
> > sparse warnings: (new ones prefixed by >>)
> >
> >    ./arch/xtensa/include/generated/uapi/asm/unistd_32.h:391:41: sparse: sparse: no newline at end of file
> > >> drivers/ide/ide-ioctls.c:15:24: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected signed int *__pu_addr @@    got signed int [noderef] [usertypsigned int *__pu_addr @@
> > >> drivers/ide/ide-ioctls.c:15:24: sparse:    expected signed int *__pu_addr
> > >> drivers/ide/ide-ioctls.c:15:24: sparse:    got signed int [noderef] [usertype] <asn:1> *
> > >> drivers/ide/ide-ioctls.c:15:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void [noderef] <asn:1> *to @@    got f] <asn:1> *to @@
> >    drivers/ide/ide-ioctls.c:15:24: sparse:    expected void [noderef] <asn:1> *to
> > >> drivers/ide/ide-ioctls.c:15:24: sparse:    got signed int *__pu_addr
> 
> 
> I think this is a bug in the xtensa asm/uaccess.h, but I don't know why it
> only showed up now.

xtensa has no __user annotations in there.  At all.  So until somebody sits
down and does those, there will be such noise, reported every time somebody
changes a line with get_user() or put_user() anywhere in the tree.

As far as I'm concerned, __user-related reports on xtensa are to be ignored
for now.
