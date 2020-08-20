Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124D0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E182D20786
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597905333;
	bh=ErMMAe2L27D4w6o1aKREy2/vwt6gkJXftaU2eA0RGLw=;
	h=Date:From:To:Subject:List-ID:From;
	b=pYUWHr5fXALMTvcmtU0E1agJSUchNuaQ4/nyapP0yO2cDKBIjgVD8TpBygnPLPooC
	 G7F01KRD7EnFCHBOIIJX818a8RGddCs6uzKZcRGVtRTlC6oiBCI6WSEwQuQVktMMPM
	 w5fiEox2JZTAxhFpKQA1dgGQWYUbulqNhkS++LM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHTGfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHTGfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:35:30 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A34BC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 23:35:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id f24so1222333ejx.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 23:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=FDAZX3BWtlT3nDwxucs41QpogMSugFHgKBFFN3K6pCc=;
        b=aZMcJaCcgPqBPHEwJQEji+9jE9lyvhDdmrPqfJGjKQoreAqPu7YF+A5BdjsM5sR/1K
         iWSZ2Ig3XDSYlNfsM5+BgPdVkN/IMr3G0Uo22b+FBISOZC4SdGxDDcjgt86oOq/RwcZZ
         4lAsf4+gXP+IbWk6xSh1bDp7H8xg0+0pRUEuvDmdusvHK21yfHWxQDj9mUrVR5lODsBf
         JBneSIHwo2P7kFjFkucIHByELw/Qttm7nMPj0/KoHZIchr8hEorYUjqHizhunwBKSC9m
         +x97puZu36ef0iTRCgZXnuep2DTzmonYBHWwzNPqLYwDgcwOOFQSACqWhvuay85gADuf
         qPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mime-version:content-disposition;
        bh=FDAZX3BWtlT3nDwxucs41QpogMSugFHgKBFFN3K6pCc=;
        b=HjgdrdR+08psLPTtqaww8OJKNCTfaC65QFCwvuw95rTBIRpkve/vJew0okxYJWLTUZ
         C3fzVu5h/dO5jACfNc+SaKwEqVm5Un73lXiAQAZ7WYUquftOcEkIepNUFxEGGhUwNRFn
         7TafkGNL9SwX/tMg1xwd+9w1br4r9Pmb75Ko+sE/sPUhXAmRXG/6o93attaHzd4cfNDd
         kbQtUvjY5/pgn6uUEZDbOaAGdsFbvpwD6CBHrkem7KExGPRlmTjtqKxa38t8h9FDPeMo
         LZHpVYiapznzYoHRuM1zRjxfXTybjhINKO/g+o8n7IZG+Qi0YNZCh1NDx/vgZD4UVSRB
         awDw==
X-Gm-Message-State: AOAM5331pRSUUVz/vaiksRRwGwcVutVVWiV7JT5ml6pS2lPwrLeRLIDc
        AWf+unxwRkuq4X1CMHECEbrd38o80O4=
X-Google-Smtp-Source: ABdhPJx6MxgZdcAyDzbl6wuAWtZJB7gFQDp+TG7MQcc2AYhfm1+Z5aK+HF4WFCSIAQbK93LvocOuYw==
X-Received: by 2002:a17:906:1c84:: with SMTP id g4mr1972438ejh.50.1597905328777;
        Wed, 19 Aug 2020 23:35:28 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id cn27sm724436edb.4.2020.08.19.23.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 23:35:27 -0700 (PDT)
Date:   Thu, 20 Aug 2020 08:35:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH] kbuild: Run syncconfig with -s
Message-ID: <20200820063526.GA3278096@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On every kernel build that runs --syncconfig, there's an output of the following line:

  scripts/kconfig/conf  --syncconfig Kconfig

This is the only non-platform build message the kbuild system emits that isn't
prefixed by at least a space, or is a build warning.

Run it under -s - if there's any problem it will emit messages anyway.

With this change the following simple grep filter will show all build warnings
and errors of a kernel build:

   make | grep -v '^ '

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9cac6fde3479..2057c92a6205 100644
--- a/Makefile
+++ b/Makefile
@@ -709,7 +709,7 @@ $(KCONFIG_CONFIG):
 # The syncconfig should be executed only once to make all the targets.
 # (Note: use the grouped target '&:' when we bump to GNU Make 4.3)
 %/config/auto.conf %/config/auto.conf.cmd %/generated/autoconf.h: $(KCONFIG_CONFIG)
-	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
+	$(Q)$(MAKE) -sf $(srctree)/Makefile syncconfig
 else # !may-sync-config
 # External modules and some install targets need include/generated/autoconf.h
 # and include/config/auto.conf but do not care if they are up-to-date.
