Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0696C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 14:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E258206F0
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 14:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l/4IdG6h";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="cIPIC0Vl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgEBOmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 10:42:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60585 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgEBOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 10:42:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B394CA3E1;
        Sat,  2 May 2020 10:42:00 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=Qr889P1uhpX3OQgFsz/gSRurnuw=; b=l/4IdG
        6hlJZR9GFni+bTCY8ELrNMy7WDrOQUhdHY4wrQWdPw2qTCvR4yv5z+Qn1m9thKq3
        MtRDCjRiWg6MyA9ZtZl09zARMUsKKURrCu0po/8ZTRDPUx1qacCnIG+yMRjtgsNP
        IgOfkvXKGjN759AKDh4L2Q9lDdHgOSwwjyDeQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 02677CA3E0;
        Sat,  2 May 2020 10:42:00 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=+xyRM65cQrk2nopkGYugk8MJo4ePfBLL3e4k5xIZ4c0=; b=cIPIC0VlSBV2RW6Yx3gbvPfoP2pYS60OUTrIzC/fMwsXk0q3nz/lDH/tNuQVksQwFkHfkju5pxuMawjznzk+tsiHj7TkwrpqoyGtqXpkJLRcG4yGeLchoDiIM7M4q12m2BD/N+H6pUA8Dv2QJAN1VZHJ/dz0APiMJJ54gOHWaPQ=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E7FD1CA3DF;
        Sat,  2 May 2020 10:41:56 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 166C72DA016E;
        Sat,  2 May 2020 10:41:55 -0400 (EDT)
Date:   Sat, 2 May 2020 10:41:54 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Jiri Slaby <jslaby@suse.com>
cc:     syzbot <syzbot+0bfda3ade1ee9288a1be@syzkaller.appspotmail.com>,
        daniel.vetter@ffwll.ch, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at arch/x86/mm/physaddr.c:LINE! (5)
In-Reply-To: <0c39d350-846a-eeda-f202-e36a53d495b2@suse.com>
Message-ID: <nycvar.YSQ.7.76.2005021040150.2671@knanqh.ubzr>
References: <000000000000479d8d05a49221b1@google.com> <0c39d350-846a-eeda-f202-e36a53d495b2@suse.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 12A52F54-8C83-11EA-B9CF-B0405B776F7B-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 May 2020, Jiri Slaby wrote:

> > Call Trace:
> >  virt_to_head_page include/linux/mm.h:833 [inline]
> >  virt_to_cache mm/slab.h:474 [inline]
> >  kfree+0x60/0x220 mm/slab.c:3749
> >  vc_do_resize+0x738/0x1ce0 drivers/tty/vt/vt.c:1233
> Of course, s/kfree/vfree/ there. NIcolas, could you fix this?

Damn...  Will do.


Nicolas
