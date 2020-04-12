Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547AAC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 11:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313A820575
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 11:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgDLLY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 07:24:28 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:7259 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgDLLY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 07:24:28 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.227])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 58C9C4E1659;
        Sun, 12 Apr 2020 19:24:23 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, kernel@vivo.com,
        Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH v2,0/3] drivers: rpmon: new driver Remote Processor Monitor
Date:   Sun, 12 Apr 2020 04:24:02 -0700
Message-Id: <20200412112405.24116-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200411095301.18780-1-wenhu.wang@vivo.com>
References: <20200411095301.18780-1-wenhu.wang@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVJT0lLS0tKS0lCQk1DSFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MiI6Eww5Hjg2TxQpMSwiNDcP
        NRdPFCJVSlVKTkNNTUJLTU1OTU9OVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlMWVdZCAFZQUhNT0w3Bg++
X-HM-Tid: 0a716e2224699376kuws58c9c4e1659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPMON is a driver framework. It supports remote processor monitor
from user level. The basic components are a character device
with sysfs interfaces for user space communication and different
kinds of message drivers introduced modularly, which are used to
communicate with remote processors.

As for user space, one can get notifications of different events
of remote processors, like their registrations, through standard
file read operation of the file descriptors related to the exported
character devices. Actions can also be taken into account via
standard write operations to the devices. Besides, the sysfs class
attributes could be accessed conveniently.

Message drivers act as engines to communicate with remote processors.
Currently RPMON_QMI is available which uses QMI infrastructures
on Qualcomm SoC Platforms.

RPMON_QMI implements a kind of communication routine for RPMON to
communicate with remote processors through QMI infrastructure.
RPMON_QMI itself is designed as a modular framework that would
introduce different kind of message sets which are binding to
different services.

RPMON_QMI creates a device of rpmon_device type for each remote
processor endpoint. All the endpoint devices share an unique set
of QMI suite.

RPMON_QMI_MSG_V01 implements a RPMON_QMI message set for connection check.
RPMON_QMI defines its message types modularly. Each rpmon service
binds to a message set and introduced as a module. This version 1.0
message set could be used for connection checking of remote processors.

RPMON_QMI messages depend on QCOM_QMI_HELPERS and should be updated
together with QMI related modules.

Changes since v1:
 - Addressed review comments from Randy

Wang Wenhu (3):
  driver: rpmon: new driver Remote Processor Monitor
  driver: rpmon: qmi message version 01
  driver: rpmon: add rpmon_qmi driver

 drivers/Kconfig                  |   2 +
 drivers/Makefile                 |   1 +
 drivers/rpmon/Kconfig            |  54 ++++
 drivers/rpmon/Makefile           |   3 +
 drivers/rpmon/rpmon.c            | 506 +++++++++++++++++++++++++++++++
 drivers/rpmon/rpmon_qmi.c        | 431 ++++++++++++++++++++++++++
 drivers/rpmon/rpmon_qmi.h        |  77 +++++
 drivers/rpmon/rpmon_qmi_msg_v1.c | 242 +++++++++++++++
 include/linux/rpmon.h            |  68 +++++
 9 files changed, 1384 insertions(+)
 create mode 100644 drivers/rpmon/Kconfig
 create mode 100644 drivers/rpmon/Makefile
 create mode 100644 drivers/rpmon/rpmon.c
 create mode 100644 drivers/rpmon/rpmon_qmi.c
 create mode 100644 drivers/rpmon/rpmon_qmi.h
 create mode 100644 drivers/rpmon/rpmon_qmi_msg_v1.c
 create mode 100644 include/linux/rpmon.h

-- 
2.17.1

