Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1E3C433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E3820759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgG0FaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 01:30:14 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35454 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726858AbgG0FaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 01:30:09 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06R5RmeS010997;
        Mon, 27 Jul 2020 01:29:53 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32ghn5da46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 01:29:53 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 06R5TpEd017784
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 27 Jul 2020 01:29:51 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 26 Jul 2020 22:29:50 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 26 Jul 2020 22:29:50 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sun, 26 Jul 2020 22:29:49 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06R5TksM007624;
        Mon, 27 Jul 2020 01:29:47 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v6 0/9] hwmon: pmbus: adm1266: add support
Date:   Mon, 27 Jul 2020 08:31:12 +0300
Message-ID: <20200727053121.23288-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_03:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270040
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

2. Add Block Write-Read Process Call command.
A PMBus specific implementation was required because
block write with I2C_SMBUS_PROC_CALL flag allows a
maximum of 32 bytes to be received.

3. This makes adm1266 driver expose GPIOs
to user-space. Currently are read only. Future
developments on the firmware will allow
them to be writable.

4. Allow the current sate of the seqeuncer to be read
through debugfs.

5. Blackboxes are 64 bytes of chip state related data
that is generated on faults. Use the nvmem kernel api
to expose the blackbox chip functionality to userspace.

6. Add group command support. This will allow the driver
to stop/program all cascaded adm1266 devices at once.

7. Writing the firmware hex file with offset 0
to the nvmem of the master adm1266 will trigger
the firmware programming of all cascaded devices.
The master adm1266 of each device is specified in
the devicetree.

8. Writing the configuration hex file to 0x30000
byte address of the nvmem file will trigger the
programing of that device in particular.

9. dt bindings for ADM1266.

Alexandru Tachici (9):
  hwmon: pmbus: adm1266: add support
  hwmon: pmbus: adm1266: Add Block process call
  hwmon: pmbus: adm1266: Add support for GPIOs
  hwmon: pmbus: adm1266: add debugfs for states
  hwmon: pmbus: adm1266: read blackbox
  hwmon: pmbus: adm1266: Add group command support
  hwmon: pmbus: adm1266: program firmware
  hwmon: pmbus: adm1266: program configuration
  dt-bindings: hwmon: Add bindings for ADM1266

 .../bindings/hwmon/adi,adm1266.yaml           |   56 +
 Documentation/hwmon/adm1266.rst               |   37 +
 Documentation/hwmon/index.rst                 |    1 +
 drivers/hwmon/pmbus/Kconfig                   |   10 +
 drivers/hwmon/pmbus/Makefile                  |    1 +
 drivers/hwmon/pmbus/adm1266.c                 | 1273 +++++++++++++++++
 6 files changed, 1378 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
 create mode 100644 Documentation/hwmon/adm1266.rst
 create mode 100644 drivers/hwmon/pmbus/adm1266.c

-- 
2.20.1

