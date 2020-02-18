Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7218C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7121F20801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G0ZnAaGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgBRNyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:54:02 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45958 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgBRNyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:54:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id a2so19460230qko.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 05:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wco1ACmBJKT01bm8zBO0MP2nnQlGcVNyX36uIR1E9uo=;
        b=G0ZnAaGIytyfHiex43w/GJT+NEhMLwNxhYp1/W9HDnNFPo3glIRu93O66AaSeintW4
         ewAToI5pRBz8O0l7tILOYNKjgySJWe17ht2quS2ahOjbZzAcz+xWKd0a5zthc019NWFQ
         R1W77HwaNo2iUrrHabUyK2dJHQqwkMP3HcjM/gvl7CgOnOP2bq7gx3OJGNClRVsDU1GO
         EpLTqCubJgP4nYoHsCBh1Njcn6q1PFTHEiM9EHe9usCQvVsgXVgmRkKNwwLnoHhUcsio
         7ZzHIqeumqbjEfKuANmJfatwdGn/Gam/JXB0m0k1C5xdDcz21BPJmu8PlWtabKOypOds
         oRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wco1ACmBJKT01bm8zBO0MP2nnQlGcVNyX36uIR1E9uo=;
        b=dL+Nzd7G+3O1jhzCd13ubs6mnnOVsSWHi6lOL+iBI5A/BM7uYweeuv6gYcwG7Eb6cz
         3azN0GmkvX46hQQe0Ecx3oRlFUW0UMdBLY+cKirRdXGKQoRJShimGwwR0rzjAZpF8yxL
         hKymoLL1LeXjErtoUZbqWkyHGTuisFPwVDvkGT/gnVWZz520bultkUbWqWfvEsvR1bmv
         pechLEPl/F0Kyh6sLjNZaXQziWQFpdlPe6F1E6B3xQl1S7jJnPmi37Bu6mxP7LVGP0+O
         SqDvzB9gPU0t7bfRMOWQ+5d48zDv+WxmvnQY7BVvZsWCMUMg4FVSsdIq/5Fh1ZrSD8/E
         fQ/Q==
X-Gm-Message-State: APjAAAUU4+0825hwDBPCftpAjOHHvWjsge6xttURNmrZ6WH4z5VX+UFY
        z0dj17eBjHNT5i8C9yHXG8WtZg==
X-Google-Smtp-Source: APXvYqwkMwWoPoOuRyU9S1o0YCBdIBRy95mN2TqVYVQmY44HIF+ueV8rib/5b0aqZ5/M9OsEvpjRCQ==
X-Received: by 2002:a37:b8c2:: with SMTP id i185mr18411300qkf.156.1582034040843;
        Tue, 18 Feb 2020 05:54:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w21sm1956489qth.17.2020.02.18.05.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 05:54:00 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j43K3-0002fU-Nx; Tue, 18 Feb 2020 09:53:59 -0400
Date:   Tue, 18 Feb 2020 09:53:59 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     mst@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, shahafs@mellanox.com,
        rob.miller@broadcom.com, haotian.wang@sifive.com,
        eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com,
        rdunlap@infradead.org, hch@infradead.org, jiri@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com,
        maxime.coquelin@redhat.com, lingshan.zhu@intel.com,
        dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Message-ID: <20200218135359.GA9608@ziepe.ca>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131033651.103534-1-tiwei.bie@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 11:36:51AM +0800, Tiwei Bie wrote:

> +static int vhost_vdpa_alloc_minor(struct vhost_vdpa *v)
> +{
> +	return idr_alloc(&vhost_vdpa.idr, v, 0, MINORMASK + 1,
> +			 GFP_KERNEL);
> +}

Please don't use idr in new code, use xarray directly

> +static int vhost_vdpa_probe(struct device *dev)
> +{
> +	struct vdpa_device *vdpa = dev_to_vdpa(dev);
> +	const struct vdpa_config_ops *ops = vdpa->config;
> +	struct vhost_vdpa *v;
> +	struct device *d;
> +	int minor, nvqs;
> +	int r;
> +
> +	/* Currently, we only accept the network devices. */
> +	if (ops->get_device_id(vdpa) != VIRTIO_ID_NET) {
> +		r = -ENOTSUPP;
> +		goto err;
> +	}
> +
> +	v = kzalloc(sizeof(*v), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> +	if (!v) {
> +		r = -ENOMEM;
> +		goto err;
> +	}
> +
> +	nvqs = VHOST_VDPA_VQ_MAX;
> +
> +	v->vqs = kmalloc_array(nvqs, sizeof(struct vhost_virtqueue),
> +			       GFP_KERNEL);
> +	if (!v->vqs) {
> +		r = -ENOMEM;
> +		goto err_alloc_vqs;
> +	}
> +
> +	mutex_init(&v->mutex);
> +	atomic_set(&v->opened, 0);
> +
> +	v->vdpa = vdpa;
> +	v->nvqs = nvqs;
> +	v->virtio_id = ops->get_device_id(vdpa);
> +
> +	mutex_lock(&vhost_vdpa.mutex);
> +
> +	minor = vhost_vdpa_alloc_minor(v);
> +	if (minor < 0) {
> +		r = minor;
> +		goto err_alloc_minor;
> +	}
> +
> +	d = device_create(vhost_vdpa.class, NULL,
> +			  MKDEV(MAJOR(vhost_vdpa.devt), minor),
> +			  v, "%d", vdpa->index);
> +	if (IS_ERR(d)) {
> +		r = PTR_ERR(d);
> +		goto err_device_create;
> +	}
> +

I can't understand what this messing around with major/minor numbers
does. Without allocating a cdev via cdev_add/etc there is only a
single char dev in existence here. This and the stuff in
vhost_vdpa_open() looks non-functional.

> +static void vhost_vdpa_remove(struct device *dev)
> +{
> +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> +	struct vhost_vdpa *v = dev_get_drvdata(dev);
> +	int opened;
> +
> +	add_wait_queue(&vhost_vdpa.release_q, &wait);
> +
> +	do {
> +		opened = atomic_cmpxchg(&v->opened, 0, 1);
> +		if (!opened)
> +			break;
> +		wait_woken(&wait, TASK_UNINTERRUPTIBLE, HZ * 10);
> +	} while (1);
> +
> +	remove_wait_queue(&vhost_vdpa.release_q, &wait);

*barf* use the normal refcount pattern please

read side:

  refcount_inc_not_zero(uses)
  //stuff
  if (refcount_dec_and_test(uses))
     complete(completer)

destroy side:
  if (refcount_dec_and_test(uses))
     complete(completer)
  wait_for_completion(completer)
  // refcount now permanently == 0

Use a completion in driver code

> +	mutex_lock(&vhost_vdpa.mutex);
> +	device_destroy(vhost_vdpa.class,
> +		       MKDEV(MAJOR(vhost_vdpa.devt), v->minor));
> +	vhost_vdpa_free_minor(v->minor);
> +	mutex_unlock(&vhost_vdpa.mutex);
> +	kfree(v->vqs);
> +	kfree(v);

This use after-fress vs vhost_vdpa_open prior to it setting the open
bit. Maybe use xarray, rcu and kfree_rcu ..

> +static int __init vhost_vdpa_init(void)
> +{
> +	int r;
> +
> +	idr_init(&vhost_vdpa.idr);
> +	mutex_init(&vhost_vdpa.mutex);
> +	init_waitqueue_head(&vhost_vdpa.release_q);
> +
> +	/* /dev/vhost-vdpa/$vdpa_device_index */
> +	vhost_vdpa.class = class_create(THIS_MODULE, "vhost-vdpa");
> +	if (IS_ERR(vhost_vdpa.class)) {
> +		r = PTR_ERR(vhost_vdpa.class);
> +		goto err_class;
> +	}
> +
> +	vhost_vdpa.class->devnode = vhost_vdpa_devnode;
> +
> +	r = alloc_chrdev_region(&vhost_vdpa.devt, 0, MINORMASK + 1,
> +				"vhost-vdpa");
> +	if (r)
> +		goto err_alloc_chrdev;
> +
> +	cdev_init(&vhost_vdpa.cdev, &vhost_vdpa_fops);
> +	r = cdev_add(&vhost_vdpa.cdev, vhost_vdpa.devt, MINORMASK + 1);
> +	if (r)
> +		goto err_cdev_add;

It is very strange, is the intention to create a single global char
dev?

If so, why is there this:

+static int vhost_vdpa_open(struct inode *inode, struct file *filep)
+{
+	struct vhost_vdpa *v;
+	struct vhost_dev *dev;
+	struct vhost_virtqueue **vqs;
+	int nvqs, i, r, opened;
+
+	v = vhost_vdpa_get_from_minor(iminor(inode));

?

If the idea is to create a per-vdpa char dev then this stuff belongs
in vhost_vdpa_probe(), the cdev should be part of the vhost_vdpa, and
the above should be container_of not an idr lookup.

Jason
