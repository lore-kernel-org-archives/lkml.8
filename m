Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8798AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6CA2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gS6L/Rjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgHYXVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:21:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26754 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726856AbgHYXVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598397667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=xNdewgWH8gCx0lJ9ZMNVoHAdBDGRlASSw/JoCtrkyuQ=;
        b=gS6L/RjlUrQFmw6/x7+bKXc9iuR77y3mv9W9QQOHNqSmbR0yYHZ1KnArcdc+1ZmcmPtbfX
        O5yiNPzBSIka1nqv7uVhNjgqrj8RzvvySDsuDhnozCDE8AuF9M5IiyCye1suuJ6fereMJU
        MGRTLVWXeW5IBgBctvS51MgPei7AYVU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-IXargCX3PeiR3-rlPZnnTA-1; Tue, 25 Aug 2020 19:21:05 -0400
X-MC-Unique: IXargCX3PeiR3-rlPZnnTA-1
Received: by mail-qv1-f72.google.com with SMTP id y7so47500qvj.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 16:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xNdewgWH8gCx0lJ9ZMNVoHAdBDGRlASSw/JoCtrkyuQ=;
        b=BkDCihUvU75WmpLJ+28E+hy6qf3CM41/ROjo7RX4/MQ0YDU6s1GDeS/0x7B6TsbSHP
         Xqkwb6MbMm3mVAoALFNrmCStuILeGK2EOF9WHQamo6Pd7afTpVa+19Sj1Ozo5bSyl2m9
         WBvSZ2bGnZuHQMB+ZsdRu63aClwGYlSh5v7Dr8AFWDqRP36p8TmwCgZBnPLjtEAEfN8g
         9NvsCyQFL/TOpsaln/F8zkg4kuXypplW65GSddktAVd999iYP0ePAJ5CPoOagRUk/IZ2
         TaDOuivzd8fNUCsjxSEeMRwfG8wBGW+xbcicsug6KgGoVstBdq8BX2Swnbv+aDqYFYve
         q0rQ==
X-Gm-Message-State: AOAM531qieig42b7NGNWt+8BxhA8oQxbADbjUkBeSKgWCcmm7PUyhJEc
        hV+Gncz8IRksMJ4lt7qBUWg2zrXOkiGusdfqxNq6wGUXS3627Q37IgzyqB0+wFNP6EI2oHm0ux7
        SL1IPCTO9Q8QsK9Tww/t8wNLU
X-Received: by 2002:ac8:17f1:: with SMTP id r46mr5963452qtk.135.1598397664838;
        Tue, 25 Aug 2020 16:21:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8I7EJn0X+Y1AjXauBs3W/d3tk01cGPGwK4MefHhs4PA5UeDTE8BAPGY84Kz1xBSI26HkGwA==
X-Received: by 2002:ac8:17f1:: with SMTP id r46mr5963432qtk.135.1598397664642;
        Tue, 25 Aug 2020 16:21:04 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g55sm494590qta.94.2020.08.25.16.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 16:21:04 -0700 (PDT)
From:   trix@redhat.com
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        jose.souza@intel.com, matthew.d.roper@intel.com,
        anusha.srivatsa@intel.com, pankaj.laxminarayan.bharadiya@intel.com,
        wambui.karugax@gmail.com, vivek.kasireddy@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/i915/display: fix uninitialized variable
Date:   Tue, 25 Aug 2020 16:20:57 -0700
Message-Id: <20200825232057.31601-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this error

intel_combo_phy.c:268:7: warning: The left expression of the
  compound assignment is an uninitialized value.
  The computed value will also be garbage
                ret &= check_phy_reg(...
                ~~~ ^

ret has no initial values, in icl_combo_phy_verify_state() ret is
set by the next statment and then updated by similar &= logic.

Because the check_phy_req() are only register reads, reorder the
statements.

Fixes: 239bef676d8e ("drm/i915/display: Implement new combo phy initialization step")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_combo_phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_combo_phy.c b/drivers/gpu/drm/i915/display/intel_combo_phy.c
index 6968de4f3477..7622ef66c987 100644
--- a/drivers/gpu/drm/i915/display/intel_combo_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_combo_phy.c
@@ -264,6 +264,8 @@ static bool icl_combo_phy_verify_state(struct drm_i915_private *dev_priv,
 	if (!icl_combo_phy_enabled(dev_priv, phy))
 		return false;
 
+	ret = cnl_verify_procmon_ref_values(dev_priv, phy);
+
 	if (INTEL_GEN(dev_priv) >= 12) {
 		ret &= check_phy_reg(dev_priv, phy, ICL_PORT_TX_DW8_LN0(phy),
 				     ICL_PORT_TX_DW8_ODCC_CLK_SEL |
@@ -276,8 +278,6 @@ static bool icl_combo_phy_verify_state(struct drm_i915_private *dev_priv,
 				     DCC_MODE_SELECT_CONTINUOSLY);
 	}
 
-	ret = cnl_verify_procmon_ref_values(dev_priv, phy);
-
 	if (phy_is_master(dev_priv, phy)) {
 		ret &= check_phy_reg(dev_priv, phy, ICL_PORT_COMP_DW8(phy),
 				     IREFGEN, IREFGEN);
-- 
2.18.1

