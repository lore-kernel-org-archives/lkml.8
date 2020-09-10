Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F025C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A68A208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgIJKbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:31:20 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:15346 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgIJKbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:31:12 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 10 Sep 2020 03:31:12 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Sep 2020 03:31:10 -0700
Received: from gubbaven-linux.qualcomm.com ([10.206.64.32])
  by ironmsg01-blr.qualcomm.com with ESMTP; 10 Sep 2020 16:00:44 +0530
Received: by gubbaven-linux.qualcomm.com (Postfix, from userid 2365015)
        id B073B21993; Thu, 10 Sep 2020 16:00:45 +0530 (IST)
From:   Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        rjliao@codeaurora.org, hbandi@codeaurora.org,
        abhishekpandit@chromium.org,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Subject: [RESEND v1 0/2] Close UART port if NON_PERSISTENT_SETUP is set
Date:   Thu, 10 Sep 2020 16:00:41 +0530
Message-Id: <1599733843-20311-1-git-send-email-gubbaven@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When HCI_QUIRK_NON_PERSISTENT_SETUP is set by drivers,
it indicates that BT SoC will be completely powered OFF
during BT OFF. On next BT ON firmware must be downloaded
again. Holding UART port open during BT OFF is draining
the battery. Now during BT OFF, UART port is closed if
qurik HCI_QUIRK_NON_PERSISTENT_SETUP is set by clearing
HCI_UART_PROTO_READY proto flag. On next BT ON, UART
port is opened if HCI_UART_PROTO_READY proto flag is cleared.

Venkata Lakshmi Narayana Gubba (2):
  Bluetooth: hci_serdev: Close UART port if NON_PERSISTENT_SETUP is set
  Bluetooth: hci_qca: Remove duplicate power off in proto close

 drivers/bluetooth/hci_qca.c    |  5 ++---
 drivers/bluetooth/hci_serdev.c | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 6 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

