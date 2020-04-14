Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB775C3815B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81FC206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mEbJKx7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632890AbgDNUPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2632871AbgDNUP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:15:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF376C061A10;
        Tue, 14 Apr 2020 13:15:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x25so14557018wmc.0;
        Tue, 14 Apr 2020 13:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/nMN3gP9x2ARfODCEnbyaFnmiKSgzhDo+Aw3jjcLnlo=;
        b=mEbJKx7U88hspWaZQv2wZirmksuZrorf1nF8yEpwzZjYupFgLEII0wWhYQBph6N1GQ
         TQZDp9FTxyLAVl+eof0qZzzAhwqgnfNRHjj0CAVmvrM34KAuoYv4J/u1tB17P8D9Vn9f
         /fdr/NS/i5wKBsfX3TGXfy1L52YyO9FKGVb+onQTJ9LpQL0d3/fbOGucdabipdTpSaSs
         h9BZxhPcFRZaEihwL5XJ7Pjok1f6IMu5cQSyqEKXHFRjyDTQTZAD1KlUF+mi2NbUl8b6
         D9p7Ch03BlS7tu4NoPWtlNF/lAfwQN7SYdDRSe2pEyI3N34zkhd4ioKbPAuMXPdHuon8
         HWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/nMN3gP9x2ARfODCEnbyaFnmiKSgzhDo+Aw3jjcLnlo=;
        b=V9m4IyohS8DZuSd4fXry7GpAyrGoaNfM6YPlzLgGxloWQZ4XiEi4uOBdtadHNOJwPG
         n7dw7v8s60NSNanqQEji/8V5wCYwRYJhd3oiqYhvRRcFFiGGcq0gn0Idx0HN69C1t7g5
         WmxyMPzDAhRpC0x+yhIi2vXV7LhyafO1vdqh6QG1RMTWSWsX0tiSBN34Vn9snNKMvCNV
         SamQF9nBvbAKs3bnfdKv8CJeI+Rh9Ia6EwvFlnfa8GZRu5uzww7BP2P3O5zi2qoQ5N7J
         jt0AX9VqsMEgK43YV0bcBUnfzgyemNgm1H6N4oRnjJl+f1GdYyMz3DJQT+KCA/H5qOF7
         Rl0A==
X-Gm-Message-State: AGi0PuaxOFCWoFvt3UglhfIdVmD8DP++WQbjzLDXvH8dgtwbsYBluUJi
        kRx9s9UkLIMFGZSIJz9B9Xk=
X-Google-Smtp-Source: APiQypKh2JU4ueEU0WUjbHYK8S4/0j/0MkKPw8LrYTuKKOm8lG5Osf/3Xu2oOVPnjrrPih3R/LI0Ng==
X-Received: by 2002:a05:600c:4102:: with SMTP id j2mr1610523wmi.159.1586895327469;
        Tue, 14 Apr 2020 13:15:27 -0700 (PDT)
Received: from localhost.localdomain (p200300F13717DF00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3717:df00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id u17sm22537467wra.63.2020.04.14.13.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:15:26 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 0/4] meson-ee-pwrc: support for Meson8/8b/8m2 and GX
Date:   Tue, 14 Apr 2020 22:14:53 +0200
Message-Id: <20200414201457.229131-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for all "older" SoCs to the meson-ee-pwrc 
driver. I wanted to compare as much as I could between my Meson8b EC-100
(Endless Mini) and the Le Potato board so I added support for GXBB, GXL
and GXM as well as for the SoCs that I'm actually working on. I will
send the ARM64 dts patches once all of this is reviewed and merged.

@Neil: I would like you to review especially the GX dt-binding patch.
The old GX driver seems to include the same reset lines as G12A *plus*
"dvin". You probably know best whether that's needed or not - for now
I decided to keep it (as this is what "works" with the old pwrc driver).
Also I decided to use your copyright in meson-gxbb-power.h since it's
a shameless copy of meson-g12a-power.h with s/G12A/GXBB/g

I successfully tested the Meson8b part on EC-100 where u-boot does not
initialize the VPU controller. So this the board where I have been
struggling most.


Martin Blumenstingl (4):
  dt-bindings: power: meson-ee-pwrc: add support for Meson8/8b/8m2
  dt-bindings: power: meson-ee-pwrc: add support for the Meson GX SoCs
  soc: amlogic: meson-ee-pwrc: add support for Meson8/Meson8b/Meson8m2
  soc: amlogic: meson-ee-pwrc: add support for the Meson GX SoCs

 .../bindings/power/amlogic,meson-ee-pwrc.yaml | 102 +++++++++++++++---
 drivers/soc/amlogic/meson-ee-pwrc.c           |  98 ++++++++++++++++-
 include/dt-bindings/power/meson-gxbb-power.h  |  13 +++
 include/dt-bindings/power/meson8-power.h      |  13 +++
 4 files changed, 204 insertions(+), 22 deletions(-)
 create mode 100644 include/dt-bindings/power/meson-gxbb-power.h
 create mode 100644 include/dt-bindings/power/meson8-power.h

-- 
2.26.0

