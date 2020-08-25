Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC385C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09872074A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6gxX5XA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHYULD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYUK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:10:59 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D12CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:10:59 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id u3so12288719qkd.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=anJ6TO8IF7oTrWX6oY0NrEzQ43dkonEIWniqSuGEw7k=;
        b=Z6gxX5XAKrY7ka/Z1pfQY6IKhNJvCTGLjtwD6vFCE+OMhO+nbMF6yvvogcDOYY9YBR
         tBMvAU2tV0eAviS+VKwmbmdIQ3AsLh+21lnUQdRynUTQL2pJneUvy4qO3eIrhyYfYmaq
         JyfZUqe9f5bzLDpvHYbmk2HF6ywjaAWSYxEoMFXrjOHHINsgG5xfv31tlvWZiOH9SEr4
         pXL/3LuMJgejwbfG+UkJpAMLvKNsvbfeJf46/8Bi2iRWm0oSzcZwnuLrKSMKGNSbmmtj
         348fGan9+a/EIuuPTYLPEJX9TC+nEeqXJHiLIsOrPUv7uO3vmsBNLOpN3UE2Mjyaggyo
         6SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=anJ6TO8IF7oTrWX6oY0NrEzQ43dkonEIWniqSuGEw7k=;
        b=T87ZhlHIvjnk6nhT+FiH9C9ASYW8Vu5fp2JXKfYRfMeXWnUC7ayvVjYXdC/LMoGKgB
         3k8J9IDI3gSHMnQoKV79VFdo6JZHqZLwROc6u29LZ4F3kTRKyoMTKBfUThVOyVAZfTNv
         ZULU4W3MrJMPL215qaN3H3VfCi2dN4k2SJaz+acOOZSvm2tpFZoLmRmDuX/RUkgrSBGH
         HOwGslcqeggpC9ighFkKf55irlBimsnF4ENLjsXp89vSC3Vv2lotSAgPTYNMEJ3n9+Cj
         H3oQ/qPyfhI5WrtONErt5vapGLUd7U8WyikTyF1eMy0eUtKTnJqh8tBDUkoS+AtCTVLr
         mNcA==
X-Gm-Message-State: AOAM530cycDJKBCEZVwsfIw9cfSI6FVdk9CbuoVG8JI4o3zAWPCS12Ed
        37D4idTsM9NdEz0ZEPS7t3A=
X-Google-Smtp-Source: ABdhPJxyCscw1gPTxYOvCaAOCWN2I2GU+PLFxjx9g7Jmishi7MajeY/cgiqo1v1Sdex0/PAl89qC4g==
X-Received: by 2002:a37:64d7:: with SMTP id y206mr10565741qkb.133.1598386258281;
        Tue, 25 Aug 2020 13:10:58 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id n23sm12453459qkk.105.2020.08.25.13.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:10:57 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/20] ALSA: hda/ca0132 - Add AE-7 support/Control cleanup.
Date:   Tue, 25 Aug 2020 16:10:19 -0400
Message-Id: <20200825201040.30339-1-conmanx360@gmail.com>
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

---
v2: Change control names to omit unnecessary information.

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

