Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4975C3524C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90D42082E
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY7speDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgBBVS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:18:59 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35430 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgBBVS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:18:58 -0500
Received: by mail-pj1-f67.google.com with SMTP id q39so5480465pjc.0;
        Sun, 02 Feb 2020 13:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=04i36zyfiz51z7eT5HV2OIVr29EI5WaNJsS0RGWr67s=;
        b=gY7speDpmI6/WM4qTRz0yzyX8KB0Ia+aJ/EDBvUCQfosP4MslP1VLcDpr8jMt6hiNs
         4is/6wRQCumsrm6bOErSMiI1qZv7f8zFUFsSZnglP5DWvV6tys3e6NJPlYyRVvpxmcee
         b4wlgqWLTVmnBTtuk4KXPZEqW4bphWx04WsIUxCqYhA3DKS/iXjfXKkTe1pqQoesZ16o
         Wptw6NpXeCjQ5Qhmv9WLY0BP9nsrhDaAkTzMxANW/feTmvh0VDnYJyFSymScnc/JM24l
         J6q/vRL0vwv8LKfXIESrBJjpDgwMD3uJTaES9ZgtHVkURrbkUL+ziIc6C2noVutYLwqU
         BGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=04i36zyfiz51z7eT5HV2OIVr29EI5WaNJsS0RGWr67s=;
        b=PhECnUb0BrtJHAzJ+JyPwGEHwPdUCu9fuSxuhZ5W+dNE9OwUTbWsRIsZQu6kDWRbIp
         1a/iy0xeA7/Qr+0Lth+G7JWqdS+IVtmfJ6/XPTeK1j9M+ZVf41+5rEEcBXKrh5a2ed/J
         LfOieQGt+xX6DqPy/C4cdRSpckxu52IyX67cvLKF1/vhpVIyGe44Wmi5QOiOFek/V2O4
         O2VvfrBNKbzbtMluQGdLrzM+dsrI6mr16nrXyJXnOPaDm4an8Acq8lT7dKha+dE58+eq
         h3zEV5TcTYuR4OsNKiZUtxcWDHp7XfA7Cp7zpAFgfppSvLfEVASiYWhrFxgNSPqou3wb
         6L4Q==
X-Gm-Message-State: APjAAAXki4ASHdXTyBNoixHSDdn2kBfAy8SDnf65kyD0+EtrhhSbxD4a
        zHqjMnIn3VNOy9VFxWB10Mo5Bduu
X-Google-Smtp-Source: APXvYqzdCwZ3TKIAMcS2BLggKnc2AhScNcnKyLh7xtQG+us/aUCJWzJG4od80uak2LhqlhdSGVCxBQ==
X-Received: by 2002:a17:90a:26ec:: with SMTP id m99mr25756067pje.130.1580678337405;
        Sun, 02 Feb 2020 13:18:57 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y24sm8755639pge.72.2020.02.02.13.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:18:56 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE), Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH 00/12] dt-bindings: arm: bcm: Convert boards to YAML
Date:   Sun,  2 Feb 2020 13:18:15 -0800
Message-Id: <20200202211827.27682-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

This patch series converts most files under D/dt-bindings/arm/bcm/ with
the exception of bcm63138 and brcmstb to the YAML format. Those two may
be split accordingly later on since document not just the root node.

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
 .../bindings/arm/bcm/brcm,bcm11351.yaml       | 23 +++++
 .../bindings/arm/bcm/brcm,bcm21664.txt        | 15 ----
 .../bindings/arm/bcm/brcm,bcm21664.yaml       | 23 +++++
 .../arm/bcm/brcm,bcm23550-cpu-method.txt      | 36 --------
 .../bindings/arm/bcm/brcm,bcm23550.txt        | 15 ----
 .../bindings/arm/bcm/brcm,bcm23550.yaml       | 23 +++++
 .../bindings/arm/bcm/brcm,bcm4708.txt         | 15 ----
 .../bindings/arm/bcm/brcm,bcm4708.yaml        | 88 +++++++++++++++++++
 .../bindings/arm/bcm/brcm,cygnus.txt          | 31 -------
 .../bindings/arm/bcm/brcm,cygnus.yaml         | 66 ++++++++++++++
 .../devicetree/bindings/arm/bcm/brcm,hr2.txt  | 14 ---
 .../devicetree/bindings/arm/bcm/brcm,hr2.yaml | 30 +++++++
 .../devicetree/bindings/arm/bcm/brcm,ns2.txt  |  9 --
 .../devicetree/bindings/arm/bcm/brcm,ns2.yaml | 25 ++++++
 .../bindings/arm/bcm/brcm,nsp-cpu-method.txt  | 39 --------
 .../devicetree/bindings/arm/bcm/brcm,nsp.txt  | 34 -------
 .../devicetree/bindings/arm/bcm/brcm,nsp.yaml | 68 ++++++++++++++
 .../bindings/arm/bcm/brcm,stingray.txt        | 12 ---
 .../bindings/arm/bcm/brcm,stingray.yaml       | 26 ++++++
 .../bindings/arm/bcm/brcm,vulcan-soc.txt      | 10 ---
 .../bindings/arm/bcm/brcm,vulcan-soc.yaml     | 24 +++++
 .../arm/bcm/raspberrypi,bcm2835-firmware.txt  | 14 ---
 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 33 +++++++
 .../devicetree/bindings/arm/cpus.yaml         | 16 ++++
 26 files changed, 445 insertions(+), 290 deletions(-)
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
2.17.1

