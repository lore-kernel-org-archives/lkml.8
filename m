Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84366C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4D2206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpMeAIjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgDGJum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:50:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32238 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725883AbgDGJum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 05:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586253040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0sVBPEE0xzucWIbbsT162YE9B5hG9SIrPw6ALlMaDJs=;
        b=YpMeAIjWHHfk0cA0K6FzC3QW5OxLn8UMVnOUC7kviT1wDCOvIbePTaNOz2e+r7U0JWuOdB
        2qumAjnYpOjN8agtsCEdWmyiUzVnuvBK6TZmVF+nqcZGmczOIR8QPpeRQtYS2GryBMC8uc
        bbooeIO2hzegv5JurGMdTk1jK9x3NS4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-HQ_XrFGaOUChFFutM9_OAw-1; Tue, 07 Apr 2020 05:50:37 -0400
X-MC-Unique: HQ_XrFGaOUChFFutM9_OAw-1
Received: by mail-wm1-f69.google.com with SMTP id f81so493880wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 02:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0sVBPEE0xzucWIbbsT162YE9B5hG9SIrPw6ALlMaDJs=;
        b=GOyLzzuSg00RkGB6fH/b3igRsp0sVRRnl9Kjgm8YX0y/j/+8yMhkFSgV2fIGpuXret
         g2hx6QMtOeQfFJWV+8nDAbkulaom2pILoBSG5NpRxQ/F93M0qjKb75DKQS6Eyo3TQXz4
         tdlCBHXH9GvIbo5FKVOLiP1oOqdBf0l1o8l0wMBeDJRiVetYs2l6Yw7HVNFWpZcOJDRo
         RBtgCYU5yo1n2lTfjhk2O+CAP2Llkm9zIO+k5/E7aWqdbH9UgIdNh/muoCd0ZCDwR7yE
         Vdj5ZytqkJtoUGkFQbxiECz7MiwById8ZB99RCDFLcE7m1l98H7ms4Ksy2IK3ZQ7VRHe
         nb9g==
X-Gm-Message-State: AGi0PubAdOB9vPoAlWL4pwbgBl70AeeSH+WtouD14boOAJ59T1GmrYdY
        yyZ+8Z9Y8yXr7kTby+57Ugu1BswnduuoFqGBp0WF9bp/TIn8/9xVn5lTn2dIEzH38JzsobJivRK
        D867kGjz+m/HDxcvovUZ12BJH
X-Received: by 2002:a1c:6a14:: with SMTP id f20mr1431095wmc.125.1586253035890;
        Tue, 07 Apr 2020 02:50:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypJfdSbEhEAnnavsksjAg2GryZUBfh45QLjmuphCxXIBX+5BhJi3IGriZs1rxxuFBrWFBIg72Q==
X-Received: by 2002:a1c:6a14:: with SMTP id f20mr1431058wmc.125.1586253035663;
        Tue, 07 Apr 2020 02:50:35 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id y15sm6107385wro.68.2020.04.07.02.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 02:50:35 -0700 (PDT)
Date:   Tue, 7 Apr 2020 05:50:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexander.h.duyck@linux.intel.com, david@redhat.com,
        eperezma@redhat.com, jasowang@redhat.com, lingshan.zhu@intel.com,
        mhocko@kernel.org, namit@vmware.com, rdunlap@infradead.org,
        rientjes@google.com, tiwei.bie@intel.com, tysand@google.com,
        wei.w.wang@intel.com, xiao.w.wang@intel.com,
        yuri.benditovich@daynix.com
Subject: Re: [GIT PULL] vhost: fixes, vdpa
Message-ID: <20200407054752-mutt-send-email-mst@kernel.org>
References: <20200406171124-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406171124-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 05:11:28PM -0400, Michael S. Tsirkin wrote:
> Now that many more architectures build vhost, a couple of these (um, and
> arm with deprecated oabi) have reported build failures with randconfig,
> however fixes for that need a bit more discussion/testing and will be
> merged separately.
> 
> Not a regression - these previously simply didn't have vhost at all.
> Also, there's some DMA API code in the vdpa simulator is hacky - if no
> solution surfaces soon we can always disable it before release:
> it's not a big deal either way as it's just test code.
> 
> The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:
> 
>   Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to c9b9f5f8c0f3cdb893cb86c168cdaa3aa5ed7278:
> 
>   vdpa: move to drivers/vdpa (2020-04-02 10:41:40 -0400)
> 
> ----------------------------------------------------------------
> virtio: fixes, vdpa
> 
> Some bug fixes.
> Balloon reverted to use the OOM handler again.
> The new vdpa subsystem with two first drivers.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

OK this was conflicting with akpm tree, turns out Stephen
was reverting the OOM handler change since akpm tree has its own
variant.

So I pushed the revert in my tree to make it easier for you.
I'll send PULL v2 just to make things clear.


> ----------------------------------------------------------------
> David Hildenbrand (1):
>       virtio-balloon: Switch back to OOM handler for VIRTIO_BALLOON_F_DEFLATE_ON_OOM
> 
> Jason Wang (7):
>       vhost: refine vhost and vringh kconfig
>       vhost: allow per device message handler
>       vhost: factor out IOTLB
>       vringh: IOTLB support
>       vDPA: introduce vDPA bus
>       virtio: introduce a vDPA based transport
>       vdpasim: vDPA device simulator
> 
> Michael S. Tsirkin (2):
>       tools/virtio: option to build an out of tree module
>       vdpa: move to drivers/vdpa
> 
> Tiwei Bie (1):
>       vhost: introduce vDPA-based backend
> 
> Yuri Benditovich (3):
>       virtio-net: Introduce extended RSC feature
>       virtio-net: Introduce RSS receive steering feature
>       virtio-net: Introduce hash report feature
> 
> Zhu Lingshan (1):
>       virtio: Intel IFC VF driver for VDPA
> 
>  MAINTAINERS                      |   3 +
>  arch/arm/kvm/Kconfig             |   2 -
>  arch/arm64/kvm/Kconfig           |   2 -
>  arch/mips/kvm/Kconfig            |   2 -
>  arch/powerpc/kvm/Kconfig         |   2 -
>  arch/s390/kvm/Kconfig            |   4 -
>  arch/x86/kvm/Kconfig             |   4 -
>  drivers/Kconfig                  |   4 +
>  drivers/Makefile                 |   1 +
>  drivers/misc/mic/Kconfig         |   4 -
>  drivers/net/caif/Kconfig         |   4 -
>  drivers/vdpa/Kconfig             |  37 ++
>  drivers/vdpa/Makefile            |   4 +
>  drivers/vdpa/ifcvf/Makefile      |   3 +
>  drivers/vdpa/ifcvf/ifcvf_base.c  | 389 +++++++++++++++++
>  drivers/vdpa/ifcvf/ifcvf_base.h  | 118 ++++++
>  drivers/vdpa/ifcvf/ifcvf_main.c  | 435 +++++++++++++++++++
>  drivers/vdpa/vdpa.c              | 180 ++++++++
>  drivers/vdpa/vdpa_sim/Makefile   |   2 +
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 629 ++++++++++++++++++++++++++++
>  drivers/vhost/Kconfig            |  45 +-
>  drivers/vhost/Kconfig.vringh     |   6 -
>  drivers/vhost/Makefile           |   6 +
>  drivers/vhost/iotlb.c            | 177 ++++++++
>  drivers/vhost/net.c              |   5 +-
>  drivers/vhost/scsi.c             |   2 +-
>  drivers/vhost/vdpa.c             | 883 +++++++++++++++++++++++++++++++++++++++
>  drivers/vhost/vhost.c            | 233 ++++-------
>  drivers/vhost/vhost.h            |  45 +-
>  drivers/vhost/vringh.c           | 421 ++++++++++++++++++-
>  drivers/vhost/vsock.c            |   2 +-
>  drivers/virtio/Kconfig           |  13 +
>  drivers/virtio/Makefile          |   1 +
>  drivers/virtio/virtio_balloon.c  | 107 ++---
>  drivers/virtio/virtio_vdpa.c     | 396 ++++++++++++++++++
>  include/linux/vdpa.h             | 253 +++++++++++
>  include/linux/vhost_iotlb.h      |  47 +++
>  include/linux/vringh.h           |  36 ++
>  include/uapi/linux/vhost.h       |  24 ++
>  include/uapi/linux/vhost_types.h |   8 +
>  include/uapi/linux/virtio_net.h  | 102 ++++-
>  tools/virtio/Makefile            |  27 +-
>  42 files changed, 4354 insertions(+), 314 deletions(-)
>  create mode 100644 drivers/vdpa/Kconfig
>  create mode 100644 drivers/vdpa/Makefile
>  create mode 100644 drivers/vdpa/ifcvf/Makefile
>  create mode 100644 drivers/vdpa/ifcvf/ifcvf_base.c
>  create mode 100644 drivers/vdpa/ifcvf/ifcvf_base.h
>  create mode 100644 drivers/vdpa/ifcvf/ifcvf_main.c
>  create mode 100644 drivers/vdpa/vdpa.c
>  create mode 100644 drivers/vdpa/vdpa_sim/Makefile
>  create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim.c
>  delete mode 100644 drivers/vhost/Kconfig.vringh
>  create mode 100644 drivers/vhost/iotlb.c
>  create mode 100644 drivers/vhost/vdpa.c
>  create mode 100644 drivers/virtio/virtio_vdpa.c
>  create mode 100644 include/linux/vdpa.h
>  create mode 100644 include/linux/vhost_iotlb.h

