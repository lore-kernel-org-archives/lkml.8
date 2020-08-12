Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9ECC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92081207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="vyER/vRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgHLMeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgHLMeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:34:15 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3304FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 05:34:15 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w14so2034118ljj.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 05:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vRsgpWlrVrAeF+nyXlaCfqr74kFavuamyQhp5nZhvi8=;
        b=vyER/vRrat855EEo97VUfuvsVjpZIDdDTeYVf9cFwUz0hMLDtB0fG10+y+3cDMZVBv
         bKX01SSQMed1a8GpBC/XAq1iggczWA1d+fwcbQX3Y7qbAyDQZPLWYTrCP8H14Q55Aykp
         RMC36FfOeRsjCt6a2LXfIM5FxQU7WE4yWDnsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vRsgpWlrVrAeF+nyXlaCfqr74kFavuamyQhp5nZhvi8=;
        b=gBBlXV6tLq9WEPT3DB/0JYmGiaGAxalBpFAilm88ZVYtFaADhyyuRdZ+9/I9pP/Y5c
         QXy8rfEUlP4m9zEcyvursppZ2E7PA3TF3b0XkF2FS6d+4WiBsHldDTHA3Tl0QCQUMPRT
         CvX4uQBYGRFbLpqwR5nG9iB/3TYRkIVujCgapmlf0pX4TnH6ujeZt75Ig+46bhC6/s40
         6qj2PUx+3pX6EGUxIaUOW1BUtDkxD9JErb29RsNU30f3uepSyvwcdOP20m1UIPXtNOZO
         5JX64EIlXvemB3Qwa4EWlrxTqVhED/ja2amfKlycIo42E7eLIIlrsAl1LZ8GV3cIPrBS
         PO6A==
X-Gm-Message-State: AOAM532P0wqwUgbY42BwwdkU4DXggoPpdFP2DDTGziN3zKryR7eVen2w
        Qp0BEliEdBmuJuB3eZBo+wEpqA==
X-Google-Smtp-Source: ABdhPJw0fk6/6Osk2A/0AAAhovM8IKAPgjhnZgC4o/dkjjb8TezQnlLbJdMPkhDLkauuHAlZpBDqXw==
X-Received: by 2002:a2e:720f:: with SMTP id n15mr5155305ljc.73.1597235653681;
        Wed, 12 Aug 2020 05:34:13 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id q22sm445593lfc.33.2020.08.12.05.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 05:34:13 -0700 (PDT)
Date:   Wed, 12 Aug 2020 14:34:06 +0200
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
Subject: [PATCH v10 1/5] dt-bindings: vendor: add vendor prefix for LiteX
Message-ID: <20200812143324.2394375-1-mholenko@antmicro.com>
References: <20200812143324.2394375-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812143324.2394375-0-mholenko@antmicro.com>
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
    No changes in v10.

    No changes in v9.

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

