Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7989BC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348F22192A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpP4z647"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgBFWqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:46:55 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43712 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgBFWqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 17:46:55 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so80536oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 14:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=mRfn9CMlX/X35LGWUqX09L+aJqRjTqZEyr0DskyPEVk=;
        b=YpP4z647YJNTgMYDaCbmfNNSE81aL3av7qBko0/VdtiGhZSvur6WtjtYSWHkjDAIoM
         BdOhCFg/OclcKtXF8ytjWJWduHIG7YXU85bFNUgXf338ijk9OV+cqc9/WjjhuE5qwXcc
         JkhXHDNyLonrgI3ihoO0oyG917X6ifHyDW2Bv1okERhRnaFOrrVfQxArgEk5ojwC57gP
         VdNp6r1ZJBEIld6vnHuY6orzdh4MjGqsXuTrPXdc3VkDZsNIxHP5Ig+msMLEID/DJYEV
         d0USKt/26FLPQMc3USE+pkmkIqHyosIqOcVsw//7bawSc7DpPCHR35TvSYtdMeEbsyiJ
         G6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=mRfn9CMlX/X35LGWUqX09L+aJqRjTqZEyr0DskyPEVk=;
        b=jgnYHNNqFfnReY9w3wLOX1/TVcNHg6wWNOa+NLieEXVjDI0QHdkJfjFVBbGXDE5y/T
         l++wyOt5/vL77yhYDTpufu5OGQDe4eF9lEpHJhGY775+VAApTxq0m4eHwkiLdTCT0wnt
         qTo9vgXoGFyRTgkyszhbszFaeSmQFSEXjABRdS5eBeOtv16flD4nwcX6GYJU9c/flZ9M
         MIBAXvJE2Vj6fFlhrlK2PIv5rrwaPx0oPgWaEmEDWTXnYO+MakDTbKZWfHo5OZrnrtCT
         N2d8bl9lQZZ6qeRdK2AA7BVTgTTxYbZIjzWQCaPSWZyTx4argYaUibzIuYbM5thIqu4p
         si6w==
X-Gm-Message-State: APjAAAVegS1nF5/1HdtGoWdy6vXMUagMXvMePvR7v9tZTx6Ge1QYKxN4
        rOCoAhr23yBaVJYhoOWvOb4=
X-Google-Smtp-Source: APXvYqyrKNbNDWFqb6VTc7OysBx1MqLemYXBPyd8xS/tJ7PY+mI9Aw7k0tEyCCHESSnDY/bxANiEfw==
X-Received: by 2002:aca:554d:: with SMTP id j74mr68745oib.92.1581029214126;
        Thu, 06 Feb 2020 14:46:54 -0800 (PST)
Received: from [192.168.1.120] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id z17sm369196oib.3.2020.02.06.14.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 14:46:53 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Tom Anderson <thomasanderson@google.com>,
        Hans Verkuil <hansverk@cisco.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Error building v5.5-git on PowerPC32 - bisected to commit
 7befe621ff81
Message-ID: <0fb64c98-57c2-b988-051c-6ba0e460ad37@lwfinger.net>
Date:   Thu, 6 Feb 2020 16:46:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building post V5.5 on my PowerBook G4 Aluminum, the build failed with the 
following error:

drivers/gpu/drm/drm_edid.c: In function ‘cea_mode_alternate_timings’:
drivers/gpu/drm/drm_edid.c:3275:2: error: call to ‘__compiletime_assert_3282’ 
declared with attribute error: BUILD_BUG_ON failed: cea_mode_for_vic(8)->vtotal 
!= 262 || cea_mode_for_vic(9)->vtotal != 262 || cea_mode_for_vic(12)->vtotal != 
262 || cea_mode_for_vic(13)->vtotal != 262 || cea_mode_for_vic(23)->vtotal != 
312 || cea_mode_for_vic(24)->vtotal != 312 || cea_mode_for_vic(27)->vtotal != 
312 || cea_mode_for_vic(28)->vtotal != 312

This error was bisected to commit 7befe621ff81 ("drm/edid: Abstract away 
cea_edid_modes[]").

This problem is clearly a problem with the gcc compiler on the box, namely gcc 
(Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3. I had no success finding why the 
attributes were wrong, and finally settled on the following hack:

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 99769d6c9f84..062bbe2b254a 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3272,6 +3272,7 @@ cea_mode_alternate_timings(u8 vic, struct drm_display_mode 
*mode)
          * get the other variants by simply increasing the
          * vertical front porch length.
          */
+#ifndef CONFIG_PPC32
         BUILD_BUG_ON(cea_mode_for_vic(8)->vtotal != 262 ||
                      cea_mode_for_vic(9)->vtotal != 262 ||
                      cea_mode_for_vic(12)->vtotal != 262 ||
@@ -3280,6 +3281,7 @@ cea_mode_alternate_timings(u8 vic, struct drm_display_mode 
*mode)
                      cea_mode_for_vic(24)->vtotal != 312 ||
                      cea_mode_for_vic(27)->vtotal != 312 ||
                      cea_mode_for_vic(28)->vtotal != 312);
+#endif

         if (((vic == 8 || vic == 9 ||
               vic == 12 || vic == 13) && mode->vtotal < 263) ||

Disabling the build check allows me to build and test the post v5.5 versions.

Larry
