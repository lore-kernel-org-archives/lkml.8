Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBA3C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10B72073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbgDVKcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:32:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:34672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731124AbgDVKcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:32:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9187CABCC;
        Wed, 22 Apr 2020 10:32:32 +0000 (UTC)
Message-ID: <1587551540.26476.12.camel@suse.com>
Subject: Re: general protection fault in go7007_usb_probe
From:   Oliver Neukum <oneukum@suse.com>
To:     syzbot <syzbot+cabfa4b5b05ff6be4ef0@syzkaller.appspotmail.com>,
        andreyknvl@google.com, hverkuil-cisco@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Cc:     tiwai@suse.com
Date:   Wed, 22 Apr 2020 12:32:20 +0200
In-Reply-To: <000000000000a0f56c05a3d59b69@google.com>
References: <000000000000a0f56c05a3d59b69@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 21.04.2020, 16:45 -0700 schrieb syzbot:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    e9010320 usb: cdns3: gadget: make a bunch of functions sta..
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=12da0b58100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bd14feb44652cfaf
> dashboard link: https://syzkaller.appspot.com/bug?extid=cabfa4b5b05ff6be4ef0
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1146eb17e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159d136fe00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+cabfa4b5b05ff6be4ef0@syzkaller.appspotmail.com

Hi,

this looks to be technically caused by

commit a3ea410cac41b19a5490aad7fe6d9a9a772e646e
Author: Takashi Iwai <tiwai@suse.de>
Date:   Thu Feb 6 16:45:27 2020 +0100

    media: go7007: Fix URB type for interrupt handling

It introduces this check:

+       ep = usb->usbdev->ep_in[4];
+       if (usb_endpoint_type(&ep->desc) == USB_ENDPOINT_XFER_BULK)

However, there is no guarantee ep_in[4] exists, if a malicious device
were involved. But, I do not want to just add a check for NULL. That
would just paper over the bug and the driver would fail at a later
stage.

How many endpoints do these devices need to have to operate?

	Regards
		Oliver

