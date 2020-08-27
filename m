Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6D2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D659E2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJ3s1wAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgH0Shl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:37:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44129 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726009AbgH0Shk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598553459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=GIOyNKn4lpZbuj6L4tBDqNoHcELuwP+YTy/cWEhcVsA=;
        b=JJ3s1wAl1I+k/O0Gffi1YCxvuYZ1JNLE0dwJunl4IuWmBKojK10I/hQ2bPyey5dbDxKr0M
        2HZ/PSUZlydAfk90Q/f/KvOd/WxKfIZCAeNBsYRjRisdgweaP9E8Ft27ofzwtJ4WGjKXhA
        IaLgaBftXBA1yhevrFcEIp7dshCFfk4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-tUhRq4mZOnqYit4x_IcbwA-1; Thu, 27 Aug 2020 14:37:37 -0400
X-MC-Unique: tUhRq4mZOnqYit4x_IcbwA-1
Received: by mail-qt1-f199.google.com with SMTP id r24so5514550qtu.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GIOyNKn4lpZbuj6L4tBDqNoHcELuwP+YTy/cWEhcVsA=;
        b=BSt7OS+V67xMWh6Tk9Jpv3IHyP5H6exqz7zuX4ENAVd9I4wMz3tubtpqzQxdRsk1tP
         wLH+jNx57uO0Z8akRMqpmXAp01weqRrRSn1UHtOxDCG3XaqmDr53hu562nA4E2tsYK2Y
         Ip0FGJfqO1UfODizUA2rtK6grOjudawwVri6R9oRZXnS5i9SdEtar5t3vr71+mrrR/Uj
         rOSgl5lOjgUGBNebdIHiOzWi1AufwHjzmNKSR+z+l7ZTZJKRKo5QqJmXdqiMmb6CUuSk
         Em1c45A1LKBW+bSB7ltMw8wWcbKMM9vE6L0RFdSPQw9u/Ujbm6LIWzsAm4wxYynjirx1
         qEug==
X-Gm-Message-State: AOAM530/oHkPwEl7Ava+xhz5fIW7Jh8i6T6D3FNLstU8tsExsgiIl/iN
        RjrPEJMaeoHqioaU3+xIizfxu0GGNTxGHs3RvXx7E0CDEk1CxXskUm2Law9kMZHOuEp0FuL8tIb
        V6zgR/bKNv3M63X/FVp0xMJKw
X-Received: by 2002:ac8:45c7:: with SMTP id e7mr20255189qto.187.1598553456823;
        Thu, 27 Aug 2020 11:37:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXdvN0a05gbC1rP9FvdO3i+S9AkoKl/LGZWrmmNmYELI9HeqKh23RzqUkEBrEfpUvhGucamw==
X-Received: by 2002:ac8:45c7:: with SMTP id e7mr20255172qto.187.1598553456580;
        Thu, 27 Aug 2020 11:37:36 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x28sm2362305qki.55.2020.08.27.11.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 11:37:35 -0700 (PDT)
From:   trix@redhat.com
To:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau: remove redundant check
Date:   Thu, 27 Aug 2020 11:37:23 -0700
Message-Id: <20200827183723.7767-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this problem

hw.c:271:12: warning: The left operand of '>=' is a
  garbage value
    if (pv.M1 >= pll_lim.vco1.min_m ...
        ~~~~~ ^

This is mostly not a problem because an early check in
nouveau_hw_fix_bad_vpll()

    	if (nvbios_pll_parse(bios, pll, &pll_lim))
		return;
	nouveau_hw_get_pllvals(dev, pll, &pv);

shadows a similar check in nouveau_hw_get_pllvals()

	ret = nvbios_pll_parse(bios, plltype, &pll_lim);
	if (ret || !(reg1 = pll_lim.reg))
		return -ENOENT;

Since the first check is redundant, remove it and
check the status of nouveau_hw_get_pllvals().

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv04/hw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/hw.c b/drivers/gpu/drm/nouveau/dispnv04/hw.c
index b674d68ef28a..b96c5628c33b 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/hw.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/hw.c
@@ -259,14 +259,12 @@ nouveau_hw_fix_bad_vpll(struct drm_device *dev, int head)
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nvif_device *device = &drm->client.device;
 	struct nvkm_clk *clk = nvxx_clk(device);
-	struct nvkm_bios *bios = nvxx_bios(device);
 	struct nvbios_pll pll_lim;
 	struct nvkm_pll_vals pv;
 	enum nvbios_pll_type pll = head ? PLL_VPLL1 : PLL_VPLL0;
 
-	if (nvbios_pll_parse(bios, pll, &pll_lim))
+	if (nouveau_hw_get_pllvals(dev, pll, &pv))
 		return;
-	nouveau_hw_get_pllvals(dev, pll, &pv);
 
 	if (pv.M1 >= pll_lim.vco1.min_m && pv.M1 <= pll_lim.vco1.max_m &&
 	    pv.N1 >= pll_lim.vco1.min_n && pv.N1 <= pll_lim.vco1.max_n &&
-- 
2.18.1

