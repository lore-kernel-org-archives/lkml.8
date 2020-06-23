Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1E3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5B62078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733152AbgFWRfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:35:23 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23920 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733045AbgFWRfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:35:21 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NHNRKr031355;
        Tue, 23 Jun 2020 13:35:04 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 31uk3grq2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 13:35:03 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 05NHZ202031562
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 23 Jun 2020 13:35:02 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 23 Jun
 2020 13:35:01 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 23 Jun 2020 13:35:01 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05NHYxMP017521;
        Tue, 23 Jun 2020 13:34:59 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v4 0/7] hwmon: pmbus: adm1266: add support
Date:   Tue, 23 Jun 2020 20:36:52 +0300
Message-ID: <20200623173659.41358-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_11:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230123
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

4. Add two ioctl commands for issuing GO_COMMAND
and reading the state of the adm1266 sequencer.

5. Blackboxes are 64 bytes of chip state related data
that is generated on faults. Use the nvmem kernel api
to expose the blackbox chip functionality to userspace.

6. Expose BLACKBOX_INFO register through debugfs.

7. Device tree bindings for ADM1266.

Alexandru Tachici (7):
  hwmon: pmbus: adm1266: add support
  hwmon: pmbus: adm1266: Add Block process call
  hwmon: pmbus: adm1266: Add support for GPIOs
  hwmon: pmbus: adm1266: Add ioctl commands
  hwmon: pmbus: adm1266: read blackbox
  hwmon: pmbus: adm1266: debugfs for blackbox info
  dt-bindings: hwmon: Add bindings for ADM1266

Changelog v3 -> v4:
- moved pmbus_block_wr (pmbus process call) from pmbus_core.
to adm1266.c and renamed to pmbus_block_xfer
- in pmbus_block_xfer: fixed buffer size bug (from 255 to 257)
- in adm1266_gpio_get_multiple: handle pdios and gpios one at a time
to lower allocated space on stack
- in adm1266_gpio_dbg_show: replaced write_buf with u8 write_cmd var
- in adm1266_gpio_dbg_show: check number of bytes received from device
returned by pmbus_block_xfer.
- now use ioctl to send GO_COMMAND and retrieve current state of adm1266
- split blackbox commit into blackbox nvmem implementation and debugfs
blackbox info debugfs
- create adm1266 debugfs dir under /sys/kernel/debug/pmbus/hwmon for
blackbox_info

 .../bindings/hwmon/adi,adm1266.yaml           |  56 ++
 Documentation/hwmon/adm1266.rst               |  50 ++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/hwmon/pmbus/Kconfig                   |  10 +
 drivers/hwmon/pmbus/Makefile                  |   1 +
 drivers/hwmon/pmbus/adm1266.c                 | 657 ++++++++++++++++++
 include/uapi/linux/adm1266.h                  |  16 +
 7 files changed, 791 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
 create mode 100644 Documentation/hwmon/adm1266.rst
 create mode 100644 drivers/hwmon/pmbus/adm1266.c
 create mode 100644 include/uapi/linux/adm1266.h

-- 
2.20.1

