Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE11C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C2A20678
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fm/WTMAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIBU1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726226AbgIBU1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599078419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=cIAL4uSFyLFSVcItg2mcli0KRxTiY1/Wt15t2VmCv+8=;
        b=fm/WTMAVQaemtLzMp4/o76IBNc9xuHITHl88jWFg1X+p3sG3vBzeFMvEwG8B6zSy6/532N
        WVRg2Ld1PCIlGY+oHztPe3AgRRylTXtpBRC1HYZPXUEbHOpcTMHPInWiP6WWEWu5Uu8K31
        6875ABl/A+ggjd82SmjilfvUUN0n+hY=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-FtGejIojPFW38PVbek_d4g-1; Wed, 02 Sep 2020 16:26:56 -0400
X-MC-Unique: FtGejIojPFW38PVbek_d4g-1
Received: by mail-il1-f199.google.com with SMTP id m80so632856ilb.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 13:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cIAL4uSFyLFSVcItg2mcli0KRxTiY1/Wt15t2VmCv+8=;
        b=Kw2n5mSeVnuE9CS/09hoewg67Xv1M0AZvkD3H2DYtHAYV0JSMNDu6zQD8XzjSOG3q9
         tWcUZOi+CeWzb1MdAldh3lRIcvSGIqqeVfYZUBar4qDz5GlHdt63b1I62nCdKNXYPV6E
         iXjGBwbA3pWedWslf1UkCtsYEJvogYDomWPcREkmML5xsCRDU6wUfcByNg4RxPMGQwBU
         7hHja3ohFXNqWdb8mmgyTn+781AseshwSciCDBazFMklzY3EX4qGNVyztyqA4mUSYv4O
         2J+AZxoRl4bDqZpRhdhIw++YFso6g21niErYLM5YXjx7/ri0+49aZ7wQ9gIld7gZqd3R
         llDw==
X-Gm-Message-State: AOAM532guvIAilH1MtoJJ8gFJxXvBVIVbkkE0bxBOdmNIpXrsB2TNNDa
        K446d/aNyJwg8yuaIQvWQ809KrKgIHB8THcvcsWCXbGOZXgzDGThtRwmuItucDM79t+3VAZX1MP
        xGKNix7dskJOZVNHLnr98aImt
X-Received: by 2002:a92:a1d4:: with SMTP id b81mr19924ill.152.1599078415831;
        Wed, 02 Sep 2020 13:26:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyA12e2y880FIcVpufJTfqjLja+2TIGbXlSF6n0WsreiuRt2D1J+eMlzyCBT8LQ2F8+uVeYPg==
X-Received: by 2002:a92:a1d4:: with SMTP id b81mr19902ill.152.1599078415553;
        Wed, 02 Sep 2020 13:26:55 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i73sm330622ill.4.2020.09.02.13.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 13:26:55 -0700 (PDT)
From:   trix@redhat.com
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        natechancellor@gmail.com, ndesaulniers@google.com,
        shreyas.nc@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] soundwire: fix double free of dangling pointer
Date:   Wed,  2 Sep 2020 13:26:50 -0700
Message-Id: <20200902202650.14189-1-trix@redhat.com>
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
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
v2 : change title, was 'soundwire: fix error handling'
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

