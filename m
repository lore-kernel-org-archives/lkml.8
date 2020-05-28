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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFCAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 04:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F8921508
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 04:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aCkMq37g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgE1ECX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 00:02:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54464 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgE1ECU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 00:02:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04S41m5Q153940;
        Thu, 28 May 2020 04:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=vn6zVVZmICnL9E0RyBPMSzspks17zsHewEDQE4IfYyU=;
 b=aCkMq37gj5cs4fSitWUW6KhQNtKljMriAL9OtQUY9J3Fx6neQYPvF3colhdoJjDBKGJF
 CxFa8GRQ1wcKBPoJeoc1qNxSSt8gAyPhNjMEPWgyoWfA5FrL6EtbMLMl9XgDg0/Q/mFW
 XiiRwikVVvbaQWtC99ayjBN5Pr8V26LrxwAp6s5H6623JlC+qAjNtFjdlj65lWDT8TUs
 zzYMaAoqTVfdo4gCEFbJkLhM2F71Xi3Aieb4M4Pc1b+4anOX4AV+C6BZLaZNLu+Jc8nx
 8kKxRqkuKEnNyxvcC9p/52jnZAKDPxlgaNgNl/QqdnYURM5WuKK/gP/rAybaiBzqcVTx 0w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 318xbk2rx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 04:01:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04S3veHw132695;
        Thu, 28 May 2020 04:01:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 317dkvpnqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 04:01:42 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04S41dO9008043;
        Thu, 28 May 2020 04:01:39 GMT
Received: from localhost.localdomain (/10.159.238.186)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 May 2020 21:01:39 -0700
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: <soc.lore.kernel.org>
Cc:     khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com,
        soc@kernel.org
Subject: [GIT PULL 1/2] soc: TI drivers updates for v5.8
Date:   Wed, 27 May 2020 21:01:28 -0700
Message-Id: <1590638489-12023-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9634 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9634 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005280019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.8

for you to fetch changes up to b8b38a8e3cae100f292d756e32c78ab288db8a7d:

  drivers: soc: ti: knav_qmss_queue: Make knav_gp_range_ops static (2020-05-27 20:39:14 -0700)

----------------------------------------------------------------
soc: ARM TI update for v5.8

 - Platform chipid driver support and associated dts doc update
 - Sparse warning fix in Navigator driver

----------------------------------------------------------------
Grygorii Strashko (2):
      dt-bindings: soc: ti: add binding for k3 platforms chipid module
      soc: ti: add k3 platforms chipid module driver

Samuel Zou (1):
      drivers: soc: ti: knav_qmss_queue: Make knav_gp_range_ops static

 .../devicetree/bindings/soc/ti/k3-socinfo.yaml     |  40 ++++++
 drivers/soc/ti/Kconfig                             |  10 ++
 drivers/soc/ti/Makefile                            |   1 +
 drivers/soc/ti/k3-socinfo.c                        | 152 +++++++++++++++++++++
 drivers/soc/ti/knav_qmss_queue.c                   |   2 +-
 5 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
 create mode 100644 drivers/soc/ti/k3-socinfo.c
