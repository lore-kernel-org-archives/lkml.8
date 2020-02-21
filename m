Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A80C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D71206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgBUBSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:18:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729476AbgBUBSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:18:04 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L1AES3058501
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 20:18:03 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y9ytr1e7k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 20:18:03 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Fri, 21 Feb 2020 01:18:01 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 01:17:57 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01L1HtsE41419040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 01:17:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C748D4203F;
        Fri, 21 Feb 2020 01:17:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C2A642045;
        Fri, 21 Feb 2020 01:17:51 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.85.188.83])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 21 Feb 2020 01:17:51 +0000 (GMT)
Date:   Thu, 20 Feb 2020 17:17:48 -0800
From:   Ram Pai <linuxram@us.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Michael Mueller <mimu@linux.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220154904-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220154904-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 20022101-0016-0000-0000-000002E8C975
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022101-0017-0000-0000-0000334BE816
Message-Id: <20200221011748.GE5713@oc0525413822.ibm.com>
Subject: RE: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is protected
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_19:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1011 mlxlogscore=989 mlxscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 03:55:14PM -0500, Michael S. Tsirkin wrote:
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
> 
> 
> IOW this looks like another iteration of:
> 
> 	virtio: Support encrypted memory on powerpc secure guests
> 
> which I was under the impression was abandoned as unnecessary.

It has been abondoned on powerpc. We enabled VIRTIO_F_ACCESS_PLATFORM;
by default, flag on powerpc.

We would like to enable secure guests on powerpc without this flag
aswell enabled, but past experience has educated us that its not a easy
path.  However if Halil makes some inroads in this path for s390, we
will like to support him.


RP

