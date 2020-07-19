Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DA5C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29A4208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="Xc44/Knw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="CX6l72cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgGSRKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:10:50 -0400
Received: from relay5.mymailcheap.com ([159.100.248.207]:40762 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:10:49 -0400
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.199.117])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id A8ACD262A5;
        Sun, 19 Jul 2020 17:10:46 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 5D5FA3F1CF;
        Sun, 19 Jul 2020 19:10:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 2D1FA2A6D5;
        Sun, 19 Jul 2020 19:10:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1595178644;
        bh=aXuCOvvLAl4OmE5tmJwl21v9ZPBFCzifF5ABa0V0PTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xc44/Knw+AibcszcHj9z+RUJuKo17W5VK7c4SYulyBirEbT9YPPl0xKo+1hWU+Fy7
         OomwFdXOeknmF6DhOwvZ9wvFP51R+I1dtqd9XyveWusITWokwNhm521UXTu3tuZ8OF
         8eH7eMdztn2X+/qQlzXoUFLbPYc97AqGbfgZ//Yo=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cTExEHgjk77B; Sun, 19 Jul 2020 19:10:43 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Sun, 19 Jul 2020 19:10:43 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id B0BCA40B41;
        Sun, 19 Jul 2020 17:10:42 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="CX6l72cj";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.163.116])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 04B7B40856;
        Sun, 19 Jul 2020 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1595178631; bh=aXuCOvvLAl4OmE5tmJwl21v9ZPBFCzifF5ABa0V0PTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CX6l72cjdJ+z+xm3OQ3msOC7aRWmZBW5c50MqJUm/u3Phxm5cO6ij7TGMg8VTYLaR
         69OsZ8w7EoiYoL+uRv0dXoN4u0qIt4JbwWgPXsRqYOGLcDTsI0UFiTh+eVN9+z0ThV
         Vwh3L85YEW8rbz4LiZER3Q7cKOPz0vFWku9/iSLk=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/4] dt-bindings: ili9881c: add compatible string for Feixin K101-IM2BYL02
Date:   Mon, 20 Jul 2020 01:10:04 +0800
Message-Id: <20200719171007.276383-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200719170411.275812-1-icenowy@aosc.io>
References: <20200719170411.275812-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B0BCA40B41
X-Spamd-Result: default: False [6.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         FREEMAIL_TO(0.00)[gmail.com,ravnborg.org,kernel.org];
         RCVD_NO_TLS_LAST(0.10)[];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.163.116:received];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         MID_CONTAINS_FROM(1.00)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: mail20.mymailcheap.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feixin K101-IM2BYL02 is a drop-in replacement of K101-IM2BA02 panel
(which is already supported by panel-feixin-k101-im2ba02 driver) with
the same pinout. It utilizes an Ilitek ILI9881C controller chip, so its
compatible string should be added to ilitek,ili9881c file.

Add the compatible string for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index a39332276bab2..c60b3bd74337e 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
         - bananapi,lhr050h41
+        - feixin,k101-im2byl02
 
       - const: ilitek,ili9881c
 
-- 
2.27.0
