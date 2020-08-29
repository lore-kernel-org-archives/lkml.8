Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1444CC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 15:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B4E20791
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 15:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grA9sBId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgH2Pf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 11:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24042 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728196AbgH2PfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 11:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598715323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=qmmPLRQSTKQjwJoLTLyS2w23N792Fkd1ROx5b2pWcYU=;
        b=grA9sBIdr9GxAxhbJRllkEvqs9sUMhiUBYzMWUUFspuuTjwByPQSQnld6qg9UUF2Ouf2cr
        Hhe5BhZ/oX1G0wxMLg6Be3xk70VnumfS4bqv+lBAvHtPiRUC1YMUvOygXWjpO7flXVHbgu
        dZB2AmkH/8C8p1cNGiBiNKtXYzPCA58=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-oe7KsWbTMyWGwslYcs_uTg-1; Sat, 29 Aug 2020 11:35:21 -0400
X-MC-Unique: oe7KsWbTMyWGwslYcs_uTg-1
Received: by mail-ot1-f71.google.com with SMTP id q26so1313558otf.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qmmPLRQSTKQjwJoLTLyS2w23N792Fkd1ROx5b2pWcYU=;
        b=JiZvU/m84HUW0P3lfw+4MHLJJzuLuk82OiEyBYbGMuawzYevmkxKUw+BjkOJweP05F
         4No2Up66+ALl4ijUwZDXDSU3FFG5G6n8uBFBlTD/wGa5azxtQ2dUBdl25pafoODnBngV
         aELlmu0dcrdanZ0nj4KTer+o7+MyOgwPMqOtHb1rIR6rt0FK3cfpfiIM3V1+LUHciGeC
         M9aSBMCkIQMZSC1Xt0fmLALW2VlEi4x0KXmMI9aEtR+qLFex/JvwXgRBOiYJ4CwNx2Rl
         ny8WonzaF4l5nTclI1/JMaElkyB5Qq3LcSP98DfGXbjMbZh0cpRaIUc9AWddyV+U1Osp
         tvrQ==
X-Gm-Message-State: AOAM532xbm6RkUd7MGcH1KVh6EXWor7v0J5OoFBA9n3owvkmgQlr7OAu
        JtwNDosUO/CbrB3OXmNuk6kn40oAlaOW/wwjlvMx0xj3QrAIJh48XDuna/2Xt+9K3L9gHk78qX8
        2U9B8n1t2wmkrPguVqikY0mex
X-Received: by 2002:a9d:c64:: with SMTP id 91mr2355425otr.59.1598715320888;
        Sat, 29 Aug 2020 08:35:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvYyZNzj2QwclEeBTiTUzzukf5QXLtgqUFvURZjHxxRdmyDGTyXa8nonkQGGQ/TLdoaTTojg==
X-Received: by 2002:a9d:c64:: with SMTP id 91mr2355412otr.59.1598715320674;
        Sat, 29 Aug 2020 08:35:20 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t22sm226211otq.44.2020.08.29.08.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 08:35:20 -0700 (PDT)
From:   trix@redhat.com
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        natechancellor@gmail.com, ndesaulniers@google.com,
        shreyas.nc@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] soundwire: fix error handling
Date:   Sat, 29 Aug 2020 08:35:15 -0700
Message-Id: <20200829153515.3840-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this problem

stream.c:844:9: warning: Use of memory after
  it is freed
        kfree(bus->defer_msg.msg->buf);
              ^~~~~~~~~~~~~~~~~~~~~~~

This happens in an error handler cleaning up memory
allocated for elements in a list.

	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
		bus = m_rt->bus;

		kfree(bus->defer_msg.msg->buf);
		kfree(bus->defer_msg.msg);
	}

And is triggered when the call to sdw_bank_switch() fails.
There are a two problems.

First, when sdw_bank_switch() fails, though it frees memory it
does not clear bus's reference 'defer_msg.msg' to that memory.

The second problem is the freeing msg->buf. In some cases
msg will be NULL so this will dereference a null pointer.
Need to check before freeing.

Fixes: 99b8a5d608a6 ("soundwire: Add bank switch routine")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/soundwire/stream.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 37290a799023..6e36deb505b1 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -717,6 +717,7 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
 	kfree(wbuf);
 error_1:
 	kfree(wr_msg);
+	bus->defer_msg.msg = NULL;
 	return ret;
 }
 
@@ -840,9 +841,10 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 error:
 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
 		bus = m_rt->bus;
-
-		kfree(bus->defer_msg.msg->buf);
-		kfree(bus->defer_msg.msg);
+		if (bus->defer_msg.msg) {
+			kfree(bus->defer_msg.msg->buf);
+			kfree(bus->defer_msg.msg);
+		}
 	}
 
 msg_unlock:
-- 
2.18.1

