Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C05C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2815F2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="MDjRu9lm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgDWL41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:56:27 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34623 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728197AbgDWL4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:56:25 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NBrJ4n027364;
        Thu, 23 Apr 2020 13:56:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=32DkuINxmGb0Gh3Yn0zcdCa7UHTz4GuphAt8o/QOmXw=;
 b=MDjRu9lmwq13W44Bf+SYWnQbzlxhBnm8ekXRN0vdPB4oA1IaZM6jEzHNUIqMFS6ClLPr
 SL6UiDPpShLk/mN8pf9nJG2LY5zFXos21jsP4/cZilGnW8dNMa29t9YPw7n1ZFTstrY/
 UfjHXccPeNmsFblASLU0A53aYuoz5fqI3IgkOZ9aJFuMU8ddaMNGGy64lJCRj7I01iCa
 J0dIyX1RW/XrN6WSj2jikaUPR5wcA7xjboTx6yjvYAaDYe57I3DI7h38w7UmJ+LeNPRZ
 Y5DjZGEyaSBAmlUXvuBaMfDXA+y58aLxZVZbmR4O4sx95hscO0mWlaKzEhIZlWOUUW1n Ww== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fqawmghn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Apr 2020 13:56:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EE800100039;
        Thu, 23 Apr 2020 13:56:14 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D7D292BC7CE;
        Thu, 23 Apr 2020 13:56:14 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Apr 2020 13:56:14
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@st.com>, <fabrice.gasnier@st.com>
Subject: [PATCH v2 0/4] usb: gadget: serial: add supend resume support
Date:   Thu, 23 Apr 2020 13:55:52 +0200
Message-ID: <1587642956-8157-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_07:2020-04-22,2020-04-23 signatures=0
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

Changes in v2:
- update dwc2 with Minas suggestions

Fabrice Gasnier (4):
  usb: dwc2: gadget: move gadget resume after the core is in L0 state
  usb: gadget: u_serial: add suspend resume callbacks
  usb: gadget: f_serial: add suspend resume callbacks
  usb: gadget: f_acm: add suspend resume callbacks

 drivers/usb/dwc2/core_intr.c           |  7 +++--
 drivers/usb/gadget/function/f_acm.c    | 16 ++++++++++
 drivers/usb/gadget/function/f_serial.c | 16 ++++++++++
 drivers/usb/gadget/function/u_serial.c | 57 +++++++++++++++++++++++++++++-----
 drivers/usb/gadget/function/u_serial.h |  2 ++
 5 files changed, 88 insertions(+), 10 deletions(-)

-- 
2.7.4

