Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E01BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 09:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129B82078E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 09:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgDKJxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 05:53:36 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:63690 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgDKJxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 05:53:36 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.227])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 94B814E114D;
        Sat, 11 Apr 2020 17:53:31 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH 0/3] drivers: rpmon: new driver Remote Processor Monitor
Date:   Sat, 11 Apr 2020 02:52:58 -0700
Message-Id: <20200411095301.18780-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVKQk5LS0tKTEpNTUpIQ1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBg6KQw*Czg3KBQyPz9WIg44
        LzYwCUlVSlVKTkNNTkJDQ0pIQ0pMVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlMWVdZCAFZQUhJT0M3Bg++
X-HM-Tid: 0a7168a898399376kuws94b814e114d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPMON is a driver framework. It supports remote processor monitor
from user level. The baisc components are a character device
with sysfs interfaces for user space communication and different
kinds of message drivers introduced modularly, which are used to
communicate with remote processors.

As for user space, one can get notifications of different events
of remote processors, like their registrations, through standard
file read operation of the file discriptors related to the exported
character devices. Actions can also be taken into account via
standard write operations to the devices. Besides, the sysfs class
attributes could be accessed conveniently.

Message drivers act as engines to communicate with remote processors.
Currently RPMON_QMI is available which uses QMI infrastructures
on Qualcomm SoC Platforms.

RPMON_QMI is used by RPMON to communicate with remote processors
with QMI APIs if enabled. RPMON_QMI itself is designed as a modular
framework that would introduce different kinds of message sets 
which may be updated for versions.

RPMON_QMI creates a device of rpmon_device type for each remote
processor endpoint. All the endpoint devices shares an unique set
of QMI suite.

RPMON_QMI_MSG_V01 implements a RPMON_QMI message set for connection check.
RPMON_QMI defines its message types modularly. Each rpmon service
binds to a message set and introduced as a module. This version 1.0
message set could be used for connection checking of remote processors.

RPMON_QMI messages depend on QCOM_QMI_HELPERS and should be updated
together with QMI related modules.

Wang Wenhu (3):
  driver: rpmon: new driver Remote Processor Monitor
  driver: rpmon: qmi message version 01
  driver: rpmon: add rpmon_qmi driver

 drivers/Kconfig                  |   2 +
 drivers/Makefile                 |   1 +
 drivers/rpmon/Kconfig            |  54 ++++
 drivers/rpmon/Makefile           |   3 +
 drivers/rpmon/rpmon.c            | 505 +++++++++++++++++++++++++++++++
 drivers/rpmon/rpmon_qmi.c        | 434 ++++++++++++++++++++++++++
 drivers/rpmon/rpmon_qmi.h        |  77 +++++
 drivers/rpmon/rpmon_qmi_msg_v1.c | 240 +++++++++++++++
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

