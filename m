Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DFDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308422070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWbKsITb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgERFkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 01:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERFkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 01:40:31 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8787DC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 22:40:31 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i15so10173072wrx.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 22:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MMjdutDALIvUMNOO7cn1LHe7cERFsIE93IZCcxogKmw=;
        b=BWbKsITbbG866jhVuiZepJkHVHJOaUij5ISLXVpxTxg43x/HutmxHTwsvztFoW4oWG
         nMgHkfnZT2QmDPL0cQGLGaFkTfDcmQrvIlfXsGekYzv8Zzh4/rFUCxdyjJuR0Pu/ogUy
         5eBvnwI9oVp3A2b1csE72HZEy+S/hHPY9sPZ8VC/BcIvKc29BmibhuVFw/jKVZyKNzVn
         VzLxRykordK+Y9xUTf04UKsMXZYrs6C2VdvKaYsnF0Oc57UWkyYTngAIRif5m5Pf5O/b
         GKtt2JURlSmjhcW7qYdYD4rmw9cWWhC3TImQnhCiqHaPQ43cdHkFl89vz4Z/AIpwqL71
         M7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MMjdutDALIvUMNOO7cn1LHe7cERFsIE93IZCcxogKmw=;
        b=Vzn4UeamP3tO4a1UzgG/xn4dApfxJwqdzBIQjf/KeDQtrQ4ODr98L+C8BCrbBi0JV6
         5GJbrK58teiGwvHcGQU1Mg3nbqTQbDT0fjrLDGHT/N1Zm+wWHfNYq7FT0kx/knqmwKto
         n1HcrBbdEnOv+BmokhOTvUnIEiqXgxTwkDZNhF6E7X4rX7mE2ZfiQx2TeXqK7Seo0hJX
         e2DXV+A1E54ebd+ji4ILe2hgkeKBfh3RYKk4fDJBM4TY1q5LM8kffemHJksAUYpqxOpW
         Q5JVcMepBvNrQq0igfVNq29/MJzN2GeEIEspdfKfgpIxyoaEfVxLc/S4qkgPjyuAZTKL
         owaA==
X-Gm-Message-State: AOAM531WAPaeJfwP/FpHFNsmepCulQ+LOD7Ij1X65K6rebQuz+fJvwVf
        M1gFkJg5h2it+EDtWZ8aZ4Gq/f230J0=
X-Google-Smtp-Source: ABdhPJyAFR8sIj+RWb8fxtbh0zuEGOHKesXlOWZ3ydOzH2ChVJpz1b1krsWqNbdokP5bFXOF3omzBQ==
X-Received: by 2002:a5d:65d0:: with SMTP id e16mr14220592wrw.371.1589780430165;
        Sun, 17 May 2020 22:40:30 -0700 (PDT)
Received: from cosmos.lan (84-114-134-91.cable.dynamic.surfer.at. [84.114.134.91])
        by smtp.gmail.com with ESMTPSA id q14sm15410069wrc.66.2020.05.17.22.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 22:40:29 -0700 (PDT)
From:   Christian Lachner <gladiac@gmail.com>
To:     patch@alsa-project.org
Cc:     alsa-devel@alsa-project.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, Christian Lachner <gladiac@gmail.com>
Subject: [PATCH 0/1] Fix silent output on Gigabyte X570 Aorus Xtreme
Date:   Mon, 18 May 2020 07:38:43 +0200
Message-Id: <20200518053844.42743-1-gladiac@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gigabyte X570 Aorus Xtreme motherboard with ALC1220 codec
requires a similar workaround for Clevo laptops to enforce the
DAC/mixer connection path. This patch sets up a quirk entry for
that. It was successfully tested by a user on BugZilla (see BugLink).

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205275

Christian Lachner (1):
  ALSA: hda/realtek - Fix silent output on Gigabyte X570 Aorus Xtreme

 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.26.2

