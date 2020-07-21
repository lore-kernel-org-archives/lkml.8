Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEBFC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B4620729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FBZxMoMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbgGUVOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbgGUVOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:14:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B185DC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:14:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a24so43640pfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Uk6YJuT856BNR4iZImXQR7yVi4i1mDik67FAAf4cPZQ=;
        b=FBZxMoMsxylHjcUvAbhV6gmt7acj3lLOJeUs0rme23xuscRhD6htClpZIjUn8KUD9y
         rQnb9qIfFNIqnf6DuMVaigHowzFvaponsCjdWoZRaXsEYhqFSEU6CZmj4b5nj0Asua/Q
         J/PKIHwCeH6HyQauOGtDc0TAtt7ZHRN6I2KJ7bvrsiy98O1LmyQVnsaqV61SKlfD7Xgf
         MmqjBgglGJ4Cv5dJF/cPTjvviKjfzviRlLx+q2yprJQgm0u520iCHvxend/i4bu311Oz
         d5ZnFiNLg6SLyfXNhdHgIbm8VZQdscvTWj0zqsK5QKbuU8fJ22Z6mwET+015vmi0B4hL
         5IOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uk6YJuT856BNR4iZImXQR7yVi4i1mDik67FAAf4cPZQ=;
        b=diuJhdm8Q6DamTIOVKa9NzTqXOvswkaPShDqZNgunC0jawPHb4NlpnxnoF8pWwZPjj
         MgEHiQUs10wzrGF2aOyaqb9OswH2uFPAeV4SSuHk2ijBPAWfYieLxgfQrsJcJqgw4Nt8
         uIv+PyXJGOtukSo+/DAEOlI9dYqYFqVSYKwvxcWxrU8YwkQEUkm4vYbhqvFbHBiakAI+
         KjVP2RSoe8TdiFUwm108KCjhRWLKYHbTLxpMEHgZeeaLWqAz+CJtt9tUSRUilk7lT1TS
         fjrVRoXZfmyafdi/b+0OQKEky8oBqqKpKRihauDc/C0fJ6RQ4U4JVuhEY8XOskZd3kLm
         rd4w==
X-Gm-Message-State: AOAM530qk7FL0BEsoqolYKZ1wnqVsQL54ADvipv28qco7x4Wbtv9eS0K
        G+mS4ctt1ce3gIPF5ZADPpwz6g==
X-Google-Smtp-Source: ABdhPJybylTdnd9qyJY0SEkfZfMZYm9qVAb/EXUZnxUlWpc4ybwM7APQ7Rfpu652uIRJWWkcFky5tg==
X-Received: by 2002:a63:457:: with SMTP id 84mr24534756pge.219.1595366088049;
        Tue, 21 Jul 2020 14:14:48 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id gv16sm4208949pjb.5.2020.07.21.14.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 14:14:47 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] arm64: dts: meson: add more SM1 soundcards
Date:   Tue, 21 Jul 2020 14:14:43 -0700
Message-Id: <159536607960.30777.2402620386587255771.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200718072532.8427-1-christianshewitt@gmail.com>
References: <20200718072532.8427-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 07:25:30 +0000, Christian Hewitt wrote:
> This series adds basic support for LPCM audio over HDMI interfaces
> to the Khadas VIM3L (reusing the same config as the VIM3) and the
> HardKernel ODROID-C4 devices. I'm sure support can be extended to
> include other hardware but this gets the HDMI port working as a
> minimum capability. I have personally tested with both devices.
> 
> Christian Hewitt (2):
>   arm64: dts: meson: add audio playback to odroid-c4
>   arm64: dts: meson: add audio playback to khadas-vim3l
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: meson: add audio playback to odroid-c4
      commit: 725da67ce4d77540d4d6f7ecc3ac5a885a684716
[2/2] arm64: dts: meson: add audio playback to khadas-vim3l
      commit: b8b85d01be916a30c9863a5456c218d802e01d97

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
