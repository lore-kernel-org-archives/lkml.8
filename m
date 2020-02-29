Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756D9C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 15:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F25D24699
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 15:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYgnTIsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgB2Prr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 10:47:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45902 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgB2Prq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 10:47:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id e18so6725108ljn.12;
        Sat, 29 Feb 2020 07:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qKnesHmoBmkag7afF4T2hMq9e7zOlVqqvlQY6asutgI=;
        b=ZYgnTIshFA3SA6KepwgRqr5oUtuUCbz4B2COy7r5yyka2yYxbVu79xdN7YKFTKHiPn
         XHTG0Tr8/akQ1CXsX9zbIvuNoFX617SS6bvk5OlsYRbsu82HqnO8EJKcoALaSk5hmx4Z
         tZZpSJhqWyfxzVkIyIhTU3xTbccdiYy0F+RCgoYGye+XiCxwZJI2h0UdRnhmDUEReIN5
         EBHO4JjUxwCKzrAAx1VJnSzfY1hFS5W7uXiiTmuXkth3aqwoe2Bh7GgJpfLQlWQWwaJX
         rMJq8GsUv7X0Cadle9ZGosMQFdxSZfkSU8s6WXZ2++pdhKMjrdDxH64zPhGUDCfOIjjE
         yMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qKnesHmoBmkag7afF4T2hMq9e7zOlVqqvlQY6asutgI=;
        b=Y45dEnyKRHB+MNc1LtRwPJss3HsWPd1FkqbpDlU3ja1smPFau1S/alONYdpJJipflW
         +v+QnUdyuifVaH4GVUnGuSG/ltbpi951hf6+CipXL/oK3BJceQ6ndZ1Iyk6YYGHyLl7x
         yO8+9k+w42ujSGKzpCrf4fTxf9+njWwCiXz4hdMInxKwaX9dcBibO0nCDgdAE9ZwcgKB
         +5L7+ugVVgTADgIPRrIz7Vtp/jeGde7fGw5JAGIcd8tnDSDNw0F9+XEnT1cIpzobw8S3
         ktSvn1yKbRQFEtPePzxMgam4t6nEXt7G05uSbCxygCnIUYbLG9tLuXXfQcucTS6yaZrJ
         D3rg==
X-Gm-Message-State: ANhLgQ1H4ps1ZKDBPmQv0GbEvcCF7U6XzrI2/QQYf8Xn0bbigP9L9BmB
        dwA7AzWvohyQ0KbBltuf7qI=
X-Google-Smtp-Source: ADFU+vuJeGLV4/eo3/0Y4eK+BpBa3yvD+ui50MRir/6gj1Ss+eZRs556UDZ9Tud5nszjviVxLu4l0g==
X-Received: by 2002:a05:651c:39b:: with SMTP id e27mr4981749ljp.99.1582991264652;
        Sat, 29 Feb 2020 07:47:44 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id g20sm7294786lfb.33.2020.02.29.07.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Feb 2020 07:47:44 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/2] arm64: dts: meson: add dts/bindings for Tanix TX5 Max
Date:   Sat, 29 Feb 2020 19:46:52 +0400
Message-Id: <1582991214-85209-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds new bindings and a device-tree file for the Tanix TX5 Max
set-top box.

Christian Hewitt (2):
  dt-bindings: arm: amlogic: add support for the Tanix TX5 Max
  arm64: dts: meson-g12a-tanix-tx5max: add initial device tree

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-g12a-tanix-tx5max.dts   | 481 +++++++++++++++++++++
 3 files changed, 483 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-tanix-tx5max.dts

-- 
2.7.4

