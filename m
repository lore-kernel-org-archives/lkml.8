Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B9AC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5212F20724
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgCTQ1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:27:19 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55615 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgCTQ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:27:19 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mj8eD-1jjB8C0bjR-00fA6M for <linux-kernel@vger.kernel.org>; Fri, 20 Mar
 2020 17:27:17 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id E59B1650374
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 16:27:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2sEak8lm4fTd for <linux-kernel@vger.kernel.org>;
        Fri, 20 Mar 2020 17:27:15 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 8BA9E64FD31
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 17:27:15 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.8.5.41) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 20 Mar 2020 17:27:15 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id E8DB480501; Fri, 20 Mar 2020 17:11:47 +0100 (CET)
Date:   Fri, 20 Mar 2020 17:11:47 +0100
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        <devel@driverdev.osuosl.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>
Subject: [PATCH v3 04/11] media: adv748x: add definitions for audio output
 related registers
Message-ID: <c4314afadd7e0882d8e2cbcbe2fe9c6a46775016.1584720678.git.alexander.riesen@cetitec.com>
Mail-Followup-To: Alex Riesen <alexander.riesen@cetitec.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        devel@driverdev.osuosl.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <cover.1584720678.git.alexander.riesen@cetitec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1584720678.git.alexander.riesen@cetitec.com>
X-Originating-IP: [10.8.5.41]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6D7660
X-Provags-ID: V03:K1:JPQtecOT6Xe/vZgyik8AGa0L3B+DLUrx8MdYsdsRMvPg2ccEcdG
 CoYbtlDUtkzMuT1fOLUi1wrTWS49lZyCMkSY/XwzZN8XT4brA4Vr4LU3p75lrW3J6R/Npg9
 +aOXGjl2ZgP7u8dMkSblf7YT94kXuMKAARszFRWKII/SRJu5evg6roEeUmdCpQyEJbdBbPE
 B5onA4yFNPKQ6lRKcUhIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QBEPN5o03M4=:ZfCytaNYMu6KazjM/T1RSv
 ZgliicnEFogJlhviZdhmHjTM8zvJuD65+U0sqfNE50pq5VWeThipzjivg4S+7LAqs+PjaQM0H
 6PXN/QIu8+cNC7GB6gaBZ4CzTkvd4gr+jdfZlPpVH+q5ohXLmEbaDzFK/x7bhT0C1d9sXw/Ry
 gtOm9OxfZOZeH4b0HWBQpzmyNFqmdYtFTA9UMUQ0pjmBquDOg0epxC9vTg+JFif18/KjOoTfw
 uJtaIMtB7fMmm56J5i91HsqyXnxOQps3vxv18Arvfb+MalfODPIQKchm6eSfRau0RhCVOpbWm
 w8Ni55RvujYywS+1S69USfUpYcM1GLfKAPQCqUtsxkmy+XT43AQdkUHgL98z3lIJg1S1B9E9z
 8RPAIXH8RibszGXnI1+vUkVglwxqJS2zh/Uj+ly2ZgMvcB6CquNG1eO01Q+/DhUhNhQwUfsIn
 4RrV7gBu3aUo5GAi+VB5AzW6lP0Aj2/MQ6pi9Y+TQY3G0IE4gtVE6j+YlLA8fxlmw4DtyQDKF
 qB5ufYcoQIuEXh+VL28bzu0jJ9sCBJDBZCDDtKpm4EFdkAMV+UzmQRrOXPPmwJN/FoF62zlD4
 BaPV6ByxRtLFZRvPehAFy9H8RUoSfelC9GQPpRfaFnaFfRS4BFlz1z+C/ayCb6xQxd40HOszd
 z853Zbw/Ia1sunQAzLImanohczu4xMxKdI0T0PJWYUU+SZDdQOjqJtDXermALSMZONZ8SGlgM
 4nJMt2uGDg/Z7gblpsEdpw5D3XPsEnB2hurb66BwfCWjs+xsrdgvg1v6hb9DJcZ/cl25R993y
 ayibIoZqHgVccgAXaOVH/u7Ov1duEsGyhK3jJKr2Oz6zAIn4BIkydNjNF6XHGl2r3aEN/KcPq
 PG21AkJvXNtooG/14y+XW3COopyUKKa2nZqZJIwLczaIwnjII3aeqDlK73DT/+E+23dkJHzla
 3Pb2JAALjFt6Id1ufAqan7p49Oace7is=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexander Riesen <alexander.riesen@cetitec.com>
---
 drivers/media/i2c/adv748x/adv748x.h | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/media/i2c/adv748x/adv748x.h b/drivers/media/i2c/adv748x/adv748x.h
index 0a9d78c2870b..1a1ea70086c6 100644
--- a/drivers/media/i2c/adv748x/adv748x.h
+++ b/drivers/media/i2c/adv748x/adv748x.h
@@ -226,6 +226,11 @@ struct adv748x_state {
 
 #define ADV748X_IO_VID_STD		0x05
 
+#define ADV748X_IO_PAD_CONTROLS		0x0e
+#define ADV748X_IO_PAD_CONTROLS_TRI_AUD	BIT(5)
+#define ADV748X_IO_PAD_CONTROLS_PDN_AUD	BIT(1)
+#define ADV748X_IO_PAD_CONTROLS1	0x1d
+
 #define ADV748X_IO_10			0x10	/* io_reg_10 */
 #define ADV748X_IO_10_CSI4_EN		BIT(7)
 #define ADV748X_IO_10_CSI1_EN		BIT(6)
@@ -248,7 +253,21 @@ struct adv748x_state {
 #define ADV748X_IO_REG_FF		0xff
 #define ADV748X_IO_REG_FF_MAIN_RESET	0xff
 
+/* DPLL Map */
+#define ADV748X_DPLL_MCLK_FS		0xb5
+#define ADV748X_DPLL_MCLK_FS_N_MASK	GENMASK(2, 0)
+
 /* HDMI RX Map */
+#define ADV748X_HDMI_I2S		0x03	/* I2S mode and width */
+#define ADV748X_HDMI_I2SBITWIDTH_MASK	GENMASK(4, 0)
+#define ADV748X_HDMI_I2SOUTMODE_SHIFT	5
+#define ADV748X_HDMI_I2SOUTMODE_MASK	\
+	GENMASK(6, ADV748X_HDMI_I2SOUTMODE_SHIFT)
+#define ADV748X_I2SOUTMODE_I2S 0
+#define ADV748X_I2SOUTMODE_RIGHT_J 1
+#define ADV748X_I2SOUTMODE_LEFT_J 2
+#define ADV748X_I2SOUTMODE_SPDIF 3
+
 #define ADV748X_HDMI_LW1		0x07	/* line width_1 */
 #define ADV748X_HDMI_LW1_VERT_FILTER	BIT(7)
 #define ADV748X_HDMI_LW1_DE_REGEN	BIT(5)
@@ -260,6 +279,16 @@ struct adv748x_state {
 #define ADV748X_HDMI_F1H1		0x0b	/* field1 height_1 */
 #define ADV748X_HDMI_F1H1_INTERLACED	BIT(5)
 
+#define ADV748X_HDMI_MUTE_CTRL		0x1a
+#define ADV748X_HDMI_MUTE_CTRL_MUTE_AUDIO BIT(4)
+#define ADV748X_HDMI_MUTE_CTRL_WAIT_UNMUTE_MASK	GENMASK(3, 1)
+#define ADV748X_HDMI_MUTE_CTRL_NOT_AUTO_UNMUTE	BIT(0)
+
+#define ADV748X_HDMI_AUDIO_MUTE_SPEED	0x0f
+#define ADV748X_HDMI_AUDIO_MUTE_SPEED_MASK	GENMASK(4, 0)
+#define ADV748X_MAN_AUDIO_DL_BYPASS BIT(7)
+#define ADV748X_AUDIO_DELAY_LINE_BYPASS BIT(6)
+
 #define ADV748X_HDMI_HFRONT_PORCH	0x20	/* hsync_front_porch_1 */
 #define ADV748X_HDMI_HFRONT_PORCH_MASK	0x1fff
 
@@ -281,6 +310,9 @@ struct adv748x_state {
 #define ADV748X_HDMI_TMDS_1		0x51	/* hdmi_reg_51 */
 #define ADV748X_HDMI_TMDS_2		0x52	/* hdmi_reg_52 */
 
+#define ADV748X_HDMI_REG_6D		0x6d	/* hdmi_reg_6d */
+#define ADV748X_I2S_TDM_MODE_ENABLE BIT(7)
+
 /* HDMI RX Repeater Map */
 #define ADV748X_REPEATER_EDID_SZ	0x70	/* primary_edid_size */
 #define ADV748X_REPEATER_EDID_SZ_SHIFT	4
-- 
2.25.1.25.g9ecbe7eb18


