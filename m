Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F33DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F68206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHLUVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:21:21 -0400
Received: from cmta20.telus.net ([209.171.16.93]:58207 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgHLUVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 16:21:20 -0400
Received: from montezuma.home ([154.5.226.127])
        by cmsmtp with SMTP
        id 5xFLkg3D9ljNx5xFNkm9WQ; Wed, 12 Aug 2020 14:21:18 -0600
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=Z8aS40ZA c=1 sm=1 tr=0
 a=f8b3WT/FcTuUJCJtQO1udw==:117 a=f8b3WT/FcTuUJCJtQO1udw==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=COSDN44dAAMA:10 a=pGLkceISAAAA:8
 a=e5mUnYsNAAAA:8 a=XlkWa5Bfyw0YRDVwgmMA:9 a=CjuIK1q_8ugA:10
 a=Vxmtnl_E_bksehYqCbjh:22
Date:   Wed, 12 Aug 2020 13:21:15 -0700 (PDT)
From:   Zwane Mwaikambo <zwanem@gmail.com>
To:     Lyude Paul <lyude@redhat.com>
cc:     Daniel Vetter <daniel@ffwll.ch>, tcamuso@redhat.com,
        dkwon@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm: assure aux_dev is nonzero before using it
In-Reply-To: <a1141faf8c6a0a924d87132fb4a297cd6d47e09d.camel@redhat.com>
Message-ID: <alpine.DEB.2.21.2008121314020.39850@montezuma.home>
References: <alpine.DEB.2.21.2008101004110.27032@montezuma.home> <20200811085830.GZ2352366@phenom.ffwll.local> <alpine.DEB.2.21.2008111514210.35094@montezuma.home> <CAKMK7uHxikojLQNbsnnfDfGZ3tFP9CRUTzvr+DsZghzQupaBGg@mail.gmail.com>
 <a1141faf8c6a0a924d87132fb4a297cd6d47e09d.camel@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfIACCZgqsl7hQ/V5ALQdJOX5hoBiAWLWNHcOudD4WTPn27pItJZX8X3z7CohxBXrrnmVbaVKJ1vkhU+4zZjJ7AKb9xusq0tvYU4/rd2IBBDl2UckdrVI
 8Fy3wRp8q91bY639t572MU5EMXzTonJlR0SP1ZBm3WkW4m9cxTOa755+52hL/qtPe8VatsObSBwi0IYiXFl5m0VkbUeK+JRa3LgnLbaTQuHiaamaLErspTaL
 /JkCF/m7hGoZQ7Nl1tzZNCrwB3nOzSHMaRd90owBpWkoBRY1EEbRf5UK/C4Ca3W1gL/9xOqK/8rIp2CYd/+E209mTSyDzQvFRISQ5GXohls=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020, Lyude Paul wrote:

> On Wed, 2020-08-12 at 16:10 +0200, Daniel Vetter wrote:
> > On Wed, Aug 12, 2020 at 12:16 AM Zwane Mwaikambo <zwanem@gmail.com> wrote:
> > > On Tue, 11 Aug 2020, Daniel Vetter wrote:
> > > 
> > > > On Mon, Aug 10, 2020 at 10:11:50AM -0700, Zwane Mwaikambo wrote:
> > > > > Hi Folks,
> > > > >     I know this thread eventually dropped off due to not identifying
> > > > > the underlying issue. It's still occuring on 5.8 and in my case it
> > > > > happened because the udev device nodes for the DP aux devices were not
> > > > > cleaned up whereas the kernel had no association with them. I can
> > > > > reproduce the bug just by creating a device node for a non-existent
> > > > > minor
> > > > > device and calling open().
> > > > 
> > > > Hm I don't have that thread anymore, but generally these bugs are solved
> > > > by not registering the device before it's ready for use. We do have
> > > > drm_connector->late_register for that stuff. Just a guess since I'm not
> > > > seeing full details here.
> > > 
> > > In this particular case, the physical device disappeared before the nodes
> > > were cleaned up. It involves putting a computer to sleep with a monitor
> > > plugged in and then waking it up with the monitor unplugged.
> > 
> > We also have early_unregister for the reverse, but yes this sounds
> > more tricky ... Adding Lyude who's been working on way too much
> > lifetime fun around dp recently.
> > -Daniel
> > 
> Hi-I think just checking whether the auxdev is NULL or not is a reasonable
> fix, although I am curious as to how exactly the aux dev's parent is getting
> destroyed before it's child, which I would have thought would be the only way
> you could hit this?

Here is what it looks like without (1) and with (2) monitor connected. In 
the case where the monitor disappears during suspend, the device nodes 
aux3,4 are still around

1) No monitor connected
ls -l /dev/drm*
crw------- 1 root root 238, 0 Aug  6 22:32 /dev/drm_dp_aux0
crw------- 1 root root 238, 1 Aug  6 22:32 /dev/drm_dp_aux1


2) Monitor connected
crw------- 1 root root 238, 0 Aug  6 22:32 /dev/drm_dp_aux0
crw------- 1 root root 238, 1 Aug  6 22:32 /dev/drm_dp_aux1
crw------- 1 root root 238, 2 Aug 11 14:51 /dev/drm_dp_aux2
crw------- 1 root root 238, 3 Aug 11 14:51 /dev/drm_dp_aux3
crw------- 1 root root 238, 4 Aug 11 14:51 /dev/drm_dp_aux4



> 
> > > 
> > > > > To me it still makes sense to just check aux_dev because the chardev
> > > > > has
> > > > > no way to check before calling.
> > > > > 
> > > > > (gdb) list *drm_dp_aux_dev_get_by_minor+0x29
> > > > > 0x17b39 is in drm_dp_aux_dev_get_by_minor
> > > > > (drivers/gpu/drm/drm_dp_aux_dev.c:65).
> > > > > 60      static struct drm_dp_aux_dev
> > > > > *drm_dp_aux_dev_get_by_minor(unsigned index)
> > > > > 61      {
> > > > > 62              struct drm_dp_aux_dev *aux_dev = NULL;
> > > > > 63
> > > > > 64              mutex_lock(&aux_idr_mutex);
> > > > > 65              aux_dev = idr_find(&aux_idr, index);
> > > > > 66              if (!kref_get_unless_zero(&aux_dev->refcount))
> > > > > 67                      aux_dev = NULL;
> > > > > 68              mutex_unlock(&aux_idr_mutex);
> > > > > 69
> > > > > (gdb) p/x &((struct drm_dp_aux_dev *)(0x0))->refcount
> > > > > $8 = 0x18
> > > > > 
> > > > > static int auxdev_open(struct inode *inode, struct file *file)
> > > > > {
> > > > >     unsigned int minor = iminor(inode);
> > > > >     struct drm_dp_aux_dev *aux_dev;
> > > > > 
> > > > >     aux_dev = drm_dp_aux_dev_get_by_minor(minor);
> > > > >     if (!aux_dev)
> > > > >         return -ENODEV;
> > > > > 
> > > > >     file->private_data = aux_dev;
> > > > >     return 0;
> > > > > }
> > > > > 
> > > > > 
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 
> > 
> 
