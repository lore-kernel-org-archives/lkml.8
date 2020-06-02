Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D087EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A830D2068D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bl7mUjpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgFBPYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 11:24:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37870 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFBPYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:24:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052FI3TC079934;
        Tue, 2 Jun 2020 15:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=RdKFhYWt2EVLN8DEYLxppo07dg9bx6p1SH/2PNSToNc=;
 b=bl7mUjpT2KhULZT0AnX4fMuZvGkjOkLUxpInTBx6wean0WADTqamDu1Bp0JGMSUu5AJU
 i6VGllzD4u6UDyYSBgtHIvveRn0+fb5DD0DLcbTgCXVy5Gw46RCqkTvDmhquiZ/zCEry
 tAq85L8nFWtDmBlb8gCXiWm6saYWy/+3dyd2Cu9mFpZf/g0II7QGSgYMBm/NZwx5dVGz
 MucVU6JHpEfhSUaXoPwYsFexcIP3qy7z3ovi2NaolrPlCvQzaFC6yUijVDzzeSfmC6ck
 4J+z49SLYgClLb+5DBnHurqsx8vDd3u2OGtXBIjJVQDqZuNqtoKFPmuik+zpw8lRi4k9 dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31dkruhpeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 15:24:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052FDH6x051475;
        Tue, 2 Jun 2020 15:22:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31c1dxdwp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 15:22:05 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 052FM4iS020836;
        Tue, 2 Jun 2020 15:22:04 GMT
Received: from [192.168.0.190] (/68.201.65.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 08:22:03 -0700
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>
Subject: [GIT PULL] JFS fix for v5.8
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Autocrypt: addr=dave.kleikamp@oracle.com; prefer-encrypt=mutual; keydata=
 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
 rnNNL3zBkwD3nWcTxFnX
Message-ID: <3be89f81-68af-3520-56f6-f4a34b823a38@oracle.com>
Date:   Tue, 2 Jun 2020 10:22:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=718
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 adultscore=0 mlxlogscore=756 cotscore=-2147483648 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2c523b344dfa65a3738e7039832044aa133c75fb:

  Linux 5.6-rc5 (2020-03-08 17:44:44 -0700)

are available in the Git repository at:

  git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.8

for you to fetch changes up to 7aba5dcc234635b44b2781dbc268048cfba388ad:

  jfs: Replace zero-length array with flexible-array member (2020-03-09 15:18:51 -0500)

----------------------------------------------------------------
Replace zero-length array in JFS

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      jfs: Replace zero-length array with flexible-array member

 fs/jfs/jfs_dtree.c | 2 +-
 fs/jfs/jfs_xattr.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
