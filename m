Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EB7C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657652072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCFAZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 19:25:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726128AbgCFAZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:25:11 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0260L7w6074875;
        Thu, 5 Mar 2020 19:24:43 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yk33mam54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Mar 2020 19:24:43 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0260McpM020995;
        Fri, 6 Mar 2020 00:24:42 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 2yffk6q8mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 00:24:42 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0260OfJN53346782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Mar 2020 00:24:41 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0F1CAE05F;
        Fri,  6 Mar 2020 00:24:41 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87334AE05C;
        Fri,  6 Mar 2020 00:24:39 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.147])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  6 Mar 2020 00:24:39 +0000 (GMT)
Message-ID: <80aff8226242ca105375ac7562a5a5a06a1c3bdc.camel@linux.ibm.com>
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
Date:   Thu, 05 Mar 2020 21:24:38 -0300
In-Reply-To: <20200305233231.174082-1-leonardo@linux.ibm.com>
References: <20200305233231.174082-1-leonardo@linux.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Mx5LUMAp7F+NvuFrrzMd"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-05_08:2020-03-05,2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=718
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Mx5LUMAp7F+NvuFrrzMd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-03-05 at 20:32 -0300, Leonardo Bras wrote:
> I will send the matching qemu change as a reply later.

http://patchwork.ozlabs.org/patch/1249931/

--=-Mx5LUMAp7F+NvuFrrzMd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl5hmEYACgkQlQYWtz9S
ttT0nw/9F6t/IWYBeEGdh94vxUcCxA0AL4P8lFGQLUJj4qus90wUD5i0/rINKpCN
iQfYuutsm6rzUbV7bn0dNyiu3a4Z8Mw7PRaScQBSByYUIm3mcU+ns+yTdvTsMiuw
jFLguaIkR6qtWJKuiafcTOxGoUcDyqvCqpi4IvwQ0QtzCFAH0ncSqjHRCTEOOTOI
s1c+Yckh0FxhkfVfMI3ocKYdCWLisksiQQSQg6eAZxhnv2JbDg0oB04oqzsmM/s/
9wKbAS8pw2kAxnf4aFxWEnJrIjSYSecLMLVaTmatfZ76mwE1nkwQhZEWUHHI/bjL
EbW0lyJrD4MgjKaYMJ9VDMoH8PzfSAzMPYChj+aHFia07dd3hVFkw4M6DPYUGcM9
mo+9K4lt6iyap+eFeuaGiE5kjBQJwXlBXi/D0kDYI7w2OC8jDRGRtiiseAybrLMr
hjb+/Uzntmtiu3NeeeP20ghtgeTDgl33tl5F0C3vqUlBtCZO+tMVJroO9W7kfYms
Jfo9c5JQ+r4BdXZ0GNvQrMw/oPBqbPbIIfkrKCTXpPwZnpjQCF8jCJTDnd+fNyLa
WEadSqKFBn8gbkSQbcBHrVcZ+EKtMJ2ygQxBvlcHhhVFlqPX04KjMPU75wE9wD2M
bRmOsV+YzhDjpgSko2gBMgOo7Q/9oLXACw69SRlGomjY1tHw9q8=
=r7S1
-----END PGP SIGNATURE-----

--=-Mx5LUMAp7F+NvuFrrzMd--

