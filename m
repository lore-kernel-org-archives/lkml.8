Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8954C38A2F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 05:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9644B206B8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 05:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXHHU4XZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgDSFxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 01:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSFxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 01:53:31 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD84EC061A0C;
        Sat, 18 Apr 2020 22:53:30 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k28so5208912lfe.10;
        Sat, 18 Apr 2020 22:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cp+YcW+uZwweqktYq1kPw5M/xoHZD09hBXWzWgZpn8o=;
        b=mXHHU4XZ0bVgIZ8xBu5v+wSWHF77YPQuCaV2Ohf5J7nhQ+9RRUnj64tgiGpMfkHtQo
         VSRKBf0X7fYqORWd+DiN7jwSHdexbNeClY7LsNIBBQGfFqKWNiGa0XFES5JuUdUykXzU
         VSFBsFPFDSMKAZwOI4PujeDFObKpDL0kQdJpVcs+PVwtT4dIkl7oE0AdQJm90oiNDEai
         7WoK51OpKMyZeYwFEAYddCaQgWRNJDTCJ3dCAd/qMhuPPr3mSG8pZzFjm/TdwlgL/hlj
         4P42cFOcxrgL2xbgPGdYh+ZYlBDP5cO3DP9VcYlG1l+9/hMmpZojE5MfJ/C3H/mFxUx0
         mTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cp+YcW+uZwweqktYq1kPw5M/xoHZD09hBXWzWgZpn8o=;
        b=F2YTXgfFBymTu7ebX/y9+PITf04hA5YFo680YRKy/EJIF6So7jX2RoZq9ENnkRqKT7
         yRp1B0MCewLnIQBBwoq9Ku6M03HSs7Dq2VpHlJFPh/h5i56W8NE36EcxVrtUp09l6DXS
         lEoYKnnCBENG6rZvwcokQDfTF/Hze3Nj+lTAXKhFMzAcPygvD33dEw2nB9KpGy8Px0gY
         lveBACvE+p33cbYqDDx9ZT+3Sa1d/0Lncc0wn9XFXDuyd4S9h3gXgk+lS8zPtbTv8BUN
         Nq5dVzE55pAUJb7/eSMrjx7v5MF4QNWg3Oky0M4i1YsepVLdjKAn45mRsE3x4T1qjoG6
         W6Yg==
X-Gm-Message-State: AGi0PuZV6rxOrZXXP9JQnxP+GyUJjZEtBdWAb1Qa37FbLXXMQz1PNLbl
        mK50HRBJ7rXyUQdbxgcsD90=
X-Google-Smtp-Source: APiQypJoxv0TyES2AdqlW9umna3BrKG7kN4I69FJTVPxKmNrdHFQYkkPxXYmypsFbZTO7en3OnIJPg==
X-Received: by 2002:a19:4841:: with SMTP id v62mr6609541lfa.66.1587275609345;
        Sat, 18 Apr 2020 22:53:29 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id h7sm3366247ljg.37.2020.04.18.22.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 22:53:28 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/4] dt-bindings: arm: amlogic: add support for the Beelink GT-King
Date:   Sun, 19 Apr 2020 05:53:19 +0000
Message-Id: <20200419055322.16138-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419055322.16138-1-christianshewitt@gmail.com>
References: <20200419055322.16138-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Shenzen AZW (Beelink) GT-King is based on the Amlogic W400 reference
board with an S922X chip.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index f74aba48cec1..6bf9bbcf4968 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -148,6 +148,7 @@ properties:
       - description: Boards with the Amlogic Meson G12B S922X SoC
         items:
           - enum:
+              - azw,gtking
               - hardkernel,odroid-n2
               - khadas,vim3
               - ugoos,am6
-- 
2.17.1

