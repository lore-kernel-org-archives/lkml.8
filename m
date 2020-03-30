Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0ABC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A88220936
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgC3ONi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:13:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727067AbgC3ONh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:13:37 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UE4IwJ079953;
        Mon, 30 Mar 2020 10:12:55 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30206x6s9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 10:12:55 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02UE4Ydj081736;
        Mon, 30 Mar 2020 10:12:55 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30206x6s9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 10:12:54 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02UEAJcc024595;
        Mon, 30 Mar 2020 14:12:54 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 301x775jdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 14:12:54 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02UECr3v10355162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 14:12:53 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F208311206D;
        Mon, 30 Mar 2020 14:12:52 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 230E7112065;
        Mon, 30 Mar 2020 14:12:50 +0000 (GMT)
Received: from LeoBras (unknown [9.85.228.254])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 30 Mar 2020 14:12:49 +0000 (GMT)
Message-ID: <d52b7462dfa5189a9e7590d6db88bc22b8c2ac5d.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] ppc/crash: Skip spinlocks during crash
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 30 Mar 2020 11:12:45 -0300
In-Reply-To: <20200330110231.GG20696@hirez.programming.kicks-ass.net>
References: <20200326222836.501404-1-leonardo@linux.ibm.com>
         <af505ef0-e0df-e0aa-bb83-3ed99841f151@c-s.fr>
         <20200330110231.GG20696@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-gVsIBY7sA3uStdFMltv4"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-30_01:2020-03-27,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=919 suspectscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003300129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gVsIBY7sA3uStdFMltv4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Peter,=20

On Mon, 2020-03-30 at 13:02 +0200, Peter Zijlstra wrote:
>  		do {
> > > +			if (unlikely(crash_skip_spinlock))
> > > +				return;
> >=20
> > You are adding a test that reads a global var in the middle of a so hot=
 path
> > ? That must kill performance. Can we do different ?
>=20
> This; adding code to a super hot patch like this for an exceptional case
> like the crash handling seems like a very very bad trade to me.
>=20
> One possible solution is to simply write 0 to the affected spinlocks
> after sending the NMI IPI thing, no?

Yes, I agree.
I suggested this on a comment in v2 of this patch:
http://patchwork.ozlabs.org/patch/1262468/



--=-gVsIBY7sA3uStdFMltv4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl6B/l0ACgkQlQYWtz9S
ttQs2BAAuPr6rhedYYK9wDBKiEL6Z8aiIdSNv5Mi9FlB5LweF6mXP7Qls401eJZh
urSWei6iSGS590yGTdBlSYbhp1jF/oDwW3DR/RRkqGoMFAGNg1FOW8NeXBWUMcp3
GNpP4CJC6ZSd3L/rfo6mVDxO/k27I1XpbHOtfcvY+VnDpkWRAcDSsyUvyWSHg1kA
TH8vjxKg4hW48qsffbui6+UIkekPuOyrwU/TjCLl9WRZf7i26tQnVoiBh66NvdQQ
njq+NFvRe35sgcNvzAQUW+Aaz26GUElUuHSe49TCapUc4YDPsei3PXr6kIYlihEl
tI6pTEenQmzdj9vKlLnv5s8Mxq14xJL/qbB+r2z6KRJ0t7GR4+xNAU1paFBFtwun
WNHr0M8rOjZNr1RBKWfZWy3PYO7E3K4oyB8HG0KoTGPVeCoN+tjrAWmenrNnsVDG
awvK+3DRnXsds/bspm26YgxMxYfhLnl44lfWSYA5UfW6RqpiyotwbHURG+xug6yQ
A7YV+2ZPCyMwdLH4ZVSrFekJ5G7iyYcihscW1fSvUVi9U7nVvtFNxkD8tkAuDWuH
Tva7JR98/rTsg5fT78eq3JUKxwDHVqj11nYrkOHK815nTeVaAxGUWFd0IWcJ7X3x
sEM1aiLEB4jOoEZRPMYNjAZhZlDCJQRPbNn4gIcOZDP1SFA4kWw=
=6xHm
-----END PGP SIGNATURE-----

--=-gVsIBY7sA3uStdFMltv4--

