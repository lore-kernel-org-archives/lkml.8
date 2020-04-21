Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71829C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50EC02071C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ZC3vU05/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgDUMdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:33:21 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12014 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728576AbgDUMdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:33:19 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LCO4w7004143;
        Tue, 21 Apr 2020 14:33:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=jg6lQEENULGmAuBll1sz812Jd5LCwX8WfZpvOP07m4Q=;
 b=ZC3vU05/6gpJisoqUzvDvG77Q9M2KnQbI9MAiWeu/eAvhvTR7w6w20IYkB1nhamAu8Up
 /mK6G+zHEGSP57wZ/ulBMj6XQONpOFCWYP96mompds3ENj1+2AXC1dqLkcaPOuxh7YVe
 H+5MWTY+xCPg8dGjhqZkqAX43xYvha/Y/21qQo5yWpn6v8MLexP/hcVkIdb8xjLQvojN
 J/kpirKdEzMWwd/AdZtzkOtz6bdiclpjGknw4nTvB0DqN9D05spESxf8mpkihOOBoY/Y
 Olk1RS9G2Uq1JLu0rxFNE6EMqSdRB2TDRU8ocYNZjv4OfFI5nAnB4fRh9da4N2sMAEtY yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fpp8rap8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 14:33:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2E84810002A;
        Tue, 21 Apr 2020 14:33:10 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 179772B0FCB;
        Tue, 21 Apr 2020 14:33:10 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Apr 2020 14:33:09
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <hminas@synopsys.com>, <balbi@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@st.com>
Subject: [PATCH 0/4] usb: gadget: serial: add supend resume support
Date:   Tue, 21 Apr 2020 14:32:17 +0200
Message-ID: <1587472341-17935-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_05:2020-04-20,2020-04-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series handles an issue seen when doing basic testing using ACM or SERIAL
gadget functions like in [1], and using the DWC2 gadget driver. It occurs when
the HOST has suspended the bus before testing, in this order:
- On the device:
  cat /dev/ttyGS<Y>
  Dmesg error log is seen on device side:
  configfs-gadget gadget: acm ttyGS0 can't notify serial state, -11
- On the host:
  echo test > /dev/ttyACM<X>
  The bus resumes, but the serial link isn't functional.

So, implement suspend/resume callbacks in gadget serial drivers to handle this.
There is a precursor patch in DWC2 to enable submitting usb requests from the
gadget resume routine, once in L0 state.

[1] https://www.kernel.org/doc/html/latest/usb/gadget-testing.html#testing-the-acm-function

Fabrice Gasnier (4):
  usb: dwc2: gadget: move gadget resume after the core is in L0 state
  usb: gadget: u_serial: add suspend resume callbacks
  usb: gadget: f_serial: add suspend resume callbacks
  usb: gadget: f_acm: add suspend resume callbacks

 drivers/usb/dwc2/core_intr.c           | 10 ++++--
 drivers/usb/gadget/function/f_acm.c    | 16 ++++++++++
 drivers/usb/gadget/function/f_serial.c | 16 ++++++++++
 drivers/usb/gadget/function/u_serial.c | 57 +++++++++++++++++++++++++++++-----
 drivers/usb/gadget/function/u_serial.h |  2 ++
 5 files changed, 90 insertions(+), 11 deletions(-)

-- 
2.7.4

