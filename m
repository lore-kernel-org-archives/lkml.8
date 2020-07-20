Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6264BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462572073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388707AbgGTQWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:22:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39040 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388667AbgGTQWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:22:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id b25so20882030ljp.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s6tdYtNz+qDIDRhGgPrdBToU6tSHk3rys73lASsyyZg=;
        b=IiB2wuh+V4SyKF8ondMk0MqfZyY9amFi+k1BeFs+NRZ/LlSk8p0AeN7B33YZP1hj6D
         woU4YchPvz8vUTN5R8CzPzNm3FU3bDDhfzIH0bOdLXJyIZJszSYOpu8M2jqbwqy2UrqS
         AU0TAgaV/p5h+8W+WSAJERbWpwOrk7oP5XQUHWMC2WNLvHarVcdNf18ym8k/x9cMev63
         K8lRuXkTh9J3+TA4KkckVL2rrgDlRxYUjZToxKqo1VwEueayCaGXQbn1OSkbCIm1j3Eg
         dM9vIkeveyUtprV/f7fWLnBnGAr0kO0Ey9kd37O0n4ep0tEyf19NnRqr+BhvoaxoIQj3
         jkVA==
X-Gm-Message-State: AOAM531xZvTOVmgllbpn/JWxUeK3KEErsVwWDchG6nBg0cO5KUkNnxN+
        VaFBB3AEui83aKpeCuN66oQ=
X-Google-Smtp-Source: ABdhPJzTpx/3GEm/mdl3zCsea6GWprPX5/o5NX25tfmUNJ8qGeNGweY4sfXRocU5bYUIRUhGtCX2mQ==
X-Received: by 2002:a2e:8556:: with SMTP id u22mr11328825ljj.348.1595262166015;
        Mon, 20 Jul 2020 09:22:46 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id a19sm925855lff.25.2020.07.20.09.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 09:22:44 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Update memdup_user.cocci
Date:   Mon, 20 Jul 2020 19:22:13 +0300
Message-Id: <20200720162216.13248-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GFP_USER to the allocation flags and handle vmemdup_user().

Changes in v2:
 - memdup_user/vmemdup_user matching suppressed
 - PoC for selfcheck virtual rule
Changes in v3:
 - add missing '-' for patch rule in kmalloc/kzalloc call args
 - selfcheck rule dropped from patchset

Denis Efremov (3):
  coccinelle: api: extend memdup_user transformation with GFP_USER
  coccinelle: api: extend memdup_user rule with vmemdup_user()
  coccinelle: api: filter out memdup_user definitions

 scripts/coccinelle/api/memdup_user.cocci | 64 ++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 3 deletions(-)

-- 
2.26.2

