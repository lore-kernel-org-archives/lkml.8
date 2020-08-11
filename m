Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93D4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1E2206DC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgHKWQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 18:16:49 -0400
Received: from cmta19.telus.net ([209.171.16.92]:35830 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgHKWQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 18:16:48 -0400
Received: from montezuma.home ([154.5.226.127])
        by cmsmtp with SMTP
        id 5cZXkg9CWpULu5cZYkCNXh; Tue, 11 Aug 2020 16:16:47 -0600
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=T9TysMCQ c=1 sm=1 tr=0
 a=f8b3WT/FcTuUJCJtQO1udw==:117 a=f8b3WT/FcTuUJCJtQO1udw==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=COSDN44dAAMA:10 a=e5mUnYsNAAAA:8
 a=7LT71PhNQJGCqy_fO74A:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Date:   Tue, 11 Aug 2020 15:16:43 -0700 (PDT)
From:   Zwane Mwaikambo <zwanem@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
cc:     tcamuso@redhat.com, dkwon@redhat.com,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: assure aux_dev is nonzero before using it
In-Reply-To: <20200811085830.GZ2352366@phenom.ffwll.local>
Message-ID: <alpine.DEB.2.21.2008111514210.35094@montezuma.home>
References: <alpine.DEB.2.21.2008101004110.27032@montezuma.home> <20200811085830.GZ2352366@phenom.ffwll.local>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfM7P2Qveb9f03hcrnn/yURgCyHfwV6v+s0PERnrykmqUT9nIDFaYZca86P7MhymuDfMJ8Dft8ITHy7q8RytlH7vlQSIZSejlytm13CeLcq/mMelBiApu
 y1TTYNtKCJ3Q/v2pncXORY17OTSUGFaloe8dt7NV8Wq1vj9jLDnpoq4wyyV/kSdE+CczOlN4IhiiFlo2Dh8yJcWP93bErXIkEArHtGERwrKsXGQl5d2lK0XW
 x50GKKcuU6FBvyR2xKvixQevQ4Vu39luQkhZOHO4NYGtFQj7qrjElt44L3H4n8Yq9StF7F1YIVq9M5YDX7S95Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020, Daniel Vetter wrote:

> On Mon, Aug 10, 2020 at 10:11:50AM -0700, Zwane Mwaikambo wrote:
> > Hi Folks,
> > 	I know this thread eventually dropped off due to not identifying 
> > the underlying issue. It's still occuring on 5.8 and in my case it 
> > happened because the udev device nodes for the DP aux devices were not 
> > cleaned up whereas the kernel had no association with them. I can 
> > reproduce the bug just by creating a device node for a non-existent minor 
> > device and calling open().
> 
> Hm I don't have that thread anymore, but generally these bugs are solved
> by not registering the device before it's ready for use. We do have
> drm_connector->late_register for that stuff. Just a guess since I'm not
> seeing full details here.

In this particular case, the physical device disappeared before the nodes 
were cleaned up. It involves putting a computer to sleep with a monitor 
plugged in and then waking it up with the monitor unplugged.


> > 
> > To me it still makes sense to just check aux_dev because the chardev has 
> > no way to check before calling.
> > 
> > (gdb) list *drm_dp_aux_dev_get_by_minor+0x29
> > 0x17b39 is in drm_dp_aux_dev_get_by_minor (drivers/gpu/drm/drm_dp_aux_dev.c:65).
> > 60      static struct drm_dp_aux_dev *drm_dp_aux_dev_get_by_minor(unsigned index)
> > 61      {
> > 62              struct drm_dp_aux_dev *aux_dev = NULL;
> > 63
> > 64              mutex_lock(&aux_idr_mutex);
> > 65              aux_dev = idr_find(&aux_idr, index);
> > 66              if (!kref_get_unless_zero(&aux_dev->refcount))
> > 67                      aux_dev = NULL;
> > 68              mutex_unlock(&aux_idr_mutex);
> > 69
> > (gdb) p/x &((struct drm_dp_aux_dev *)(0x0))->refcount
> > $8 = 0x18
> > 
> > static int auxdev_open(struct inode *inode, struct file *file)
> > {
> >     unsigned int minor = iminor(inode);
> >     struct drm_dp_aux_dev *aux_dev;
> > 
> >     aux_dev = drm_dp_aux_dev_get_by_minor(minor);
> >     if (!aux_dev)
> >         return -ENODEV;
> > 
> >     file->private_data = aux_dev;
> >     return 0;
> > }
> > 
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
