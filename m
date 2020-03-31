Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ABDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6407B20848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq/9g2MQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbgCaRC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:02:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41538 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCaRC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:02:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id f52so22761679otf.8;
        Tue, 31 Mar 2020 10:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jxEDY7Lh9sFrcdUwEPS+IX6vGxzZgavjk6ZW2NcrVrk=;
        b=Kq/9g2MQD/2QCPgF2+mn1+/B1jcPmOv3EWTIqQ2Fh6zbQtoecS4FHkQjUo9ozsnRKA
         W1k9E1kh/u8Ni3caRzBYd6ZdLbeCspOUzmXE2GGF54oEgxdkGCklbstYts5Euv7Ausch
         xKeBwPImJH1IusJkhsbL4JadMjuR/hk71CZToPkYsA5VfejNPcNXNj5OTLYIhHGQN0+K
         5K8171uaD/5TuAwdubMGiFnWR9ZLNpXdL2jjwcV/YSqD1JQ13epwUe0QlUor0rOrZ9cZ
         /Y2IK6GgRWL566lc6bEhOCelT36yY+orkfyTsTWnoLjbUJnKcN8zaRGFaCAZfeWrBdtB
         tdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jxEDY7Lh9sFrcdUwEPS+IX6vGxzZgavjk6ZW2NcrVrk=;
        b=XTsjoi6CEI+TSJymWu05PYx2wIcNmybcPvzRo0bLFNxr0ChR6r7OWnZE0jSx2H8TIX
         U+kgYy3hYvErpyiovl7in+BMMqebVXeYJFCW/Q7575jKEZ0GZWcJnPrpco6RVS+B3QqQ
         6CkegRjnu5yA3aFHBJCTQonEyEkCc1oVL2CWfNL3ek7g7k8rDpZGL6cagDWJvdxPzcCi
         gJJhqSbbI2ZayIKcVesxArbkN26UzOkxz74PiNaPSwaa6gzkYMZ5KBcfgwcMl3ecOWq2
         EnomLGGpirpBsBXiAArKtiuobDw9B505N8om+GTZUP9Yv8Xh9ig5HC6JgJc/ViCdbN+v
         nc/Q==
X-Gm-Message-State: ANhLgQ0xr3LKWAPVUYLc16YwSeKHEhX6cVy69TfQMu5iOrMgXKbBpZEe
        lpynGC8iYXAQpNJiYdPn/yg=
X-Google-Smtp-Source: ADFU+vvsUd4Z5AdeIEOonIjmQWuPNBNc8nTzBnvHkHh65f1ICpuQJbiBIa5rO87xKTILuWXS57w29A==
X-Received: by 2002:a9d:6e8f:: with SMTP id a15mr9692562otr.188.1585674146917;
        Tue, 31 Mar 2020 10:02:26 -0700 (PDT)
Received: from desertvoice.lan ([2601:3c7:8303:2a10::21c])
        by smtp.gmail.com with ESMTPSA id h7sm2952605otk.3.2020.03.31.10.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:02:26 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     George Hilliard <thirtythreeforty@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Support the Allwinner F1C100s USB stack
Date:   Tue, 31 Mar 2020 12:02:14 -0500
Message-Id: <20200331170219.267732-1-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner F1C100s has an MUSB-based USB peripheral.  This patch
series implements support for it alongside existing Allwinner support
code.

This series was originally written by Icenowy Zheng for Linux v4.14.
I've rebased and bugfixed that work against mainline and tested it on
both the Lichee Nano and my custom hardware.  Where I've made functional
changes, I have changed the commit author to myself.

This is a follow-up to the previous series [1], a little late on my
self-imposed schedule but here nonetheless.

[1]: https://patchwork.kernel.org/cover/11428003/


George Hilliard (2):
  dt-bindings: Add new F1C100s compatible strings for USB
  musb: sunxi: add support for the suniv MUSB controller

Icenowy Zheng (3):
  phy: sun4i-usb: add support for the USB PHY on suniv SoC
  ARM: suniv: add USB-related device nodes
  ARM: suniv: f1c100s: enable USB on Lichee Pi Nano

 .../phy/allwinner,sun4i-a10-usb-phy.yaml      |  1 +
 .../usb/allwinner,sun4i-a10-musb.yaml         |  1 +
 .../boot/dts/suniv-f1c100s-licheepi-nano.dts  | 16 ++++++++++
 arch/arm/boot/dts/suniv-f1c100s.dtsi          | 29 +++++++++++++++++++
 drivers/phy/allwinner/phy-sun4i-usb.c         | 10 +++++++
 drivers/usb/musb/sunxi.c                      |  8 +++--
 6 files changed, 63 insertions(+), 2 deletions(-)

-- 
2.26.0

