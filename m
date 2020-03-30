Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8930C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915A8205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca92LU24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgC3WQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:16:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37665 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbgC3WQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:16:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id u20so12437964oic.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 15:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rHTfazG0JcHchUkZkwqmfv3skWoFel0RHtJDeLWFMUQ=;
        b=Ca92LU24QgTe15iUum7o+GWCCxrpDi/NBlydV3Y7UaeHp3UkpEJ0w3PsnajA8/jp1R
         xa4eS5TvtcurrFF8L9WuPHdSCuUhFfYlAomFz951J9FAMhgAfJkK33UVCRcVBw2m52Wd
         ZK+i/Q8HIqIYIVo9n2fKbgbduGG394emhSQyh6rPbdXWu9dxOcpPGwj3Ql7/+b7FvLDw
         wrgqKKtyJBby4Qq2AHh2zf6iDd6ex8sq8izmSMRGf0W8M+Gtr6xKUbo00XLWOS8R5dsx
         RTEvjWV+Vxu/htwiMLb+gkKPSMgSTF+GuUwxTfPNyiSsp4kLGyPP9oFgjobop6Cffs86
         4GAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rHTfazG0JcHchUkZkwqmfv3skWoFel0RHtJDeLWFMUQ=;
        b=XbrRukad1c5P5FBpdvXsM688hNcyH/RPZN5wyhocB6zMdqTfEjs6yH+YhUuuPRC/Ip
         PAmWyAAHweFEEFeCsPcmKnGTvzFaTGxyUY5JrBKNdKhLIQsBLteG/C1RM7qCc1a4EmBf
         lZVWGYhuWyJaupfjzPDUSF6yHr9n5btKWMIH0BpGoEJweDx/k/manUbahZOU7jInhsEu
         WrsooQbJLiItnGmGrrPH3vDqWATbDrfBX5JhIscoR9p6vbVfY0baHFbRP7B7Fv+DQS7Z
         fGQyvhTpzP9DXP4SM5hK/++wZcB9JTA7Y/J5Li27Z4Pf+Eo3QHfmYiKiEHD7RVzvL4kB
         nMFg==
X-Gm-Message-State: ANhLgQ2Mhg0dJjlUMmd93MP/uZzRWXF6gsAJcSiZuKBjvVPva5pCCWEi
        j0pkM7qIZvXWKgNxzPla1nY=
X-Google-Smtp-Source: ADFU+vtRqzG9oYmCmjI3rVBaaXZZBnhy9DdhlKuP9NiWmIWqtTC/fMZaYpnYKJ/MHG2Na6JPD8ApJg==
X-Received: by 2002:aca:646:: with SMTP id 67mr202286oig.4.1585606593916;
        Mon, 30 Mar 2020 15:16:33 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id c18sm4680750ooa.8.2020.03.30.15.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 15:16:32 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/display: Fix 64-bit division error on 32-bit platforms in mod_freesync_build_vrr_params
Date:   Mon, 30 Mar 2020 15:16:14 -0700
Message-Id: <20200330221614.7661-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building arm32 allyesconfig,

ld.lld: error: undefined symbol: __aeabi_uldivmod
>>> referenced by freesync.c
>>>               gpu/drm/amd/display/modules/freesync/freesync.o:(mod_freesync_build_vrr_params) in archive drivers/built-in.a
>>> did you mean: __aeabi_uidivmod
>>> defined in: arch/arm/lib/lib.a(lib1funcs.o)

Use div_u64 in the two locations that do 64-bit divisior, which both
have a u64 dividend and u32 divisor.

Fixes: 349a370781de ("drm/amd/display: LFC not working on 2.0x range monitors")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 8911f01671aa..c33454a9e0b4 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -761,10 +761,10 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 
 	// If a monitor reports exactly max refresh of 2x of min, enforce it on nominal
 	rounded_nominal_in_uhz =
-			((nominal_field_rate_in_uhz + 50000) / 100000) * 100000;
+			div_u64(nominal_field_rate_in_uhz + 50000, 100000) * 100000;
 	if (in_config->max_refresh_in_uhz == (2 * in_config->min_refresh_in_uhz) &&
 		in_config->max_refresh_in_uhz == rounded_nominal_in_uhz)
-		min_refresh_in_uhz = nominal_field_rate_in_uhz / 2;
+		min_refresh_in_uhz = div_u64(nominal_field_rate_in_uhz, 2);
 
 	if (!vrr_settings_require_update(core_freesync,
 			in_config, (unsigned int)min_refresh_in_uhz, (unsigned int)max_refresh_in_uhz,
-- 
2.26.0

