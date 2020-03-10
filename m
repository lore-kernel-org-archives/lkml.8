Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48210C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC9624692
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvlpXK+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgCJLMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:12:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60332 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726315AbgCJLMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583838756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=axpVG1V/qjT3loDwbt+JJkZn/lElqcRQbdYlgx1uCXo=;
        b=PvlpXK+24/oGjZj5fUGVGK9+5ngiw+/cIcWCx3umuXuSsQmAvKuvJ+gbka2Sn0vik+kedz
        kvNxhd38cP0jAqgxUunslIYBN1c2TfQqpr2zOcd5WuCcRNmxWKNdhHsRf041PC9aVxT4yb
        1ggDMmtWD8ZWWdxvuQYFL7KksuiRyTo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-DxQWG3cVPe6XtdrdgkkADw-1; Tue, 10 Mar 2020 07:12:33 -0400
X-MC-Unique: DxQWG3cVPe6XtdrdgkkADw-1
Received: by mail-qk1-f197.google.com with SMTP id l27so9494349qkl.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 04:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=axpVG1V/qjT3loDwbt+JJkZn/lElqcRQbdYlgx1uCXo=;
        b=sIH8TgUmU1G9E/KrFDHXF8EqsXUELkGmUq7PrcgvnnwgVLcaJaS5StSZA+lPPbIHJY
         VtL5TUU7d3wlIv1SUzQTdofXwSZLifivGjHW+fSIm9T/OyRqNCipbE5zY8WdhN+YIvvV
         akg58nHy6RRsOSGhml1Hny/QwPo+XuowMpSDl+lalhDC+8LdlcyAzX/GNUe6zssXGZRZ
         5eTR20gDD1hOKjBcQgDpc+4wY/TK4RmiQMbmfmq8tr+azqqz13cng0wMeMHmUENpmnUq
         5+rJbsTWN4Km34moq3/FkxZBZGviZwQ0quC/zwtnwHGv617b0eraaxYKaxtyzaIK/I3y
         A2rA==
X-Gm-Message-State: ANhLgQ2mRoU1oSti88JyUcRcn69dofwjLb+EuaX1s4vemrSxFg84Dslm
        KaaLR1QcnClnusyaHQsM/UpNkUQYWrGkCFqi6GPQ6epAJUoch1GybJsnj3cycGvBgmRMjfqRhap
        exuG1U00rlMeNcFfX8XKWJwii
X-Received: by 2002:aed:2591:: with SMTP id x17mr6733469qtc.380.1583838752612;
        Tue, 10 Mar 2020 04:12:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vutTgn6crJxCQfwGwj+7cZGf1ntMnVj+EoHAqemBucZaiqkgmtSkvFtwxvMhZzKEPjBUqZi+Q==
X-Received: by 2002:aed:2591:: with SMTP id x17mr6733431qtc.380.1583838752300;
        Tue, 10 Mar 2020 04:12:32 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id y5sm6737555qkb.123.2020.03.10.04.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 04:12:31 -0700 (PDT)
Date:   Tue, 10 Mar 2020 07:12:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 04/20] virtio: Implement get_shm_region for PCI transport
Message-ID: <20200310071043-mutt-send-email-mst@kernel.org>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-5-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304165845.3081-5-vgoyal@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 11:58:29AM -0500, Vivek Goyal wrote:
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> 
> On PCI the shm regions are found using capability entries;
> find a region by searching for the capability.
> 
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 107 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_pci.h    |  11 ++-
>  2 files changed, 117 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 7abcc50838b8..52f179411015 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -443,6 +443,111 @@ static void del_vq(struct virtio_pci_vq_info *info)
>  	vring_del_virtqueue(vq);
>  }
>  
> +static int virtio_pci_find_shm_cap(struct pci_dev *dev,
> +                                   u8 required_id,
> +                                   u8 *bar, u64 *offset, u64 *len)
> +{
> +	int pos;
> +
> +        for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
> +             pos > 0;
> +             pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> +		u8 type, cap_len, id;
> +                u32 tmp32;
> +                u64 res_offset, res_length;
> +
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +                                                         cfg_type),
> +                                     &type);
> +                if (type != VIRTIO_PCI_CAP_SHARED_MEMORY_CFG)
> +                        continue;
> +
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +                                                         cap_len),
> +                                     &cap_len);
> +		if (cap_len != sizeof(struct virtio_pci_cap64)) {
> +		        printk(KERN_ERR "%s: shm cap with bad size offset: %d size: %d\n",
> +                               __func__, pos, cap_len);
> +                        continue;
> +                }
> +
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +                                                         id),
> +                                     &id);
> +                if (id != required_id)
> +                        continue;
> +
> +                /* Type, and ID match, looks good */
> +                pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +                                                         bar),
> +                                     bar);
> +
> +                /* Read the lower 32bit of length and offset */
> +                pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap, offset),
> +                                      &tmp32);
> +                res_offset = tmp32;
> +                pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap, length),
> +                                      &tmp32);
> +                res_length = tmp32;
> +
> +                /* and now the top half */
> +                pci_read_config_dword(dev,
> +                                      pos + offsetof(struct virtio_pci_cap64,
> +                                                     offset_hi),
> +                                      &tmp32);
> +                res_offset |= ((u64)tmp32) << 32;
> +                pci_read_config_dword(dev,
> +                                      pos + offsetof(struct virtio_pci_cap64,
> +                                                     length_hi),
> +                                      &tmp32);
> +                res_length |= ((u64)tmp32) << 32;
> +
> +                *offset = res_offset;
> +                *len = res_length;
> +
> +                return pos;
> +        }
> +        return 0;
> +}
> +
> +static bool vp_get_shm_region(struct virtio_device *vdev,
> +			      struct virtio_shm_region *region, u8 id)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct pci_dev *pci_dev = vp_dev->pci_dev;
> +	u8 bar;
> +	u64 offset, len;
> +	phys_addr_t phys_addr;
> +	size_t bar_len;
> +	int ret;
> +
> +	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
> +		return false;
> +	}
> +
> +	ret = pci_request_region(pci_dev, bar, "virtio-pci-shm");
> +	if (ret < 0) {
> +		dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
> +			__func__);
> +		return false;
> +	}
> +
> +	phys_addr = pci_resource_start(pci_dev, bar);
> +	bar_len = pci_resource_len(pci_dev, bar);
> +
> +        if (offset + len > bar_len) {
> +                dev_err(&pci_dev->dev,
> +                        "%s: bar shorter than cap offset+len\n",
> +                        __func__);
> +                return false;
> +        }
> +

Something wrong with indentation here.
Also as long as you are validating things, it's worth checking
offset + len does not overflow.

> +	region->len = len;
> +	region->addr = (u64) phys_addr + offset;
> +
> +	return true;
> +}
> +
>  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.get		= NULL,
>  	.set		= NULL,
> @@ -457,6 +562,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.bus_name	= vp_bus_name,
>  	.set_vq_affinity = vp_set_vq_affinity,
>  	.get_vq_affinity = vp_get_vq_affinity,
> +	.get_shm_region  = vp_get_shm_region,
>  };
>  
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> @@ -473,6 +579,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.bus_name	= vp_bus_name,
>  	.set_vq_affinity = vp_set_vq_affinity,
>  	.get_vq_affinity = vp_get_vq_affinity,
> +	.get_shm_region  = vp_get_shm_region,
>  };
>  
>  /**
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index 90007a1abcab..fe9f43680a1d 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -113,6 +113,8 @@
>  #define VIRTIO_PCI_CAP_DEVICE_CFG	4
>  /* PCI configuration access */
>  #define VIRTIO_PCI_CAP_PCI_CFG		5
> +/* Additional shared memory capability */
> +#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
>  
>  /* This is the PCI capability header: */
>  struct virtio_pci_cap {
> @@ -121,11 +123,18 @@ struct virtio_pci_cap {
>  	__u8 cap_len;		/* Generic PCI field: capability length */
>  	__u8 cfg_type;		/* Identifies the structure. */
>  	__u8 bar;		/* Where to find it. */
> -	__u8 padding[3];	/* Pad to full dword. */
> +	__u8 id;		/* Multiple capabilities of the same type */
> +	__u8 padding[2];	/* Pad to full dword. */
>  	__le32 offset;		/* Offset within bar. */
>  	__le32 length;		/* Length of the structure, in bytes. */
>  };
>  
> +struct virtio_pci_cap64 {
> +       struct virtio_pci_cap cap;
> +       __le32 offset_hi;             /* Most sig 32 bits of offset */
> +       __le32 length_hi;             /* Most sig 32 bits of length */
> +};
> +
>  struct virtio_pci_notify_cap {
>  	struct virtio_pci_cap cap;
>  	__le32 notify_off_multiplier;	/* Multiplier for queue_notify_off. */
> -- 
> 2.20.1

