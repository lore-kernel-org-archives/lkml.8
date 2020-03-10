Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570AAC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4FB2468E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844359;
	bh=f/KoOrQ5UNbB+ZWe5oWIk6h2JcUqzFq1wESw4mwP/J4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TnVw0qZ+VlLYCinyFdYOizT1Mw7Z2LdtYZdV1dTWK12LITR7kF5qMClUlIHYkjm60
	 Ka22NnhwLBXR+LISO689MMvc8M1QP7ent+fUTEUcUqdc9AJxbAUazdn5Wi2elt3cnX
	 8/J8lv24ALeXAEdOQgAr3UKxZpDS9Hpsa4WacWr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgCJMp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:45:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbgCJMpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:45:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DA652468C;
        Tue, 10 Mar 2020 12:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844353;
        bh=f/KoOrQ5UNbB+ZWe5oWIk6h2JcUqzFq1wESw4mwP/J4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vSQi+yGvlo2wyUU/is2hfz1hZkyMiY17dQOXmzSyJ7a+7Ssj3qhtxl56AY8eO1SCB
         v36wxpFv+UbJ2V6U7CsRslZXBe7/12+LJ+VkvE6psHoWkA1ZZ6163EjuJBRjoc8wp5
         9IYXdNWsqIeHvaj3zFJsVz7AO1AY4MYQ3Rm1S36M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Korsnes <jkorsnes@cisco.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Armando Visconti <armando.visconti@st.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.9 33/88] HID: core: increase HID report buffer size to 8KiB
Date:   Tue, 10 Mar 2020 13:38:41 +0100
Message-Id: <20200310123613.993998210@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123606.543939933@linuxfoundation.org>
References: <20200310123606.543939933@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Korsnes <jkorsnes@cisco.com>

commit 84a4062632462c4320704fcdf8e99e89e94c0aba upstream.

We have a HID touch device that reports its opens and shorts test
results in HID buffers of size 8184 bytes. The maximum size of the HID
buffer is currently set to 4096 bytes, causing probe of this device to
fail. With this patch we increase the maximum size of the HID buffer to
8192 bytes, making device probe and acquisition of said buffers succeed.

Signed-off-by: Johan Korsnes <jkorsnes@cisco.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Armando Visconti <armando.visconti@st.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/hid.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -453,7 +453,7 @@ struct hid_report_enum {
 };
 
 #define HID_MIN_BUFFER_SIZE	64		/* make sure there is at least a packet size of space */
-#define HID_MAX_BUFFER_SIZE	4096		/* 4kb */
+#define HID_MAX_BUFFER_SIZE	8192		/* 8kb */
 #define HID_CONTROL_FIFO_SIZE	256		/* to init devices with >100 reports */
 #define HID_OUTPUT_FIFO_SIZE	64
 


