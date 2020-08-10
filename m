Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22413C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0227C20825
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgHJRUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:20:04 -0400
Received: from cmta16.telus.net ([209.171.16.89]:53268 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgHJRUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:20:03 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Aug 2020 13:20:02 EDT
Received: from montezuma.home ([154.5.226.127])
        by cmsmtp with SMTP
        id 5BKwkkXSG5b7l5BKykm83N; Mon, 10 Aug 2020 11:11:53 -0600
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=YPHhNiOx c=1 sm=1 tr=0
 a=f8b3WT/FcTuUJCJtQO1udw==:117 a=f8b3WT/FcTuUJCJtQO1udw==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=COSDN44dAAMA:10
 a=bG9gDjmhPuXUG-eiuMMA:9 a=CjuIK1q_8ugA:10
Date:   Mon, 10 Aug 2020 10:11:50 -0700 (PDT)
From:   Zwane Mwaikambo <zwanem@gmail.com>
To:     tcamuso@redhat.com
cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, dkwon@redhat.com
Subject: Re: [PATCH] drm: assure aux_dev is nonzero before using it
Message-ID: <alpine.DEB.2.21.2008101004110.27032@montezuma.home>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfLXLrG61H3IewWgL14PAlsxl0Y3rkOFoECheosPcZUUND7JWnN8rPKnbtQKPrkOXCu1aPejTgwQ+X7R90J+w6fD9IdyUBsRp14+2pRNZx/kNWYggJTdX
 0xLa2pgKJOC23iLr8VbAmtdlcXp7oCl9+cr4ZWuCC5EQUMDbBt8V0rmF1448y9Q6MKlDSh7QNFCoPzAZAgrUHqhl+APfxkN1I6+iktMRThGoW689FGKKUnsC
 hvLSjM46j66W8Oh7ifli8AEYTmDmtKv58sakJbGgDH3mCHUKafvaPsOcpDWN9xrS
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,
	I know this thread eventually dropped off due to not identifying 
the underlying issue. It's still occuring on 5.8 and in my case it 
happened because the udev device nodes for the DP aux devices were not 
cleaned up whereas the kernel had no association with them. I can 
reproduce the bug just by creating a device node for a non-existent minor 
device and calling open().

To me it still makes sense to just check aux_dev because the chardev has 
no way to check before calling.

(gdb) list *drm_dp_aux_dev_get_by_minor+0x29
0x17b39 is in drm_dp_aux_dev_get_by_minor (drivers/gpu/drm/drm_dp_aux_dev.c:65).
60      static struct drm_dp_aux_dev *drm_dp_aux_dev_get_by_minor(unsigned index)
61      {
62              struct drm_dp_aux_dev *aux_dev = NULL;
63
64              mutex_lock(&aux_idr_mutex);
65              aux_dev = idr_find(&aux_idr, index);
66              if (!kref_get_unless_zero(&aux_dev->refcount))
67                      aux_dev = NULL;
68              mutex_unlock(&aux_idr_mutex);
69
(gdb) p/x &((struct drm_dp_aux_dev *)(0x0))->refcount
$8 = 0x18

static int auxdev_open(struct inode *inode, struct file *file)
{
    unsigned int minor = iminor(inode);
    struct drm_dp_aux_dev *aux_dev;

    aux_dev = drm_dp_aux_dev_get_by_minor(minor);
    if (!aux_dev)
        return -ENODEV;

    file->private_data = aux_dev;
    return 0;
}


