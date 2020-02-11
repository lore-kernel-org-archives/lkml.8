Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ECFC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799F1214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZKGrFc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbgBKSs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:48:26 -0500
Received: from mail-yw1-f46.google.com ([209.85.161.46]:33072 "EHLO
        mail-yw1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbgBKSs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:48:26 -0500
Received: by mail-yw1-f46.google.com with SMTP id 192so5694270ywy.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 10:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+kQqg894ymcaPpTU+slbxV54o97AEArgCde/E/E3bK8=;
        b=FZKGrFc5FVnFTZZQnm3tPFg0oD94ghQ5VqaGUx2qBVBlU4FBgKsQXLzTmXhI+totLr
         3J1YcvUYg/r65kODV/71Vu55zJ600BnoSTl4jWLwqgwd8exJy5o2qpqzwQyBykWoDvVo
         Vsru6M9oY+ION7cV0s5uXU7gvO8aw9EEwW+4FC2q4e5wfxrj4WAzq+d1jhHkJ52jUKoi
         6XuFNWndwgXP4B9CyYJ7mWKt6In4v2VahQyNqrc3hh+grUQo/HzOcH/E96FqibsKky49
         syD7h+kJeiEdjBf8zW6vCx799/LSIo6o3uPIkhHu2U/QxP8sp2UvBOQ9DOy8Q5jNZDa1
         S6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+kQqg894ymcaPpTU+slbxV54o97AEArgCde/E/E3bK8=;
        b=lehQ0P/uPGz0YwfYQYl4u0zskHML6ziv+WOn4RowiJAvwQUblHU3AjzJhzEQ9AZzt/
         ZeEBu0iOiD/vopqLOcNRhnJ/Arn4t6nbbws6FtuZJSESzW2l7VMAshGuCdWH7q7n5vu0
         EILI3dv1VvvAtzW6FjS9RSR5LKvqJqTcuD8ssXsS2U/q1e9vqdoXQ8V+y4UNRHda/8Px
         u7V3YNV0E0rLlLik090eXpYH506cKnWVp2U7kicgpy15hfmRh9kbOz2WFT1T5PEx1m84
         VgkmbDZVcmpGQAAsztoTdgUaAqD2QPwB4gQj2L/S1qlJhWsgNx6iOIBG6snFZ4tw5rGr
         5Hrw==
X-Gm-Message-State: APjAAAXYrsOm2atINU8R0eB+KmSG+hHdwE1BSg2QilHIT2/qXEs/mYRQ
        wH4ywlsO8QyYzXa5mWwl7MY=
X-Google-Smtp-Source: APXvYqz+yitDKBvBiImcBkAM8FgYP/5DBkRVCPyXQDlV/fhwFrrf9G3aKZAZ7P/sM9vt68EBYj8tTA==
X-Received: by 2002:a0d:c4c1:: with SMTP id g184mr6620334ywd.305.1581446905354;
        Tue, 11 Feb 2020 10:48:25 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id d9sm2242276ywh.55.2020.02.11.10.48.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 10:48:25 -0800 (PST)
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
From:   Frank Rowand <frowand.list@gmail.com>
Subject: build error: f7655d42fcee drm/edid: Add CTA-861-G modes with VIC >=
 193
Message-ID: <4e918a35-dbcd-b2fd-1888-a86e7d448128@gmail.com>
Date:   Tue, 11 Feb 2020 12:48:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting a kernel build error at version 5.6-rc1:

drivers/gpu/drm/drm_edid.c: In function 'cea_mode_alternate_timings':
drivers/gpu/drm/drm_edid.c:3275:2: error: call to '__compiletime_assert_3282' declared with attribute error: BUILD_BUG_ON failed: cea_mode_for_vic(8)->vtotal != 262 || cea_mode_for_vic(9)->vtotal != 262 || cea_mode_for_vic(12)->vtotal != 262 || cea_mode_for_vic(13)->vtotal != 262 || cea_mode_for_vic(23)->vtotal != 312 || cea_mode_for_vic(24)->vtotal != 312 || cea_mode_for_vic(27)->vtotal != 312 || cea_mode_for_vic(28)->vtotal != 312
make[4]: *** [drivers/gpu/drm/drm_edid.o] Error 1


Kernel configuration:
  make qcom_defconfig

  (arch/arm/configs/qcom_defconfig)


Compiler is arm-eabi-gcc 4.6.x


The build error goes away if I revert:

   f7655d42fcee drm/edid: Add CTA-861-G modes with VIC >= 193


The build error also goes away if I comment out the two lines added to cea_mode_for_vic():

 	if (vic >= 193 && vic < 193 + ARRAY_SIZE(edid_cea_modes_193))
 		return &edid_cea_modes_193[vic - 193];


-Frank
