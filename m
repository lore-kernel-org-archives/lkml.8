Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767C8C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525E42077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390237AbgDBXlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:41:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390182AbgDBXlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:41:44 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032NXlLB034909;
        Thu, 2 Apr 2020 19:41:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304r514xc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 19:41:26 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 032NXpRQ035174;
        Thu, 2 Apr 2020 19:41:25 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304r514xbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 19:41:25 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 032NeIMV012504;
        Thu, 2 Apr 2020 23:41:24 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 301x787qnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 23:41:24 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 032NfNpg7799192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Apr 2020 23:41:23 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A47C3AC05E;
        Thu,  2 Apr 2020 23:41:23 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08355AC05B;
        Thu,  2 Apr 2020 23:41:17 +0000 (GMT)
Received: from LeoBras (unknown [9.85.174.86])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  2 Apr 2020 23:41:16 +0000 (GMT)
Message-ID: <acbb25cdc30dc38a54eb6fb4874cc418b002c1df.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] powerpc/kernel: Enables memory hot-remove after
 reboot on pseries guests
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     "Oliver O'Halloran" <oohall@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 02 Apr 2020 20:41:05 -0300
In-Reply-To: <CAOSf1CHSCMsQgJTcMPiRUFDxBF=WVpTRk7-bzyg6iit8bmm7rg@mail.gmail.com>
References: <20200402195156.626430-1-leonardo@linux.ibm.com>
         <CAOSf1CEihBDDRny5S_7TA5Cqbdgsh6zN=kdq83OSgaLbRphtrg@mail.gmail.com>
         <6b4a4a0d4f7af723d0a5a12f4267717a507ce3f0.camel@linux.ibm.com>
         <CAOSf1CHSCMsQgJTcMPiRUFDxBF=WVpTRk7-bzyg6iit8bmm7rg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-FcTYmY9hFvNhTlbiuayE"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-02_13:2020-04-02,2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FcTYmY9hFvNhTlbiuayE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-04-03 at 10:31 +1100, Oliver O'Halloran wrote:
> On Fri, Apr 3, 2020 at 10:07 AM Leonardo Bras <leonardo@linux.ibm.com> wr=
ote:
> > Hello Oliver, thank you for the feedback.
> > Comments inline:
> >=20
> > On Fri, 2020-04-03 at 09:46 +1100, Oliver O'Halloran wrote:
> > > I don't really understand why the flag is needed at all. According to
> > > PAPR any memory provided by dynamic reconfiguration can be hot-remove=
d
> > > so why aren't we treating all DR memory as hot removable? The only
> > > memory guaranteed to be there 100% of the time is what's in the
> > > /memory@0 node since that's supposed to cover the real mode area.
> >=20
> > All LMBs are listed in DR memory, even the base memory.
> >=20
> > The v1 of the patch would work this way, as qemu would configure it's
> > DR memory with (DRC_INVALID | RESERVED) flags and the hot-added memory
> > with (ASSIGNED) flag. Looking for assigned flag would be enough.
> >=20
> > But as of today, PowerVM doesn't seem to work that way.
> > When you boot a PowerVM virtual machine with Linux, all memory is added
> > with the same flags (ASSIGNED).
> >=20
> > To create a solution that doesn't break PowerVM, this new flag was made
> > necessary.
>=20
> I'm still not convinced it's necessary. Why not check memory@0 and use
> the size as a clip level? Any memory above that level gets marked as
> hotpluggable and anything below doesn't. Seems to me that would work
> on all current platforms, so what am I missing here?
>=20

Humm, wouldn't that assume that all unmovable memory should be at the
first LMBs?=20

If we use the recently approved flag, there would be no such
limitation, and there would be possible to do some other things, like
hot-adding more unmovable memory to kernel usage.

What do you think?

Best regards,

--=-FcTYmY9hFvNhTlbiuayE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl6GeBEACgkQlQYWtz9S
ttQbQg/+IHviCwxKs+XeXG2iSTkkRo2eRSITlSy19Xdtf1IaZzAn4cVurxFhGL4T
jwrjPmXpHRhnl0tMFM2L5UXW/EUSkj1fmFXbIZsaxswDs/FbIdLGT0lCYrDSNAdu
P4KR5wTEJPffeLwl9d7BNfyjSy9pWlAMUaSCoCJPbN6p6sSYYC+dhRvz1pg/FdYF
kxf2OKtpdDbYdGRsL5BfmyPsXgBMaLY4RATyxWuSePEpZ1gk977RKGRc4lyy0NCL
FJLRw6Gv4oTBunO9FKol1sbxMHU7TneHksiAyb8rjSqdaMw4DOLWBCbmM55gAhgW
xHVHxTbCdcPyG/ZPz7I1fEs2YdhnWHN/Cao+6e/+51/bqpfCiOmUNTcfzDbALA/H
DKKO/QLyytZ3cunIsP4SW4CNJ409fBnHtlCWIuw92SDXvKq4AjcZiSU+Tej1HvOV
xr9qKQ7yxlYF6ikPak/iDpIff4xM6ngdsiG/UJaQstiaCAka7XZXJWouMMlDaQSp
Q1NAn/f2zpPWKYvN1D4RTzrp1v5KdSkfZXTToVujj5rB7HHWKkkqOY/3CFT5ogza
u5bAOvKpkpBFqJmTEcI4BIgJa2+iM5nlvIwvagGhOmkPsaKUqnWIQbrh8ujOw8D3
AoSEqVlwQX6NtEqXr7lIg2wHTw4NuMv+qomA4Ec1z2/iCTPezFQ=
=CkBs
-----END PGP SIGNATURE-----

--=-FcTYmY9hFvNhTlbiuayE--

