Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3673C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8024020809
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589928660;
	bh=Fqra9IuVuRyQX7OP0Uy6DhIAmIXe+LMIOkrDcW8htPo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=zjpsrihndatZnrHZxiFkcZkJVNnMoOy6VJRgpuIcWIk7YX6S04wWteT6ZYmv+dd7V
	 GcIWaWl7Ceqn/iwmTuBsAiCB1uYo3fig+e4sfFA3itdYNLRCNyXuDZebJsWeekuGGx
	 3CxKIVRZxlBtpRJhQFzX5FrRmBE/jGkrvA7m+ygI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgESWu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgESWu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:50:59 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA30620674;
        Tue, 19 May 2020 22:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589928658;
        bh=Fqra9IuVuRyQX7OP0Uy6DhIAmIXe+LMIOkrDcW8htPo=;
        h=Date:From:To:Cc:Subject:From;
        b=VqIiz4a8dXOCfJYo0RzYsoa/zEaVTZCPxvClxFI9E0CB5b3lE56BiocD6YcC4zvMG
         HUYFxIWUyjxQ2YIBBA9fvKdRS+d06BfV1qgKmXWimlij4rdkaFog6YzOXCvYEynvdv
         b2g1hSeX3IXsCIj7lAQIsBg9FyXj52owte8DEhBA=
Date:   Tue, 19 May 2020 17:55:45 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amdgpu/smu10: Replace one-element array and use
 struct_size() helper
Message-ID: <20200519225545.GA2066@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of one-element arrays in the following
form:

struct something {
    int length;
    u8 data[1];
};

struct something *instance;

instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
instance->length = size;
memcpy(instance->data, source, size);

but the preferred mechanism to declare variable-length types such as
these ones is a flexible array member[1][2], introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on. So, replace
the one-element array with a flexible-array member.

Also, make use of the new struct_size() helper to properly calculate the
size of struct smu10_voltage_dependency_table.

This issue was found with the help of Coccinelle and, audited and fixed
_manually_.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 6 ++----
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 246bb9ac557d8..c9cfe90a29471 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -410,12 +410,10 @@ static int smu10_get_clock_voltage_dependency_table(struct pp_hwmgr *hwmgr,
 			struct smu10_voltage_dependency_table **pptable,
 			uint32_t num_entry, const DpmClock_t *pclk_dependency_table)
 {
-	uint32_t table_size, i;
+	uint32_t i;
 	struct smu10_voltage_dependency_table *ptable;
 
-	table_size = sizeof(uint32_t) + sizeof(struct smu10_voltage_dependency_table) * num_entry;
-	ptable = kzalloc(table_size, GFP_KERNEL);
-
+	ptable = kzalloc(struct_size(ptable, entries, num_entry), GFP_KERNEL);
 	if (NULL == ptable)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h
index 1fb296a996f3a..0f969de10fabc 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h
@@ -192,7 +192,7 @@ struct smu10_clock_voltage_dependency_record {
 
 struct smu10_voltage_dependency_table {
 	uint32_t count;
-	struct smu10_clock_voltage_dependency_record entries[1];
+	struct smu10_clock_voltage_dependency_record entries[];
 };
 
 struct smu10_clock_voltage_information {
-- 
2.26.2

