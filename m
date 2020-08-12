Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6A5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43076207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nq9Vrgw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHLPpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:45:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32751 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726226AbgHLPpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597247101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4SS0jWX/8AdP73VJgwkCVotT/hkNBUzg6SOi5kPmUG4=;
        b=Nq9Vrgw2fy4bd8ZTnXJp5I5joVHKf2CseVMKOqq8KrIAnDRElotyhdlcrC3egYGfQ+vciG
        YpSJc+ecX/cI4hP/4AhluTVMmYC644aImIAfRp84T/C0kVi+UjkNfGj7c0e3aVrSW/sxCt
        VuLBEFT2S8OJckKHtT+frhzUuTubUiA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-kN_MMJAyPtaFmu5mqLxxAQ-1; Wed, 12 Aug 2020 11:44:59 -0400
X-MC-Unique: kN_MMJAyPtaFmu5mqLxxAQ-1
Received: by mail-qv1-f69.google.com with SMTP id h6so1715887qvz.14
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 08:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=4SS0jWX/8AdP73VJgwkCVotT/hkNBUzg6SOi5kPmUG4=;
        b=IfdAx+1oXQr1sldcEZnnYAquaqKBCrVNwP7Fc7rKq19HbJZCcoTIpfuXii0zRLxqQX
         RJuk1JUl+BtDquE3NzO0n4DJl3ji0Qd7XERTdHeRt6FqFagAj0tvfNdt7n+wfmAqTFH+
         pMNKSAPwkLP59wcHVtb4ZcVemhF/VlUNuZvB3TGGSczHqke8sBm+KFRY+RXw3jJFhFq2
         Jira5dUCzC7lWeTLy/at4fHh5q++kVEeRvsz2/2qyuSSKtOIDo6v4txgp+m0UGiMLpzD
         zjmOUCdSwA7F6o9TUP1HHz6UhCNCaO8glWu6fhOwdt1mdd0iIlkxC/p3oF3PRTzZ1lm7
         5iHQ==
X-Gm-Message-State: AOAM531BF6erBcRvwVU5OMpM6WPKH5VVg7iZytSZSzsISMr/C7WSZayF
        o380fiWoAY47lLDsTVA1cfssiMTij8c9eAJsFWGtganBx5jG02SvKn/yAoa+nl6Z3Wv7SS5F4Tt
        nf2l0Yz2SG+RMhmtPMOkjdu36
X-Received: by 2002:aed:2ca5:: with SMTP id g34mr147705qtd.337.1597247098552;
        Wed, 12 Aug 2020 08:44:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxihC1nazXhwK6q3KqmG+xQT8vcRSFSs9qlG1xH4pBMLdf/U1hCZwc0/JtKxjg0ahn7Xo10Ug==
X-Received: by 2002:aed:2ca5:: with SMTP id g34mr147682qtd.337.1597247098320;
        Wed, 12 Aug 2020 08:44:58 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id s4sm2809991qtn.34.2020.08.12.08.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 08:44:57 -0700 (PDT)
Message-ID: <a1141faf8c6a0a924d87132fb4a297cd6d47e09d.camel@redhat.com>
Subject: Re: [PATCH] drm: assure aux_dev is nonzero before using it
From:   Lyude Paul <lyude@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Zwane Mwaikambo <zwanem@gmail.com>
Cc:     tcamuso@redhat.com, dkwon@redhat.com,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Date:   Wed, 12 Aug 2020 11:44:56 -0400
In-Reply-To: <CAKMK7uHxikojLQNbsnnfDfGZ3tFP9CRUTzvr+DsZghzQupaBGg@mail.gmail.com>
References: <alpine.DEB.2.21.2008101004110.27032@montezuma.home>
         <20200811085830.GZ2352366@phenom.ffwll.local>
         <alpine.DEB.2.21.2008111514210.35094@montezuma.home>
         <CAKMK7uHxikojLQNbsnnfDfGZ3tFP9CRUTzvr+DsZghzQupaBGg@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-12 at 16:10 +0200, Daniel Vetter wrote:
> On Wed, Aug 12, 2020 at 12:16 AM Zwane Mwaikambo <zwanem@gmail.com> wrote:
> > On Tue, 11 Aug 2020, Daniel Vetter wrote:
> > 
> > > On Mon, Aug 10, 2020 at 10:11:50AM -0700, Zwane Mwaikambo wrote:
> > > > Hi Folks,
> > > >     I know this thread eventually dropped off due to not identifying
> > > > the underlying issue. It's still occuring on 5.8 and in my case it
> > > > happened because the udev device nodes for the DP aux devices were not
> > > > cleaned up whereas the kernel had no association with them. I can
> > > > reproduce the bug just by creating a device node for a non-existent
> > > > minor
> > > > device and calling open().
> > > 
> > > Hm I don't have that thread anymore, but generally these bugs are solved
> > > by not registering the device before it's ready for use. We do have
> > > drm_connector->late_register for that stuff. Just a guess since I'm not
> > > seeing full details here.
> > 
> > In this particular case, the physical device disappeared before the nodes
> > were cleaned up. It involves putting a computer to sleep with a monitor
> > plugged in and then waking it up with the monitor unplugged.
> 
> We also have early_unregister for the reverse, but yes this sounds
> more tricky ... Adding Lyude who's been working on way too much
> lifetime fun around dp recently.
> -Daniel
> 
Hi-I think just checking whether the auxdev is NULL or not is a reasonable
fix, although I am curious as to how exactly the aux dev's parent is getting
destroyed before it's child, which I would have thought would be the only way
you could hit this?

> > 
> > > > To me it still makes sense to just check aux_dev because the chardev
> > > > has
> > > > no way to check before calling.
> > > > 
> > > > (gdb) list *drm_dp_aux_dev_get_by_minor+0x29
> > > > 0x17b39 is in drm_dp_aux_dev_get_by_minor
> > > > (drivers/gpu/drm/drm_dp_aux_dev.c:65).
> > > > 60      static struct drm_dp_aux_dev
> > > > *drm_dp_aux_dev_get_by_minor(unsigned index)
> > > > 61      {
> > > > 62              struct drm_dp_aux_dev *aux_dev = NULL;
> > > > 63
> > > > 64              mutex_lock(&aux_idr_mutex);
> > > > 65              aux_dev = idr_find(&aux_idr, index);
> > > > 66              if (!kref_get_unless_zero(&aux_dev->refcount))
> > > > 67                      aux_dev = NULL;
> > > > 68              mutex_unlock(&aux_idr_mutex);
> > > > 69
> > > > (gdb) p/x &((struct drm_dp_aux_dev *)(0x0))->refcount
> > > > $8 = 0x18
> > > > 
> > > > static int auxdev_open(struct inode *inode, struct file *file)
> > > > {
> > > >     unsigned int minor = iminor(inode);
> > > >     struct drm_dp_aux_dev *aux_dev;
> > > > 
> > > >     aux_dev = drm_dp_aux_dev_get_by_minor(minor);
> > > >     if (!aux_dev)
> > > >         return -ENODEV;
> > > > 
> > > >     file->private_data = aux_dev;
> > > >     return 0;
> > > > }
> > > > 
> > > > 
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

