Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAAEC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0E02072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgBQOQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:16:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbgBQOQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:16:11 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HEFRwV129122;
        Mon, 17 Feb 2020 09:15:45 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6buma029-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Feb 2020 09:15:44 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01HEA8n8003987;
        Mon, 17 Feb 2020 14:15:43 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 2y689627sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Feb 2020 14:15:43 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01HEFgRi56623462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 14:15:42 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 400F9BE054;
        Mon, 17 Feb 2020 14:15:42 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A59FBE051;
        Mon, 17 Feb 2020 14:15:40 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 17 Feb 2020 14:15:40 +0000 (GMT)
Message-ID: <4177ac465032c043fc2bd2d257cfed1f9b32130f.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] powerpc/cputable: Remove unnecessary copy of
 cpu_spec->oprofile_type
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Michael Neuling <mikey@neuling.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, desnesn@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Feb 2020 11:15:39 -0300
In-Reply-To: <f61f9a59ddb0f103cd62792e13afde4ca8afa7bb.camel@neuling.org>
References: <20200215053637.280880-1-leonardo@linux.ibm.com>
         <f61f9a59ddb0f103cd62792e13afde4ca8afa7bb.camel@neuling.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-miUKIdMazE7d2FNrQGQu"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-17_08:2020-02-17,2020-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002170118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-miUKIdMazE7d2FNrQGQu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-17 at 09:33 +1100, Michael Neuling wrote:
> On Sat, 2020-02-15 at 02:36 -0300, Leonardo Bras wrote:
> > Before checking for cpu_type =3D=3D NULL, this same copy happens, so do=
ing
> > it here will just write the same value to the t->oprofile_type
> > again.
> >=20
> > Remove the repeated copy, as it is unnecessary.
> >=20
> > Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
>=20
> LGTM
>=20
> Reviewed-by: Michael Neuling <mikey@neuling.org>
>=20

Thanks!

> > ---
> >  arch/powerpc/kernel/cputable.c | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputa=
ble.c
> > index e745abc5457a..5a87ec96582f 100644
> > --- a/arch/powerpc/kernel/cputable.c
> > +++ b/arch/powerpc/kernel/cputable.c
> > @@ -2197,7 +2197,6 @@ static struct cpu_spec * __init setup_cpu_spec(un=
signed
> > long offset,
> >  		 */
> >  		if (old.oprofile_cpu_type !=3D NULL) {
> >  			t->oprofile_cpu_type =3D old.oprofile_cpu_type;
> > -			t->oprofile_type =3D old.oprofile_type;
> >  		}
> >  	}
> > =20

--=-miUKIdMazE7d2FNrQGQu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl5KoAsACgkQlQYWtz9S
ttSMkBAAloSDxI0JohdkvgvExJbJjNZFsMlB+OpXFavgD0axzhXdgPJGVuJCkS4o
ZdEahayhfkTsHyHEj/JosZGo5FcLlAW7yPtJKWA+HQhqezM+LrvFr0IFqPdV6SjP
RPfta0nf1OOk4KA7bik2fBAFbLZUJ2k2ujxLgFFeIuDinxIa82K661DJ3Kr8MpSc
39CQeRe/rcAIb+x+vpHa7KkL/jB/Nh7DZ5IeTvOnCE0oKoZq/cETSqmEgq3OBiHI
tC0+HgYRr4T4FCTnUktgSp7oomvMy8SB/8rcypxkkrxucN1522mL5vDhcDxa25f+
QxsIK95jjYVrJrVsRUdXccIfush9eSUMtZobyllSGO9AqMZ/8b3HxubyS9gT7Ag8
yGxBM8H8mD0G4ITxv+ylP9I1I3YuNPkT93JD+7nU6OPvGXmD0xnN0x+cgK/1x5SD
0UOwGnbJ4yAeQBIu+1uHT795psAUF0j2t7EN2H+haIWJfAXu4l188ALU9jvtqoOC
KoXcSi0YzG7mEfB5IyQyAVKI/7r3jbrbfl4rDSaf2IhOvZT7ueR/sA3G2u5u3Bw1
8QoP6MjRb6d7R+wbFUvMeW+Rk2IGTfdbEJr7vABlIwUMR0yLGc2LeGIyJ+9+7P+A
BsomQjSu6cPEQsQ2FwWKdBeKbnyQWZRpcjCj2xPhut/XJwS9z1s=
=7iTa
-----END PGP SIGNATURE-----

--=-miUKIdMazE7d2FNrQGQu--

