Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E1CC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333E7206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585316092;
	bh=50d7atbbqCu8sVfTjeDFx1DNlGegS0O1DKeZQZ52JP8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hRSi1MKLyjv8v7P8Qd86PFcIdXgz710VlC5FiRB1xgN31LmsZPjAWBOLJkqj3x+DO
	 YqCD368FrBvbPGThqPDIexfvjbd2nWL4CkfOB88Xq7JVe2oX3x2YBoC8Im3/K1EdNP
	 vEzWILV2tdKQbkW5hu5JCrpMopL4+3E8sa9xLFGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgC0Nev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgC0Nev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 09:34:51 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28EF120658;
        Fri, 27 Mar 2020 13:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585316090;
        bh=50d7atbbqCu8sVfTjeDFx1DNlGegS0O1DKeZQZ52JP8=;
        h=From:To:Cc:Subject:Date:From;
        b=WBUFkK5g/Fd0EJOxssi6MUZ8HPDTne7wpMIkbWcxTeqKQxpHTFrdDUGhYKsfAiNsr
         DUQJCsqXySsHXU3oZs7SEwrbj4VOHzh+wky1vfgBqQNR+bklIcYFGZZaQRh0o6yd4W
         xRJC502G1n6dGOTlOIc6cmGye2/plnCxTk7nVWFw=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jHp8J-0049th-V8; Fri, 27 Mar 2020 14:34:47 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Simon Horman <simon.horman@netronome.com>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] docs: dt: fix a broken reference for a file converted to json
Date:   Fri, 27 Mar 2020 14:34:47 +0100
Message-Id: <33fa622c263ad40a129dc2b8dd0111b40016bc17.1585316085.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 32ced09d7903 ("dt-bindings: serial: Convert slave-device bindings to json-schema")
moved a binding to json and updated the links. Yet, one link
was forgotten.

Update this one too.

Fixes: 32ced09d7903 ("dt-bindings: serial: Convert slave-device bindings to json-schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index beca6466d59a..d2202791c1d4 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -29,7 +29,7 @@ Required properties for compatible string qcom,wcn399x-bt:
 
 Optional properties for compatible string qcom,wcn399x-bt:
 
- - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
+ - max-speed: see Documentation/devicetree/bindings/serial/serial.yaml
  - firmware-name: specify the name of nvm firmware to load
  - clocks: clock provided to the controller
 
-- 
2.25.1

