Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84D6C35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD32D21927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="l2AwvKtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgBYIqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:46:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37354 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbgBYIqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:46:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id q23so13114543ljm.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 00:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mU4JnOUOVxqxZ36QdYJ5U3KLqP1IM5LUm7cfygDKacI=;
        b=l2AwvKtt7YhgpVdY6QmP0Rf1NjNk7T4OVJIkhMNiJyRLund6iPDmdMy9keVPMcYtAS
         NAvVn16fpHqaTIhjXwzvUoeyX1j6wDwuI9bunUCXUJvmnQr7gs6mrz0Tc5ajJAp7JW1k
         tGf874bnYurX9Kc8ITGWK31xjYmv6JTytrQtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mU4JnOUOVxqxZ36QdYJ5U3KLqP1IM5LUm7cfygDKacI=;
        b=ulzZxj8SD2ypOA38HRFyAv3Jossiv1CvFBKHTEi+rGaH09buRDWDEkD1mbVV4t5c5E
         6vcq4G3mdbDKz6TgAWQ6k/quAB5DE7jjVHyHg646yhHKMrIlqIEwTbll0ebr+DSa1F1w
         0aroAjdCajjCz2K4YqqgxyhXCDd0Z7fpavh+9ubTrYj91QkOnvTh7xOVMkmrmrv3JAGM
         qbRp7wx+Y28atjjHTeB5gOmSfYYomzxUG0k9mnOmgla5TYCa/PoPLUqZnaLIQq4AKq9x
         PGgpLV3MYEc3jS7LrG/htWpZnPcZRFwyprV7DvMcrnp95mbUB16xKzHuT4SU4yGJBxPS
         /AAw==
X-Gm-Message-State: APjAAAWGNcKO0wUC+zNASoSzrNfUSLrmjgZA0S4sk/9fuawn6iJNpato
        3oBq3p2l6GJXoRvp4SQN0k70cA==
X-Google-Smtp-Source: APXvYqwmGHxprXso3OM+eG1dgajWRSODUWYeOuWKpRznqafT7X3t8pIBTwo1iSirn0AvR5QNiy34WA==
X-Received: by 2002:a2e:9b95:: with SMTP id z21mr32851409lji.291.1582620393600;
        Tue, 25 Feb 2020 00:46:33 -0800 (PST)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id g78sm3410189lfd.21.2020.02.25.00.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 00:46:32 -0800 (PST)
Date:   Tue, 25 Feb 2020 09:46:28 +0100
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
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] dt-bindings: vendor: add vendor prefix for LiteX
Message-ID: <20200225094437.4170502-1-mholenko@antmicro.com>
References: <20200225094437.4170502-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225094437.4170502-0-mholenko@antmicro.com>
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
    Changes in v3:
    - added Acked-by tag
    
    No changes in v2.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9e67944bec9c..d9107f0fed2e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -549,6 +549,8 @@ patternProperties:
     description: Linux-specific binding
   "^linx,.*":
     description: Linx Technologies
+  "^litex,.*":
+    description: LiteX SoC builder
   "^lltc,.*":
     description: Linear Technology Corporation
   "^logicpd,.*":
-- 
2.25.0

