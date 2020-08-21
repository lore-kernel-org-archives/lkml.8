Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43CAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0BAE20748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHn3Pdrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgHUSxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgHUSxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:53:40 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48576C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:53:40 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v22so1933480qtq.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6fEk5o+JtGsEMi+t1XipTCOzTB4EYy5u5pAnjhPn+tc=;
        b=IHn3PdrjjkxPkH4x22lOEh8mz7SNlFAtCTdUqXGkJQNcr2zYGRLUIhWPChaEStztrQ
         fC/X4a4IPpXC+NY6PV3e13wwGSXbSutrgBvEH73X2uTEg6Xexsr19AGU9QjZhTNFNv9x
         NdqMYitYDpykv2AWPTiK4bJrpYsjuc4oSaSL9WWNnMA3QzMNEwiRbL44QUpyJpuBnP5d
         xJdHOFyVMWGVxmdu0QhU8ph4AOeofUo9QO2a8SJma2sX6/7ZSpMj1KUYJDrFphbiyCtK
         qD+CYmbFsLahWwV05hIQgi6XNJ+eYkuoJBqWoH2lTf1YqXyOjVnj6GpNSzTI3//xx9tY
         pl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6fEk5o+JtGsEMi+t1XipTCOzTB4EYy5u5pAnjhPn+tc=;
        b=AqJtplJCMqi7OLL7LKL16orneaOoXso5r8J4yO5dN1QfcNdxSc8Ok58CD3QasCzAF1
         mJWekHRkru1D2xwNdEVMx/t6Q/BUkbB/E0jcxsrmV23O3DxEFfMeuLSxKBr5CiV6o2u5
         ObzL+ZR4+3v2gexMQVhDCFy46lpbmIlAH8tcxc0nCkiZcdAPV92GAAYZxMcF5FdBYUV1
         GvdfFuIdWg1Vq4+fDdrSkQHOD82TWbX990/lWSCnhVy/cTTqyE0xA2pCrrd6eBoVwev2
         dDCK5U9G2PpCTlYVkiQdzkD/k6l1QoSPxV/3kxoKLAep7bNqk3rAjeJO7WaXtl0/sK+q
         fy4w==
X-Gm-Message-State: AOAM531xJZazhjG4FbSh+GHBgU/R4gUhI7F1/fUCuhZiZ81TyGwNhd1O
        jtaKQbQPXL1mEruo5m6Yq9M=
X-Google-Smtp-Source: ABdhPJxqidkPRdoAqeh12zWutA108nXj9dr2/WKtZ5kYfsIuy56E6pDiDC5ku6o7yafxKR14Hb7DfA==
X-Received: by 2002:ac8:4117:: with SMTP id q23mr4029550qtl.186.1598036019416;
        Fri, 21 Aug 2020 11:53:39 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:53:38 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/20] ALSA: hda/ca0132 - Add AE-7 support/Control cleanup.
Date:   Fri, 21 Aug 2020 14:52:17 -0400
Message-Id: <20200821185239.26133-1-conmanx360@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the Sound Blaster AE-7 along with
adding new controls and cleaning up the old ones. I have personally
tested the Recon3D, Recon3Di, Sound Blaster Z/ZxR, and AE-5 cards to
confirm they work with these patches. Another user has confirmed that
they work on the AE-7.

Connor McAdams (20):
  ALSA: hda/ca0132 - Cleanup ca0132_mmio_init function.
  ALSA: hda/ca0132 - Add speaker tuning initialization commands.
  ALSA: hda/ca0132 - Add surround channel config control.
  ALSA: hda/ca0132 - Add full-range speaker selection controls.
  ALSA: hda/ca0132 - Add bass redirection controls.
  ALSA: hda/ca0132 - Remove surround output selection.
  ALSA: hda/ca0132 - Clean up ca0132_alt_out_select.
  ALSA: hda/ca0132 - Add quirk output selection structures.
  ALSA: hda/ca0132 - Fix Recon3D Center/LFE output.
  ALSA: hda/ca0132 - Add new quirk ID for SoundBlaster AE-7.
  ALSA: hda/ca0132 - Add SoundBlaster AE-7 pincfg.
  ALSA: hda/ca0132 - Set AE-7 bools and select mixer.
  ALSA: hda/ca0132 - Add ca0132_mmio_init data for SoundBlaster AE-7.
  ALSA: hda/ca0132 - Add pre-init function for SoundBlaster AE-7.
  ALSA: hda/ca0132 - Add init data for SoundBlaster AE-7.
  ALSA: hda/ca0132 - Add DSP setup functions for AE-7.
  ALSA: hda/ca0132 - Add output selection for SoundBlaster AE-7.
  ALSA: hda/ca0132 - Add AE-7 microphone selection commands.
  ALSA: hda/ca0132 - Add AE-7 custom controls.
  ALSA: hda/ca0132 - Add AE-7 exit commands.

 sound/pci/hda/patch_ca0132.c | 1794 +++++++++++++++++++++++++++-------
 1 file changed, 1430 insertions(+), 364 deletions(-)

-- 
2.20.1

