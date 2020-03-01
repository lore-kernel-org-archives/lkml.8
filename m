Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31E1C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 02:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A685F222C4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 02:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxqEXM8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgCACHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 21:07:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53708 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgCACHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 21:07:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id f15so7525492wml.3;
        Sat, 29 Feb 2020 18:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=mFMK4D+LnUKRd/F79nEwyUOb2aPeDQ33LhkUgHUmiGc=;
        b=WxqEXM8LNzUi/E7hr0gNTnCsdZ3nu91HgDePZERGtz3W9noXE+0ktjuMCq5ufbOiYq
         T8rXIsM/gYs6Eb4CPv0RE7G7jyOzqpE9I6Do9tnbZ2b20Hj2l+5lkGdt17BCST/BU77Z
         zpwE6Z5GZ9PaJk5ovCzdQ+H3SNzV1BOhOkVfpEwDUWJ5Ur2oweOKLRGGwXbEViHuamKX
         mmT7nIeWRgad4+IfBfSvTjsEVj9AzZIEr1DpKrryRclGh9lWAq/Nx9pORGuiXjDl5b44
         NKHzxUVU/75XqVjK2BZU/x5YbQcO/EFzmjmOvkAm6BbkihQCnwHRBj3+MUgvdcIbe2HK
         R+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=mFMK4D+LnUKRd/F79nEwyUOb2aPeDQ33LhkUgHUmiGc=;
        b=KXW4xcrmj3txOQChsA2Y3e3QR2xRYWgZ1cnsjJ5v6XoSeMUaog3TUW1l5TAJ2hJYIr
         jsWcxJFjdcktEiR18oHIRLApsudmQ/wGtGfxiTgWaeTJnGNjg5Yn7PJ7Zlx1vdLLPggT
         etzQA1hAx2WYy90ZFqxprRw+A55x8YmE89yIig2GQ9ioqHrLQga2sGv5GkuHOqoT/OYm
         n5EJ3YGUdqoWp3kwmTepDII27fxGODwAD+//KBCaw8gh7we3Vvo/CLhKGmBkFiBP7ayk
         Zj1N845/KPg578F9VAoSPmOkbniGdTlhybP6SMWJMV9QiJ/EfTe9ZXCe3F788HKoxrVJ
         IuSA==
X-Gm-Message-State: APjAAAWBGoy6WzsKz5ABmjT4ri1NYt4tAiJCdg79axXSUfO6MYdh0q18
        3tKNpfeB3roB9RrzahhhT7g=
X-Google-Smtp-Source: APXvYqzo/NeLjiWLx17CFDKlODf5uCGNKaEDGv01jvjeA8hCO8or8bNmA4KCjZe/q9m0WsEFjEbPaw==
X-Received: by 2002:a1c:238d:: with SMTP id j135mr12374607wmj.165.1583028418492;
        Sat, 29 Feb 2020 18:06:58 -0800 (PST)
Received: from [192.168.1.6] (ppp141237210022.access.hol.gr. [141.237.210.22])
        by smtp.gmail.com with ESMTPSA id f195sm8614206wmf.17.2020.02.29.18.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 18:06:58 -0800 (PST)
Date:   Sun, 01 Mar 2020 04:06:54 +0200
From:   "Leonidas P." <papadakospan@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add txpbl node for RK3399/RK3328
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Carlos de Paula <me@carlosedp.com>, jose.abreu@synopsys.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Peter Geis <pgwipeout@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Johan Jonker <jbx6244@gmail.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <1583028414.33600.0@gmail.com>
In-Reply-To: <6132615.msM8OCcsVu@phil>
References: <20200218221040.10955-1-me@carlosedp.com>
        <6132615.msM8OCcsVu@phil>
X-Mailer: geary/3.34.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I am also in favor of this but I think we should remove the line that 
specifies the txpbl in the rk3328-roc-cc.dts gmac2io since it will get 
applied here in the .dtsi


