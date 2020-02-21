Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54532C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA3D208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgBUNiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:38:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727851AbgBUNiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:38:06 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LDZDRK073222
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:38:05 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubr1vsy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:38:04 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 21 Feb 2020 13:38:01 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 13:37:58 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LDbulk52166660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 13:37:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92E10A405F;
        Fri, 21 Feb 2020 13:37:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1ACCAA405B;
        Fri, 21 Feb 2020 13:37:56 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.149])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 13:37:56 +0000 (GMT)
Date:   Fri, 21 Feb 2020 14:37:54 +0100
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
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
In-Reply-To: <20200220162747-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
        <20200220162747-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022113-0012-0000-0000-000003890028
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022113-0013-0000-0000-000021C59A04
Message-Id: <20200221143754.7c5f61ff.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_03:2020-02-19,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 16:29:50 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Feb 20, 2020 at 05:06:04PM +0100, Halil Pasic wrote:
> > * This usage is not congruent with  standardised semantics of
> > VIRTIO_F_IOMMU_PLATFORM. Guest memory protected is an orthogonal reason
> > for using DMA API in virtio (orthogonal with respect to what is
> > expressed by VIRTIO_F_IOMMU_PLATFORM). 
> 
> Quoting the spec:
> 
>   \item[VIRTIO_F_ACCESS_PLATFORM(33)] This feature indicates that
>   the device can be used on a platform where device access to data
>   in memory is limited and/or translated. E.g. this is the case if the device can be located
>   behind an IOMMU that translates bus addresses from the device into physical
>   addresses in memory, if the device can be limited to only access
>   certain memory addresses or if special commands such as
>   a cache flush can be needed to synchronise data in memory with
>   the device. Whether accesses are actually limited or translated
>   is described by platform-specific means.
>   If this feature bit is set to 0, then the device
>   has same access to memory addresses supplied to it as the
>   driver has.
>   In particular, the device will always use physical addresses
>   matching addresses used by the driver (typically meaning
>   physical addresses used by the CPU)
>   and not translated further, and can access any address supplied to it by
>   the driver. When clear, this overrides any platform-specific description of
>   whether device access is limited or translated in any way, e.g.
>   whether an IOMMU may be present.
> 
> since device can't access encrypted memory,
> this seems to match your case reasonably well.
> 

As David already explained, the device does not have to access encrypted
memory. In fact, we don't have memory encryption but memory protection on
s390. All the device *should* ever see is non-protected memory (one that
was previously shared by the guest).

Our protected guests start as non-protected ones, and may or may not
turn protected during their life-span. From the device perspective,
really, nothing changes. I believe David explained this much better than
I did.

Regards,
Halil

