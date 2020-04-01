Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B06C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA2320776
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbgDAPIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:08:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732687AbgDAPIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:08:10 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031F4I9S075063;
        Wed, 1 Apr 2020 11:07:43 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 303uj4gujr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 11:07:43 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 031F16GH031835;
        Wed, 1 Apr 2020 15:07:42 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 301x76t8nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 15:07:42 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 031F7fWh45613404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 15:07:41 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60210AE05C;
        Wed,  1 Apr 2020 15:07:41 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AE29AE060;
        Wed,  1 Apr 2020 15:07:38 +0000 (GMT)
Received: from LeoBras (unknown [9.85.228.30])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 15:07:37 +0000 (GMT)
Message-ID: <33333c2ffe9fedbee252a1731d7c10cd3308252b.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/1] powerpc/kernel: Enables memory hot-remove
 after reboot on pseries guests
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Anderson <andmike@linux.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        bharata.rao@in.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Apr 2020 12:07:33 -0300
In-Reply-To: <20200305233231.174082-1-leonardo@linux.ibm.com>
References: <20200305233231.174082-1-leonardo@linux.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-VynV9rUX+88/vxShdVMp"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_01:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=829 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VynV9rUX+88/vxShdVMp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-03-05 at 20:32 -0300, Leonardo Bras wrote:
> ---
> The new flag was already proposed on Power Architecture documentation,
> and it's waiting for approval.
>=20
> I would like to get your comments on this change, but it's still not
> ready for being merged.

New flag got approved on the documentation.
Please review this patch.

--=-VynV9rUX+88/vxShdVMp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl6ErjUACgkQlQYWtz9S
ttTBKhAAlHs4fzgLuSqNlQADyKsBH7BIUd0lzkGIYBuyBmswiNXSgvCNjT6Dm5MX
o2xXMdLwhSyg4B82Vjt3ykc5OBqphBtF4X9FBGAag+D0FsodTkmSRIJZgM6uwbn+
RSboIpXmches0B9OLGCW286RWU1aVO2hIZqhWLgORNFsnH8zzYuYHDHhaJ8gXiOA
CrNn0IpTNtdjjsMkxtzoh3FTEgsafcQWmicMhPk3GK6SvF8BkB8xTyADqQgHV95r
5zscp72pYhEO86m1ZEJjUCEkoL4bLlrONeVDD5ZRAG95+Okf5Q6wYDC42rCYoHhH
CqMiLcfnBfow1DExc8nv8yIYGIaMitR2n27sGgzgg6l4CgYrZvHsMyQoxT5umXM7
7sFOsVNND4hnMGs5WEUm5SuSn03tYaV6e59WI8ihiqOk2wsuIqmtPxP7XyA3Aw7d
ocKqN9hajO2ylltq7NeTm1xitlWYShX+BZ0q9Z4/7iyk0Z57QRAi6GBHf+/jmCUc
o68jcF0CIVLZFK/FyXcNMV0ndd2g0Q5OqtJLTbujtV494clWOzTa4zYB/h0QnS49
MSElbBVgbD7JheuCSoHKj5KRL0QPHKAzmGydngqhJiV7ngC3CEbX1ddW5+euZuSb
Hxrrbj9KUDsNm9UoqX11MMzomkjYWZxQzJEcVv1eUXdm4t0NVBs=
=AaxG
-----END PGP SIGNATURE-----

--=-VynV9rUX+88/vxShdVMp--

