Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571A1C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285D32067C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bapl5xqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgA3Fr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 00:47:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39901 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgA3Fr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 00:47:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id 4so1056841pgd.6;
        Wed, 29 Jan 2020 21:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JgTX40zcozu1pIq38hokOFeu1RslbKauSmp+/sBiQgY=;
        b=bapl5xqAOEbJm4v5NM89kCOkaf95CdGOFMi8UIv3ub9+diADUePj1yJinvZDZuvAKn
         Zz13DBHIVI5ky3TjS3O5f15mvkJQ4+gRHwqYiLgCe1SPhaWBaB/tEDKVUJXBoddk5Mbk
         loE1eRLtUxf9gxxsZ1g1rOKwDJ+rG9EOw3S71esWnLK36SBgW63hBn/wRj2URfEKn/4E
         tCDPXDnS69vLgzlj0hEZJNMgkWoN1/TeAgjzeyfikyjpejSf0XeEjtv5+zBqz6ZsWoVG
         c19FidVD4+oHr/yShB/hn+McueKhhkZs88/nB7JryqRmfZJsBALUFn22809cGSvFAAwx
         9RFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JgTX40zcozu1pIq38hokOFeu1RslbKauSmp+/sBiQgY=;
        b=ppvJvPRFRKIi78WRL8epsjs2Bicp0f3osQHumK2vtUyHqICphRzeFZajqBli8CUrWw
         SmyvOr6YB/Ve1/aS+KFRf89IDltVnE1qUebBKr2s3DczN4Fv3WGipOmMh3CbA2xoqbnu
         Tb0UaAACMdLxeknpONzJkI7eZN0cg37exbpTLFSN9ydGZ1AF//iHm+LDFr9nqCJJXkxU
         NrSmrVANe655CshC5Ad4BSo5Mb65hr8ScpldmxuJaGztJu3tSL0AR+VYyZiIxZfYu4/p
         pRAQsktQZw1gPNKFXFfPaGtsVuoq4JAqDYzuJiI/PhAuum2GbqKZSRwa/VDoQpptxsNv
         6JmA==
X-Gm-Message-State: APjAAAXXyJSeJ6kXnguhR83NOxMskK+/LGPcE3ey6N7Z6NcnMVC0xW8V
        YQC2kmZMnDwmUOSsLqXJKRo=
X-Google-Smtp-Source: APXvYqwio8GshL/8kxEK7HOrxKKcI1xaaSoJPqHKTHItUR1SVn0SFxCzOqexkU++RtA4Vj6GqluM+w==
X-Received: by 2002:a63:5657:: with SMTP id g23mr2864050pgm.452.1580363276340;
        Wed, 29 Jan 2020 21:47:56 -0800 (PST)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id l37sm4852549pjb.15.2020.01.29.21.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jan 2020 21:47:55 -0800 (PST)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V3 0/6] Add Fintek F81534A series usb-to-serial driver
Date:   Thu, 30 Jan 2020 13:47:46 +0800
Message-Id: <20200130054752.9368-1-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Fintek F81532A/534A/535/536 is USB-to-2/4/8/12 serial ports device
and the serial port is default disabled when plugin computer.

The part number is a bit same with F81532/534, but F81534A series UART
core is enhanced from F81232, not F81532/534.

The IC is contains devices as following:
	1. HUB (all devices is connected with this hub)
	2. GPIO/Control device. (enable serial port and control all GPIOs)
	   but this series patch not implement GPIO control.
	3. serial port 1 to x (2/4/8/12)

It's most same with F81232, the UART device is difference as follow:
	1. TX/RX bulk size is 128/512bytes
	2. RX bulk layout change:
		F81232: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]...
		F81534A:[LEN][Data.....][LSR]

We'll try to do some code refacting before add F81534A series.

Ji-Ze Hong (Peter Hong) (6):
  USB: serial: f81232: Extract LSR handler
  USB: serial: f81232: Add tx_empty function
  USB: serial: f81232: Use devm_kzalloc
  USB: serial: f81232: Add F81534A support
  USB: serial: f81232: Set F81534A serial port with RS232 mode
  USB: serial: f81232: Add generator for F81534A

 drivers/usb/serial/f81232.c | 353 ++++++++++++++++++++++++++++++++----
 1 file changed, 317 insertions(+), 36 deletions(-)

-- 
2.17.1

