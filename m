Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A9CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104DA207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgE2NGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:06:20 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16754 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726629AbgE2NGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:06:17 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04TCxZMv028270;
        Fri, 29 May 2020 09:05:58 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 316wp8c20d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 May 2020 09:05:58 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 04TD5u0X003709
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 29 May 2020 09:05:57 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 May 2020 06:05:55 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 May 2020 06:05:13 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 29 May 2020 06:05:55 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04TD5pKM026894;
        Fri, 29 May 2020 09:05:52 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v3 0/6] hwmon: pmbus: adm1266: add support
Date:   Fri, 29 May 2020 16:05:00 +0300
Message-ID: <20200529130506.73511-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-29_07:2020-05-28,2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 clxscore=1011
 malwarescore=0 mlxscore=0 lowpriorityscore=0 cotscore=-2147483648
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add PMBus probing driver for the adm1266 Cascadable
Super Sequencer with Margin Control and Fault Recording.
Driver is using the pmbus_core, creating sysfs files
under hwmon for inputs: vh1->vh4 and vp1->vp13.

1. Add PMBus probing driver for inputs vh1->vh4
and vp1->vp13.

2. Add Block WR command. A pmbus specific implementation
was required because block write with I2C_SMBUS_PROC_CALL
flag allows a maximum of 32 bytes to be received.

3. This makes adm1266 driver expose GPIOs
to user-space. Currently are read only. Future
developments on the firmware will allow
them to be writable.

4. Add debugfs files for go_command and read_state.

5. Blakcboxes are 64 bytes of chip state related data
that is generated on faults. Use the nvmem kernel api
to expose the blackbox chip functionality to userspace.

6. Device tree bindings for ADM1266.

Alexandru Tachici (6):
  hwmon: pmbus: adm1266: add support
  hwmon: (pmbus/core) Add Block WR
  hwmon: pmbus: adm1266: Add support for GPIOs
  hwmon: pmbus: adm1266: add debugfs attr for states
  hwmon: pmbus: adm1266: read blackbox
  dt-bindings: hwmon: Add bindings for ADM1266

Changelog v2 -> v3:
- added block write-read process call in pmbus-core
- expose GPIOs/PDIOs to user-space as readonly
- allow the user to issue commands to adm1266
in go_command debugfs file
- allow the user to read state of the adm1266 sequencer
from debugfs file read_state
- chip generated blackboxes can now be read
from the nvmem file 

 .../bindings/hwmon/adi,adm1266.yaml           |  56 ++
 Documentation/hwmon/adm1266.rst               |  35 ++
 drivers/hwmon/pmbus/Kconfig                   |  11 +-
 drivers/hwmon/pmbus/Makefile                  |   1 +
 drivers/hwmon/pmbus/adm1266.c                 | 500 ++++++++++++++++++
 drivers/hwmon/pmbus/pmbus.h                   |   4 +
 drivers/hwmon/pmbus/pmbus_core.c              |  88 +++
 7 files changed, 694 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
 create mode 100644 Documentation/hwmon/adm1266.rst
 create mode 100644 drivers/hwmon/pmbus/adm1266.c

-- 
2.20.1

