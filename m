Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C010C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1AF20720
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="iGIaQkXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbgGOLHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbgGOLHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:07:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C052C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 04:07:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id k17so834670lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pdpyDKWlzuaMU2ht3Q+igXAxvM9HrHqG+4QvM2jlT+c=;
        b=iGIaQkXiShFfnr9nnsBVqiHLyDV2i/diGsGdxbdsb0W4hI/d27WGuJm0qiXhrQrsOv
         e0CpENdGqh6nDa/vMZ/LZ13ZtcCBsHmu+2bSPFGVhZeHlaNzIgDu6acDW7Hx9D3Nm0J2
         nZNKMmOiUQuK+fOBeP6qsDxKMQ4zzWyG191+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pdpyDKWlzuaMU2ht3Q+igXAxvM9HrHqG+4QvM2jlT+c=;
        b=foTKjJE2WlBEajPVj69WNmzOGKdTM8AScYbCsy2ZJcX5Pj0fEoYo0egEeDrlTMYxs5
         FbKA4vSFUZ6GsYqjSfKJPslWM5vypWbrqQHHwYgLC4FiNQEgpl1sEO24yQxsOribaOHO
         wyv8O5uYZ7HoVO2+uEDxBELAz/bVuxShBteSXkHtB2s0AHJgCMfFbFXiHDsewzQv1Bzn
         4+7t9GdBiQEAVrUPtqD0orSz3gwpXzKIVhazKc4OnAL7FUUydggsu5fUCKEsGiXoaFTQ
         g5Zx6VYLx3y2XgkFwKGxESWYoknXgenu6YBmB9zKpLk1u7LtNeDGOqMet4CiwKL+PJil
         TyxA==
X-Gm-Message-State: AOAM530iUPCoiryXVy48wnB1rXvirwBkkOx/3ER65d2701ZnEcJFS4CT
        64xacmSL6UxAReedNaq8SkReTA==
X-Google-Smtp-Source: ABdhPJy67K3axBXP6mrRYj1MC8LtQasUqF1tjbZab+wInn3H9AUQjtmFctH5+hZmxMUFYBwGUCw+3g==
X-Received: by 2002:a19:ad41:: with SMTP id s1mr4549314lfd.191.1594811239973;
        Wed, 15 Jul 2020 04:07:19 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id l5sm513327lfp.9.2020.07.15.04.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 04:07:19 -0700 (PDT)
Date:   Wed, 15 Jul 2020 13:07:12 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, "Gabriel L. Somlo" <gsomlo@gmail.com>
Subject: [PATCH v8 1/5] dt-bindings: vendor: add vendor prefix for LiteX
Message-ID: <20200715130641.1953227-1-mholenko@antmicro.com>
References: <20200715130641.1953227-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715130641.1953227-0-mholenko@antmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filip Kokosinski <fkokosinski@antmicro.com>

Add vendor prefix for LiteX SoC builder.

Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Notes:
    No changes in v8.

    No changes in v7.

    No changes in v6.

    No changes in v5.

    No changes in v4.

    Changes in v3:
    - added Acked-by tag
    
    No changes in v2.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index d3891386d671..9aae6c56d7a3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -571,6 +571,8 @@ patternProperties:
     description: Linux-specific binding
   "^linx,.*":
     description: Linx Technologies
+  "^litex,.*":
+    description: LiteX SoC builder
   "^lltc,.*":
     description: Linear Technology Corporation
   "^logicpd,.*":
-- 
2.25.1

