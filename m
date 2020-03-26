Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C9CC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411AC20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgCZWFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:05:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbgCZWFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:05:40 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02QM4pYo003294;
        Thu, 26 Mar 2020 18:05:22 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 300jeununj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 18:05:22 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02QM3AUC020255;
        Thu, 26 Mar 2020 22:05:21 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 2ywaw2ra6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 22:05:20 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02QM5KIb11076308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 22:05:20 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18E20AC311;
        Thu, 26 Mar 2020 22:05:20 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BCBDAC2E7;
        Thu, 26 Mar 2020 22:05:11 +0000 (GMT)
Received: from LeoBras (unknown [9.85.162.45])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 26 Mar 2020 22:05:10 +0000 (GMT)
Message-ID: <f86aa1672b447bd09a214bc8682a70934dcee82f.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] ppc/smp: Replace unnecessary 'while' by 'if'
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 26 Mar 2020 19:05:03 -0300
In-Reply-To: <20200326214005.GB9894@blackberry>
References: <20200326203752.497029-1-leonardo@linux.ibm.com>
         <20200326214005.GB9894@blackberry>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-GTdlyedGwk3mGYQKKQZt"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_13:2020-03-26,2020-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=838 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GTdlyedGwk3mGYQKKQZt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-03-27 at 08:40 +1100, Paul Mackerras wrote:
> On Thu, Mar 26, 2020 at 05:37:52PM -0300, Leonardo Bras wrote:
> > spin_until_cond() will wait until nmi_ipi_busy =3D=3D false, and
> > nmi_ipi_lock_start() does not seem to change nmi_ipi_busy, so there is
> > no way this while will ever repeat.
> >=20
> > Replace this 'while' by an 'if', so it does not look like it can repeat=
.
>=20
> Nack, it can repeat.  The scenario is that cpu A is in this code,
> inside spin_until_cond(); cpu B has previously set nmi_ipi_busy, and
> cpu C is also waiting for nmi_ipi_busy to be cleared, like cpu A.
> When cpu B clears nmi_ipi_busy, both cpu A and cpu C will see that and
> will race inside nmi_ipi_lock_start().  One of them, say cpu C, will
> take the lock and proceed to set nmi_ipi_busy and then call
> nmi_ipi_unlock().  Then the other cpu (cpu A) will then take the lock
> and return from nmi_ipi_lock_start() and find nmi_ipi_busy =3D=3D true.
> At that point it needs to go through the while loop body once more.
>=20
> Paul.

Ok, got it.

Thanks for explaining Paul!

--=-GTdlyedGwk3mGYQKKQZt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl59JxAACgkQlQYWtz9S
ttTSdRAAttveHAUp1FuyI8cjRY3YA64LGrCYQ/GJZfAZljGAMyg78+BO1orF0p7b
n+wYBDvQzqmLMgL5fUxeHG+CQzPX7unA/9n+rn7y4j+BVZbupjLHOnPXswoDda3Y
Ycs5eFcEJ2d5Fs0psXJs/aOVtF6cd8uKNzdpk0tVGM3VMkoB509DtJqdkjY96n1g
Oi7+eDKF+yUNIxmOjEeTaJwR9fSrzLRJhdnLLpOmR0/42QvOcGeh8q3p2qtCyfgo
H6qEXVCq5E1nYLGuvJskD46vaRRXGZ29myCPzFDTUpaP5JMH36sUw4Ei6UjNgz8x
DhXNqoqSKQ4/mP91fMXgfyBGER2l4f4dTn1fmkXRC6IAt49XIFzRTVHf7GxS3i2z
jHQQHrkWmCnFeRjzbGZDZUeNU/XmNMXKponwH7Q2KvPmtiaG9YDsPnB5cKGfFyKN
uOGH0fjq1yHDq3O4epERX+o+2qTxKcEUQOakkQ4chpJ6eC/EgM2KPEwadZdZ1BAf
DQM4nCzsPQP+zptJO+LjJqDjZ1JXBwoeJYfPJBfB8pAw8VgvIXcnXVfHwoSH7WGf
1JRmT583BLGzc3cqD89kyzZ2NbL+XEGNTWcEAEHzg6Nf+2t4AQQY3T7U4Cluj2Fl
cXrBonqlCQPiR7ShKkwkYgQ7ZuYeuV1JdKsDjVXy85WBnxcAugI=
=iE5j
-----END PGP SIGNATURE-----

--=-GTdlyedGwk3mGYQKKQZt--

