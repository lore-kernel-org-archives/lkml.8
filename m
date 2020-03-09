Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7B1C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5022921D56
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCIOPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:15:18 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24398 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbgCIOPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:15:18 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 029EF0G3002512;
        Mon, 9 Mar 2020 10:15:00 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ym6bcdr1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Mar 2020 10:14:59 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 029EEucm006118
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 9 Mar 2020 10:14:56 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 9 Mar 2020 07:14:55 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 9 Mar 2020 07:14:55 -0700
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 029EEpDS008094;
        Mon, 9 Mar 2020 10:14:52 -0400
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 0/2]  hwmon: pmbus: adm1266: add initial support
Date:   Mon, 9 Mar 2020 16:14:20 +0200
Message-ID: <20200309141422.10999-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-09_05:2020-03-09,2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxlogscore=982 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for the ADM1266 sequencer.
ADM1266 has 17 voltage input channels connected
to a 12 bit SAR ADC and supports standard VOUT
pmbus commands.

Alexandru Tachici (2):
  hwmon: pmbus: adm1266: add initial support
  dt-bindings: hwmon: Add bindings for ADM1266

 .../bindings/hwmon/adi,adm1266.yaml           |  47 ++++++
 Documentation/hwmon/adm1266                   |  34 ++++
 drivers/hwmon/pmbus/Kconfig                   |  10 ++
 drivers/hwmon/pmbus/Makefile                  |   1 +
 drivers/hwmon/pmbus/adm1266.c                 | 146 ++++++++++++++++++
 5 files changed, 238 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
 create mode 100644 Documentation/hwmon/adm1266
 create mode 100644 drivers/hwmon/pmbus/adm1266.c

-- 
2.20.1

