Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3443C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A003622B51
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFzccDYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgGSOKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 10:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGSOKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 10:10:40 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59077C0619D2;
        Sun, 19 Jul 2020 07:10:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so22749763wmh.2;
        Sun, 19 Jul 2020 07:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uip36AVEEdpoEPD2bGpIZ4N4hcQoPUCcvc3HsI5Wl9c=;
        b=TFzccDYuwliwcOwsH9orW1yBomfu2xrMFclpekz/1pXYBPwEYWQ3bnBgEGGT2aKgYK
         upiflNUFRHfN9HJwtvV64tV5nuZYsYqHo0UDZ2FqsR8t+/WeRRVy0F3O8ucl5B/JF0Fe
         79vhT5S/xP2Q9+3ie4jxNy6ywpjgt8r9a1IQlvWcJLnCzdaPHr1fPFAlIFFL6tUiWkeC
         8Qomf6b49f/Z1LrEhHkitEQ1hRjgEL/PvmXfZwci9qnKdYH4I6Cz4Q4XDqA8zMuk7F6R
         3rSPHcM8XHhqATPjE8H+HGnvjDvxjk7Xc+hQTuFrWWebn4LYyZrqwRVLWnRDYt6NsM/T
         YQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uip36AVEEdpoEPD2bGpIZ4N4hcQoPUCcvc3HsI5Wl9c=;
        b=JEClMINbrpdN5aiiCAmhxeC+0dHkvma8nPoMKjBQ6nVmcgSM4k/yTYjbFlilg1BwSq
         CXED2oiRiOCxwtUycI78f9PpDB1SD2tvdQkvPzt7eBQHl3PaWmn9LEwuydh/8WwSxPGd
         JD4hjYV1nNsPrUfIGwRKcXtgarvSGLcs67/0h+30JK86s1MIdtFU+8e+GPZpaZWsDMyk
         kC7MJNOL7/O0Zv8Rqhr5e2Vlw0ly+F3m5k9WJA6dx2gkSmKyNnmMS7P2sYW7S18tki5m
         0KBQx5zsQbLYsFIyM1i0mpMPaRNXZHYhofRVbJR0PytFIgjFAmEGGqlrHSDc6xAKLtL1
         G/PQ==
X-Gm-Message-State: AOAM530pYaiDF/Ygqi6ZfOpypERyzYJFpLicUb2vGFBB6WmVEkiJkrNy
        XX9uA58UU6QH7/OLhSLgKQ0=
X-Google-Smtp-Source: ABdhPJwTLFyiaqp1ZwCiqde8MsEGRysxCu+C+kk/5JYdJm1R8uIYdw4hYLq0IFAAP5/R5NA66iUbfg==
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr17774561wmh.68.1595167838899;
        Sun, 19 Jul 2020 07:10:38 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id y11sm9215554wrs.80.2020.07.19.07.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 07:10:38 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@hardkernel.com>
Subject: [PATCH 0/3] arm64: dts: meson: add support for ODROID-N2+
Date:   Sun, 19 Jul 2020 14:10:31 +0000
Message-Id: <20200719141034.8403-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series splits the existing meson-g12b-odroid-n2.dts into a common
dtsi and dts, and then adds new bindings and dts for the ODROID-N2+
which uses an Amlogic S922X rev.C chip that Hardkernel supports with
overclock to 2.4GHz on the big cluster and 2.0GHz on the little cluster.

The series has a soft-dependency on proposed changes to N2 audio [0]
from Jerome Brunet so will need a v2 rebase once they are applied
(basic tests for this series on N2 and N2+ are with them applied).

[0] https://patchwork.kernel.org/project/linux-amlogic/list/?series=311099

Christian Hewitt (3):
  arm64: dts: meson: convert ODROID-N2 to dtsi
  dt-bindings: arm: amlogic: add support for the ODROID-N2+
  arm64: dts: meson: add support for the ODROID-N2+

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../dts/amlogic/meson-g12b-odroid-n2-plus.dts |  53 ++
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 493 +----------------
 .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 500 ++++++++++++++++++
 5 files changed, 556 insertions(+), 492 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi

-- 
2.17.1

