Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0984EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E060722BED
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbGQs4Yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgHDMX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:23:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22024 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726202AbgHDMWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596543754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cfhrqb6pBBQzVJy0vxTB4jGpyV61Q7QFxMfhI7EBCL4=;
        b=IbGQs4YhkjDnXQxk1QUKGa65mGFOdX4pIiXMdpRgP96hQFxHVDC0yF2Yy3byoYPGgofhP1
        sj76o54Xz7UM7tUs05bXbF+Ua4X+RmNgfSvLtWlX2LWaRFnFdGSzl6cqxBglioItWbDox0
        pag+5O3F0HXoHvVzlFuzUq+4kR/eo7w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-LdrI7GNRMZKj1AQbDXc42A-1; Tue, 04 Aug 2020 08:22:14 -0400
X-MC-Unique: LdrI7GNRMZKj1AQbDXc42A-1
Received: by mail-qt1-f198.google.com with SMTP id q19so19562925qtp.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 05:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cfhrqb6pBBQzVJy0vxTB4jGpyV61Q7QFxMfhI7EBCL4=;
        b=tPc/YB0qTpvsx5KsbgN00zwSNN8dl3lzzvO9QhvwFdUJiBH8Dx2aR6PJ1SZHE0RUow
         ZM/GjvFssy1iddqntjDyhxyORN4ztVONJK5KvMBVyPt7HffiaOBSsXyt6nVCf0qF95I6
         xNxQ6UD3TDLPJCX3CMWG7GVp+Doyst7Te04gaKG+xs5BhUiakve2cA6Xl0rfrgOrfvNQ
         FrLUcf4zeYMPFf1lrZMNwECD1JnmlgXKGrHxP8BUYpL1UdkU5g4wDLnAhjO5OgKGWRKL
         oLY0DNd6wV2CYu5AsynqaAyqgSI07elpHZDMFWfp++WsjJaJZrcqlG3eGNgpHXl5otmh
         A53Q==
X-Gm-Message-State: AOAM531br4r615P5hLksOmn9uNrDTrU2Nz/74shMYX5qu2olqwcQJjIj
        q5/+KAY0rjeO2mwthIZa9rjmdJQ9LfPYDKzOoCGD+n4D67kYEsSaZuDMY+lFMrC7d0ftjhA1qGi
        GJbELxc+P7MzfdWJByO0WO28+
X-Received: by 2002:ac8:4c9a:: with SMTP id j26mr20753979qtv.373.1596543734014;
        Tue, 04 Aug 2020 05:22:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1VSzNyJdnAOf5o8b1wWZrFayNX+EyfmsmRxHvnhM/cQRo+DnGnJjhUuY1MZ5p7Z/aKPVM7Q==
X-Received: by 2002:ac8:4c9a:: with SMTP id j26mr20753950qtv.373.1596543733713;
        Tue, 04 Aug 2020 05:22:13 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id p123sm20548192qkd.26.2020.08.04.05.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 05:22:12 -0700 (PDT)
Date:   Tue, 4 Aug 2020 08:22:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <eli@mellanox.com>
Cc:     kernel test robot <lkp@intel.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Shahaf Shuler <shahafs@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH V3 vhost next 10/10] vdpa/mlx5: Add VDPA driver for
 supported mlx5 devices
Message-ID: <20200804081501-mutt-send-email-mst@kernel.org>
References: <20200728060539.4163-11-eli@mellanox.com>
 <202007282108.S8MkTrap%lkp@intel.com>
 <20200804115419.GA6326@nps-server-21.mtl.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804115419.GA6326@nps-server-21.mtl.labs.mlnx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 02:54:19PM +0300, Eli Cohen wrote:
> On Tue, Jul 28, 2020 at 04:43:00PM +0300, kernel test robot wrote:
> > Hi Eli,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on next-20200727]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Eli-Cohen/VDPA-support-for-Mellanox-ConnectX-devices/20200728-140938
> > base:    e9a523ff8f76de0768857f02ea76437d3b39d151
> > config: mips-allmodconfig (attached as .config)
> > compiler: mips-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > 
> > ERROR: modpost: "fw_arg3" [drivers/mtd/parsers/bcm63xxpart.ko] undefined!
> > >> ERROR: modpost: "__udivdi3" [drivers/vdpa/mlx5/mlx5_vdpa.ko] undefined!
> 
> I don't know where this complaint comes from. When I follow the steps
> above to reproduce, I find myself failing on code unrelated to my patch
> set so I can get my code compiled:
> 
> drivers/rpmsg/virtio_rpmsg_bus.c:88:8: error: redefinition of 'struct rpmsg_hdr'
>    88 | struct rpmsg_hdr {
>       |        ^~~~~~~~~
> In file included from drivers/rpmsg/virtio_rpmsg_bus.c:28:
> ./include/linux/virtio_rpmsg.h:21:8: note: originally defined here
>    21 | struct rpmsg_hdr {
>       |        ^~~~~~~~~
> drivers/rpmsg/virtio_rpmsg_bus.c:109:8: error: redefinition of 'struct
> rpmsg_ns_msg'
>   109 | struct rpmsg_ns_msg {
>       |        ^~~~~~~~~~~~
> In file included from drivers/rpmsg/virtio_rpmsg_bus.c:28:
> ./include/linux/virtio_rpmsg.h:42:8: note: originally defined here
>    42 | struct rpmsg_ns_msg {
>       |        ^~~~~~~~~~~~
> 

Hmm more conflicts. My bad :(


> I think the reason for the complaint comes from usage of DIV_ROUND_UP()
> which somehow does not work on mips.
> 
> I can try to avoid using this macro and implement something of my own,
> unless someone has a better idea what's going on here.
> 
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

