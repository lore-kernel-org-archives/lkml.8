Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06299C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB24924687
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acrcB6MR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbgBZVEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:04:24 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45592 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgBZVEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:04:23 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so379350pfg.12;
        Wed, 26 Feb 2020 13:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=gDsflhmxZUet6FKoOUpr1JgLOWOX8WhZiLBsohFkxw4=;
        b=acrcB6MRU4Vb+1UvCWhvmsKBEWp9AzYFdxsrjAxGAXMricxbBVcvVRjtB8sb+XAv/g
         /EcMeUSBRFB7mZKbAERFfbdTtob+4kZddu5LEW+wU2RBokveGqtRF5UxgEImkxRQHIch
         4dSz8t2TuPrGRBx+s0+d++UMIwWzp4pqmFzt9KnWq1kC6O0RKuSuHuObgMk2X3rm2Att
         NfHTw6KemCIUaIn5ulaiJq2cjRvAkkehV7whg4fPD9ZKM9gXUyC3+V97s636cGPyFSHv
         RncKBmoS0L2Zl6Fwsir+/8qpx2uPNtQnQ+1beKvOqloclFnvhFuBz309dwfCjWpWEQQn
         DKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=gDsflhmxZUet6FKoOUpr1JgLOWOX8WhZiLBsohFkxw4=;
        b=IXrTWGr3kVi+cFBqWk2Q07H5UUDvJiIg6u4ILLUd1U0OOMuVbztFWQedYQmBP8vjZX
         EZR1ShPpcCUzXCOWmk9+3V206I2OHCwHaXNJJhstXmleTwhbw0A3KphIDWPqeNeHMKmi
         wUYoB+OhhI906xPomTBn/cdqlt1D4RWooZ48CQHYVsj1Jb54+2fAm+rcFuQmpdg4dB6E
         e5Bl5oe64yODtHNAj7j1doYiXle/vzneZXqhj67CadYFKF3hAC0KJ4+a9x8ZAZxUUQmN
         Zfuk2LMsT2bc3yCniocLBbdwBk03OQC7Sxmptyt8ZyS1ESQeEZVgLeTEiDSUBYAMwVcf
         qtfg==
X-Gm-Message-State: APjAAAUZysuwlV1kITkxc+R1QedmxKbTa23I7tO66n38rF1XJE+G+EE5
        HeXKLVrEoxbGBtcPt2ynEhj2VEit
X-Google-Smtp-Source: APXvYqywZQrSHz3IYuE8wT2/U6jhtr4OyqcE66q1EJEIl5in9BFBqRKlhV8bRuJ5+aZ16YmZ77Qmeg==
X-Received: by 2002:a63:f450:: with SMTP id p16mr692547pgk.211.1582751062824;
        Wed, 26 Feb 2020 13:04:22 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t189sm3977606pfd.168.2020.02.26.13.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Feb 2020 13:04:21 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Minas Harutyunyan <hminas@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Antti=20Sepp=C3=A4l=C3=A4?= <a.seppala@gmail.com>,
        Boris ARZUR <boris@konbu.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFT PATCH 0/4] usb: dwc2: Fixes and improvements
Date:   Wed, 26 Feb 2020 13:04:10 -0800
Message-Id: <20200226210414.28133-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses the following problems:

- Fix receive buffer corruptions
- Fix receive transfers with 0 byte transfer length
- Abort transactions after unknown receive errors
  if the receive buffer is full
- Reduce "trimming xfer length" logging noise

The problems fixed with this series were observed when connecting
a DM9600 Ethernet adapter to Veyron Chromebooks such as the ASUS
Chromebook C201PA. The series was tested extensively with this and
other adapters.

The observed problems are also reported when tethering various
phones, so test coverage with such phones would be very appreciated.

----------------------------------------------------------------
Guenter Roeck (4):
      usb: dwc2: Simplify and fix DMA alignment code
      usb: dwc2: Do not update data length if it is 0 on inbound transfers
      usb: dwc2: Abort transaction after errors with unknown reason
      usb: dwc2: Make "trimming xfer length" a debug message

 drivers/usb/dwc2/hcd.c      | 82 ++++++++++++++++++++++++---------------------
 drivers/usb/dwc2/hcd_intr.c | 14 +++++++-
 2 files changed, 56 insertions(+), 40 deletions(-)
