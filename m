Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEDDC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 21:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D59206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 21:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A3UkBmSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgGYVRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 17:17:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42464 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgGYVRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 17:17:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06PLGeHf157719;
        Sat, 25 Jul 2020 21:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=oiEu6EzoobQY8dTbItiFQnrFfLjnmtvCmddaUC1kO1U=;
 b=A3UkBmShd4JJMqBjOqFAfsWq6W+g3XL9TlSCFyVeAzcMsohZTmRlNmjLcU3NSVWdmzlq
 uTPmMFLXbW0tHfmdXLJSlOZjBfIY7SChLjTWTAaMKsBaq0d5NBXz7V3arbqHzNYck5er
 5I/l3W6y6imX7qKSh9NUE7kzgM3cJNAUp1mvw9Ot+VwSwZf14nIbfSh1MLCSfBvJYu6P
 oNVZo266K3H0SQORC+XxP3EA0WRnJjuLavjOZGLeLc778D70BpP/tv37PomH+I/DBR7P
 +lLb1td1T5zY+fEy8AV7wxboNLpgpHO/FRuYsjTkPNB22pw9eIs/sPSM/0ie6s+PEcbJ pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32gc5qspqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 25 Jul 2020 21:17:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06PLCYOA066724;
        Sat, 25 Jul 2020 21:17:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32gasf42sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jul 2020 21:17:18 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06PLHFf4026302;
        Sat, 25 Jul 2020 21:17:15 GMT
Received: from localhost.localdomain (/10.159.253.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 25 Jul 2020 14:17:15 -0700
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
List-Id: <soc.lore.kernel.org>
To:     arnd@arndb.de, soc@kernel.org
Cc:     arm@kernel.org, khilman@kernel.org, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        santosh.shilimkar@oracle.com
Subject: [GIT PULL] SOC: TI Keystone driver update for v5.9 
Date:   Sat, 25 Jul 2020 14:16:54 -0700
Message-Id: <1595711814-7015-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9693 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007250177
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9693 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007250178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.9

for you to fetch changes up to 09241e61103d89abf9134849b9d0dc46ac4f9cb3:

  soc: TI knav_qmss: make symbol 'knav_acc_range_ops' static (2020-07-24 14:47:10 -0700)

----------------------------------------------------------------
SOC: TI Keystone driver update for v5.9

 - TI K3 Ring Accelerator updates
 - Few non critical warining fixes

----------------------------------------------------------------
Alexander A. Klimov (1):
      firmware: ti_sci: Replace HTTP links with HTTPS ones

Grygorii Strashko (5):
      dt-bindings: soc: ti: k3-ringacc: convert bindings to json-schema
      soc: ti: k3-ringacc: add ring's flags to dump
      soc: ti: k3-ringacc: add request pair of rings api.
      soc: ti: k3-ringacc: separate soc specific initialization
      soc: ti: k3-ringacc: fix: warn: variable dereferenced before check 'ring'

Peter Ujfalusi (2):
      soc: ti: k3-ringacc: Move state tracking variables under a struct
      dmaengine: ti: k3-udma: Switch to k3_ringacc_request_rings_pair

Randy Dunlap (1):
      soc: ti/ti_sci_protocol.h: drop a duplicated word + clarify

Wei Yongjun (1):
      soc: TI knav_qmss: make symbol 'knav_acc_range_ops' static

kernel test robot (1):
      soc: ti: k3: fix semicolon.cocci warnings

 .../bindings/interrupt-controller/ti,sci-intr.txt  |   2 +-
 .../devicetree/bindings/soc/ti/k3-ringacc.txt      |  59 ------
 .../devicetree/bindings/soc/ti/k3-ringacc.yaml     | 102 +++++++++++
 drivers/dma/ti/k3-udma-glue.c                      |  42 ++---
 drivers/dma/ti/k3-udma.c                           |  34 ++--
 drivers/firmware/ti_sci.c                          |   2 +-
 drivers/firmware/ti_sci.h                          |   2 +-
 drivers/irqchip/irq-ti-sci-inta.c                  |   2 +-
 drivers/irqchip/irq-ti-sci-intr.c                  |   2 +-
 drivers/reset/reset-ti-sci.c                       |   2 +-
 drivers/soc/ti/k3-ringacc.c                        | 200 ++++++++++++++-------
 drivers/soc/ti/knav_qmss_acc.c                     |   2 +-
 include/linux/soc/ti/k3-ringacc.h                  |   4 +
 include/linux/soc/ti/ti_sci_inta_msi.h             |   2 +-
 include/linux/soc/ti/ti_sci_protocol.h             |   6 +-
 15 files changed, 276 insertions(+), 187 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml
