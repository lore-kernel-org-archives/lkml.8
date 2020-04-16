Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5521C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FBB220656
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etEaeasS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392012AbgDPRDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732667AbgDPRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:03:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F763C061A0C;
        Thu, 16 Apr 2020 10:03:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so5686261wrs.9;
        Thu, 16 Apr 2020 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=998VS9NQrf44xyeybmnR7tkwj8PiFEeNjnEnBJHx1Ko=;
        b=etEaeasSiSnGiMygaw1TlDGQZ5cuMJRKnWb8gWIaGHwyAXZBfJeejm33AX4ONaR8aI
         JxtnLBp+/eySPyxInci7beLJ4a52M/l9P5oIPnZIWPnk3E/+YPJkf1D28FRUYTewa3gd
         jpgUngG5usb629smh5qO5gW8bxf5/gSYukgwdSU9/cG2PyZJCP0WeNbbOt7zmuLALD/B
         lF/vnL+ODCRBwZGOX8dtzV9+aiKO5gJu70kFoO7oPWBO7ck8UQbkCUqvVL9DbSE8OkBy
         3Wl2foDhlFoaaT+DXs8xvh3hVFeCXEg9Aa/5CqjGoV1OaCiJPCA46M8FFylgz6pFLtqn
         yPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=998VS9NQrf44xyeybmnR7tkwj8PiFEeNjnEnBJHx1Ko=;
        b=IQmA240EWAjl8SNnj20c29NjHgbOhbscj4+yw2e9Cc5i9+Y4SOK/r2tR/oA0f3PK84
         SbwR086Mfvw3Gu43b17kuPdCJtWFFilAUURhPzagM+SyUrIkQNZcxKE2kZ+rntUYo62h
         X/o2BoceZT913gs7DYGz66ArtPbjVqiQT4zYPtfkDlbg4Je/Nrypw/EgTr5q+p9hzrHx
         qB+ZTnYO7SFbnuGyLZ+qRteD+qZYAF7XkRhvV6ek1ZOdJcv/+X3xF2KTGo9V2A96G4j5
         IyFex03/xcLTKcsyJjfVvQlpjJJ3ZbcFDqDZaJNuRN1WRTlLuyRp5O4AlZr5WrFnQyO9
         N77Q==
X-Gm-Message-State: AGi0PuY7Y9C9FMDiK7lf+v4viw7/R8k6hSLnsxnS4YvmgIZkvr4I/XEj
        RRydsyo9FnZwKQnbArZ9Dsk=
X-Google-Smtp-Source: APiQypJ4BZpuLiC8lmK4Vpk0+VBIqECGuTW9aEjV8pEaWUoRQYlq6LDI6LbwtVgS38F2ll9IB9SpLA==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr34097581wrs.22.1587056609264;
        Thu, 16 Apr 2020 10:03:29 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g186sm4339600wme.7.2020.04.16.10.03.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 10:03:28 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: rockchip: fix phy nodename for rk3229-xms6
Date:   Thu, 16 Apr 2020 19:03:21 +0200
Message-Id: <20200416170321.4216-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200416170321.4216-1-jbx6244@gmail.com>
References: <20200416170321.4216-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm/boot/dts/rk3229-xms6.dt.yaml: phy@0:
'#phy-cells' is a required property

The phy nodename is normally used by a phy-handle.
This node is however compatible with
"ethernet-phy-id1234.d400", "ethernet-phy-ieee802.3-c22"
which is just been added to 'ethernet-phy.yaml'.
So change nodename to 'ethernet-phy' for which '#phy-cells'
is not a required property

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
phy/phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3229-xms6.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3229-xms6.dts b/arch/arm/boot/dts/rk3229-xms6.dts
index 679fc2b00..933ef69da 100644
--- a/arch/arm/boot/dts/rk3229-xms6.dts
+++ b/arch/arm/boot/dts/rk3229-xms6.dts
@@ -150,7 +150,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		phy: phy@0 {
+		phy: ethernet-phy@0 {
 			compatible = "ethernet-phy-id1234.d400",
 			             "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
-- 
2.11.0

