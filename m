Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C65C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B294206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597683172;
	bh=jWqRiW4I0WKBGrfTOQRfUOvpMlfAxLk4XnkZZTMCiq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t2ez2YsZ26929NysGCYX6zUZnJWkweMer5ysJ4VV6pcSE2KoATDFUaBnHbqA+O8JG
	 L2EKJZ04C9YCP3b4nUgAj5e4z2nTZlrEPkE62j+8UbrpMKvZ19+eEzSScarXU/EJ8k
	 nlJSjK/y6te2+l+OpCMcx61sMXiEZgh/ETCzJdQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389079AbgHQQwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730891AbgHQQCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:02:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AA282053B;
        Mon, 17 Aug 2020 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680172;
        bh=jWqRiW4I0WKBGrfTOQRfUOvpMlfAxLk4XnkZZTMCiq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kg88YTxNdSCihKGH0xUKYBUPXhA+ZPIr4rGx6T6GKEvOSrR7k/RsnN5lUxWX/X+x+
         kYQXYXlfVLtwi8wyNN8ToI6y0BfXT1FZkOp9M5305YAhBHqF6J4xBTVPBM0ScLoaXB
         32oAN6uvPzTPBNXiYmBPK78cEZVwmvwQpBGGhJlc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 080/270] gpu: host1x: debug: Fix multiple channels emitting messages simultaneously
Date:   Mon, 17 Aug 2020 17:14:41 +0200
Message-Id: <20200817143759.752045633@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit 35681862808472a0a4b9a8817ae2789c0b5b3edc ]

Once channel's job is hung, it dumps the channel's state into KMSG before
tearing down the offending job. If multiple channels hang at once, then
they dump messages simultaneously, making the debug info unreadable, and
thus, useless. This patch adds mutex which allows only one channel to emit
debug messages at a time.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/host1x/debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/host1x/debug.c b/drivers/gpu/host1x/debug.c
index c0392672a8421..1b4997bda1c79 100644
--- a/drivers/gpu/host1x/debug.c
+++ b/drivers/gpu/host1x/debug.c
@@ -16,6 +16,8 @@
 #include "debug.h"
 #include "channel.h"
 
+static DEFINE_MUTEX(debug_lock);
+
 unsigned int host1x_debug_trace_cmdbuf;
 
 static pid_t host1x_debug_force_timeout_pid;
@@ -52,12 +54,14 @@ static int show_channel(struct host1x_channel *ch, void *data, bool show_fifo)
 	struct output *o = data;
 
 	mutex_lock(&ch->cdma.lock);
+	mutex_lock(&debug_lock);
 
 	if (show_fifo)
 		host1x_hw_show_channel_fifo(m, ch, o);
 
 	host1x_hw_show_channel_cdma(m, ch, o);
 
+	mutex_unlock(&debug_lock);
 	mutex_unlock(&ch->cdma.lock);
 
 	return 0;
-- 
2.25.1



