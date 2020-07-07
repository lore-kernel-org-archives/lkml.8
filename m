Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363A0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05ED620738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uftFUaF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgGGE7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 00:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgGGE7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 00:59:04 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29250C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 21:59:04 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q17so17899748pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 21:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fnf5BOlLTguFdAJt0eKBqSFaZTROPVc2dJ5RoFXNCYA=;
        b=uftFUaF0PjHg0naEaC4J+NSl69Db+2w3bJ6URTUu0NQ0/8Syog8GFyJos/mOW2tD3B
         jgroHtO7cic5K99ZvRpTyH3vKylb+A0A4Z0kAt/s3H68nivRpBkODHGFo0SSHvHlypwh
         39U/wnLwe7ElfgFYL2M2narCr959zv9/REkd3bVvgAHOKfWH7bzVQO/xuHkcaI+QvRSB
         gY0D5JyQgoohO2h9EN1s4UsZ/KR50Mpd3MUHjvAuX7FkSxFL4Bc+vX5F5Sfp+0a4wgOH
         /hOfzJ5VbGOy6fluH/BL0dg/w7IxdNeK6Y4yJ5pAwXEVI9VWsrihdxwX7DdXV7ywcCzw
         H5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fnf5BOlLTguFdAJt0eKBqSFaZTROPVc2dJ5RoFXNCYA=;
        b=K6h2MLRdvhEIjZWJw72VBomULv5ii1SOrwE/ZlX+jkwbt99c38gqvxPN4vpKhdeMYT
         ExA7abjHkGAhrCbUfmH1ahluJHPVY3pzDhTU9/z/UFbATzYaNqxLSmaP8AijebG1zari
         Zthe7mcZj0jVqzF0VHSHQLlJr29CSFX/C3V96HkjQypQieVpZ4SOLNuW/iOyDumqaLvg
         7bzaWvaIu2+n/yC8DwohyINx/AMNnmsjQjVBI/VHOwj0rOEbEQys+4qpD2TIDX2OVtfR
         uJgT2nyLuKG09eNLY0FAbMVWenNa/rnQiT5EUFopc8wuDDN3CkLj7FmhFwaj7Zcu4qQ8
         fmqg==
X-Gm-Message-State: AOAM5306uCDFSrzS41UlmdMSm74UwyFz1KZp9fR31JRro2W2A79ifZe5
        gAEXWjRzq+j1X8Btn/+yDY4=
X-Google-Smtp-Source: ABdhPJwwBjwRcBhX5cznZ+2DvGqB7QhUlH1A9wSx7ThIxOU26AbLCZvRJz73gSNVuaTqZ6nuI1r/Kw==
X-Received: by 2002:a05:6a00:1589:: with SMTP id u9mr49055656pfk.201.1594097943614;
        Mon, 06 Jul 2020 21:59:03 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id d18sm1017930pjz.11.2020.07.06.21.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 21:59:03 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, timur@tabi.org, shengjiu.wang@nxp.com,
        linuxppc-dev@lists.ozlabs.org, festevam@gmail.com,
        shengjiu.wang@gmail.com
Subject: [PATCH v2] MAINTAINERS: Add Shengjiu to reviewer list of sound/soc/fsl
Date:   Mon,  6 Jul 2020 21:58:29 -0700
Message-Id: <20200707045829.10002-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Shengjiu who's actively working on the latest fsl/nxp audio drivers.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
Changelog
v1->v2:
 * Replaced Shengjiu's emaill address with his gmail one
 * Added Acked-by from Shengjiu and Reviewed-by from Fabio

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 496fd4eafb68..ff97b8cefaea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6956,6 +6956,7 @@ M:	Timur Tabi <timur@kernel.org>
 M:	Nicolin Chen <nicoleotsuka@gmail.com>
 M:	Xiubo Li <Xiubo.Lee@gmail.com>
 R:	Fabio Estevam <festevam@gmail.com>
+R:	Shengjiu Wang <shengjiu.wang@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
-- 
2.17.1

