Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3C9C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D9C206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgBUO4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:56:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728264AbgBUO4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:56:13 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LEoDdt085655
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:56:12 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8uc2mym3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:56:12 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 21 Feb 2020 14:56:10 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 14:56:05 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LEu3jL46924190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 14:56:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C874B4C046;
        Fri, 21 Feb 2020 14:56:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 424374C04E;
        Fri, 21 Feb 2020 14:56:03 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.149])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 14:56:03 +0000 (GMT)
Date:   Fri, 21 Feb 2020 15:56:02 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
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
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
In-Reply-To: <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
        <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022114-0020-0000-0000-000003AC5719
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022114-0021-0000-0000-000022046169
Message-Id: <20200221155602.4de41fa7.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_04:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 14:22:26 +0800
Jason Wang <jasowang@redhat.com> wrote:

> 
> On 2020/2/21 上午12:06, Halil Pasic wrote:
> > Currently if one intends to run a memory protection enabled VM with
> > virtio devices and linux as the guest OS, one needs to specify the
> > VIRTIO_F_IOMMU_PLATFORM flag for each virtio device to make the guest
> > linux use the DMA API, which in turn handles the memory
> > encryption/protection stuff if the guest decides to turn itself into
> > a protected one. This however makes no sense due to multiple reasons:
> > * The device is not changed by the fact that the guest RAM is
> > protected. The so called IOMMU bypass quirk is not affected.
> > * This usage is not congruent with  standardised semantics of
> > VIRTIO_F_IOMMU_PLATFORM. Guest memory protected is an orthogonal reason
> > for using DMA API in virtio (orthogonal with respect to what is
> > expressed by VIRTIO_F_IOMMU_PLATFORM).
> >
> > This series aims to decouple 'have to use DMA API because my (guest) RAM
> > is protected' and 'have to use DMA API because the device told me
> > VIRTIO_F_IOMMU_PLATFORM'.
> >
> > Please find more detailed explanations about the conceptual aspects in
> > the individual patches. There is however also a very practical problem
> > that is addressed by this series.
> >
> > For vhost-net the feature VIRTIO_F_IOMMU_PLATFORM has the following side
> > effect The vhost code assumes it the addresses on the virtio descriptor
> > ring are not guest physical addresses but iova's, and insists on doing a
> > translation of these regardless of what transport is used (e.g. whether
> > we emulate a PCI or a CCW device). (For details see commit 6b1e6cc7855b
> > "vhost: new device IOTLB API".) On s390 this results in severe
> > performance degradation (c.a. factor 10).
> 
> 
> Do you see a consistent degradation on the performance, or it only 
> happen when for during the beginning of the test?
> 

AFAIK the degradation is consistent.

> 
> > BTW with ccw I/O there is
> > (architecturally) no IOMMU, so the whole address translation makes no
> > sense in the context of virtio-ccw.
> 
> 
> I suspect we can do optimization in qemu side.
> 
> E.g send memtable entry via IOTLB API when vIOMMU is not enabled.
> 
> If this makes sense, I can draft patch to see if there's any difference.

Frankly I would prefer to avoid IOVAs on the descriptor ring (and the
then necessary translation) for virtio-ccw altogether. But Michael
voiced his opinion that we should mandate F_IOMMU_PLATFORM for devices
that could be used with guests running in protected mode. I don't share
his opinion, but that's an ongoing discussion.

Should we end up having to do translation from IOVA in vhost, we are
very interested in that translation being fast and efficient.

In that sense we would be very happy to test any optimization that aim
into that direction.

Thank you very much for your input!

Regards,
Halil

> 
> Thanks
> 
> 
> >
> > Halil Pasic (2):
> >    mm: move force_dma_unencrypted() to mem_encrypt.h
> >    virtio: let virtio use DMA API when guest RAM is protected
> >
> >   drivers/virtio/virtio_ring.c |  3 +++
> >   include/linux/dma-direct.h   |  9 ---------
> >   include/linux/mem_encrypt.h  | 10 ++++++++++
> >   3 files changed, 13 insertions(+), 9 deletions(-)
> >
> >
> > base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
> 

