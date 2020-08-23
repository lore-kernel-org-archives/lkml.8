Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5867C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 06:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A92F20767
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 06:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pnz8g2ef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgHWGlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 02:41:10 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18685 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgHWGlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 02:41:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f420f750000>; Sat, 22 Aug 2020 23:40:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 22 Aug 2020 23:41:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 22 Aug 2020 23:41:07 -0700
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 23 Aug
 2020 06:40:39 +0000
Date:   Sun, 23 Aug 2020 09:40:36 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <rob.miller@broadcom.com>,
        <lingshan.zhu@intel.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        <shahafs@mellanox.com>, <hanand@xilinx.com>,
        <mhabets@solarflare.com>, <gdawar@xilinx.com>,
        <saugatm@xilinx.com>, <vmireyno@marvell.com>,
        <zhangweining@ruijie.com.cn>, <eli@mellanox.com>
Subject: Re: [PATCH V2 2/3] vhost: vdpa: report iova range
Message-ID: <20200823064035.GB147797@mtl-vdi-166.wap.labs.mlnx>
References: <20200821092813.8952-1-jasowang@redhat.com>
 <20200821092813.8952-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200821092813.8952-3-jasowang@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598164853; bh=UiD8dJXe+GsLHU8pN9btsFs9/XV7cIHrvGbnOBAFGPU=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=pnz8g2efLGRimNp8lVrxsQ2m5FibE80h8lYBFZALVSm1w7qPUUdqcHZfTJWkJ9/i2
         +5UC22KO67n5pzyOgiwRwSMWLIFUoRYGceulSVqJ3MlkkCAW+TjNd6VDB69iBPLHWg
         Kf9BqO2G0WeJEp3Yu/MTK+5z8wjztuWJbEtrZjpZQpfnj8sBNt9x9P1c6ISUuPhILh
         xxovu8NL2v5w1za0BrZddeqyuV9kMV+VdC6f2yTlIoXeLq5ETXvF/x1wxOF+KIcnrg
         atnjdiKMsel6dxUdn412VZXLePhEi0S+aiiInd2pq4MWSUWh79/r/Wd8/nbZHzLhiK
         DR4gmNQ8+oUWg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 05:28:12AM -0400, Jason Wang wrote:
> This patch introduces a new ioctl for vhost-vdpa device that can
> report the iova range by the device.
> 
> For device that implements get_iova_range() method, we fetch it from
> the vDPA device. If device doesn't implement get_iova_range() but
> depends on platform IOMMU, we will query via DOMAIN_ATTR_GEOMETRY,
> otherwise [0, ULLONG_MAX] is assumed.
> 
> For safety, this patch also rules out the map request which is not in
> the valid range.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/vdpa.c             | 41 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/vhost.h       |  4 ++++
>  include/uapi/linux/vhost_types.h |  9 +++++++
>  3 files changed, 54 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 3fab94f88894..1adb4adb0345 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -48,6 +48,7 @@ struct vhost_vdpa {
>  	int minor;
>  	struct eventfd_ctx *config_ctx;
>  	int in_batch;
> +	struct vdpa_iova_range range;
>  };
>  
>  static DEFINE_IDA(vhost_vdpa_ida);
> @@ -344,6 +345,16 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
>  	return 0;
>  }
>  
> +static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
> +{
> +	struct vhost_vdpa_iova_range range = {
> +		.first = v->range.first,
> +		.last = v->range.last,
> +	};
> +
> +	return copy_to_user(argp, &range, sizeof(range));
> +}
> +
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  				   void __user *argp)
>  {
> @@ -476,6 +487,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>  	case VHOST_VDPA_SET_CONFIG_CALL:
>  		r = vhost_vdpa_set_config_call(v, argp);
>  		break;
> +	case VHOST_VDPA_GET_IOVA_RANGE:
> +		r = vhost_vdpa_get_iova_range(v, argp);
> +		break;
>  	default:
>  		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
>  		if (r == -ENOIOCTLCMD)
> @@ -597,6 +611,10 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>  	u64 iova = msg->iova;
>  	int ret = 0;
>  
> +	if (msg->iova < v->range.first ||
> +	    msg->iova + msg->size - 1 > v->range.last)
> +		return -EINVAL;
> +
>  	if (vhost_iotlb_itree_first(iotlb, msg->iova,
>  				    msg->iova + msg->size - 1))
>  		return -EEXIST;
> @@ -762,6 +780,27 @@ static void vhost_vdpa_free_domain(struct vhost_vdpa *v)
>  	v->domain = NULL;
>  }
>  
> +static void vhost_vdpa_set_iova_range(struct vhost_vdpa *v)
> +{
> +	struct vdpa_iova_range *range = &v->range;
> +	struct iommu_domain_geometry geo;
> +	struct vdpa_device *vdpa = v->vdpa;
> +	const struct vdpa_config_ops *ops = vdpa->config;
> +
> +	if (ops->get_iova_range) {
> +		*range = ops->get_iova_range(vdpa);
> +	} else if (v->domain &&
> +		   !iommu_domain_get_attr(v->domain,
> +		   DOMAIN_ATTR_GEOMETRY, &geo) &&
> +		   geo.force_aperture) {
> +		range->first = geo.aperture_start;
> +		range->last = geo.aperture_end;
> +	} else {
> +		range->first = 0;
> +		range->last = ULLONG_MAX;
> +	}

Shouldn't we require drivers that publish VIRTIO_F_ACCESS_PLATFORM to
implement get_iova_range?

> +}
> +
>  static int vhost_vdpa_open(struct inode *inode, struct file *filep)
>  {
>  	struct vhost_vdpa *v;
> @@ -802,6 +841,8 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
>  	if (r)
>  		goto err_init_iotlb;
>  
> +	vhost_vdpa_set_iova_range(v);
> +
>  	filep->private_data = v;
>  
>  	return 0;
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index 75232185324a..c998860d7bbc 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -146,4 +146,8 @@
>  
>  /* Set event fd for config interrupt*/
>  #define VHOST_VDPA_SET_CONFIG_CALL	_IOW(VHOST_VIRTIO, 0x77, int)
> +
> +/* Get the valid iova range */
> +#define VHOST_VDPA_GET_IOVA_RANGE	_IOR(VHOST_VIRTIO, 0x78, \
> +					     struct vhost_vdpa_iova_range)
>  #endif
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
> index 9a269a88a6ff..f7f6a3a28977 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -138,6 +138,15 @@ struct vhost_vdpa_config {
>  	__u8 buf[0];
>  };
>  
> +/* vhost vdpa IOVA range
> + * @first: First address that can be mapped by vhost-vDPA
> + * @last: Last address that can be mapped by vhost-vDPA
> + */
> +struct vhost_vdpa_iova_range {
> +	__u64 first;
> +	__u64 last;
> +};
> +
>  /* Feature bits */
>  /* Log all write descriptors. Can be changed while device is active. */
>  #define VHOST_F_LOG_ALL 26
> -- 
> 2.18.1
> 
