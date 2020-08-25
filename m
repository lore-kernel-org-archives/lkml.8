Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05840C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0EC20706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NfYTCdeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHYF0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 01:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgHYF0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 01:26:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF63C061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 22:26:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 83so13723323ybf.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 22:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=LXGQz3dUPtoQDrSSVVfnKwCnxD+dn14EASNuB71qWps=;
        b=NfYTCdeLik8nJHJ5W4Tzig5h9ofDMnLBuPWzZCTEfqi8uMCurIa2DrrmIuBV0yl/gQ
         ndZfPCAipt4EMz1ePICSNhkeLQ/HnPG6Ix14Doua+1ifnEUiA4/uX/M8GghFDb0fQBRy
         h/WDsoN/Z2322NPGYOO4daokc1abHQ2FF+21vQIBXM6I1WKzV23/juUjxRAfvIFk3yUS
         vITMdYOnP0+9rmp3WenpSiGZJd58GEO2FJvUUL9daC7sLU2fO4TBRFugkiX5LjjPlUqe
         vQ+nR57aBa17NAsIww2HrUlg4xTGOE/JpNNm3ZPhX9XgoMeZuoUrtbXHRdlRMGlnFg3+
         j+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=LXGQz3dUPtoQDrSSVVfnKwCnxD+dn14EASNuB71qWps=;
        b=HxQqRdtirJsWSZsGNkU68UuN1AVqBlazzHp8cBYlDhzmUD2q2fSjzkJs0MPXvv+NbA
         alA/cRxqJebkuHbr+s7epxLtWCdkU8+uIWprgXz3pxoGCU5qRDtveg7AtLJijDtsBtlq
         8FrePO0rthn6w7J8kuH9altxCL5bkdkSuwVInVIH9ZJyDZYEDpkmLTvl08veXySG8KV+
         2uyRaePxeL9CsdLNhKwbaNfISWZi3U7GcLROkEEQSMP4MuNPzcDUCBTa2JNcWlpYRQNQ
         48R7MDuLfMp6MHvQgepTPOv05cURPhOOOMOA+7sV9/kM4g4EXrkmhydlLYBJdF3VnHe1
         Q87Q==
X-Gm-Message-State: AOAM533dLLblHkZ7K8kGz7TFXPu6kkVoOx+nKFVrKbSfbJ+aOiWcmd6d
        03th77tVClS6AkyGOnvl+EnqDIkWps8L
X-Google-Smtp-Source: ABdhPJzucRsZmc5RkVsCa4ewK6Q7FHUmorTbrz/iKmabcsEFOS5l9YC8Q8uA5a0g28dzMhczWRrg2G7qU62o
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:725a:fff:fe46:72ab])
 (user=amistry job=sendgmr) by 2002:a25:b196:: with SMTP id
 h22mr12483522ybj.350.1598333168733; Mon, 24 Aug 2020 22:26:08 -0700 (PDT)
Date:   Tue, 25 Aug 2020 15:26:01 +1000
Message-Id: <20200825152551.1.I6d12081e37d27ba7580a1af877727d882935787a@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH] CHROMIUM: arm64: dts: mt8183-elm: Set GPU power regulator to
 always on
From:   Anand K Mistry <amistry@google.com>
To:     linux-mediatek@lists.infradead.org
Cc:     djkurtz@chromium.org, Anand K Mistry <amistry@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep the da9212 BUCKB always-on. This works around an issue on Elm/Hana
devices where sometimes, the regulator is disabled before scpsys is
suspended, causing the suspension of scpsys to fail.

Usually, the GPU and scpsys are suspended by the runtime PM before the
system is suspended, due to the GPU being idle. In this case, scpsys is
suspended inline with the GPU suspend, which then disables the
regulator. However, if the GPU is still active when system is suspended,
GPU suspend occurs but defers suspending scpsys to the PM's noirq phase.
Since GPU suspend disables the regulator, scpsys isn't powered and
suspending it fails with the following error:
[  523.773227] mtk-scpsys 10006000.scpsys: Failed to power off domain mfg_2d

On resume, scpsys is resumed in the noirq phase. Since scpsys requires
power from the regulator, which is still disabled at this point,
attempting to turn it on will hang the CPU. A HW watchdog eventually
reboots the system.

The obvious solution would be to add a link to the regulator from scpsys
in the devicetree. This would prevent the regulator from being disabled
until scpsys is suspended. However, in the case where suspending scpsys
is deferred to the noirq phase, disabling the regulator will fail since
it is connected over I2C which requires IRQs to be enabled. Even in the
usual case where scpsys is suspended inline with the GPU, PM will always
attempt to resume scpsys in noirq. This will attempt to enable the
regulator, which will also fail due to being unable to communicate over
I2C.

Since I2C can't be using with IRQs disabled, a workaround is to never
turn off the regulator.

Measuring power on the GPU rail on a Elm DVT shows that the change in
power usage is negligible. The two relavent cases are S0 with an idle
GPU, and S3.

In S0 with an idle GPU, current behaviour with the regulator off:
@@           NAME  COUNT  AVERAGE  STDDEV      MAX    MIN
@@         gpu_mw    600     1.74    1.31     6.75   0.00
... and with the regulator on, but no load:
@@           NAME  COUNT  AVERAGE  STDDEV     MAX    MIN
@@         gpu_mw    600     1.68    1.25    7.13   0.00
The difference being well within the margin of error.

In S3, current behaviour with the regulator off:
@@           NAME  COUNT  AVERAGE  STDDEV     MAX    MIN
@@         gpu_mw    600     0.94    0.74    3.25   0.00
... and with the regulator on:
@@           NAME  COUNT  AVERAGE  STDDEV     MAX     MIN
@@         gpu_mw    600     0.83    0.66    3.25    0.00

Signed-off-by: Anand K Mistry <amistry@google.com>

---

 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index a5a12b2599a4..1294f27b21c1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -304,6 +304,7 @@ da9211_vgpu_reg: BUCKB {
 				regulator-min-microamp  = <2000000>;
 				regulator-max-microamp  = <3000000>;
 				regulator-ramp-delay = <10000>;
+				regulator-always-on;
 			};
 		};
 	};
-- 
2.28.0.297.g1956fa8f8d-goog

