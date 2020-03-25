Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FB6C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F02A20774
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="PUFK7JiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgCYSMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:12:01 -0400
Received: from mail-wr1-f100.google.com ([209.85.221.100]:39063 "EHLO
        mail-wr1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgCYSMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 14:12:01 -0400
Received: by mail-wr1-f100.google.com with SMTP id p10so4398406wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BlUfBdbKLhRxMxTSsuT+ab6HxEoROd1o/+3/SBIv3Ug=;
        b=PUFK7JiNhpsF2FlrU1Q9bh39ZOI6jNjKfa1GMbgqJOjXFoLTg980Q//l/B6dZdYmJr
         Q1n/bHLR6DCJwHRCcp3BW0q89P7eAy5h4MF9FUYE3bExSkbjn2vd24AHhQdrIRCXrREv
         SpufX1YryF2O6P0vir4uhGB4YqI+QvrD9nz60B5wFNvz4GcgLupvRBOEUivlYPd/tnxy
         eBgUgyW0yvic953d8u1LD/EtN3S6kyu1SEP8s5pr4SQD2LQWXOGQFvzm6lJyriiCDoUI
         i5w3ehwOpqYOIiPZ15f9MOlMWpaQStee/VI7tF6cry9oQ4/dRn77iFSq6Ueh5CrsRkYp
         KNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BlUfBdbKLhRxMxTSsuT+ab6HxEoROd1o/+3/SBIv3Ug=;
        b=DDFXJ4w5KZMfsclrzLmQ1o08vq4MI+IZSo2miZXejA8lZHWGpKDrXhgtQ/LHVUSCPe
         O/b4SBQVvgRUJS3aYBr1wWAKfaPm51GKoytZexB94LCDZqNOAjLFyC6zBMLQe/KLPxn7
         InmKacGeEQAoGviYeRGNRi4obEsfIsfMRXSuluteBbKaeDlfxf9uPeaJrl2KF4CCLeDW
         4Dmpa3gjFhLBEOb2cnD0bIDoVVD89ARZUuTR1AIYrgQ1JFkWPaoMuzf4EZFVLb1k/fwd
         0udISgNkCg0jq6TSSloQu2vPqQQnrATwEcM9wl0hw4bod9RD7piiqrTmt36efbWbwRPS
         lR5Q==
X-Gm-Message-State: ANhLgQ2iKL8FATNBU+pbD5clbHkMG/opejbuujdGi6p0y/crVQ+L2TEg
        UwI4GmHakeu6sMmxPqmjxzuaz415LjC6Vme2Uhw1FTxGabk4
X-Google-Smtp-Source: ADFU+vuXZzrXWPaDv1t6sY87owmRsrjwWY5Prmz78UuvMutD9DLYGNfPcoaw/eL8oyqGShQwhQRS4Um63pdj
X-Received: by 2002:adf:e34c:: with SMTP id n12mr4466668wrj.97.1585159918373;
        Wed, 25 Mar 2020 11:11:58 -0700 (PDT)
Received: from mail.besancon.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id a140sm2717wmd.22.2020.03.25.11.11.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 25 Mar 2020 11:11:58 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.13.190] (port=39524 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mail.besancon.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1jHAVR-0003Oy-P3; Wed, 25 Mar 2020 19:11:57 +0100
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     Fugang Duan <fugang.duan@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 0/4] Fix Wake on lan with FEC on i.MX6
Date:   Wed, 25 Mar 2020 19:11:55 +0100
Message-Id: <1585159919-11491-1-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes WoL support with the FEC on i.MX6
The support was already in mainline but seems to have bitrotted
somewhat.

Only tested with i.MX6DL

Changes since V1:
	Move the register offset and bit number from the DT to driver code
	Add SOB from Fugang Duan for the NXP code on which this is based

Martin Fuzzey (4):
  net: fec: set GPR bit on suspend by DT configuration.
  ARM: dts: imx6: Use gpc for FEC interrupt controller to fix wake on
    LAN.
  dt-bindings: fec: document the new gpr property.
  ARM: dts: imx6: add fec gpr property.

 Documentation/devicetree/bindings/net/fsl-fec.txt |   2 +
 arch/arm/boot/dts/imx6qdl.dtsi                    |   6 +-
 drivers/net/ethernet/freescale/fec.h              |   7 +
 drivers/net/ethernet/freescale/fec_main.c         | 149 +++++++++++++++++-----
 4 files changed, 132 insertions(+), 32 deletions(-)

--
1.9.1

