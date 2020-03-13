Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E858C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4583A206E7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3MTBnEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgCMQ5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:57:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39523 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMQ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:57:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id r15so13020126wrx.6;
        Fri, 13 Mar 2020 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v5r3JgQeN5AyhHUkOec2ZrM8UZtYSG9cRv+0kfvBEWw=;
        b=X3MTBnEVYQ4rbOtyNEmnpN7B9+OjMNFLUjDgwFhraxNDRc1Uunq6RQFgqFL/2GgiZQ
         c1kn/v3zq/HS9HI2uEuj+ZK67Zw3bRfVx/uTrj/I1IvpRCWP8Md2hly/TWi/4RzR2Pn8
         LqyNK8EEQKPbjSzojyRqgMXBFTWGBF37NBTDMo1w0kRBWchZbodDTOzMN/XkybGuQtBJ
         xvdA4DNtJmzAI0/NvGTNIIJzny6vn7fTN2xP3ZWyK0ZYESqbWgTPzxRvJZgcFYN2Bm14
         efYLXL/NO7PGMUWWPui0Z0vKrNr5dbcQtKnV5Wlc6RDl8SSUcBbzBDdtj3MB5zQjqFCJ
         Wl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v5r3JgQeN5AyhHUkOec2ZrM8UZtYSG9cRv+0kfvBEWw=;
        b=KHbuAeApqzFjmTlcAhrfDOVCWQ0GOMLniIJMNZpGvT0hb/BzTWB+PQ5b1M0IxRyTLy
         k8lb/JtD4vxurtem6p3ZzF6V4gX2gXjYrJR1r92w38MyRYmDkH5v4GyGfweALmXbyr/G
         XKd8jpPtQf6luta4xjpm1Y0GS60js5YBcxydH6/PkoggZdqBvkvQ73veTZMF4bWNjZKc
         9LH7TTTwtJ+aCruf76t2SdCYLupK9ETXbFa2Lco6QhHyeD1MyGgslK1+HzUV5srSrs9h
         qSeNGOgjczuYqPfwPPmub9i2qeWiFHHJApwKOpErGCHGrh//fIKOqWDgl42GUCVtNWYG
         tq5Q==
X-Gm-Message-State: ANhLgQ3eYI4PNxdOvEmFgZDYkuhL9Ze8oiCH4H19a8z+1UQnRXb666Tl
        TGD97g+Cd8c/HPImCal05YU=
X-Google-Smtp-Source: ADFU+vv+/33S+FmaomgMaZ8CRJQRNIavHxV/PecNqLCgDRWUkYUdAi+woMxfgYm50urtGsGc/dZDxw==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr18420463wrk.407.1584118627926;
        Fri, 13 Mar 2020 09:57:07 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f207sm19295374wme.9.2020.03.13.09.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 09:57:07 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     jacek.anaszewski@gmail.com
Cc:     pavel@ucw.cz, dmurphy@ti.com, robh+dt@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: leds: common: fix example for gpio-leds
Date:   Fri, 13 Mar 2020 17:57:00 +0100
Message-Id: <20200313165700.15569-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The preferred form for gpio-leds compatible subnodes is:
^led-[0-9a-f]$
Fix example by changing led0 and led1 to led-0 and led-1.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/leds/common.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index c60b994fe..4c270fde4 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -167,13 +167,13 @@ examples:
     led-controller {
         compatible = "gpio-leds";
 
-        led0 {
+        led-0 {
             function = LED_FUNCTION_STATUS;
             linux,default-trigger = "heartbeat";
             gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
         };
 
-        led1 {
+        led-1 {
             function = LED_FUNCTION_USB;
             gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
             trigger-sources = <&ohci_port1>, <&ehci_port1>;
-- 
2.11.0

