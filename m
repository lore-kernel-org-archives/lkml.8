Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DCFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34B52084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="p5RaWs4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391067AbgE0Q0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389903AbgE0Q0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:26:18 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C6BC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:26:17 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id e4so7209698ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NGxN51AQqztcyfn3BiBc00+QK/qVzhsSjQFFAAJJPdc=;
        b=p5RaWs4Kz5ihoV1zi6MiQwoe/iA+eISPpBLiQy51yd2LsKvii+gTGoZyanYKzG5Uax
         F4e7t8RBbzpcRyuXsTchPLmkzAVlzODr7VQMw5BCSt0Qvy0OG8T7CYO9hcdo38ZUZvi4
         90HdLxvQtYFrwdG8e5JO0/h7ZlISHwDrKdMHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NGxN51AQqztcyfn3BiBc00+QK/qVzhsSjQFFAAJJPdc=;
        b=CIMl7gG6iQAtiTZAbEjC8KwT2No5RXVRL3g0mPDVOBPxrgV2pDB+F7iQ2t79SfYdTp
         yr330UXG18/k6eqTnkPdVS11Dbw6d1Qh8xlj0L1OYgafSSi3gK04Hf3fVVwPnC18ZayJ
         y13p2AoE9MrCCCsInp0AK7mXsKrV503p0wbk7o5oAoMz/v3MfrKmrOEHk2kRXFNm9xUw
         veRajfkgh9MOGbTLCsTJgCFZxGxP8W65URCy6Gk9gdKRUbcJfhCIjgLDLmo35eX3dk4E
         UY3it1TT/JpFjDL9g/WEd4T03w6IYrw0OS8YJ3OFe7Bx2q9dXjhT8+FX/VXNt0O92ZJS
         XTtg==
X-Gm-Message-State: AOAM532tDJnZhJb+Zmt+3Lv6TxOrX6pUjLyyFcBPg3TmOCJJjRhLeJvv
        KGBtOu1cQIVkiG/KdqlxtQpwbw==
X-Google-Smtp-Source: ABdhPJy6b7SXdu38UyYKHoPPN47aH8U59t6YMiO3QKwT95eJ2ZYPViquJBWFqZzclAKXW9p6SxMRMA==
X-Received: by 2002:a2e:7614:: with SMTP id r20mr3276762ljc.394.1590596775507;
        Wed, 27 May 2020 09:26:15 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id j14sm877779lji.63.2020.05.27.09.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:26:14 -0700 (PDT)
Date:   Wed, 27 May 2020 18:26:09 +0200
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
Subject: [PATCH v6 1/5] dt-bindings: vendor: add vendor prefix for LiteX
Message-ID: <20200527182545.3859622-1-mholenko@antmicro.com>
References: <20200527182545.3859622-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527182545.3859622-0-mholenko@antmicro.com>
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

