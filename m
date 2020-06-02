Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6D0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE48B2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591106501;
	bh=fZH11i5Q7gqU/qRbrKlZ6oMTCERUJw6ZUawYVDPcU8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kN82R3qUVXD3vD3OhrgckGtKCTUZwW7sxlVwUQNbtrIP0TclGY7C9V/omcHgNo4tE
	 6W3PlIwhYIdmK8sWYjzIj58UdxUEVmZ/jA9laDx6ouVQVYnl8gaYSuNlmGrVbjJULm
	 M9REhXp+5zmCZ1Axbl5oxcrpflJEWnt4xdhjMLVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgFBOBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:01:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36056 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgFBOBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:01:30 -0400
Received: by mail-lf1-f66.google.com with SMTP id c21so6241392lfb.3;
        Tue, 02 Jun 2020 07:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TA2VrMpQcKxxkV/93dofpkZjb0FySJYHvfRazp8UvOQ=;
        b=uMb1/Xd7MhJVJoHZvqjm0Fk/cLlOBI+8tuScKSqiIqxHS/0CPfeBsW7IVF06vjklPn
         ETRn6zOQ/LfZaXL2EUJ044YzBlSpwGJvrVHhmVpS/JTSe5O4vwmquwmhPgRnQyQ2Kb1t
         cPuMy2jjpMZdCOqsG1h06iWFIb1q7feMRm3K7PPikczWdSUo5PYSW2bgw0+ZkelhHIyM
         PEPZZkeOlbValw5QGjUzZNoliRnRVkyvj2OYtLZwKvo4lu2aHHVR7XfMsb4qAbnox8eb
         s9ONn0SMONRaxIzf8jdJTWxo600Ry6Grnx/n2TZW3xenDlCP4iVqE+f7UXmdwtxHfReh
         3xqA==
X-Gm-Message-State: AOAM533CMdIG+L4ewNJHbLrahetdWe//FScd/99V4cEpK6vwtikoiE+y
        kTGW31o56TyCl6H/ITZKB8A=
X-Google-Smtp-Source: ABdhPJw4qHQUsMq3CqXI9gPXpNZdAlvrVo30lnIjen10Igua9LsXpcqp8e72gU7Hknt1mvWKupwi5Q==
X-Received: by 2002:ac2:58fb:: with SMTP id v27mr14410052lfo.116.1591106488045;
        Tue, 02 Jun 2020 07:01:28 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id t22sm430077lji.90.2020.06.02.07.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 07:01:26 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jg7Tj-0000y8-0g; Tue, 02 Jun 2020 16:01:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/4] serial: core: drop redundant sysrq checks
Date:   Tue,  2 Jun 2020 16:00:58 +0200
Message-Id: <20200602140058.3656-5-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602140058.3656-1-johan@kernel.org>
References: <20200602140058.3656-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysrq timestamp will never be set unless port->has_sysrq so drop the
redundant checks that where added by commit 1997e9dfdc84 ("serial_core:
Un-ifdef sysrq SUPPORT_SYSRQ").

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/serial_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index a8a213b71553..2f6c3cfe2ae7 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -468,7 +468,7 @@ bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch);
 
 static inline int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
 {
-	if (!port->has_sysrq || !port->sysrq)
+	if (!port->sysrq)
 		return 0;
 
 	if (ch && time_before(jiffies, port->sysrq)) {
@@ -487,7 +487,7 @@ static inline int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch
 
 static inline int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
 {
-	if (!port->has_sysrq || !port->sysrq)
+	if (!port->sysrq)
 		return 0;
 
 	if (ch && time_before(jiffies, port->sysrq)) {
-- 
2.26.2

