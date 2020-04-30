Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C125C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 18:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 492232082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 18:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588272576;
	bh=Ghi/KHsDImSD6RDtlegKVP3dkhovtpgHLcqczBeaYvg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=OxKIfqoBtNf9HDiTX/g/YjT+8eOIFPyfTJqPthT4aDalO+vG8ejrXX9uMA+ahRLPx
	 Y4ffLV+t+65cYKB3U4dZu26ajQ+wqMGaLSwu3cVumKeR6kKzc7chOa5IdX2xlLG5sF
	 c0TfONV4FlKY/+Zt+nYjPz9DQAa211ms3xmCKdPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgD3Stf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 14:49:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbgD3Stf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 14:49:35 -0400
Received: from localhost.localdomain (unknown [157.46.61.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28A612073E;
        Thu, 30 Apr 2020 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588272574;
        bh=Ghi/KHsDImSD6RDtlegKVP3dkhovtpgHLcqczBeaYvg=;
        h=From:To:Cc:Subject:Date:From;
        b=AioxeAcM8h0Tn1CANfolz9h0us9eCpARqAQlrHAeCU+h5z8Rt7SQ9pZj0+J3j0X1s
         q3WeBnsJpWQCpobdVhuK57UwyGh7sXXJsRPi5K4cmqKy4i96iScAITXVeY1RXLaHuV
         NqTRInYBIuMPXREqTwMvAfrFd/eYAhAGjOfFOcnM=
From:   mani@kernel.org
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v3 0/2] Add support for MaxLinear/Exar USB to serial converters
Date:   Fri,  1 May 2020 00:19:22 +0530
Message-Id: <20200430184924.31690-1-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Hello,

This series adds support for MaxLinear/Exar USB to serial converters.
This driver only supports XR21V141X series but it can easily be extended
to other series in future.

This driver is inspired from the initial one submitted by Patong Yang:

https://patchwork.kernel.org/patch/10543261/

While the initial driver was a custom tty USB driver exposing whole
new serial interface ttyXRUSBn, this version is completely based on USB
serial core thus exposing the interfaces as ttyUSBn. This will avoid
the overhead of exposing a new USB serial interface which the userspace
tools are unaware of.

This series has been tested with Hikey970 board hosting XR21V141X chip.

Thanks,
Mani

Changes in v3:

* Dropped the check for PID and also the reg_width property.

Changes in v2:

* Dropped the code related to handling variable register size. It's all u8 now.
* Dropped the header file and moved the contents to driver itself.
* Added Linus's reviewed-by tag for gpiochip patch.
* Added PID to gpiochip label
* Dropped gpiochip for interface 0

Manivannan Sadhasivam (2):
  usb: serial: Add MaxLinear/Exar USB to Serial driver
  usb: serial: xr_serial: Add gpiochip support

 drivers/usb/serial/Kconfig     |   9 +
 drivers/usb/serial/Makefile    |   1 +
 drivers/usb/serial/xr_serial.c | 821 +++++++++++++++++++++++++++++++++
 3 files changed, 831 insertions(+)
 create mode 100644 drivers/usb/serial/xr_serial.c

-- 
2.17.1

