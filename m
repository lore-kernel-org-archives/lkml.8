Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF96C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72322205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agxrwNfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgFCGfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 02:35:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33125 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbgFCGfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591166102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B2vN8Dw/qz4vI/EzjgMHSYDUd1pSEefI0GYoGuUtsDQ=;
        b=agxrwNfj7/mPjkklCLuU28p92rZTzh+MxqERBaaBdRtV/RvprXCHqhppX4xwyv8B04oD4C
        57yyUAOB4NYSQT6+zm6exZicvgQxcUMgjhWvQvTijes558h16ZKeLJGlZLviD64ofS4120
        ts9VTBDNwqxnB9qoxzEvuKLLNlIDV+Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-qeGQY9VROmelKSiVXXzenw-1; Wed, 03 Jun 2020 02:35:00 -0400
X-MC-Unique: qeGQY9VROmelKSiVXXzenw-1
Received: by mail-wr1-f70.google.com with SMTP id l18so681026wrm.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 23:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=B2vN8Dw/qz4vI/EzjgMHSYDUd1pSEefI0GYoGuUtsDQ=;
        b=Dczdije6xOjMmuWAzPhlZ6md8XX0BqfzuytS4ndP00yjPxmN+ubpFyzLuYPDZ23Y8j
         ddt2AaSRrIO89O78ezaHb0SCSRy0xlUnGzOUA0/tAociXE8KwFx2iwm9NNDrI116PMpe
         qyVOw+D9nHNTM75auxJhbNv61xl/2S65KgexvgQSGnYwAP4+CeCB9gpTPj+FbrjLxw2n
         UV8wObo/T2ZFrD9AF7kZ94PTggkLZQQdlMYBolG2AEck/Pnh8vlS8m28JO8DEeW8xwza
         XCE49PcZFlqKRLR/4PjizPbwnuQ7XaZ5W50tMnOwSSQF0MbzFSZseO9gGUsmy8zbjYbp
         qB9g==
X-Gm-Message-State: AOAM5330TJ+n6I2GPoBih6eBxfvWQljMFaNBSZCxQRcIZ6RPCj/hWYHG
        4bjBIXhZopglGltbv0TEFDJ1/x3CuD6NgNY+s0aJBE1dpWUazS+KPZBNq8BAgyArtFWtNBoBKhq
        RpQgF/e2sGR3qeEyEZcRePOeD
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr2298374wrw.225.1591166098334;
        Tue, 02 Jun 2020 23:34:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI/UQ1e2IEFfNgnSn57m0Bfm86YlMkYesjj021UABMgsR+tPWUtN6rPFfKqgucl2vmU6mZTg==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr2298360wrw.225.1591166098131;
        Tue, 02 Jun 2020 23:34:58 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id z16sm1734703wrm.70.2020.06.02.23.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 23:34:57 -0700 (PDT)
Date:   Wed, 3 Jun 2020 02:34:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com
Subject: Re: [PATCH 4/6] vhost_vdpa: support doorbell mapping via mmap
Message-ID: <20200603023429-mutt-send-email-mst@kernel.org>
References: <20200529080303.15449-5-jasowang@redhat.com>
 <202006020308.kLXTHt4n%lkp@intel.com>
 <20200602005007-mutt-send-email-mst@kernel.org>
 <bd7dde11-b726-ee08-4e80-71fb784fa549@redhat.com>
 <20200602093025-mutt-send-email-mst@kernel.org>
 <5db6b413-cb6c-a566-2f2d-ad580d8e165b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5db6b413-cb6c-a566-2f2d-ad580d8e165b@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 12:18:44PM +0800, Jason Wang wrote:
> 
> On 2020/6/2 下午9:31, Michael S. Tsirkin wrote:
> > On Tue, Jun 02, 2020 at 02:49:38PM +0800, Jason Wang wrote:
> > > On 2020/6/2 下午12:56, Michael S. Tsirkin wrote:
> > > > On Tue, Jun 02, 2020 at 03:22:49AM +0800, kbuild test robot wrote:
> > > > > Hi Jason,
> > > > > 
> > > > > I love your patch! Yet something to improve:
> > > > > 
> > > > > [auto build test ERROR on vhost/linux-next]
> > > > > [also build test ERROR on linus/master v5.7 next-20200529]
> > > > > [if your patch is applied to the wrong git tree, please drop us a note to help
> > > > > improve the system. BTW, we also suggest to use '--base' option to specify the
> > > > > base tree in git format-patch, please seehttps://stackoverflow.com/a/37406982]
> > > > > 
> > > > > url:https://github.com/0day-ci/linux/commits/Jason-Wang/vDPA-doorbell-mapping/20200531-070834
> > > > > base:https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git  linux-next
> > > > > config: m68k-randconfig-r011-20200601 (attached as .config)
> > > > > compiler: m68k-linux-gcc (GCC) 9.3.0
> > > > > reproduce (this is a W=1 build):
> > > > >           wgethttps://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross  -O ~/bin/make.cross
> > > > >           chmod +x ~/bin/make.cross
> > > > >           # save the attached .config to linux build tree
> > > > >           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k
> > > > > 
> > > > > If you fix the issue, kindly add following tag as appropriate
> > > > > Reported-by: kbuild test robot<lkp@intel.com>
> > > > > 
> > > > > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > > > > 
> > > > > drivers/vhost/vdpa.c: In function 'vhost_vdpa_fault':
> > > > > > > drivers/vhost/vdpa.c:754:22: error: implicit declaration of function 'pgprot_noncached' [-Werror=implicit-function-declaration]
> > > > > 754 |  vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > > > > |                      ^~~~~~~~~~~~~~~~
> > > > > > > drivers/vhost/vdpa.c:754:22: error: incompatible types when assigning to type 'pgprot_t' {aka 'struct <anonymous>'} from type 'int'
> > > > > cc1: some warnings being treated as errors
> > > > > 
> > > > > vim +/pgprot_noncached +754 drivers/vhost/vdpa.c
> > > > > 
> > > > >      742	
> > > > >      743	static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
> > > > >      744	{
> > > > >      745		struct vhost_vdpa *v = vmf->vma->vm_file->private_data;
> > > > >      746		struct vdpa_device *vdpa = v->vdpa;
> > > > >      747		const struct vdpa_config_ops *ops = vdpa->config;
> > > > >      748		struct vdpa_notification_area notify;
> > > > >      749		struct vm_area_struct *vma = vmf->vma;
> > > > >      750		u16 index = vma->vm_pgoff;
> > > > >      751	
> > > > >      752		notify = ops->get_vq_notification(vdpa, index);
> > > > >      753	
> > > > >    > 754		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > > > >      755		if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
> > > > >      756				    notify.addr >> PAGE_SHIFT, PAGE_SIZE,
> > > > >      757				    vma->vm_page_prot))
> > > > >      758			return VM_FAULT_SIGBUS;
> > > > >      759	
> > > > >      760		return VM_FAULT_NOPAGE;
> > > > >      761	}
> > > > >      762	
> > > > Yes well, all this remapping clearly has no chance to work
> > > > on systems without CONFIG_MMU.
> > > 
> > > It looks to me mmap can work according to Documentation/nommu-mmap.txt. But
> > > I'm not sure it's worth to bother.
> > > 
> > > Thanks
> > 
> > Well
> > 
> > int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
> >                  unsigned long pfn, unsigned long size, pgprot_t prot)
> > {
> >          if (addr != (pfn << PAGE_SHIFT))
> >                  return -EINVAL;
> > 
> >          vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
> >          return 0;
> > }
> > EXPORT_SYMBOL(remap_pfn_range);
> > 
> > 
> > So things aren't going to work if you have a fixed PFN
> > which is the case of the hardware device.
> 
> 
> Looking at the implementation of some drivers e.g mtd_char. If I read the
> code correctly, we can do this by providing get_unmapped_area method and use
> physical address directly.
> 
> But start form CONFIG_MMU should be fine.  Do you prefer making vhost_vdpa
> depends on CONFIG_MMU or just fail mmap when CONFIG_MMU is not configured?
> 
> Thanks

I'd just not specify the mmap callback at all.

> 
> > 
> > 
> > > > 
> > > > 

