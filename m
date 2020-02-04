Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D9BC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C07121D7E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQhh3jNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgBEAH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:07:26 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:34772 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgBEAH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:07:26 -0500
Received: by mail-pf1-f179.google.com with SMTP id i6so209799pfc.1;
        Tue, 04 Feb 2020 16:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sKuRVgZYpENen5Cz3VDrnFcc4DVuMBzApnyyyVJ6zaE=;
        b=KQhh3jNzBpodgAhuHIuGWKRjfiTD86TDKA23osA7JkY++h0/PKlBfkiOw89Ar6A8uE
         +cOzJ0G2EJOWw8pSiRKAUxQrNKVeScWlUhD4z89/PGY0V/xabP8ie1QMB2+qcyhqD+Nw
         EKzmpEI81e3DPWau+NGt4BDodD+9mrFlpmsJv88LzkKb5i8XYfx3rRmfUMubQAK47fn9
         QZbrk9+y1sMf3NKU5/eDLMnbEIh1I3CkDjcqmB1+DSgIqnvG3yNe1pG4HaO06E1OxLfn
         wMXjP0Rg1jEkREK8u5c0aHmGp6nXkl/dbdozjSfTtaeX9LmjEFnc4vuKmgRab5TE5HWq
         YP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sKuRVgZYpENen5Cz3VDrnFcc4DVuMBzApnyyyVJ6zaE=;
        b=Ru/WFcpelefZoMg2k0mFSuAI067XCmTxpnfzYIc6Kvtzpd6Z3EXoSpbNvfAuRonNKD
         VJh8BUtw1SQNbm/t+HOSkXOVxqnAqF4R8Nt5Le1gG0X69PGhebh7/mkFVj0QAbgsFJE7
         xD8HEUZFDI3N0v9mRuPtyFH/XwwxJszTRjeaXHI2zkXuRc8tIQQRpZxsUPRk8JGzt5IT
         0xHPjAARrUvh7Pa2Eu9Il4w3Hby4dYr3/hNAY2nA5bdqVTTw7pF/gDatxkwTw9rnFzJ+
         +TGgL7cLxUFoGnTk2ePawab37NGYOo3Ry+2l/futnUazesHNZpG5nCTPIVAl1WE5YzLk
         nu0A==
X-Gm-Message-State: APjAAAULUsaD0KxyY3GQcJd1kgjZ9wp2qRxdlQ5zRYv1fIO206x7sMq0
        dL4ARcjteOX2ucbzHcz7JSI=
X-Google-Smtp-Source: APXvYqx0K3cPPads9nxdC8fJvQ9IeGOtnRotQy3PL9b2ojqNWhd1Q+HuBQScM883KEjPz4kC4xdNnQ==
X-Received: by 2002:a63:d40d:: with SMTP id a13mr34868627pgh.9.1580861245087;
        Tue, 04 Feb 2020 16:07:25 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id g2sm25575468pgn.59.2020.02.04.16.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:07:24 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE), Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Maxime Ripard <mripard@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "james.tai" <james.tai@realtek.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v2 00/12] dt-bindings: arm: bcm: Convert boards to YAML
Date:   Tue,  4 Feb 2020 15:55:40 -0800
Message-Id: <20200204235552.7466-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Maxime,

This patch series converts most files under D/dt-bindings/arm/bcm/ with
the exception of bcm63138 and brcmstb to the YAML format. Those two may
be split accordingly later on since document not just the root node.

Changes in v2:

- fixed typo in Vulcan binding
- simplified how SoC compatible strings are specified
- fixed filename in bcm2835 firmware binding
- added 'secondary-boot-reg' constraint


Florian Fainelli (12):
  dt-bindings: arm: bcm: Convert Cygnus to YAML
  dt-bindings: arm: bcm: Convert Hurricane 2 to YAML
  dt-bindings: arm: bcm: Convert Northstar Plus to YAML
  dt-bindings: arm: bcm: Convert Northstar 2 to YAML
  dt-bindings: arm: bcm: Convert Stingray to YAML
  dt-bindings: arm: bcm: Convert BCM21664 to YAML
  dt-bindings: arm: bcm: Convert BCM23550 to YAML
  dt-bindings: arm: bcm: Convert BCM4708 to YAML
  dt-bindings: arm: bcm: Convert BCM11351 to YAML
  dt-bindings: arm: bcm: Convert Vulcan to YAML
  dt-bindings: arm: Document Broadcom SoCs 'secondary-boot-reg'
  dt-bindings: arm: bcm: Convert BCM2835 firmware binding to YAML

 .../arm/bcm/brcm,bcm11351-cpu-method.txt      | 36 --------
 .../bindings/arm/bcm/brcm,bcm11351.txt        | 10 ---
 .../bindings/arm/bcm/brcm,bcm11351.yaml       | 21 +++++
 .../bindings/arm/bcm/brcm,bcm21664.txt        | 15 ----
 .../bindings/arm/bcm/brcm,bcm21664.yaml       | 21 +++++
 .../arm/bcm/brcm,bcm23550-cpu-method.txt      | 36 --------
 .../bindings/arm/bcm/brcm,bcm23550.txt        | 15 ----
 .../bindings/arm/bcm/brcm,bcm23550.yaml       | 21 +++++
 .../bindings/arm/bcm/brcm,bcm4708.txt         | 15 ----
 .../bindings/arm/bcm/brcm,bcm4708.yaml        | 88 +++++++++++++++++++
 .../bindings/arm/bcm/brcm,cygnus.txt          | 31 -------
 .../bindings/arm/bcm/brcm,cygnus.yaml         | 29 ++++++
 .../devicetree/bindings/arm/bcm/brcm,hr2.txt  | 14 ---
 .../devicetree/bindings/arm/bcm/brcm,hr2.yaml | 28 ++++++
 .../devicetree/bindings/arm/bcm/brcm,ns2.txt  |  9 --
 .../devicetree/bindings/arm/bcm/brcm,ns2.yaml | 23 +++++
 .../bindings/arm/bcm/brcm,nsp-cpu-method.txt  | 39 --------
 .../devicetree/bindings/arm/bcm/brcm,nsp.txt  | 34 -------
 .../devicetree/bindings/arm/bcm/brcm,nsp.yaml | 36 ++++++++
 .../bindings/arm/bcm/brcm,stingray.txt        | 12 ---
 .../bindings/arm/bcm/brcm,stingray.yaml       | 24 +++++
 .../bindings/arm/bcm/brcm,vulcan-soc.txt      | 10 ---
 .../bindings/arm/bcm/brcm,vulcan-soc.yaml     | 22 +++++
 .../arm/bcm/raspberrypi,bcm2835-firmware.txt  | 14 ---
 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 33 +++++++
 .../devicetree/bindings/arm/cpus.yaml         | 33 +++++++
 26 files changed, 379 insertions(+), 290 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351-cpu-method.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,hr2.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,hr2.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,ns2.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,ns2.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,stingray.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml

-- 
2.19.1

