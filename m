Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC53CC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E062082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581504245;
	bh=3WmScTJz4euc1fE6/Vis4Trrr8L3e+POIZjWyczQr90=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zaNeMq2SLcYUGSn3jAemh2biUa9ku/Mpk8/Ajo8YyiMTFWB+A4cHY9Q3lbZw5W5sd
	 iYI069tKMgZCMp36rsh52F6ivBlirqPx3w07hF67vUR8Ul9KX5g1C5kt1K2kPPnS4m
	 6b/FSYudVsY+539Ka+ECz+afT8Uho7x5japhzcQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgBLKoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:44:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43401 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgBLKoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:44:02 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so1718962ljm.10;
        Wed, 12 Feb 2020 02:44:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xSMdDt84jzVon3FDMXee+uRWwXiN2FB36JLOXBaNo4w=;
        b=QTa6msXX2SnavS2Cn2/NRdkse4GdWbVAwDUkacif1aGEc5cg36jfxb8JXhgkaIbekh
         s0zqdz+uGRzl9IJmucVEJ0pT42di64SUzh5Ql7WT94/T1f9X/dNlrXCerfj9Kvq7QMB5
         LZ2JOTUo/J5GLWNFxLdOpq6uyUHXlae/SferaBk65ZgQrHkrijIPLsXwByybzSMleGX5
         TFfpEBj08h3zJc/cByN8TtxGly1HsOn6SU6RVug3n15k8nAz9dCgItBqWKxAsc54qVoH
         hKTxIBi900ItrfBXVaeoaFOtKmm9GFoVGwsfWQAUyTAi4mdv1QBv4jw8I0sclDCj2Zgw
         WLJQ==
X-Gm-Message-State: APjAAAWMMkmglnsixXqvMqlQ3hpBFtvCTXxqJcpplNjLuV96DD9sXmlU
        OyJa2XsQLnzlzPA7VbXSLoyHIFSK
X-Google-Smtp-Source: APXvYqz0m90S7S3vc/bZc65CJPxi9oF38n9ilCWGT0Pxsc7Hwb+hUwkjC2+zBKXnvZA39KyHwTI/XQ==
X-Received: by 2002:a2e:7818:: with SMTP id t24mr7180342ljc.195.1581504239548;
        Wed, 12 Feb 2020 02:43:59 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id 3sm17542lja.65.2020.02.12.02.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 02:43:58 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1j1pUr-0005CO-VW; Wed, 12 Feb 2020 11:43:58 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Barry Song <Baohua.Song@csr.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] ARM: dts: atlas7: fix spaces in compatible strings
Date:   Wed, 12 Feb 2020 11:43:45 +0100
Message-Id: <20200212104348.19940-1-johan@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I stumbled over a new driver in 5.6 whose compatible strings did not
match the corresponding binding due to spaces in the driver compatible
strings:

	https://lkml.kernel.org/r/20200212092426.24012-1-johan@kernel.org

A quick grep revealed that we a couple of devicetrees in mainline with
similarly malformed compatible strings.

Note that there are no in-kernel drivers or bindings that use the
strings question, so I think simply dropping the spaces would be
acceptable. This is especially true for the flexnox nodes that also
specify "simple-bus" so therefore I split the fixes in three patches.

Johan


Johan Hovold (3):
  ARM: dts: atlas7: fix space in flexnoc compatible strings
  ARM: dts: atlas7: fix space in gmac compatible string
  ARM: dts: atlas7: fix space in g2d compatible string

 arch/arm/boot/dts/atlas7.dtsi | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

-- 
2.24.1

