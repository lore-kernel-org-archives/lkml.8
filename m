Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0002C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A7F2065D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvLAqgvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgGHSpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:45:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57296 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725937AbgGHSpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594233939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=HBQ82n+w/WkL5Dn69AeeYd9jMfgvauwNJ/WlDchFV98=;
        b=cvLAqgvxXk9Bm9/LZ6EZjt1xmh/rT1YHjxdgxfmYITbGwB7Jk2AQm+LElNa8nk78OSpUP5
        aaWUNokb7gd0NsfEoUSLmsoDkeT7AoiTLj5vJRoA9cgM7JAlbf2AIaUSTv3wt0qDgdvtmY
        7wga7ml1YD5SAe0ZZZEC4OfPyqWMOCw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-kbeRbXlJN_SX6WllJtTNYg-1; Wed, 08 Jul 2020 14:45:35 -0400
X-MC-Unique: kbeRbXlJN_SX6WllJtTNYg-1
Received: by mail-qk1-f200.google.com with SMTP id 204so31617041qki.20
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 11:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HBQ82n+w/WkL5Dn69AeeYd9jMfgvauwNJ/WlDchFV98=;
        b=giCQco9F0SAVhmLY0SIKk8KhAskp8tfzTA9qkFzhTdYutCU8YdNAQl6VBE+TxHdt4I
         0pJg8fugHyu/SmO2Z/MfMFkfqEz7db6UG7OQ2tTCzK1+HVPAXGNM/fh4SMg/A5Yv+lvG
         BXkPVBB43F9iA8AUEyjYZuZxF90hCpMN+g+Yci2ciIq9SZ4nU5Iaz2MjrpKELYwh7/4p
         t12EU168l/KyJxJ4NsEtsOqoL+te6rMoLnKXY++yM9WmNr9wTNKPE3EcfQyyM0aSGrKv
         8IEzh1CANxekSquYWV2pMLcwbbTHZGYS515sfxtWVsKfvYepJiVNSgPFCOb0ZENfaCYz
         ykRg==
X-Gm-Message-State: AOAM532oCXQT2H/uqXXT4rPyIaofM3KoJRLurCdwPF2wUNeovIumrM9S
        l0E95NnJEmfE+8ccDWvE/poVdZotWqkNgjkuJetzCCMZZeS1Lg2sd10DX7r8cKqAidOH//ohSKJ
        isNTh6zbjZdqhCijGV8eZsFQB
X-Received: by 2002:a37:6190:: with SMTP id v138mr57615241qkb.121.1594233935197;
        Wed, 08 Jul 2020 11:45:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzY9/rs+89N7inQ6K4/MVqFYIpQ41LEB78Tv5FPBRiirxx0mGR+/M3OoZtEfY2K3ZzunfehpA==
X-Received: by 2002:a37:6190:: with SMTP id v138mr57615219qkb.121.1594233934908;
        Wed, 08 Jul 2020 11:45:34 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r35sm565217qtb.11.2020.07.08.11.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 11:45:34 -0700 (PDT)
From:   trix@redhat.com
To:     stuyoder@gmail.com, laurentiu.tudor@nxp.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] bus: fsl-mc: fix invalid free in fsl_mc_device_add
Date:   Wed,  8 Jul 2020 11:45:24 -0700
Message-Id: <20200708184524.1809-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this error

fsl-mc-bus.c:695:2: warning: Attempt to free released memory [unix.Malloc]
        kfree(mc_dev);
        ^~~~~~~~~~~~~

The problem block of code is

		mc_bus = kzalloc(sizeof(*mc_bus), GFP_KERNEL);
		if (!mc_bus)
			return -ENOMEM;

		mc_dev = &mc_bus->mc_dev;

mc_bus's structure contains a mc_dev element,
freeing it later is not appropriate.

So check if mc_bus was allocated before freeing mc_dev

This is a case where checkpatch

WARNING: kfree(NULL) is safe and this check is probably not required
+	if (mc_bus)
+		kfree(mc_bus);

is wrong.

Fixes: a042fbed0290 ("staging: fsl-mc: simplify couple of deallocations")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 40526da5c6a6..7390e56661a0 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -691,8 +691,10 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 
 error_cleanup_dev:
 	kfree(mc_dev->regions);
-	kfree(mc_bus);
-	kfree(mc_dev);
+	if (mc_bus)
+		kfree(mc_bus);
+	else
+		kfree(mc_dev);
 
 	return error;
 }
-- 
2.18.1

