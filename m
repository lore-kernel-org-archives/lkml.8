Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E203FC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DF220674
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eoW3ojXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgBCWGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:06:50 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42692 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgBCWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:06:49 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 013M4ZF3186917;
        Mon, 3 Feb 2020 22:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=NB6sde12eQA5tWD5a8THQMHPqXfAxjDZixfUJ6/2uDw=;
 b=eoW3ojXGBlrl0QsjywVC4TTeOxKjLTEdbLzKm90+VgOHF0nJV+siN4GAaKm5Ho81X2kv
 WzcsbLydae2Oq8NMC8ctYKeflx7gR7f138p2q3IDj1rSp9tVL0ITVgVBQojYOmFs1h1v
 Qv4kToXls2BSZE0vkjM2rBfOWlVJkv6E/3j3LOCC9aJSMHTci47RjHd565mTt/ZhibsO
 4Nq+S2LEGxZOJj6pN9CDFmzsKhAdmLtHCVQK82qEdFuv4oyO4JRXPYgf1mfGZUD5IG5d
 x54QaUv3XfUt5hSJh9xntcZio9MgA+lXtVTrxActUr2qValGvZIXdaYzkWtC8oPZ7A/Y 9Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xw19qat17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 22:06:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 013M4WoI140542;
        Mon, 3 Feb 2020 22:06:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2xxsbhvtkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 22:06:46 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 013M6jil019527;
        Mon, 3 Feb 2020 22:06:45 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Feb 2020 14:06:45 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 1F3246A010B; Mon,  3 Feb 2020 17:10:27 -0500 (EST)
Date:   Mon, 3 Feb 2020 17:10:27 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] (ibft) changes for 5.6 merge window
Message-ID: <20200203221027.GA10946@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002030159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002030159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Linus,

The following changes since commit 040a3c33623ba4bd11588ab0820281b854a3ffaf:

  Merge tag 'iommu-fixes-v5.5-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu (2020-01-12 09:35:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git stable/for-linus-5.6

for you to fetch changes up to c08406033fe83a4cb307f2a2e949c59bb86b4f49:

  iscsi_ibft: Don't limits Targets and NICs to two (2020-01-12 13:16:04 -0500)

..basically adhere to the iBFT spec and extend the structure to handle to more
than two NICs.

Thank you!

----------------------------------------------------------------
Lubomir Rintel (1):
      iscsi_ibft: Don't limits Targets and NICs to two

 drivers/firmware/iscsi_ibft.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJeOJpTAAoJEFKlDoTx2wm/7LgP/1o2Bmpyy2PZDJJs8Ow1QYe6
m0CcWsWFp7rwbJ3usZaLb5MCp97LcbYrKooVdgtH1zAiRt1mp00VHJj6hXfbdhxf
qUABAJ4HommRILvRS1ejm/rx8YT3WJzn8n6RPFWSDlx+tmZy+roJcVEts9c/xDFa
9T5h+1L3xzQw1IGSPH5yXG7LcbEKOVdH3N1wXiZdnU/ZYhgrYGP1jdk/c5uF2W4C
LNELAt3tSUUxCIm7r6/7qQpOvtDqOeORnRxeN+eObWqlOOQzw7RWkX5p1CniFc1Z
L2HCooxHr5gKHRVLL5MtJP2DRKaOUR5NJSMUk+fxeyeP78NtIixfGAP90W5w/cOY
ucZXdVxeNsq+mmm388LIjQ6ht/3g+ehJP5+T1144kHdf45X8cnHq78XruuWafiqz
mkc73CABxHi9ZgUMBv3hTIXVRRS3eaW9oE4R58ikuHDqJ3npa4A5mm1sffqK5PLZ
Qnw33mi0rVdIi5rNqu4E18GF/mVX1cc7ejl8wyr9Hb3d2qS3F6KtHmjE4k1cZeCk
t1Zx3OKv+Umb50RsNDiLaZXJNpBwJeZTJxZHHI0NgCYIKDdhZ/LWVB1pSXex3vaS
5P/d2NC0FPUrVIpQml22rSoyCNScLd/H6FL5imFZueyvJu1eVt0qODEXv5K77orF
GlL3744Ff3seK7X/WCG/
=+mMZ
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
