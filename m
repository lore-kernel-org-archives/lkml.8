Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587BBC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E5520786
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A66f6X8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgC3Ums (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:42:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41974 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgC3Umr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:42:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id n17so19649034lji.8;
        Mon, 30 Mar 2020 13:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q9dmJd31XEhMYenYHGxi8YuYhFyxM6XMQHq+VN0FDTA=;
        b=A66f6X8lQNBIne5NO0ntEAJDEDYnNwBIz73Tdrfxf3GiMPg1AB2mXl5GB40UwzKxa7
         bZWbkxfhEKJpGG7P6OLuY8UDztGFJ/JfZAhT0FyWHnr0Ht25MLHgspwJV+wnfrWFq46j
         MpcbwYhUJXs1pWmyeW/AdT2yPjCpymvJanazaVokahWPFoh1bXLTDU6pZCuWIwNIPdYP
         v4gflHBdWxYiKfeBsyBVtAg+5+eRX7zlIclt7vDgnJCYz+VAJb4JjmgZ+2Mcc74Vd0dp
         i8Mye5k72gPGFnijorIDp3Q66t2tLmlSuSkElwpdzQ51T+ypjl+8FVNHzdHj8xucT4mj
         Xt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9dmJd31XEhMYenYHGxi8YuYhFyxM6XMQHq+VN0FDTA=;
        b=XT+12CyxKfWXaxmaoqwTRl/5+R07OT8fA5bVY4NMnMtlBJjnitIsFGItuHhuTIcBXg
         S+VrGdbr9+sE8H11VqcsGmjTmy8xSxlXaYUjxgtTn/cjMLwgzSrHxAHkrknuFZ689NWj
         gfgh3j6mRQldHCMTk71oMvRNo2syYVQ9MiWM75FEdqG1MCt/84jy/pyjfnVrrc9Ph/1L
         hKcGUScqu9y7jKhcd/yxQZpyqlaqwNaytLcz8cGlAm+KqK0UbhjgeaptrXgL/Xz8Pkda
         4pJI//VORpqv0AuGCnKhlHZlgxFEVlQblyyDUllReTshELhN9PW7mBriXWkqxcW7iTIp
         dbOw==
X-Gm-Message-State: AGi0PubIHoatj9kF7l6BSn+GRFBOtR19xOWNFTK62RvVRCP/5s/ztnUp
        VxGoZT8bj0wJip1Xlht1AYc=
X-Google-Smtp-Source: APiQypJfqcBA7TyhBQLhNFsjLxFmFe3JYTbJlcU1IjgTFoLg6D02DeJMCMcDI1MOWqZjd6xZNkUSsw==
X-Received: by 2002:a2e:94c8:: with SMTP id r8mr8112416ljh.28.1585600964401;
        Mon, 30 Mar 2020 13:42:44 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id v22sm7287988ljj.67.2020.03.30.13.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 13:42:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: sound: tegra-wm8903: Document new nvidia,headset property
Date:   Mon, 30 Mar 2020 23:40:10 +0300
Message-Id: <20200330204011.18465-2-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330204011.18465-1-digetx@gmail.com>
References: <20200330204011.18465-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices have a 4-pin headset jack instead of 3-pin microphone jack.
The new boolean nvidia,headset property tells that the Mic Jack represents
the state of a headset microphone. This additional hardware description is
needed because microphone detection procedure differs in a case of a 4-pin
jack from a 3-pin jack.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
index a8f2b0c56c79..bbd581a8c5bc 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
@@ -29,6 +29,7 @@ Optional properties:
 - nvidia,hp-det-gpios : The GPIO that detect headphones are plugged in
 - nvidia,int-mic-en-gpios : The GPIO that enables the internal microphone
 - nvidia,ext-mic-en-gpios : The GPIO that enables the external microphone
+- nvidia,headset : The Mic Jack represents state of the headset microphone pin
 
 Example:
 
-- 
2.25.1

