Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28BBC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 17:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAE0206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 17:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jytLqm33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgCGR5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 12:57:42 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47498 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgCGR5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 12:57:41 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 027HsCaQ091729;
        Sat, 7 Mar 2020 17:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=fJpsbI/bmww1tS/7F7pETLhlrcExlBsSe57jyl5U0/M=;
 b=jytLqm33KpDYcdZizIEytt4F9RIdd2ZkH6TUcQ6L36ab4vugOmyA24TxtgXltNblGHiW
 rfMk+GK1EbcfnHRT1IaVWpKxwIb6kuODA9TsZzpSCM4XKhLUyKktXK6PaPux28XIRWOj
 USUJ5rfCU7Pue+ua1IpWVqF0LenRfnf/VKRGPcGMslQqi00pigda9lhATYb0nMuBavtM
 OuLgKRtRkzAV2Vjc2kJ1JQC9fFGr5ta4I6m147z2Nemnbc6uuLs60NLdsdayUVkKs0nM
 jISylrGToiG5QLQjo/K91GB+V87W0XUuQtkqqGEwyg4LJTWuFEO4eiSlMWW+/1Fjb06C 3A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ym31u1evh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Mar 2020 17:57:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 027HvHXO114747;
        Sat, 7 Mar 2020 17:57:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ym0qw9s2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Mar 2020 17:57:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 027HvCP2029314;
        Sat, 7 Mar 2020 17:57:16 GMT
Received: from localhost.localdomain (/10.159.155.75)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 07 Mar 2020 09:57:12 -0800
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arm@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: [GIT PULL] ARM: Keystone DTS updates for 5.7
Date:   Sat,  7 Mar 2020 09:56:59 -0800
Message-Id: <1583603819-9651-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9553 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=703
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003070132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9553 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=765 mlxscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003070131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_5.7

for you to fetch changes up to 7856488bd83b0182548a84d05c07326321ae6138:

  ARM: dts: keystone-k2g-evm: add HDMI video support (2020-03-07 09:47:24 -0800)

----------------------------------------------------------------
ARM: Keystone DTS updates for 5.7

Add display support for K2G EVM Board

----------------------------------------------------------------
Jyri Sarha (2):
      ARM: dts: keystone-k2g: Add DSS node
      ARM: dts: keystone-k2g-evm: add HDMI video support

 arch/arm/boot/dts/keystone-k2g-evm.dts | 101 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi    |  22 +++++++
 2 files changed, 123 insertions(+)
