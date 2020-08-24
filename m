Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0B4C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD41320639
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598263175;
	bh=LEHr3HsevyMnaJkhSBY7315fU7qnMjb9UHxHuYi1qX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hpCzyZ1wRBjuaTAjkBqS+gTOzgGsDtdhUCzsS9/gKffj7ANr0sTT0wFdVQHa0U8kS
	 gBXHTXK4AcrP3wYbjXNw0GzYmaW6p2Bfw8iR0oaVGHp5B9YulY2wE/dp7PPpBtmbFm
	 /aFHldB3zghIrsaEN8K+zWwD/35RfmHcgrBHZgtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgHXJ7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbgHXIdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:33:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BB8A2074D;
        Mon, 24 Aug 2020 08:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258001;
        bh=LEHr3HsevyMnaJkhSBY7315fU7qnMjb9UHxHuYi1qX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a3UmNdJMsBk6i8I5qSSPSi9ool5tjoWgJprAfthEVYUEJD8BkZJfZ9UiG8DDQJH7V
         WUWkXZxDac+LyU1yjmNsvEpBWp9Bd2ExfudI4DM70NlXivo4rKOqlUzw8+nivjmG4q
         go4BwovlnJ9t5PS1ZkOX8o00qzgTTE8hGI9H/UQ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aric Cyr <aric.cyr@amd.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.8 038/148] drm/amd/display: Fix incorrect backlight register offset for DCN
Date:   Mon, 24 Aug 2020 10:28:56 +0200
Message-Id: <20200824082415.864565560@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aric Cyr <aric.cyr@amd.com>

commit a49f6727e14caff32419cc3002b9ae9cafb750d7 upstream.

[Why]
Typo in backlight refactor inctroduced wrong register offset.

[How]
Change DCE to DCN register map for PWRSEQ_REF_DIV

Cc: stable@vger.kernel.org
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Ashley Thomas <Ashley.Thomas2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.h
@@ -49,7 +49,7 @@
 #define DCN_PANEL_CNTL_REG_LIST()\
 	DCN_PANEL_CNTL_SR(PWRSEQ_CNTL, LVTMA), \
 	DCN_PANEL_CNTL_SR(PWRSEQ_STATE, LVTMA), \
-	DCE_PANEL_CNTL_SR(PWRSEQ_REF_DIV, LVTMA), \
+	DCN_PANEL_CNTL_SR(PWRSEQ_REF_DIV, LVTMA), \
 	SR(BL_PWM_CNTL), \
 	SR(BL_PWM_CNTL2), \
 	SR(BL_PWM_PERIOD_CNTL), \


