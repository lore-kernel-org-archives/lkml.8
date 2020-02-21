Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF414C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955752073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgBUNMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:12:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728177AbgBUNMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:12:42 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LDAm64079185
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:12:40 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubr0xfe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:12:40 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 21 Feb 2020 13:12:38 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 13:12:34 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LDCWSN42467504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 13:12:32 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7841B11C04C;
        Fri, 21 Feb 2020 13:12:32 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF8AB11C04A;
        Fri, 21 Feb 2020 13:12:31 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.149])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 13:12:31 +0000 (GMT)
Date:   Fri, 21 Feb 2020 14:12:30 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
In-Reply-To: <20200220154904-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
        <20200220160606.53156-3-pasic@linux.ibm.com>
        <20200220154904-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022113-0012-0000-0000-00000388FC69
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022113-0013-0000-0000-000021C59639
Message-Id: <20200221141230.13eebc35.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_03:2020-02-19,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 15:55:14 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Feb 20, 2020 at 05:06:06PM +0100, Halil Pasic wrote:
> > Currently the advanced guest memory protection technologies (AMD SEV,
> > powerpc secure guest technology and s390 Protected VMs) abuse the
> > VIRTIO_F_IOMMU_PLATFORM flag to make virtio core use the DMA API, which
> > is in turn necessary, to make IO work with guest memory protection.
> > 
> > But VIRTIO_F_IOMMU_PLATFORM a.k.a. VIRTIO_F_ACCESS_PLATFORM is really a
> > different beast: with virtio devices whose implementation runs on an SMP
> > CPU we are still fine with doing all the usual optimizations, it is just
> > that we need to make sure that the memory protection mechanism does not
> > get in the way. The VIRTIO_F_ACCESS_PLATFORM mandates more work on the
> > side of the guest (and possibly he host side as well) than we actually
> > need.
> > 
> > An additional benefit of teaching the guest to make the right decision
> > (and use DMA API) on it's own is: removing the need, to mandate special
> > VM configuration for guests that may run with protection. This is
> > especially interesting for s390 as VIRTIO_F_IOMMU_PLATFORM pushes all
> > the virtio control structures into the first 2G of guest memory:
> > something we don't necessarily want to do per-default.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Tested-by: Ram Pai <linuxram@us.ibm.com>
> > Tested-by: Michael Mueller <mimu@linux.ibm.com>
> 
> This might work for you but it's fragile, since without
> VIRTIO_F_ACCESS_PLATFORM hypervisor assumes it gets
> GPA's, not DMA addresses.
> 

Thanks for your constructive approach. I do want the hypervisor to
assume it gets GPA's. My train of thought was that the guys that need
to use IOVA's that are not GPA's when force_dma_unencrypted() will have
to to specify VIRTIO_F_ACCESS_PLATFORM (at the device) anyway, because
otherwise it won't work. But I see your point: in case of a
mis-configuration and provided the DMA API returns IOVA's one could end
up trying to touch wrong memory locations. But this should be similar to
what would happen if DMA ops are not used, and memory is not made accessible.

> 
> 
> IOW this looks like another iteration of:
> 
> 	virtio: Support encrypted memory on powerpc secure guests
> 
> which I was under the impression was abandoned as unnecessary.

Unnecessary for powerpc because they do normal PCI. In the context of
CCW there are only guest physical addresses (CCW I/O has no concept of
IOMMU or IOVAs).

> 
> 
> To summarize, the necessary conditions for a hack along these lines
> (using DMA API without VIRTIO_F_ACCESS_PLATFORM) are that we detect that:
> 
>   - secure guest mode is enabled - so we know that since we don't share
>     most memory regular virtio code won't
>     work, even though the buggy hypervisor didn't set VIRTIO_F_ACCESS_PLATFORM

force_dma_unencrypted(&vdev->dev) is IMHO exactly about this.

>   - DMA API is giving us addresses that are actually also physical
>     addresses

In case of s390 this is given. I talked with the power people before
posting this, and they ensured me they can are willing to deal with
this. I was hoping to talk abut this with the AMD SEV people here (hence
the cc).

>   - Hypervisor is buggy and didn't enable VIRTIO_F_ACCESS_PLATFORM
> 

I don't get this point. The argument where the hypervisor is buggy is a
bit hard to follow for me. If hypervisor is buggy we have already lost
anyway most of the time, or?
 
> I don't see how this patch does this.

I do get your point. I don't know of a good way to check that DMA API
is giving us addresses that are actually physical addresses, and the
situation you describe definitely has some risk to it.

Let me comment on other ideas that came up. I would be very happy to go
with the best one. Thank you very much.

Regards,
Halil

> 
> 
> > ---
> >  drivers/virtio/virtio_ring.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 867c7ebd3f10..fafc8f924955 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -243,6 +243,9 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> >  	if (!virtio_has_iommu_quirk(vdev))
> >  		return true;
> >  
> > +	if (force_dma_unencrypted(&vdev->dev))
> > +		return true;
> > +
> >  	/* Otherwise, we are left to guess. */
> >  	/*
> >  	 * In theory, it's possible to have a buggy QEMU-supposed
> > -- 
> > 2.17.1
> 

