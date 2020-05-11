Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0E9C54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA3120673
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LO+Aq4jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgEKXzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 19:55:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54538 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgEKXzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 19:55:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BNrDM9176631;
        Mon, 11 May 2020 23:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Q9qF6QvxsvKMahlrSs0awaRIP4+CXw2XsmpF1BAXkz4=;
 b=LO+Aq4jjNMVVAg0PFiDkWpRpottZXIzO/9LGMtYY0VupNZNL5bpgiK7Lv7bxVTiulBjG
 vvQ2gXbV13j/21ut9eSNwN2MukZCvWkkiZ1md7P4yNmGhskovRsWtQ0Ztq5woHOg3YmL
 FnQaNG3n4iQ4i8hbCPSyrAtjpci8IRTMdKwnljeyBZvVvTkQrJzz7AgJpNk8gaUuslOS
 BuGlw3MjDWFIt+kudX5WvyqBKP7w54kZSkldYnepMjDOfXef8b/5Fg8TyCxIV34qrRlM
 fqahWUFm0Jv7c1rqeB2rLwJU7k8/8ouCVs3zjv3IHrPGbay4MTnm6Sp/SL9ZPcuyeO0r PA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30x3gmg2bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 23:55:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BNrquF081630;
        Mon, 11 May 2020 23:55:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30ydsp9c3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 23:55:04 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04BNt2uE028997;
        Mon, 11 May 2020 23:55:03 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2020 16:55:01 -0700
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Ewan D. Milne" <emilne@redhat.com>
Subject: Re: linux-next: Fixes tag needs some work in the scsi-fixes tree
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200508213348.16bbbd79@canb.auug.org.au>
Date:   Mon, 11 May 2020 19:54:59 -0400
In-Reply-To: <20200508213348.16bbbd79@canb.auug.org.au> (Stephen Rothwell's
        message of "Fri, 8 May 2020 21:33:48 +1000")
Message-ID: <yq1zhae2fjg.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen,

>   Fixes: 4910b524ac9 ("scsi: qla2xxx: Add support for setting port speed")
>
> has these problem(s):
>
>   - SHA1 should be at least 12 digits long

I'm pretty good at spotting 8-digit SHAs but the 11 digits tripped me up
in this case.

I refined the SHA validation logic in my commit hook script to ensure 12
digits going forward.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
