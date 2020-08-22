Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D07C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 21:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCCCB207CD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 21:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+QXDwWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgHVVP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 17:15:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50208 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728478AbgHVVP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 17:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598130956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=kCeFAGVjFqJLQdc3o1tYQIxy58jDPQXZfRClMoCDccQ=;
        b=g+QXDwWGc6q4B7FYeGXtWx3n3PvIglHsEv/37eRAczGNDRlZ4M0BA4lx4qqFniAKT3MmUL
        WWZ16HoBk2xjvLjjLykOJKaJnYH7dAuQ0WZ5W5R5kmbXGr142Y+EywqqoYAQuYwa0zCe/7
        k1BIDew9fjnlYVjfzeT30MLno1DguKw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-WFMd4jxgPmuJ-qdZvFXGPg-1; Sat, 22 Aug 2020 17:15:54 -0400
X-MC-Unique: WFMd4jxgPmuJ-qdZvFXGPg-1
Received: by mail-qv1-f71.google.com with SMTP id p15so3636965qvv.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 14:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kCeFAGVjFqJLQdc3o1tYQIxy58jDPQXZfRClMoCDccQ=;
        b=Q9HfydkQA8QCIfDi0bVyN1phQuBtnqO456acMYqgoKekudAeoJBYItXNhmtAfxEIuN
         38cdGugi2dcaUYfIZFxPBbIcEjDIA1lU+pGOSxLWKWTWsGfLcSSYu0bRw9YDX6i07w+P
         gGZ/7yEdeIPJJhyCijXyhunx1qNqbN54Ag9nyjnN4VrqBDSjLdKnHYTZWT7nKGzUqdSi
         QV22JQviKpifODpkY2mmH1L8nbVkfeheIEn+M+13J5f0FKRmrTH/GHMAHnfoPqmVJDcc
         SWKJQN4fxAkYXrkp2zSFcQ7aDMhxf6Ix6Tr1Re8gGqmIJqoWbqMu64DC22BY/lGuLdxq
         255Q==
X-Gm-Message-State: AOAM531GRGCRSAyYlr+e/9rgbCWGrSpxWUTk4zbc2KJcCgW9uBvEB3vS
        5xsCvAYBWPCC3JPgz3QY1/A0doi/RaJphFhcoaM14YMJWnUZtRAQCH2G4Lkofn94UngTFZVSaTd
        xsCerlugodYf5ikOp/amdZhB7
X-Received: by 2002:ac8:67da:: with SMTP id r26mr8107598qtp.332.1598130954074;
        Sat, 22 Aug 2020 14:15:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznW20o6pLcfbuLeN9PqYmhQbUbKp5bO7nim+GspqDuutoEBbwdn7aWc4EzVYzUqhSKIzqm3A==
X-Received: by 2002:ac8:67da:: with SMTP id r26mr8107582qtp.332.1598130953798;
        Sat, 22 Aug 2020 14:15:53 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o17sm6416894qtr.13.2020.08.22.14.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 14:15:53 -0700 (PDT)
From:   trix@redhat.com
To:     mchehab@kernel.org, mkrufky@linuxtv.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] media: tuner-simple: fix regression in simple_set_radio_freq
Date:   Sat, 22 Aug 2020 14:15:47 -0700
Message-Id: <20200822211547.4595-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem

tuner-simple.c:714:13: warning: Assigned value is
  garbage or undefined
        buffer[1] = buffer[3];
                  ^ ~~~~~~~~~
In simple_set_radio_freq buffer[3] used to be done
in-function with a switch of tuner type, now done
by a call to simple_radio_bandswitch which has this case

	case TUNER_TENA_9533_DI:
	case TUNER_YMEC_TVF_5533MF:
		tuner_dbg("This tuner doesn't ...
		return 0;

which does not set buffer[3].  In the old logic, this case
would have returned 0 from simple_set_radio_freq.

Recover this old behavior by returning an error for this
codition. Since the old simple_set_radio_freq behavior
returned a 0, do the same.

Fixes: c7a9f3aa1e1b ("V4L/DVB (7129): tuner-simple: move device-specific code into three separate functions")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/tuners/tuner-simple.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/tuners/tuner-simple.c b/drivers/media/tuners/tuner-simple.c
index b6e70fada3fb..8fb186b25d6a 100644
--- a/drivers/media/tuners/tuner-simple.c
+++ b/drivers/media/tuners/tuner-simple.c
@@ -500,7 +500,7 @@ static int simple_radio_bandswitch(struct dvb_frontend *fe, u8 *buffer)
 	case TUNER_TENA_9533_DI:
 	case TUNER_YMEC_TVF_5533MF:
 		tuner_dbg("This tuner doesn't have FM. Most cards have a TEA5767 for FM\n");
-		return 0;
+		return -EINVAL;
 	case TUNER_PHILIPS_FM1216ME_MK3:
 	case TUNER_PHILIPS_FM1236_MK3:
 	case TUNER_PHILIPS_FMD1216ME_MK3:
@@ -702,7 +702,8 @@ static int simple_set_radio_freq(struct dvb_frontend *fe,
 		    TUNER_RATIO_SELECT_50; /* 50 kHz step */
 
 	/* Bandswitch byte */
-	simple_radio_bandswitch(fe, &buffer[0]);
+	if (simple_radio_bandswitch(fe, &buffer[0]))
+		return 0;
 
 	/* Convert from 1/16 kHz V4L steps to 1/20 MHz (=50 kHz) PLL steps
 	   freq * (1 Mhz / 16000 V4L steps) * (20 PLL steps / 1 MHz) =
-- 
2.18.1

