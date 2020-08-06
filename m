Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D587C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1457206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+raWMdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgHFRnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:43:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30762 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730003AbgHFRlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596735668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hAx0JcxmeQQ153nHejpTHF0Pmr69cGDwLEAWTLdX41E=;
        b=S+raWMdIKPcRLLtcIEMQRkL+Gv8G3e2D6F04Yjf37H3CYjzzm/BnWY0as1ReTnFAejhBtL
        7UBZ3CxZwCTxyyMR/+76+nD1Fs2FjsZjfaP2cxofOxJe7mh5K0vEpfSWMLQr5hrpZ7visC
        /FgK1I/xYBX9kt/oYEP9i3uz0C6TPb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-4ibZkQ2jMtS0U3rACgJxhA-1; Thu, 06 Aug 2020 13:40:54 -0400
X-MC-Unique: 4ibZkQ2jMtS0U3rACgJxhA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D3F91009441;
        Thu,  6 Aug 2020 17:40:53 +0000 (UTC)
Received: from horse.redhat.com (ovpn-112-23.rdu2.redhat.com [10.10.112.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23C5E65C83;
        Thu,  6 Aug 2020 17:40:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9184A220441; Thu,  6 Aug 2020 13:40:49 -0400 (EDT)
Date:   Thu, 6 Aug 2020 13:40:49 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: fs/fuse/virtio_fs.c:1009:6: warning: Variable 'err' is
 reassigned a value before the old one has been used.
Message-ID: <20200806174049.GE367847@redhat.com>
References: <202008061415.sHRFePnn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008061415.sHRFePnn%lkp@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 02:04:18PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   fffe3ae0ee84e25d2befe2ae59bc32aa2b6bc77b
> commit: a62a8ef9d97da23762a588592c8b8eb50a8deb6a virtio-fs: add virtiofs filesystem
> date:   11 months ago
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> cppcheck warnings: (new ones prefixed by >>)
> 
> >> fs/fuse/virtio_fs.c:1009:6: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
>     err = -ENOMEM;
>         ^
>    fs/fuse/virtio_fs.c:1003:6: note: Variable 'err' is reassigned a value before the old one has been used.
>     err = -EINVAL;
>         ^
>    fs/fuse/virtio_fs.c:1009:6: note: Variable 'err' is reassigned a value before the old one has been used.
>     err = -ENOMEM;
>         ^
>    fs/fuse/virtio_fs.c:1020:6: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
>     err = fuse_fill_super_common(sb, &ctx);
>         ^
>    fs/fuse/virtio_fs.c:1009:6: note: Variable 'err' is reassigned a value before the old one has been used.
>     err = -ENOMEM;

Not sure why this is a warning. Previous value is not going to be used
anymore. If it were to be used, we would have taken "goto err" path,
and return err. Very fact that we did not take that path means we
are not going to use previous value of err, hence it is ok to override
it. 

IOW, this seems like a false warning from compiler. This pattern has been
used in fuse and overlayfs code all over the place.

Thanks
Vivek

>         ^
>    fs/fuse/virtio_fs.c:1020:6: note: Variable 'err' is reassigned a value before the old one has been used.
>     err = fuse_fill_super_common(sb, &ctx);
>         ^
> 
> vim +/err +1009 fs/fuse/virtio_fs.c
> 
>    979	
>    980	static int virtio_fs_fill_super(struct super_block *sb)
>    981	{
>    982		struct fuse_conn *fc = get_fuse_conn_super(sb);
>    983		struct virtio_fs *fs = fc->iq.priv;
>    984		unsigned int i;
>    985		int err;
>    986		struct fuse_fs_context ctx = {
>    987			.rootmode = S_IFDIR,
>    988			.default_permissions = 1,
>    989			.allow_other = 1,
>    990			.max_read = UINT_MAX,
>    991			.blksize = 512,
>    992			.destroy = true,
>    993			.no_control = true,
>    994			.no_force_umount = true,
>    995		};
>    996	
>    997		mutex_lock(&virtio_fs_mutex);
>    998	
>    999		/* After holding mutex, make sure virtiofs device is still there.
>   1000		 * Though we are holding a reference to it, drive ->remove might
>   1001		 * still have cleaned up virtual queues. In that case bail out.
>   1002		 */
>   1003		err = -EINVAL;
>   1004		if (list_empty(&fs->list)) {
>   1005			pr_info("virtio-fs: tag <%s> not found\n", fs->tag);
>   1006			goto err;
>   1007		}
>   1008	
> > 1009		err = -ENOMEM;
>   1010		/* Allocate fuse_dev for hiprio and notification queues */
>   1011		for (i = 0; i < VQ_REQUEST; i++) {
>   1012			struct virtio_fs_vq *fsvq = &fs->vqs[i];
>   1013	
>   1014			fsvq->fud = fuse_dev_alloc();
>   1015			if (!fsvq->fud)
>   1016				goto err_free_fuse_devs;
>   1017		}
>   1018	
>   1019		ctx.fudptr = (void **)&fs->vqs[VQ_REQUEST].fud;
>   1020		err = fuse_fill_super_common(sb, &ctx);
>   1021		if (err < 0)
>   1022			goto err_free_fuse_devs;
>   1023	
>   1024		fc = fs->vqs[VQ_REQUEST].fud->fc;
>   1025	
>   1026		for (i = 0; i < fs->nvqs; i++) {
>   1027			struct virtio_fs_vq *fsvq = &fs->vqs[i];
>   1028	
>   1029			if (i == VQ_REQUEST)
>   1030				continue; /* already initialized */
>   1031			fuse_dev_install(fsvq->fud, fc);
>   1032		}
>   1033	
>   1034		/* Previous unmount will stop all queues. Start these again */
>   1035		virtio_fs_start_all_queues(fs);
>   1036		fuse_send_init(fc);
>   1037		mutex_unlock(&virtio_fs_mutex);
>   1038		return 0;
>   1039	
>   1040	err_free_fuse_devs:
>   1041		virtio_fs_free_devs(fs);
>   1042	err:
>   1043		mutex_unlock(&virtio_fs_mutex);
>   1044		return err;
>   1045	}
>   1046	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

