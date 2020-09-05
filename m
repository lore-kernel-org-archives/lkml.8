Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828BDC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 19:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2919A2074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 19:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXxMYIWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgIET0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 15:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728400AbgIET0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 15:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599333981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=pFLFpRHDE4JFudYeKR0yB2Nja5ud5d8SymFz+afFxk4=;
        b=RXxMYIWNPBCTo2auwlE+pvzTSu1jCicBVT5sPW+BIYIvmmhEU3Z8UaW1nbQ6EcXDFkMwY8
        HhZy2p/C2fmiDc82k0gvNX727B8f/2eBWNitp3tfzobvyY6cq5/7XEeWurJvrYzSDWjpND
        q1oW7gazY/A7vEY1yfskxQw8RZR/pFU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-ihtj0uDINhSeAXVansYWLw-1; Sat, 05 Sep 2020 15:26:20 -0400
X-MC-Unique: ihtj0uDINhSeAXVansYWLw-1
Received: by mail-qk1-f198.google.com with SMTP id a2so281297qkg.19
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 12:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pFLFpRHDE4JFudYeKR0yB2Nja5ud5d8SymFz+afFxk4=;
        b=g6cf1I40Nz6hcf1ggig3HrMWU3yRps0hj4074/ZJQaotYzilJEH9KoJDBLbHNas2FQ
         1KHJnjpkeT3kS2F7EWUclwKagHsrjs0920xYeRZ1NAeipa7ShpZt8/8updOjTiFAYvdH
         RS6oVB8vu0kHmruIgro7evrJH6L4KfjNQD2F4cqQW3MuxZuL9Dvz+Gn/0Kcqp3yBBjCB
         ikRZtEiLZATEGjEfUveVz4J+nO97X93Br8MN6C4zT+PyL55tlmN3pgOju3KqhhymKsvw
         IVTaQZB8pUDSJtqSX8kbVYpXiCY9XqFZD0Wgnff4VAyJ7ocquGxM2IkxBOCKGojHuqyz
         6q1g==
X-Gm-Message-State: AOAM532DgQtvo7pt+0Jat/Wr3qMGz1EwlERY/H0JxI7MiFdhBdPpdcDP
        RobpWFoaA62jsdxoEGrcf1Qb2Cz3GvAAWH6OD+G6CRjQmXRYsrR3tqNBTbQs9neGM+POc+DgoGD
        0h1g98/r7JvcPPCSjZinlDomO
X-Received: by 2002:ac8:34f2:: with SMTP id x47mr14259654qtb.282.1599333979700;
        Sat, 05 Sep 2020 12:26:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpdiOw+3OCNQl3hZuFU+GukyxntgmDBJOZyso2aT1TQk3zSgsC1G1xvVExkVKxfw9qtEFPhQ==
X-Received: by 2002:ac8:34f2:: with SMTP id x47mr14259643qtb.282.1599333979497;
        Sat, 05 Sep 2020 12:26:19 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 134sm2389199qkj.53.2020.09.05.12.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 12:26:18 -0700 (PDT)
From:   trix@redhat.com
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        natechancellor@gmail.com, ndesaulniers@google.com,
        guennadi.liakhovetski@linux.intel.com, kai.vehmanen@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>
Subject: [PATCH] soundwire: stream: fix an invalid free
Date:   Sat,  5 Sep 2020 12:26:13 -0700
Message-Id: <20200905192613.420-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analyzer reports this problem

stream.c:872:2: warning: Argument to kfree() is a constant
  address (18446744073709551092), which is not memory
  allocated by malloc()
        kfree(stream);
        ^~~~~~~~~~~~~

In sdw_shutdown_stream() the stream to free is set by
a call to snd_soc_dai_get_sdw_stream().  The problem block
is the check if the call was successful.

	if (!sdw_stream) {
		dev_err(rtd->dev, "no stream found...
		return;
	}

When snd_soc_dai_get_sdw_stream() fails, it does not
always return null, sometimes it returns -ENOTSUPP.

So also check for error codes.

Fixes: 4550569bd779 ("soundwire: stream: add helper to startup/shutdown streams")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/soundwire/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 6e36deb505b1..950231d593c2 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1913,7 +1913,7 @@ void sdw_shutdown_stream(void *sdw_substream)
 
 	sdw_stream = snd_soc_dai_get_sdw_stream(dai, substream->stream);
 
-	if (!sdw_stream) {
+	if (IS_ERR_OR_NULL(sdw_stream)) {
 		dev_err(rtd->dev, "no stream found for DAI %s", dai->name);
 		return;
 	}
-- 
2.18.1

