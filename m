Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA9AC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C962073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgBUNHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:07:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728085AbgBUNHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:07:19 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LD4d2E094637
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:07:18 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ya6e6h54q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:07:17 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 21 Feb 2020 13:07:15 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 13:07:11 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LD6DcU43778356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 13:06:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36FD9A4040;
        Fri, 21 Feb 2020 13:07:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AB02A404D;
        Fri, 21 Feb 2020 13:07:07 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.149])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 13:07:07 +0000 (GMT)
Date:   Fri, 21 Feb 2020 14:06:39 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Janosch Frank <frankja@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
In-Reply-To: <20200221032727.GC2298@umbus.fritz.box>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
        <20200220160606.53156-2-pasic@linux.ibm.com>
        <20200220161146.GA12709@lst.de>
        <4369f099-e4e4-4a58-b38b-642cf53ccca6@de.ibm.com>
        <20200220163135.GA13192@lst.de>
        <20200221032727.GC2298@umbus.fritz.box>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/0Kh./iiZFoeVIQkl275YsuF"; protocol="application/pgp-signature"
X-TM-AS-GCONF: 00
x-cbid: 20022113-0008-0000-0000-000003551FF7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022113-0009-0000-0000-00004A7632D4
Message-Id: <20200221140639.54928efe.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_03:2020-02-19,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0Kh./iiZFoeVIQkl275YsuF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2020 14:27:27 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Feb 20, 2020 at 05:31:35PM +0100, Christoph Hellwig wrote:
> > On Thu, Feb 20, 2020 at 05:23:20PM +0100, Christian Borntraeger wrote:
> > > >From a users perspective it makes absolutely perfect sense to use the
> > > bounce buffers when they are NEEDED.=20
> > > Forcing the user to specify iommu_platform just because you need boun=
ce buffers
> > > really feels wrong. And obviously we have a severe performance issue
> > > because of the indirections.
> >=20
> > The point is that the user should not have to specify iommu_platform.
> > We need to make sure any new hypervisor (especially one that might requ=
ire
> > bounce buffering) always sets it,
>=20
> So, I have draft qemu patches which enable iommu_platform by default.
> But that's really because of other problems with !iommu_platform, not
> anything to do with bounce buffering or secure VMs.
>=20
> The thing is that the hypervisor *doesn't* require bounce buffering.
> In the POWER (and maybe s390 as well) models for Secure VMs, it's the
> *guest*'s choice to enter secure mode, so the hypervisor has no reason
> to know whether the guest needs bounce buffering.  As far as the
> hypervisor and qemu are concerned that's a guest internal detail, it
> just expects to get addresses it can access whether those are GPAs
> (iommu_platform=3Doff) or IOVAs (iommu_platform=3Don).

I very much agree!

>=20
> > as was a rather bogus legacy hack
>=20
> It was certainly a bad idea, but it was a bad idea that went into a
> public spec and has been widely deployed for many years.  We can't
> just pretend it didn't happen and move on.
>=20
> Turning iommu_platform=3Don by default breaks old guests, some of which
> we still care about.  We can't (automatically) do it only for guests
> that need bounce buffering, because the hypervisor doesn't know that
> ahead of time.

Turning iommu_platform=3Don for virtio-ccw makes no sense whatsover,
because for CCW I/O there is no such thing as IOMMU and the addresses
are always physical addresses.

>=20
> > that isn't extensibe for cases that for example require bounce bufferin=
g.
>=20
> In fact bounce buffering isn't really the issue from the hypervisor
> (or spec's) point of view.  It's the fact that not all of guest memory
> is accessible to the hypervisor.  Bounce buffering is just one way the
> guest might deal with that.
>=20

Agreed.

Regards,
Halil




--Sig_/0Kh./iiZFoeVIQkl275YsuF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJeT9X4AAoJEA0vhuyXGx0ARxMQANpU75HMoKggL5saR9hlPY+f
8kd9nsbmTauewzRRSYganieZMbhq5H4sv5H2VARK0ySgBNe1c+odv/sbtfFcGGcp
2eYet2eXXYLylxx0nExFUWlXigdd1ZdF6OLCzriuNQO20M3bhoA619DLYAZ9LcG9
w0FNjbUyDaucworTmNFr/fbQ6Sx5UMr5KJ/ms/dK9gG4pzlIx58yfOYkyPNXfmof
/BCm3hYysWjzCprWJiWoe439z1f12ZTmtNu+nsYYhFL4JSY+HOZaY/LR3IgmKsSx
1wNvMwr5GTc+Wap23hJPd0SWEH03Szl2rbTEkhMGGzCbv44E7OFJVMt8DBKwunUD
ojlaoDt4PtkEvDI6iQxT+C0aL7rHLSmmT1aaGjCi+GhN0pVmSqBa9v71VzcdWhQb
jS22EkPJnMt+mdmEObiDo38AA/L8wyKt8Emvvza+Xm43+LGsAU7Dlq452PauXABA
jlyOp7VvKBy15KUPQsLgLY9G29wQeVfRhqXI/b1fZvPZFYjbo5eTZCsHOdoXc+w9
wrW+SYSHotrl9FCTFKXB5n4DGC+hrwaUXlX5/cEMGPhSijtYTbemx0KopMuhV4rD
ri6Am9MOOwS/UxHve/SQw17N1RfUdGat2pQNTPiSSKw8XvpWLlK2iNw+/pz4SENC
9TtNOE3IvOXOuA6UMeXy
=Cagi
-----END PGP SIGNATURE-----

--Sig_/0Kh./iiZFoeVIQkl275YsuF--

