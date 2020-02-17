Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C942C34024
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5542C20718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjJtfYRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgBQOoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:44:22 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:38297 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgBQOoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:44:21 -0500
Received: by mail-wr1-f43.google.com with SMTP id y17so20033663wrh.5;
        Mon, 17 Feb 2020 06:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uLn0bx/pcR1Oj8GSPChwzZXsWQQOfUH0hqM2U2d9x1Q=;
        b=DjJtfYRuI7xLJIwbZKOA6biK0kN2HSvZiDHQBiOW6gsVnKdMybGEgKstj6RVXyW80N
         KBAGZVUJf9Dj8Gq+iaLUor0WpcCzKlLwynZ2BCAhqP6WFwHmfNPeQf8JwNeC4yfvWcQ6
         r0oRkb7McRrhxespjAbz9v9KqR2OE1L/DwGpmbHKNpnbcDxn4wmTILul6+cyEMsInDwK
         mpmIpzJQAbAznDYTuK14r/YqFtUa/4Ec5+eUbvciZa2ZlmNeWI5aMwdD4GmnctrgJCfe
         N8xUXv3JHadxOsCkdd33cHsSRiAkyyB0amLHD3oDga2wOVgZYEuSrlBnk/B+JhzaaMJs
         fJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uLn0bx/pcR1Oj8GSPChwzZXsWQQOfUH0hqM2U2d9x1Q=;
        b=IGlaZwK+QFLDWfLM05amdMys6GHUoe0x64cjKq2sH0CKu1Cfr0zm3k3ABfAjRu0HiH
         VtUHDg1hQ0AJob4CSq3g0F/7kJZJ46LkNQ323UmQlZE6A8hK4+mwktYNL0KE+bCmiIke
         MBN7TrPAUtBCBCwZjI8wUqqan9o4Ar/MTVGwdj6mf1zYhQ4CNPusx059gasKe+lx2/v/
         yLgEfhMJGvOvlTnTeTh8NFgsHcZxJvB0KErK5HaChPEUwk+XmIYuD8DpWAsIZOPVwANi
         pe6xX9FVm4uKqUwU0nqXMp1USH+kDWCVdYtzrUfEL8iLepePjBxPdJ6Mxmog1XHsBCYb
         RSSQ==
X-Gm-Message-State: APjAAAUyu/fJyMU+6uZdqV06c+8aqrFmzudrhw2VudXOwu0rcJNYaoL1
        EphCK6mMZUIicywHpp+LwJg=
X-Google-Smtp-Source: APXvYqzy7qNM3taiWKI/a0mWrBlyNYrpSGE3vWQnx+SuTaQt8Xdles1PS+0lDFPXczNtV8Nj1S/AUg==
X-Received: by 2002:a05:6000:149:: with SMTP id r9mr21345492wrx.147.1581950659545;
        Mon, 17 Feb 2020 06:44:19 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id j5sm1381699wrb.33.2020.02.17.06.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 06:44:19 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH devicetree 0/4] DT bindings for Felix DSA switch on LS1028A
Date:   Mon, 17 Feb 2020 16:44:10 +0200
Message-Id: <20200217144414.409-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This series officializes the device tree bindings for the embedded
Ethernet switch on NXP LS1028A (and for the reference design board).
The driver has been in the tree since v5.4-rc6.

Claudiu Manoil (2):
  arm64: dts: fsl: ls1028a: add node for Felix switch
  arm64: dts: fsl: ls1028a: enable switch PHYs on RDB

Vladimir Oltean (2):
  arm64: dts: fsl: ls1028a: delete extraneous #interrupt-cells for ENETC
    RCIE
  dt-bindings: net: dsa: ocelot: document the vsc9959 core

 .../devicetree/bindings/net/dsa/ocelot.txt    | 97 +++++++++++++++++++
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 51 ++++++++++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 85 +++++++++++++++-
 3 files changed, 231 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/ocelot.txt

-- 
2.17.1

