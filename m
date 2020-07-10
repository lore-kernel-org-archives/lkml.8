Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1A1C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98BD9207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eV1HUoAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgGJNpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:45:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23204 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728347AbgGJNps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594388747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=lPlpIEpm5oUE43hFAFoTmnj/BXFQuZwXgNqQp7AmsxA=;
        b=eV1HUoAvb1X79Ymyh13c9/loyeraqd5ry/YzwGjjeyCLgIzMEnBqSJ3af6aFpYyBcAjiXg
        MUnt9QNa8iCSy8rEiX84MSgfyQB2bXm9W4kOWhpLcWBTQDyIb3P7+rJRPQungpt3A9q9/q
        3Q9An4R62d8Ho4KUsqNkiTbvnwWWjlw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-h2ma22ChNaW4BtyYDU5DmQ-1; Fri, 10 Jul 2020 09:45:45 -0400
X-MC-Unique: h2ma22ChNaW4BtyYDU5DmQ-1
Received: by mail-qv1-f70.google.com with SMTP id j18so3703488qvk.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lPlpIEpm5oUE43hFAFoTmnj/BXFQuZwXgNqQp7AmsxA=;
        b=trvslSsHBiSCYO7p1lusyg+4oiWy5zKBNzDAgy3gXoLsnFKEm+IGsKquz0N9X7nbhm
         IX+isXDTlW58LjOK66vvo/MR8pt+e4703smmp8VUXAMHI+oQxINRnkOlVjhmK/kxj/mc
         hvCYfvXmM/iDi1cARGx+2LTJ8yc62EH/PR6GSqtWj3hlpUr1IswTZs+II1PQvVBVf8QY
         gsxxNdiCwTEdJs0yTnqk8geYvuCo2cyMlEvn1OFpzPC8OQQGrRXwZ36QYnYav6/zoVAW
         XjUvXICO3q3jl0U7R3UfGLuMbPPRhTnGtOB36k98erjRt8xkh/E/33jU576vVeZpxKoD
         rkbQ==
X-Gm-Message-State: AOAM532QUd0J6CCJ7P84pjfOMiFSprlLEWC3ta0EFEWUh+msUkX/Y+tP
        Gij8guUO6iOu4hVwk4NhItOo6qHzbgHkh5pgnIMntCdVTYebWumQQ0Tb2XAfHnM1sZKOmSej727
        cDS8QEf28f4Qrvy1ykQNIAPTG
X-Received: by 2002:a37:9c51:: with SMTP id f78mr32001856qke.60.1594388744832;
        Fri, 10 Jul 2020 06:45:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwljFDiZqQSkAeAYfMmOidn6SEJGK6KdJbZ8RNJcV62h3bEKS3lxdeCTcgI/Er7wU4nz0Ue+A==
X-Received: by 2002:a37:9c51:: with SMTP id f78mr32001825qke.60.1594388744570;
        Fri, 10 Jul 2020 06:45:44 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o12sm7258887qtl.48.2020.07.10.06.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:45:43 -0700 (PDT)
From:   trix@redhat.com
To:     robin@protonic.nl, linux@rempel-privat.de, kernel@pengutronix.de,
        socketcan@hartkopp.net, mkl@pengutronix.de, davem@davemloft.net,
        kuba@kernel.org, ecathinds@gmail.com, lkp@intel.com,
        bst@pengutronix.de, maxime.jayat@mobile-devices.fr
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] can: j1939: fix double free in j1939_netdev_start
Date:   Fri, 10 Jul 2020 06:45:36 -0700
Message-Id: <20200710134536.4399-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this error

j1939/main.c:292:2: warning: Attempt to free released memory [unix.Malloc]
        kfree(priv);
        ^~~~~~~~~~~

The problem block of code is

	ret = j1939_can_rx_register(priv);
	if (ret < 0)
		goto out_priv_put;

	return priv;

 out_priv_put:
	j1939_priv_set(ndev, NULL);
	dev_put(ndev);
	kfree(priv);

When j1939_can_rx_register fails, it frees priv via the
j1939_priv_put release function __j1939_priv_release.

Since j1939_priv_put is used widely, remove the second
free from j1939_netdev_start.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/can/j1939/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 137054bff9ec..991a74bc491b 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -289,7 +289,6 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
  out_priv_put:
 	j1939_priv_set(ndev, NULL);
 	dev_put(ndev);
-	kfree(priv);
 
 	return ERR_PTR(ret);
 }
-- 
2.18.1

