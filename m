Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03315C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8492072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4Sphd+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgFJIv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:51:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25251 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726081AbgFJIv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591779114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nUG0zczzNMjrSudbB6csD4w9yvT1VpQKV8j8MI39LhA=;
        b=F4Sphd+os/fodu9eBGRAYuqmpM9XgrPwvJOTg2La2QrGIKIKB6oDIXv17UQwbkVkLeqDb+
        9qP0ewFxb7gFkxp9a4/aEhmhYteJWcFXSMqANiUhn1iPodyb3X8wam+GH61ogf82LipkwT
        LrnF3iahM1stYwFVkQvS8dnnP/mq/FE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470--IPGRUPDMsqsZMfPwo6zcg-1; Wed, 10 Jun 2020 04:51:53 -0400
X-MC-Unique: -IPGRUPDMsqsZMfPwo6zcg-1
Received: by mail-wm1-f69.google.com with SMTP id t145so279348wmt.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 01:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nUG0zczzNMjrSudbB6csD4w9yvT1VpQKV8j8MI39LhA=;
        b=e9lYN7bYTHHkzAIyexOKTGsquCT05ebU9i+s4um4aXeCZrOsu/L2LXVjxiPZXDix+s
         XB6NR6mmV3fpeeDPtz3RWLgcsAebWpSwPWFgquduJT3yREy8mGCaikR3Re7Qf6Jar+Yf
         eXGUt/Fb5UXOXVrMoN/qgIZ8yMccqNLJby2++YHtaKKAv0z5See6t2L9Q5uca/oe3bDv
         3RWgNn4oxDOTuvMHMIXDmx0yXNmNmt1RRpOKjHzfhEheJhQ/pOC+OO/FThbRzjHBVwFw
         g0enp/UpMJDy4ucXSfLv40Z6sywSh4tHG26CF+kdmSP70MyF0nsHWsWBTsNEgmFQP1TZ
         aNNA==
X-Gm-Message-State: AOAM530+XcXgJCts/osouYtrH1jtcThn2HEydbEHBOAuuHM7Xgs1QQqD
        Hhu6jL8CuRPuJHU6B36nIs3Q97Sfh7B4Cm+o8Ttwl67DAtGMwVxGVSLzPaegxmFUbYFs8ODaTU+
        ZVaTXBKdGJ9fwEMDuTR9atvX9
X-Received: by 2002:adf:e751:: with SMTP id c17mr2290197wrn.134.1591779111517;
        Wed, 10 Jun 2020 01:51:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOMl2whjrsYhpTFuAM6tByia9M2MX0inWy4mvJRt8s8fSGhgc9km+tLIwTkKcxXyHRd2mF/Q==
X-Received: by 2002:adf:e751:: with SMTP id c17mr2290177wrn.134.1591779111175;
        Wed, 10 Jun 2020 01:51:51 -0700 (PDT)
Received: from redhat.com ([212.92.121.57])
        by smtp.gmail.com with ESMTPSA id d5sm7163206wrb.14.2020.06.10.01.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 01:51:50 -0700 (PDT)
Date:   Wed, 10 Jun 2020 04:51:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: Re: [PATCH V3] vdpa: introduce virtio pci driver
Message-ID: <20200610044848-mutt-send-email-mst@kernel.org>
References: <20200610065217.25538-1-jasowang@redhat.com>
 <20200610025705-mutt-send-email-mst@kernel.org>
 <b965417d-387d-cd50-399d-3e0797e98f96@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b965417d-387d-cd50-399d-3e0797e98f96@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 04:25:06PM +0800, Jason Wang wrote:
> > > +
> > > +#define VP_VDPA_FEATURES \
> > > +	((1ULL << VIRTIO_F_ANY_LAYOUT)			| \
> > 
> > This is presumably for transitional devices only.  In fact looking at
> > code it seems that only net in legacy mode accepts VIRTIO_F_ANY_LAYOUT.
> > Spec violation I guess ... but what should we do? Relax the spec
> > or fix drivers?
> 
> 
> I don't get how it violates the spec.

Spec says transitional drivers must ack VIRTIO_F_ANY_LAYOUT

But grep for VIRTIO_F_ANY_LAYOUT and you will see they don't.
Only legacy virtio net does.

Maybe it should have been
transitional drivers when using the lgacy interface, but there
you are.

> 
> > 
> > 
> > > +	 (1ULL << VIRTIO_F_VERSION_1)			| \
> > > +	 (1ULL << VIRTIO_F_ORDER_PLATFORM)		| \
> > > +	 (1ULL << VIRTIO_F_IOMMU_PLATFORM))
> > > +
> > > +struct vp_vring {
> > > +	void __iomem *notify;
> > > +	char msix_name[256];
> > > +	resource_size_t notify_pa;
> > > +	struct vdpa_callback cb;
> > > +	int irq;
> > > +};
> > > +
> > > +struct vp_vdpa {
> > > +	struct vdpa_device vdpa;
> > > +	struct pci_dev *pdev;
> > > +
> > > +	struct virtio_device_id id;
> > > +
> > > +	struct vp_vring vring[VP_VDPA_MAX_QUEUE];
> > > +
> > > +	/* The IO mapping for the PCI config space */
> > > +	void __iomem * const *base;
> > > +	struct virtio_pci_common_cfg __iomem *common;
> > > +	void __iomem *device;
> > > +	/* Base of vq notifications */
> > > +	void __iomem *notify;
> > > +
> > > +	/* Multiplier for queue_notify_off. */
> > > +	u32 notify_off_multiplier;
> > > +
> > > +	int modern_bars;
> > > +	int vectors;
> > > +};
> > > +
> > > +static struct vp_vdpa *vdpa_to_vp(struct vdpa_device *vdpa)
> > > +{
> > > +	return container_of(vdpa, struct vp_vdpa, vdpa);
> > > +}
> > > +
> > > +/*
> > > + * Type-safe wrappers for io accesses.
> > > + * Use these to enforce at compile time the following spec requirement:
> > > + *
> > > + * The driver MUST access each field using the “natural” access
> > > + * method, i.e. 32-bit accesses for 32-bit fields, 16-bit accesses
> > > + * for 16-bit fields and 8-bit accesses for 8-bit fields.
> > > + */
> > > +static inline u8 vp_ioread8(u8 __iomem *addr)
> > > +{
> > > +	return ioread8(addr);
> > > +}
> > > +static inline u16 vp_ioread16(__le16 __iomem *addr)
> > > +{
> > > +	return ioread16(addr);
> > > +}
> > > +
> > > +static inline u32 vp_ioread32(__le32 __iomem *addr)
> > > +{
> > > +	return ioread32(addr);
> > > +}
> > > +
> > > +static inline void vp_iowrite8(u8 value, u8 __iomem *addr)
> > > +{
> > > +	iowrite8(value, addr);
> > > +}
> > > +
> > > +static inline void vp_iowrite16(u16 value, __le16 __iomem *addr)
> > > +{
> > > +	iowrite16(value, addr);
> > > +}
> > > +
> > > +static inline void vp_iowrite32(u32 value, __le32 __iomem *addr)
> > > +{
> > > +	iowrite32(value, addr);
> > > +}
> > > +
> > > +static void vp_iowrite64_twopart(u64 val,
> > > +				 __le32 __iomem *lo, __le32 __iomem *hi)
> > > +{
> > > +	vp_iowrite32((u32)val, lo);
> > > +	vp_iowrite32(val >> 32, hi);
> > > +}
> > > +
> > > +static int find_capability(struct pci_dev *dev, u8 cfg_type,
> > > +			   u32 ioresource_types, int *bars)
> > > +{
> > > +	int pos;
> > > +
> > > +	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
> > > +	     pos > 0;
> > > +	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> > > +		u8 type, bar;
> > > +
> > > +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> > > +							 cfg_type),
> > > +				     &type);
> > > +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> > > +							 bar),
> > > +				     &bar);
> > > +
> > > +		/* Ignore structures with reserved BAR values */
> > > +		if (bar > 0x5)
> > > +			continue;
> > > +
> > > +		if (type == cfg_type) {
> > > +			if (pci_resource_len(dev, bar) &&
> > > +			    pci_resource_flags(dev, bar) & ioresource_types) {
> > > +				*bars |= (1 << bar);
> > > +				return pos;
> > > +			}
> > > +		}
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +static void __iomem *map_capability(struct vp_vdpa *vp_vdpa, int off,
> > > +				    resource_size_t *pa)
> > > +{
> > > +	struct pci_dev *pdev = vp_vdpa->pdev;
> > > +	u32 offset;
> > > +	u8 bar;
> > > +
> > > +	pci_read_config_byte(pdev,
> > > +			     off + offsetof(struct virtio_pci_cap, bar),
> > > +			     &bar);
> > > +	pci_read_config_dword(pdev,
> > > +			      off + offsetof(struct virtio_pci_cap, offset),
> > > +			      &offset);
> > > +
> > > +	if (pa)
> > > +		*pa = pci_resource_start(pdev, bar) + offset;
> > > +
> > > +	return vp_vdpa->base[bar] + offset;
> > > +}
> > > +
> > > +static u64 vp_vdpa_get_features(struct vdpa_device *vdpa)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +	u64 features;
> > > +
> > > +	vp_iowrite32(0, &vp_vdpa->common->device_feature_select);
> > > +	features = vp_ioread32(&vp_vdpa->common->device_feature);
> > > +	vp_iowrite32(1, &vp_vdpa->common->device_feature_select);
> > > +	features |= ((u64)vp_ioread32(&vp_vdpa->common->device_feature) << 32);
> > > +	features &= VP_VDPA_FEATURES;
> > > +
> > > +	return features;
> > > +}
> > > +
> > > +static int vp_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +
> > > +	vp_iowrite32(0, &vp_vdpa->common->guest_feature_select);
> > > +	vp_iowrite32((u32)features, &vp_vdpa->common->guest_feature);
> > > +	vp_iowrite32(1, &vp_vdpa->common->guest_feature_select);
> > > +	vp_iowrite32(features >> 32, &vp_vdpa->common->guest_feature);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +
> > > +	return vp_ioread8(&vp_vdpa->common->device_status);
> > > +}
> > > +
> > > +static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
> > > +{
> > > +	struct pci_dev *pdev = vp_vdpa->pdev;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < VP_VDPA_MAX_QUEUE; i++) {
> > > +		if (vp_vdpa->vring[i].irq != -1) {
> > > +			vp_iowrite16(i, &vp_vdpa->common->queue_select);
> > > +			vp_iowrite16(VIRTIO_MSI_NO_VECTOR,
> > > +				     &vp_vdpa->common->queue_msix_vector);
> > > +			devm_free_irq(&pdev->dev, vp_vdpa->vring[i].irq,
> > > +				      &vp_vdpa->vring[i]);
> > > +			vp_vdpa->vring[i].irq = -1;
> > > +		}
> > > +	}
> > > +
> > > +	if (vp_vdpa->vectors) {
> > > +		pci_free_irq_vectors(pdev);
> > > +		vp_vdpa->vectors = 0;
> > > +	}
> > > +}
> > > +
> > > +static irqreturn_t vp_vdpa_intr_handler(int irq, void *arg)
> > > +{
> > > +	struct vp_vring *vring = arg;
> > > +
> > > +	if (vring->cb.callback)
> > > +		return vring->cb.callback(vring->cb.private);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
> > > +{
> > > +	struct pci_dev *pdev = vp_vdpa->pdev;
> > > +	int i, ret, irq;
> > > +
> > > +	ret = pci_alloc_irq_vectors(pdev, VP_VDPA_MAX_QUEUE,
> > > +				    VP_VDPA_MAX_QUEUE, PCI_IRQ_MSIX);
> > > +	if (ret != VP_VDPA_MAX_QUEUE) {
> > > +		dev_err(&pdev->dev, "vp_vdpa: fail to allocate irq vectors\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	vp_vdpa->vectors = VP_VDPA_MAX_QUEUE;
> > > +
> > > +	for (i = 0; i < VP_VDPA_MAX_QUEUE; i++) {
> > > +		snprintf(vp_vdpa->vring[i].msix_name, 256,
> > > +			"vp-vdpa[%s]-%d\n", pci_name(pdev), i);
> > > +		irq = pci_irq_vector(pdev, i);
> > > +		ret = devm_request_irq(&pdev->dev, irq,
> > > +				       vp_vdpa_intr_handler,
> > > +				       0, vp_vdpa->vring[i].msix_name,
> > > +				       &vp_vdpa->vring[i]);
> > > +		if (ret) {
> > > +			dev_err(&pdev->dev, "vp_vdpa: fail to request irq for vq %d\n",
> > > +				i);
> > > +			goto err;
> > > +		}
> > > +		vp_iowrite16(i, &vp_vdpa->common->queue_select);
> > > +		vp_iowrite16(i, &vp_vdpa->common->queue_msix_vector);
> > > +		vp_vdpa->vring[i].irq = irq;
> > > +	}
> > > +
> > > +	return 0;
> > > +err:
> > > +	vp_vdpa_free_irq(vp_vdpa);
> > > +	return ret;
> > > +}
> > > +
> > > +static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +	u8 s = vp_vdpa_get_status(vdpa);
> > > +
> > > +	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
> > > +	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > +		vp_vdpa_request_irq(vp_vdpa);
> > > +	}
> > > +
> > > +	vp_iowrite8(status, &vp_vdpa->common->device_status);
> > > +
> > > +	if (!(status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > > +	    (s & VIRTIO_CONFIG_S_DRIVER_OK))
> > > +		vp_vdpa_free_irq(vp_vdpa);
> > > +}
> > > +
> > > +static u16 vp_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +
> > > +	return vp_ioread16(&vp_vdpa->common->queue_size);
> > > +}
> > > +
> > > +static u64 vp_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 qid)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static struct vdpa_notification_area
> > > +vp_vdpa_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +	struct vdpa_notification_area notify;
> > > +
> > > +	notify.addr = vp_vdpa->vring[qid].notify_pa;
> > > +	notify.size = vp_vdpa->notify_off_multiplier;
> > > +
> > > +	return notify;
> > > +}
> > > +
> > > +static int vp_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
> > > +				u64 num)
> > > +{
> > > +	/* Note that this is not supported by virtio specification, so
> > > +	 * we return -ENOTSUPP here. This means we can't support live
> > > +	 * migration, vhost device start/stop.
> > > +	 */
> > > +
> > > +	return -ENOTSUPP;
> > > +}
> > > +
> > > +static void vp_vdpa_set_vq_cb(struct vdpa_device *vdpa, u16 qid,
> > > +			      struct vdpa_callback *cb)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +
> > > +	vp_vdpa->vring[qid].cb = *cb;
> > > +}
> > > +
> > > +static void vp_vdpa_set_vq_ready(struct vdpa_device *vdpa,
> > > +				 u16 qid, bool ready)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +
> > > +	vp_iowrite16(qid, &vp_vdpa->common->queue_select);
> > > +	vp_iowrite16(ready, &vp_vdpa->common->queue_enable);
> > > +}
> > > +
> > > +static bool vp_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 qid)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +
> > > +	vp_iowrite16(qid, &vp_vdpa->common->queue_select);
> > > +
> > > +	return vp_ioread16(&vp_vdpa->common->queue_enable);
> > > +}
> > > +
> > > +static void vp_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 qid,
> > > +			       u32 num)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +
> > > +	vp_iowrite16(num, &vp_vdpa->common->queue_size);
> > > +}
> > > +
> > > +static int vp_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 qid,
> > > +				  u64 desc_area, u64 driver_area,
> > > +				  u64 device_area)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +	struct virtio_pci_common_cfg __iomem *cfg = vp_vdpa->common;
> > > +
> > > +	vp_iowrite16(qid, &cfg->queue_select);
> > > +	vp_iowrite64_twopart(desc_area,
> > > +			     &cfg->queue_desc_lo, &cfg->queue_desc_hi);
> > > +	vp_iowrite64_twopart(driver_area,
> > > +			     &cfg->queue_avail_lo, &cfg->queue_avail_hi);
> > > +	vp_iowrite64_twopart(device_area,
> > > +			     &cfg->queue_used_lo, &cfg->queue_used_hi);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void vp_vdpa_kick_vq(struct vdpa_device *vdpa, u16 qid)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +
> > > +	vp_iowrite16(qid, vp_vdpa->vring[qid].notify);
> > > +}
> > > +
> > > +static u32 vp_vdpa_get_generation(struct vdpa_device *vdpa)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +
> > > +	return vp_ioread8(&vp_vdpa->common->config_generation);
> > > +}
> > > +
> > > +static u32 vp_vdpa_get_device_id(struct vdpa_device *vdpa)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +
> > > +	return vp_vdpa->id.device;
> > > +}
> > > +
> > > +static u32 vp_vdpa_get_vendor_id(struct vdpa_device *vdpa)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +
> > > +	return vp_vdpa->id.vendor;
> > > +}
> > > +
> > > +static u32 vp_vdpa_get_vq_align(struct vdpa_device *vdpa)
> > > +{
> > > +	return PAGE_SIZE;
> > > +}
> > > +
> > > +static void vp_vdpa_get_config(struct vdpa_device *vdpa,
> > > +			       unsigned int offset,
> > > +			       void *buf, unsigned int len)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +	u8 old, new;
> > > +	u8 *p;
> > > +	int i;
> > > +
> > > +	do {
> > > +		old = vp_ioread8(&vp_vdpa->common->config_generation);
> > > +		p = buf;
> > > +		for (i = 0; i < len; i++)
> > > +			*p++ = vp_ioread8(vp_vdpa->device + offset + i);
> > > +
> > > +		new = vp_ioread8(&vp_vdpa->common->config_generation);
> > > +	} while (old != new);
> > > +}
> > > +
> > > +static void vp_vdpa_set_config(struct vdpa_device *vdpa,
> > > +			       unsigned int offset, const void *buf,
> > > +			       unsigned int len)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +	const u8 *p = buf;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < len; i++)
> > > +		vp_iowrite8(*p++, vp_vdpa->device + offset + i);
> > > +}
> > > +
> > > +static void vp_vdpa_set_config_cb(struct vdpa_device *vdpa,
> > > +				  struct vdpa_callback *cb)
> > > +{
> > > +	/* We don't support config interrupt */
> > Breaks things like balloon or migration notifications with virtio net, doesn't it?
> 
> 
> Right, will fix.
> 
> 
> > 
> > > +}
> > > +
> > > +static const struct vdpa_config_ops vp_vdpa_ops = {
> > > +	.get_features	= vp_vdpa_get_features,
> > > +	.set_features	= vp_vdpa_set_features,
> > > +	.get_status	= vp_vdpa_get_status,
> > > +	.set_status	= vp_vdpa_set_status,
> > > +	.get_vq_num_max	= vp_vdpa_get_vq_num_max,
> > > +	.get_vq_state	= vp_vdpa_get_vq_state,
> > > +	.get_vq_notification = vp_vdpa_get_vq_notification,
> > > +	.set_vq_state	= vp_vdpa_set_vq_state,
> > > +	.set_vq_cb	= vp_vdpa_set_vq_cb,
> > > +	.set_vq_ready	= vp_vdpa_set_vq_ready,
> > > +	.get_vq_ready	= vp_vdpa_get_vq_ready,
> > > +	.set_vq_num	= vp_vdpa_set_vq_num,
> > > +	.set_vq_address	= vp_vdpa_set_vq_address,
> > > +	.kick_vq	= vp_vdpa_kick_vq,
> > > +	.get_generation	= vp_vdpa_get_generation,
> > > +	.get_device_id	= vp_vdpa_get_device_id,
> > > +	.get_vendor_id	= vp_vdpa_get_vendor_id,
> > > +	.get_vq_align	= vp_vdpa_get_vq_align,
> > > +	.get_config	= vp_vdpa_get_config,
> > > +	.set_config	= vp_vdpa_set_config,
> > > +	.set_config_cb  = vp_vdpa_set_config_cb,
> > > +};
> > > +
> > > +static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct vp_vdpa *vp_vdpa;
> > > +	int common, notify, device, ret, i;
> > > +	struct virtio_device_id virtio_id;
> > > +	resource_size_t notify_pa;
> > > +	u16 notify_off;
> > > +
> > > +	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
> > > +	if (pdev->device < 0x1000 || pdev->device > 0x107f)
> > > +		return -ENODEV;
> > > +
> > > +	if (pdev->device < 0x1040) {
> > > +		/* Transitional devices: use the PCI subsystem device id as
> > > +		 * virtio device id, same as legacy driver always did.
> > > +		 */
> > > +		virtio_id.device = pdev->subsystem_device;
> > > +	} else {
> > > +		/* Modern devices: simply use PCI device id,
> > > +		 * but start from 0x1040.
> > > +		 */
> > > +		virtio_id.device = pdev->device - 0x1040;
> > > +	}
> > > +	virtio_id.vendor = pdev->subsystem_vendor;
> > > +
> > > +	ret = pcim_enable_device(pdev);
> > > +	if (ret) {
> > > +		dev_err(dev, "vp_vdpa: Fail to enable PCI device\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> > > +				    dev, &vp_vdpa_ops);
> > > +	if (vp_vdpa == NULL) {
> > > +		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	pci_set_master(pdev);
> > > +	pci_set_drvdata(pdev, vp_vdpa);
> > > +
> > > +	vp_vdpa->pdev = pdev;
> > > +	vp_vdpa->vdpa.dma_dev = &pdev->dev;
> > > +
> > > +	common = find_capability(pdev, VIRTIO_PCI_CAP_COMMON_CFG,
> > > +				 IORESOURCE_IO | IORESOURCE_MEM,
> > > +				 &vp_vdpa->modern_bars);
> > > +	if (!common) {
> > > +		dev_err(&pdev->dev,
> > > +			"vp_vdpa: legacy device is not supported\n");
> > > +		ret = -ENODEV;
> > > +		goto err;
> > > +	}
> > > +
> > > +	notify = find_capability(pdev, VIRTIO_PCI_CAP_NOTIFY_CFG,
> > > +				 IORESOURCE_IO | IORESOURCE_MEM,
> > > +				 &vp_vdpa->modern_bars);
> > > +	if (!notify) {
> > > +		dev_err(&pdev->dev,
> > > +			"vp_vdpa: missing notification capabilities\n");
> > > +		ret = -EINVAL;
> > > +		goto err;
> > > +	}
> > > +
> > > +	device = find_capability(pdev, VIRTIO_PCI_CAP_DEVICE_CFG,
> > > +				 IORESOURCE_IO | IORESOURCE_MEM,
> > > +				 &vp_vdpa->modern_bars);
> > > +	if (!device) {
> > > +		dev_err(&pdev->dev,
> > > +			"vp_vdpa: missing device capabilities\n");
> > > +		ret = -EINVAL;
> > > +		goto err;
> > > +	}
> > > +
> > > +	ret = pcim_iomap_regions(pdev, vp_vdpa->modern_bars,
> > > +				 VP_VDPA_DRIVER_NAME);
> > > +	if (ret)
> > > +		goto err;
> > > +
> > > +	vp_vdpa->base = pcim_iomap_table(pdev);
> > > +
> > > +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > > +	if (ret)
> > > +		ret = dma_set_mask_and_coherent(&pdev->dev,
> > > +						DMA_BIT_MASK(32));
> > > +	if (ret)
> > > +		dev_warn(&pdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
> > > +
> > > +	vp_vdpa->device = map_capability(vp_vdpa, device, NULL);
> > > +	vp_vdpa->notify = map_capability(vp_vdpa, notify, &notify_pa);
> > > +	vp_vdpa->common = map_capability(vp_vdpa, common, NULL);
> > > +	vp_vdpa->id = virtio_id;
> > > +
> > > +	ret = vdpa_register_device(&vp_vdpa->vdpa);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "Failed to register to vdpa bus\n");
> > > +		goto err;
> > > +	}
> > > +
> > > +	pci_read_config_dword(pdev, notify + sizeof(struct virtio_pci_cap),
> > > +			      &vp_vdpa->notify_off_multiplier);
> > > +
> > > +	for (i = 0; i < VP_VDPA_MAX_QUEUE; i++) {
> > > +		vp_iowrite16(i, &vp_vdpa->common->queue_select);
> > > +		notify_off = vp_ioread16(&vp_vdpa->common->queue_notify_off);
> > > +		vp_vdpa->vring[i].irq = -1;
> > > +		vp_vdpa->vring[i].notify = vp_vdpa->notify +
> > > +			notify_off * vp_vdpa->notify_off_multiplier;
> > > +		vp_vdpa->vring[i].notify_pa = notify_pa +
> > > +			notify_off * vp_vdpa->notify_off_multiplier;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +err:
> > > +	put_device(&vp_vdpa->vdpa.dev);
> > > +	return ret;
> > > +}
> > > +
> > > +static void vp_vdpa_remove(struct pci_dev *pdev)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = pci_get_drvdata(pdev);
> > > +
> > > +	vdpa_unregister_device(&vp_vdpa->vdpa);
> > > +}
> > > +
> > > +static struct pci_driver vp_vdpa_driver = {
> > > +	.name		= "vp-vdpa",
> > > +	.id_table	= NULL, /* only dynamic ids */
> > > +	.probe		= vp_vdpa_probe,
> > > +	.remove		= vp_vdpa_remove,
> > > +};
> > > +
> > > +module_pci_driver(vp_vdpa_driver);
> > > +
> > > +MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
> > > +MODULE_DESCRIPTION("vp-vdpa");
> > > +MODULE_LICENSE("GPL");
> > > +MODULE_VERSION("1");
> > 
> > Isn't there something we can do to reduce the amount of code
> > duplication? virtio, ifcvf and now this share a ton of code ...
> > Let's make a library?
> 
> 
> I do think about this since IFCVF driver is posted.
> 
> It depends on what level we want to share. Do we have to have a common
> parent structure for modern pci device? If yes, it probably requires
> non-trivial refactoring on the existed modern virtio-pci driver. If we just
> want to share some helpers, it would be easy.

Share some helpers I'd say.

> I think we can do those stuffs on top.

Well with a 3rd copy in-tree I'm inclined to say no, let's refactor first.

> Thanks
> 
> 
> > 
> > > -- 
> > > 2.20.1

