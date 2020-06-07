Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212B8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 13:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE312067B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 13:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkUgyYM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgFGN7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 09:59:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20645 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726528AbgFGN7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 09:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591538345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49hQQxJz0ezLYVnWHq736mWDL47lS1M2M2KOpADI1+8=;
        b=dkUgyYM0Ml5IogJnzksC4sYhsrLJMRlftBkj1D4tdXz+N4OoIT/pDxVCDQy/LoC17AC4Mr
        ylIFkfmocHu+AQu5cbnh+IfETelrPgzAKLGfyR7eF1GamKfBbl2+Kn+nbLhd29c6p3imuf
        meDekaebhhPAPfVbuY8Z8A/QDzskBwA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-WC5tpMxnMPSFRD7OIrem1w-1; Sun, 07 Jun 2020 09:59:04 -0400
X-MC-Unique: WC5tpMxnMPSFRD7OIrem1w-1
Received: by mail-wm1-f71.google.com with SMTP id g84so4277677wmf.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 06:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=49hQQxJz0ezLYVnWHq736mWDL47lS1M2M2KOpADI1+8=;
        b=Dgn0fk75I8s0+woHTAnnjBkVp04l7HaXZSSLHYFfD48X7h8izXCQ/mRq+M31WcfEh4
         eKAMOL7z8aBF2uffmKEuMgp0kpN1zYKQY/HqHZUF/LXbotKfsKJefjmQBC6D2AK622ns
         92COgcX/wGAFY4vmifbVkNZzOAe6iK9RPZhCYl4/t1/OwL3tW2NW4260hqO3jrizPoO0
         7RS/pb9cm9xluFE7FR0fh4ophAievo3VXcggxdSaKk+sc6ZuS//BvyBnh+oKwMXTesmu
         7Rcp6VfIkOPhNMFq1HEiJsPcV0DqADiafR26U7Lp+7nB/CGjOXc9lbAjM5yQ4wwSHVNd
         saZQ==
X-Gm-Message-State: AOAM533sm/qwAnzl015+n1FeGrjdSJO1QcdWeb3nELV5cJTEtqV3/5m/
        ihbSPSLPfpvdVhXZob+Ya/15wni4tSclAfflcofwug9wiNYnXDoPcTm1Z0LffM1AzB9oA2oFokD
        oZteoi/qsoi1A0Ajx2gXl9s7K
X-Received: by 2002:a1c:7e52:: with SMTP id z79mr12393937wmc.104.1591538343139;
        Sun, 07 Jun 2020 06:59:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPhCdg8nsVcYSKRsQtxYqjMu3Z2lGeq+GOYXsFNupGugKNhvKfrGs/gdkikgAZslAUpcg9tw==
X-Received: by 2002:a1c:7e52:: with SMTP id z79mr12393918wmc.104.1591538342920;
        Sun, 07 Jun 2020 06:59:02 -0700 (PDT)
Received: from redhat.com (bzq-82-81-31-23.red.bezeqint.net. [82.81.31.23])
        by smtp.gmail.com with ESMTPSA id y37sm23372137wrd.55.2020.06.07.06.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 06:59:02 -0700 (PDT)
Date:   Sun, 7 Jun 2020 09:59:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH RFC 01/13] vhost: option to fetch descriptors through an
 independent struct
Message-ID: <20200607095810-mutt-send-email-mst@kernel.org>
References: <20200602130543.578420-1-mst@redhat.com>
 <20200602130543.578420-2-mst@redhat.com>
 <e35e5df9-7e36-227e-7981-232a62b06607@redhat.com>
 <20200603045825-mutt-send-email-mst@kernel.org>
 <48e6d644-c4aa-2754-9d06-22133987b3be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48e6d644-c4aa-2754-9d06-22133987b3be@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 08:04:45PM +0800, Jason Wang wrote:
> 
> On 2020/6/3 下午5:48, Michael S. Tsirkin wrote:
> > On Wed, Jun 03, 2020 at 03:13:56PM +0800, Jason Wang wrote:
> > > On 2020/6/2 下午9:05, Michael S. Tsirkin wrote:
> 
> 
> [...]
> 
> 
> > > > +
> > > > +static int fetch_indirect_descs(struct vhost_virtqueue *vq,
> > > > +				struct vhost_desc *indirect,
> > > > +				u16 head)
> > > > +{
> > > > +	struct vring_desc desc;
> > > > +	unsigned int i = 0, count, found = 0;
> > > > +	u32 len = indirect->len;
> > > > +	struct iov_iter from;
> > > > +	int ret;
> > > > +
> > > > +	/* Sanity check */
> > > > +	if (unlikely(len % sizeof desc)) {
> > > > +		vq_err(vq, "Invalid length in indirect descriptor: "
> > > > +		       "len 0x%llx not multiple of 0x%zx\n",
> > > > +		       (unsigned long long)len,
> > > > +		       sizeof desc);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	ret = translate_desc(vq, indirect->addr, len, vq->indirect,
> > > > +			     UIO_MAXIOV, VHOST_ACCESS_RO);
> > > > +	if (unlikely(ret < 0)) {
> > > > +		if (ret != -EAGAIN)
> > > > +			vq_err(vq, "Translation failure %d in indirect.\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +	iov_iter_init(&from, READ, vq->indirect, ret, len);
> > > > +
> > > > +	/* We will use the result as an address to read from, so most
> > > > +	 * architectures only need a compiler barrier here. */
> > > > +	read_barrier_depends();
> > > > +
> > > > +	count = len / sizeof desc;
> > > > +	/* Buffers are chained via a 16 bit next field, so
> > > > +	 * we can have at most 2^16 of these. */
> > > > +	if (unlikely(count > USHRT_MAX + 1)) {
> > > > +		vq_err(vq, "Indirect buffer length too big: %d\n",
> > > > +		       indirect->len);
> > > > +		return -E2BIG;
> > > > +	}
> > > > +	if (unlikely(vq->ndescs + count > vq->max_descs)) {
> > > > +		vq_err(vq, "Too many indirect + direct descs: %d + %d\n",
> > > > +		       vq->ndescs, indirect->len);
> > > > +		return -E2BIG;
> > > > +	}
> > > > +
> > > > +	do {
> > > > +		if (unlikely(++found > count)) {
> > > > +			vq_err(vq, "Loop detected: last one at %u "
> > > > +			       "indirect size %u\n",
> > > > +			       i, count);
> > > > +			return -EINVAL;
> > > > +		}
> > > > +		if (unlikely(!copy_from_iter_full(&desc, sizeof(desc), &from))) {
> > > > +			vq_err(vq, "Failed indirect descriptor: idx %d, %zx\n",
> > > > +			       i, (size_t)indirect->addr + i * sizeof desc);
> > > > +			return -EINVAL;
> > > > +		}
> > > > +		if (unlikely(desc.flags & cpu_to_vhost16(vq, VRING_DESC_F_INDIRECT))) {
> > > > +			vq_err(vq, "Nested indirect descriptor: idx %d, %zx\n",
> > > > +			       i, (size_t)indirect->addr + i * sizeof desc);
> > > > +			return -EINVAL;
> > > > +		}
> > > > +
> > > > +		push_split_desc(vq, &desc, head);
> > > 
> > > The error is ignored.
> > See above:
> > 
> >       	if (unlikely(vq->ndescs + count > vq->max_descs))
> > 
> > So it can't fail here, we never fetch unless there's space.
> > 
> > I guess we can add a WARN_ON here.
> 
> 
> Yes.
> 
> 
> > 
> > > > +	} while ((i = next_desc(vq, &desc)) != -1);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int fetch_descs(struct vhost_virtqueue *vq)
> > > > +{
> > > > +	unsigned int i, head, found = 0;
> > > > +	struct vhost_desc *last;
> > > > +	struct vring_desc desc;
> > > > +	__virtio16 avail_idx;
> > > > +	__virtio16 ring_head;
> > > > +	u16 last_avail_idx;
> > > > +	int ret;
> > > > +
> > > > +	/* Check it isn't doing very strange things with descriptor numbers. */
> > > > +	last_avail_idx = vq->last_avail_idx;
> > > > +
> > > > +	if (vq->avail_idx == vq->last_avail_idx) {
> > > > +		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
> > > > +			vq_err(vq, "Failed to access avail idx at %p\n",
> > > > +				&vq->avail->idx);
> > > > +			return -EFAULT;
> > > > +		}
> > > > +		vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
> > > > +
> > > > +		if (unlikely((u16)(vq->avail_idx - last_avail_idx) > vq->num)) {
> > > > +			vq_err(vq, "Guest moved used index from %u to %u",
> > > > +				last_avail_idx, vq->avail_idx);
> > > > +			return -EFAULT;
> > > > +		}
> > > > +
> > > > +		/* If there's nothing new since last we looked, return
> > > > +		 * invalid.
> > > > +		 */
> > > > +		if (vq->avail_idx == last_avail_idx)
> > > > +			return vq->num;
> > > > +
> > > > +		/* Only get avail ring entries after they have been
> > > > +		 * exposed by guest.
> > > > +		 */
> > > > +		smp_rmb();
> > > > +	}
> > > > +
> > > > +	/* Grab the next descriptor number they're advertising */
> > > > +	if (unlikely(vhost_get_avail_head(vq, &ring_head, last_avail_idx))) {
> > > > +		vq_err(vq, "Failed to read head: idx %d address %p\n",
> > > > +		       last_avail_idx,
> > > > +		       &vq->avail->ring[last_avail_idx % vq->num]);
> > > > +		return -EFAULT;
> > > > +	}
> > > > +
> > > > +	head = vhost16_to_cpu(vq, ring_head);
> > > > +
> > > > +	/* If their number is silly, that's an error. */
> > > > +	if (unlikely(head >= vq->num)) {
> > > > +		vq_err(vq, "Guest says index %u > %u is available",
> > > > +		       head, vq->num);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	i = head;
> > > > +	do {
> > > > +		if (unlikely(i >= vq->num)) {
> > > > +			vq_err(vq, "Desc index is %u > %u, head = %u",
> > > > +			       i, vq->num, head);
> > > > +			return -EINVAL;
> > > > +		}
> > > > +		if (unlikely(++found > vq->num)) {
> > > > +			vq_err(vq, "Loop detected: last one at %u "
> > > > +			       "vq size %u head %u\n",
> > > > +			       i, vq->num, head);
> > > > +			return -EINVAL;
> > > > +		}
> > > > +		ret = vhost_get_desc(vq, &desc, i);
> > > > +		if (unlikely(ret)) {
> > > > +			vq_err(vq, "Failed to get descriptor: idx %d addr %p\n",
> > > > +			       i, vq->desc + i);
> > > > +			return -EFAULT;
> > > > +		}
> > > > +		ret = push_split_desc(vq, &desc, head);
> > > > +		if (unlikely(ret)) {
> > > > +			vq_err(vq, "Failed to save descriptor: idx %d\n", i);
> > > > +			return -EINVAL;
> > > > +		}
> > > > +	} while ((i = next_desc(vq, &desc)) != -1);
> > > > +
> > > > +	last = peek_split_desc(vq);
> > > > +	if (unlikely(last->flags & VRING_DESC_F_INDIRECT)) {
> > > > +		pop_split_desc(vq);
> > > > +		ret = fetch_indirect_descs(vq, last, head);
> > > 
> > > Note that this means we don't supported chained indirect descriptors which
> > > complies the spec but we support this in vhost_get_vq_desc().
> > Well the spec says:
> > 	A driver MUST NOT set both VIRTQ_DESC_F_INDIRECT and VIRTQ_DESC_F_NEXT in flags.
> > 
> > Did I miss anything?
> > 
> 
> No, but I meant current vhost_get_vq_desc() supports chained indirect
> descriptor. Not sure if there's an application that depends on this
> silently.
> 
> Thanks
> 

I don't think we need to worry about that unless this actually
surfaces.

-- 
MST

