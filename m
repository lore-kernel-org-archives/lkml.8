Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FB2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 04:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89AA9207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 04:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EE0zm23c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgE1ECU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 00:02:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54880 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgE1ECT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 00:02:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04S3wB2g044457;
        Thu, 28 May 2020 04:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=QFuRgECqK9CIp1PIzye9PHB0E2yg1AqzkcQBc15PRKg=;
 b=EE0zm23cAkQNJc/2Yh3/L9GMaMDJzRqKuzkTkwjK8f96zGtPYm34ZKewMJRPyn1si3Rd
 ECt3UY7itElJwUhmcK1KIQnC+sXgDgBZfzs5FnJRT2ZKLHrqd6Qpolj9tSlNUytMFYWJ
 S+YSOWzK4BnufkpSd/DR+QwMr5lGIn2PAF5FhGwK8e3G7RmoWiUSUISUdJ/2yMnedhgW
 c7ZrBXwxMoh7eSyA/knZK7fRicNaxhSijMDn62HUciIJQLmnz/Pv3Vl5ncCBqhzZ/DQl
 uwwwgZ0qJiAnz+uSD3xBNaWzAYXB177moMTQKotX0lbhz4SQfkKGfRKb3qltWhX56GmN nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 318xe1jqxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 04:01:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04S3x53H103937;
        Thu, 28 May 2020 04:01:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 317dds07w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 04:01:43 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04S41eq7008045;
        Thu, 28 May 2020 04:01:40 GMT
Received: from localhost.localdomain (/10.159.238.186)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 May 2020 21:01:40 -0700
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: <soc.lore.kernel.org>
Cc:     khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com,
        soc@kernel.org
Subject: [GIT PULL 2/2] ARM: DTS: Keystone update for v5.8
Date:   Wed, 27 May 2020 21:01:29 -0700
Message-Id: <1590638489-12023-2-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590638489-12023-1-git-send-email-santosh.shilimkar@oracle.com>
References: <1590638489-12023-1-git-send-email-santosh.shilimkar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9634 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=804 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9634 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=832
 adultscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_5.8

for you to fetch changes up to 644c5a582261ecdf1df41b11d05d10a1cccc0a66:

  ARM: dts: keystone: Rename "msmram" node to "sram" (2020-05-27 20:36:32 -0700)

----------------------------------------------------------------
ARM: dts: Keystone update for v5.8

 - Rename "msmram" node to "sram"

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: dts: keystone: Rename "msmram" node to "sram"

 arch/arm/boot/dts/keystone-k2e.dtsi  | 4 ++--
 arch/arm/boot/dts/keystone-k2g.dtsi  | 4 ++--
 arch/arm/boot/dts/keystone-k2hk.dtsi | 4 ++--
 arch/arm/boot/dts/keystone-k2l.dtsi  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)
