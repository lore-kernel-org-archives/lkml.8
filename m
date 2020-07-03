Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C1DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBBE20782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NM2L1hAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgGCNeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:34:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25947 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726022AbgGCNeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593783247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=b6C/Ke+4UY+EMY2gXlTOC95fqvFQa1Hgh6TTQR1ucBY=;
        b=NM2L1hAdqEgFk32WqVtjlEejDXy1gyKDp5XS3YAC6iE+iGkPr2xTaYyvi7ehMvwqYr38jw
        Ecu4nDI3NDkwsZDK5ls6XFXQIyB3SQJ4mIxBxQehuaMm56bpCrKnAyvdCx7CHTUSvqJ0AR
        Vykr9e5wUfczBe7EM7buqyvGkgbHMRw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-iunxBMIeN6aubNj5qmWoyQ-1; Fri, 03 Jul 2020 09:34:06 -0400
X-MC-Unique: iunxBMIeN6aubNj5qmWoyQ-1
Received: by mail-qv1-f70.google.com with SMTP id w18so20544656qvd.16
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 06:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b6C/Ke+4UY+EMY2gXlTOC95fqvFQa1Hgh6TTQR1ucBY=;
        b=FbOLX9M37RQLmCIx9ggHAJr+gAzowhWFi1Vaj926GOu4dNG0Pq5MDbjXqK81kKQLFO
         cLXeVXVD47qp/8wr2FlvJ7dCat+hI5A+8IyoQHAPVxIk7WoB/u3UodsEU++6pAfpqFw9
         MmnVCadUBKUUkIEEDYBTaxR3cx6teVxGx2nS9vXGBLvtrfuEIC9vuFcJyl4tAEvKvDdI
         Q7JTAXdIw2XPze0HKiBN7RepVpA4Cn67CS/3zgU2SvZFouG4TSEIw8+x+Y2rMULskpX9
         XQhB9tOTJo+9tODtrMK3i44ggx7eGZrIsksS/NiSx71KYGCdxelTi5uS0+qXXsWYirDQ
         AfJg==
X-Gm-Message-State: AOAM533OKU92SCl6ErxsrrXNW4UA1nPs+6YxqojC+zhcYLGd7KI4NIc5
        ziXcUaQZaTz2vNwoUT74EzCT0aBVUt5xbQKKoqYZsJq49+MKvbdU5Kmuk5PRJGAGPKqntjwJvXh
        3fr5U8PzlXO9AktfSQYrXRdFQ
X-Received: by 2002:a05:620a:218e:: with SMTP id g14mr35187136qka.430.1593783245595;
        Fri, 03 Jul 2020 06:34:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlTZUIIj7eIyFLZ29LTns3xpC8Vhrn52+AncVRKpMxxruUBcZ8Se0pRH7bfF6O9AfT2fFIjw==
X-Received: by 2002:a05:620a:218e:: with SMTP id g14mr35187106qka.430.1593783245345;
        Fri, 03 Jul 2020 06:34:05 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y40sm11869060qtc.29.2020.07.03.06.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 06:34:04 -0700 (PDT)
From:   trix@redhat.com
To:     mlindner@marvell.com, stephen@networkplumber.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] net: sky2: initialize return of gm_phy_read
Date:   Fri,  3 Jul 2020 06:33:59 -0700
Message-Id: <20200703133359.22723-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this garbage return

drivers/net/ethernet/marvell/sky2.c:208:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
        return v;
        ^~~~~~~~

static inline u16 gm_phy_read( ...
{
	u16 v;
	__gm_phy_read(hw, port, reg, &v);
	return v;
}

__gm_phy_read can return without setting v.

So handle similar to skge.c's gm_phy_read, initialize v.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/marvell/sky2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 241f00716979..fe54764caea9 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -203,7 +203,7 @@ static int __gm_phy_read(struct sky2_hw *hw, unsigned port, u16 reg, u16 *val)
 
 static inline u16 gm_phy_read(struct sky2_hw *hw, unsigned port, u16 reg)
 {
-	u16 v;
+	u16 v = 0;
 	__gm_phy_read(hw, port, reg, &v);
 	return v;
 }
-- 
2.18.1

