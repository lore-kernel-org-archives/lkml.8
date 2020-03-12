Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EABBC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFCB2071B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+5Z+2xK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgCLRWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:22:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39280 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgCLRWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:22:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id f7so7257039wml.4;
        Thu, 12 Mar 2020 10:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Wy+lE/1lzqrBWgr4qGqulWltQuGidDCwcinzvkx26bY=;
        b=J+5Z+2xKMn1aIC0Uo2VC9f/lb55f3cqFfWZj5j1p0lphY5XIDra1fpkc65qmhCFKGH
         PWYVvNENVeQHN+rQtmr87GkugtvbXMwwNydg0Qsdf6YQnMJlQRwKgC3ksC/LDYm6iVbV
         tqs8r3NS9FDGtv1emvZBbMXBcYjJWE5q/fdFEzYgRjxbIWDvxT64WYyIVnpf+oFv9Hil
         ibu/wC1ULKbyQWjmFxELT7Z3UuIYKv+VAdw5v5dG0YIdU9haHa2rx7MRDMlZg3oJ6Qsu
         nW1NcF7FhtB7L+7XNshghcODee93iH5lj+FVmjHqbCEmSOr3M37pYB1rn+aFKC4zSis7
         ddkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wy+lE/1lzqrBWgr4qGqulWltQuGidDCwcinzvkx26bY=;
        b=VAybQWX48TcKds+LU6WvEXgTyo1PJd6fylvNRb/XSLkr2+lXz+q4g0ij0UBrwqduhl
         70G9g5XbJYp8z/RMUfxtUL3FjixrGeqLm2Fke6RB2yFrutmK1qm/DJosUl9cGKm0OqK6
         guS9SANTMF9KdT6epdk2pxScpiIdt4JVcZFnq6thhD2ib4YBcpp9/rJ3YhXxUxlxkCbo
         EYeZOmzy1mYd+IvtwZgqKdw8AsLKWzpf6F3daqeJ23DEIrK+dadTSIxuLgmr5g5TmQbd
         Pf+dAAEBme41HrM74RCofpdxOgdbyeUz5MB9mWlwt49p4/HDuqYp6z6zeIcZEiCYUurD
         zyrg==
X-Gm-Message-State: ANhLgQ1ZdwJ06I1w4fz47le9b3f+XJLKd1jFifWzKZ1auCgph3IIXoQz
        W7e43AnRA7GB2FBUyrEQ/p8=
X-Google-Smtp-Source: ADFU+vvfIDpBkUD9w0w0y9O0EdtJTyviZVdZcBsPGD0KGGOBs+1FdKuhcvmu1jQbjlNqHpBDIAFSCA==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr5831317wmj.170.1584033767636;
        Thu, 12 Mar 2020 10:22:47 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d7sm2064492wrc.25.2020.03.12.10.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 10:22:47 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: rockchip: remove properties from spdif node RK3399 Excavator
Date:   Thu, 12 Mar 2020 18:22:39 +0100
Message-Id: <20200312172240.21362-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An expermental test with the command below gives this error:

arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dt.yaml:
spdif@ff870000:
'i2c-scl-falling-time-ns', 'i2c-scl-rising-time-ns', 'power-domains'
do not match any of the regexes: 'pinctrl-[0-9]+'

'i2c-scl-falling-time-ns', 'i2c-scl-rising-time-ns'
are not valid properties for 'spdif' nodes, so remove them.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/rockchip-spdif.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
index b4d8f60b7..73e269a8a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
@@ -230,7 +230,5 @@
 };
 
 &spdif {
-	i2c-scl-rising-time-ns = <450>;
-	i2c-scl-falling-time-ns = <15>;
 	status = "okay";
 };
-- 
2.11.0

