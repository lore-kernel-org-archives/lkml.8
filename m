Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2A4C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3685520739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgCTQvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:51:04 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53899 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgCTQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:51:03 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MjxW4-1jhlqo2MQK-00kOBJ for <linux-kernel@vger.kernel.org>; Fri, 20 Mar
 2020 17:51:02 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 660D864FB26
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 16:51:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QdvdBVPMBxQn for <linux-kernel@vger.kernel.org>;
        Fri, 20 Mar 2020 17:51:02 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 12F9864F849
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 17:51:02 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.8.5.41) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 20 Mar 2020 17:51:01 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 86EAC80509; Fri, 20 Mar 2020 17:12:06 +0100 (CET)
Date:   Fri, 20 Mar 2020 17:12:06 +0100
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
Subject: [PATCH v3 11/11] media: adv748x: allow the HDMI sub-device to accept
 EDID
Message-ID: <4fce566b68bbe4f85cf92cd80a455b575a5d95d1.1584720678.git.alexander.riesen@cetitec.com>
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
X-Provags-ID: V03:K1:oEMA+4dVfXfsKRD4UklDmhZd9ABI6n8WPxTUfhnYtf8lhdkpo/X
 ukjobM0THDPTrCJ5wqCq8K3vL1spP+wsmzP3qjGeL7qOSxbo4XZIJTjOBOQK6KDUnTMygc9
 tdziSZCSYeJqz5cMJPbh3BZAHYEBfY4BvoYt66KShFAjQoS4PaVRAw34TiTcjQVB3Cbl9es
 kr6w+t1BSI8wZY0gfqQww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TJCksSkjBSU=:UixXJXNyWD+aZWy4YzspeO
 eXrwaY1kdDRLkCdEBCpjqKC1NKSA18oqghjOUxNg8ltKc4iW9L40+t2rgZU/FGMIbglXh0+hW
 Goh4gWNIxH/v+juftoerbwTihbqwa88oFPMHkbAoSI9h2hOHttGKZDVmeYhts12cH0yPmmtrJ
 VBwGztd73NOMMBqDvohsWAFley0imXMfZuMyg4AQLlw18M8ZVMEqIxijo66rmGBppOtBSF+fg
 Bum0PR+4zv4yLF730aEDpwqRJ5fFxqa+fLsd5QkxCsseFDrPiFSKrrTGDTxeQCu+XhmDUKSrU
 B8qc0YJYlbLTAAcJsXNueLNyQ+3k2byZ8NygQ1u/Isp/YtZZsqDQdSaAMaa2VtI1tWLD5Ukg2
 0UjBjgDSOZD747afmyOB1EIrecDDu01AvdBLF59O/2Hozx62OFlJ5Iy3mzgmf/UEJvVjX7mFM
 M1UauC4KWfmJfmaQyQnledTetVleMgEjKMEgml3ORWWexW/EUUtD+0xaBcq0avEWtHxjbGnyW
 ISwlSszaX1M9acklgByx9Cq4k6mGtxuHC+G/7/PKsDJr+exB2BvogiyOB4FO/7SEXJsSltSBS
 8FeKnBdPX7E3ou5N7YaF1fCicaisHWvBa3CtzVc5hhC+XTQbrL1ckxyw37Q9RoAW2aBT0F2Zv
 wj4km57ZOr29s9528yd9BYIbnqqeAY5IAR7iOVTXYwPqv0eTOT4oUMFMAkM1e8+LeNJ0qaR8f
 fZHoxPzpur8RcD9gciyqgwDCPJto+B97j8MRwzKaavMUtjeB0xgh+fYTPXPqKeSyD84OyohBt
 M3HDGy12Qjdt/yBxKgGwAWAOT1EEN8yTG6EgurBXyvUMyGjucteD7cQmpaa+sNR7ZIkRLlr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it possible to load a EDID reported by the device
with v4l2-ctl utility:

  vdev=/dev/$(grep -l '^adv748x.*hdmi$' /sys/class/video4linux/v4l-subdev*/name |cut -d/ -f5-5)
  v4l2-ctl -d $vdev --set-edid=pad=0,file=/etc/adv7482.edid

Signed-off-by: Alexander Riesen <alexander.riesen@cetitec.com>

--

I would like to avoid doing that, but found no other way yet.
Suggestions very welcome.
---
 drivers/media/i2c/adv748x/adv748x-hdmi.c | 27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/media/i2c/adv748x/adv748x-hdmi.c b/drivers/media/i2c/adv748x/adv748x-hdmi.c
index 664930e55baf..fea133472911 100644
--- a/drivers/media/i2c/adv748x/adv748x-hdmi.c
+++ b/drivers/media/i2c/adv748x/adv748x-hdmi.c
@@ -775,7 +775,34 @@ static int adv748x_hdmi_log_status(struct v4l2_subdev *sd)
 	return 0;
 }
 
+static long adv748x_hdmi_querycap(struct adv748x_hdmi *hdmi,
+				  struct v4l2_capability *cap)
+{
+	struct adv748x_state *state = adv748x_hdmi_to_state(hdmi);
+
+	cap->version = LINUX_VERSION_CODE;
+	strlcpy(cap->driver, state->dev->driver->name, sizeof(cap->driver));
+	strlcpy(cap->card, "hdmi", sizeof(cap->card));
+	snprintf(cap->bus_info, sizeof(cap->bus_info), "i2c:%d-%04x",
+		 i2c_adapter_id(state->client->adapter),
+		 state->client->addr);
+	cap->device_caps = V4L2_CAP_AUDIO | V4L2_CAP_VIDEO_CAPTURE;
+	cap->capabilities = V4L2_CAP_DEVICE_CAPS;
+	return 0;
+}
+
+static long adv748x_hdmi_ioctl(struct v4l2_subdev *sd,
+			       unsigned int cmd, void *arg)
+{
+	struct adv748x_hdmi *hdmi = adv748x_sd_to_hdmi(sd);
+
+	if (cmd == VIDIOC_QUERYCAP)
+		return adv748x_hdmi_querycap(hdmi, arg);
+	return -ENOTTY;
+}
+
 static const struct v4l2_subdev_core_ops adv748x_core_ops_hdmi = {
+	.ioctl = adv748x_hdmi_ioctl,
 	.log_status = adv748x_hdmi_log_status,
 };
 
-- 
2.25.1.25.g9ecbe7eb18

