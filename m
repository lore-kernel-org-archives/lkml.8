Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AA0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA1820781
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404528AbgFXPQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:16:09 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:60534 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404507AbgFXPQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:16:02 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05OEtAIv019590;
        Wed, 24 Jun 2020 11:15:45 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 31uurjjgb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 11:15:45 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 05OFFhNt012583
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 24 Jun 2020 11:15:44 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 24 Jun 2020 08:15:42 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 24 Jun 2020 08:15:42 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 24 Jun 2020 08:15:42 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05OFFdRp023607;
        Wed, 24 Jun 2020 11:15:39 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v5 0/7] hwmon: pmbus: adm1266: add support
Date:   Wed, 24 Jun 2020 18:17:29 +0300
Message-ID: <20200624151736.95785-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-24_08:2020-06-24,2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 cotscore=-2147483648 bulkscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006240107
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

Changelog v4 -> v5:
- added WITH Linux-syscall-note to adm1266.h

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

