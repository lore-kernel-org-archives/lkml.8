Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EE5C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F4E2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588103821;
	bh=UFA0Ixoy/ieW4R7Wteg5u5FS3Gsbhp97qtNu9VjbEAE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=e+lfHOsw96XJ/MZzKc92+AlO8AhYL6sEdtRAsG9pVtT2Whn6D/dpAlrVSza/7YdGG
	 I7iNY96Lj1n0JELEyh9+ujSh3wL/+oXUbyAVJNBEuaPTFxhcN+WozbnKmAVk2lkWC0
	 xiywIVpFxLrrzHtpoPkF/lUYADUmfBIbN/nwEvOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgD1T5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728584AbgD1T5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:57:00 -0400
Received: from localhost.localdomain (unknown [157.51.86.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 373612176D;
        Tue, 28 Apr 2020 19:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588103820;
        bh=UFA0Ixoy/ieW4R7Wteg5u5FS3Gsbhp97qtNu9VjbEAE=;
        h=From:To:Cc:Subject:Date:From;
        b=M2AKCb/qus/lxhlPZGxSypMSEaW4J5eW75ea0WdgzDbKX2c0wh+ka3AycItBCLzP0
         FuSkc2MjSQniy80sdqXweSummYx+lYY4MQybe/KqtSQm6G6f9glQ2OPpvCg0VoaO0d
         +CnDehhNa0gRcczyo21haoHkC6RqZMoYWferp2Z0=
From:   mani@kernel.org
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 0/2] Add support for MaxLinear/Exar USB to serial converters
Date:   Wed, 29 Apr 2020 01:26:49 +0530
Message-Id: <20200428195651.6793-1-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Hello,

This series adds support for MaxLinear/Exar USB to serial converters.
This driver only supports XR21V141X series but provision has been made
to support other series in future.

This driver is inspired from the initial one submitted by Patong Yang:

https://patchwork.kernel.org/patch/10543261/

While the initial driver was a custom tty USB driver exposing whole
new serial interface ttyXRUSBn, this version is completely based on USB
serial core thus exposing the interfaces as ttyUSBn. This will avoid
the overhead of exposing a new USB serial interface which the userspace
tools are unaware of.

This series has been tested on Hikey970 board hosting XR21V141X chip.

Thanks,
Mani

Manivannan Sadhasivam (2):
  usb: serial: Add MaxLinear/Exar USB to Serial driver
  usb: serial: xr_serial: Add gpiochip support

 drivers/usb/serial/Kconfig     |   9 +
 drivers/usb/serial/Makefile    |   1 +
 drivers/usb/serial/xr_serial.c | 728 +++++++++++++++++++++++++++++++++
 drivers/usb/serial/xr_serial.h | 110 +++++
 4 files changed, 848 insertions(+)
 create mode 100644 drivers/usb/serial/xr_serial.c
 create mode 100644 drivers/usb/serial/xr_serial.h

-- 
2.17.1

