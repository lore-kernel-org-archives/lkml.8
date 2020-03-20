Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88923C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FA220753
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgCTQro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:47:44 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53951 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgCTQrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:47:43 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M4alK-1jEmqJ0g1W-001kFa for <linux-kernel@vger.kernel.org>; Fri, 20 Mar
 2020 17:47:41 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id F35686502CC
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 16:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2OA5PdkcF30s for <linux-kernel@vger.kernel.org>;
        Fri, 20 Mar 2020 17:47:40 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 6AE516500B7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 17:47:40 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.8.5.41) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 20 Mar 2020 17:47:40 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 95A9480507; Fri, 20 Mar 2020 17:12:05 +0100 (CET)
Date:   Fri, 20 Mar 2020 17:12:05 +0100
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
Subject: [PATCH v3 10/11] media: adv748x: add support for log_status ioctl
Message-ID: <e52d19788355e15a1502bc90ccb1e9a077f239ef.1584720678.git.alexander.riesen@cetitec.com>
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
X-Provags-ID: V03:K1:R860yFcBO0E5W8gVQ/wS3G3AhGkUGYhgJ/dMlX//jR0TvGD7oYO
 sx5HSh8x8wIUR2KlQY4IuMbQk0dvORwODLuhUTotyS1SQ9VdsDiT5xf7sL1tQS8rMeWPOft
 xE7gz3C0uUA/l4KUlHPZuOiixEb4crtIIjVdlJUFvo7ieV3KIocB1LFeYW6vbvOjEdgYdBF
 5gUWnriRUYrCOfr7KPokA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gNZrvayu3tg=:v9tDHIYU3PIL11xniJbPHE
 kKL+AosZiHalyyMImmK1DbSrvxusNHswBNyOyID0P+s993INC4YVJt1UXj19C4twDj0eWYFHG
 9lFVcfNjqQ13wMrU9BNQHQAwtud7eMDUCLFScSbA01NeqWlPe5emS0Tn8MzAxjaVHfoLxbda7
 tnr3qAXBGbr63yJKn2nU0YLrBDuGufQoRw8Xgo2PcuEtWWQla/3DbIkoxq407vDLzSp1dpEtE
 Qj1QVyUPjEPJdM6msbcI2Y86OIeEUtLlbREz5xMgJ1oVCPFkdB+wkMWlnNuZm32XYfO/TKwEe
 7GWmFS6G8QoQOCmXHLqF6uDKu87yxrt9GV/7xmBMIzMrplTMupRkLXcQ2iO6OvnfsaYyu2LV2
 xY2QvRM1XaVU+83EKu4g5676Ucr0NKj8E9TR8cDx7HOnhp1s6wemrw6ISztZ9cNp6lMrc21q0
 MxQvzQXQKKORxKcTlCK15Q0xV1UQsZuOyLaTOv8REuDTax6sA3csrF+Lu51e3GBzZM+EcYlGr
 7+feD+Z4zIUdqNlPT6NC/bZBfORCvU4pR11oiZixIWjEJiRJwZvlBnOvYeI4ite9v8LVZEigw
 QTzZJqocIsVY9RufCinpCMxgwEsDOqnTr2HWBqhAStaYhcmngzox2bTi+g+mqxY03W1oiEnhH
 zRuXyuXC65SS58A2JJDqJu919xiRvk6tHHViOeOWsCiL4TmDWAxl1QZWqaSLkc3oyRHHYOdRR
 M4mcxeenf2ht8rf5M39umOkV1bVhU3c611/rGbGmEUa3q+ej6rc6GJOJLXlGndYl4pQC+8+8+
 qkfElG/nCU8xA39h4S5TanEvJRza8Fs5G+0Ln/fLjaMooQ9mCgP5KAIXQIzKWh0wNR4LESK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logged information provides insights about cable connection and the
state of the HDMI decoder. It is very useful when debugging hardware
problems in environments without easy access to the connectors.

This change adds a device-specific wrapper for register block read,
because some of the devices I2C-accessible registers (for instance,
cs_data for stereo channel information or tmds_params for TMDS channel
information) located in adjacent cells. According to manufacturers
information, these registers can be read using block transactions.

Signed-off-by: Alexander Riesen <alexander.riesen@cetitec.com>
---
 drivers/media/i2c/adv748x/adv748x-core.c |  15 ++
 drivers/media/i2c/adv748x/adv748x-hdmi.c | 179 +++++++++++++++++++++++
 drivers/media/i2c/adv748x/adv748x.h      |   2 +
 3 files changed, 196 insertions(+)

diff --git a/drivers/media/i2c/adv748x/adv748x-core.c b/drivers/media/i2c/adv748x/adv748x-core.c
index 3513ca138e53..775450ab2bad 100644
--- a/drivers/media/i2c/adv748x/adv748x-core.c
+++ b/drivers/media/i2c/adv748x/adv748x-core.c
@@ -95,6 +95,21 @@ static const struct adv748x_register_map adv748x_default_addresses[] = {
 	[ADV748X_PAGE_TXA] = { "txa", 0x4a },
 };
 
+int adv748x_read_block(struct adv748x_state *state, u8 client_page, u8 reg,
+		       void *val, size_t reg_count)
+{
+	struct i2c_client *client = state->i2c_clients[client_page];
+	int err;
+
+	err = regmap_bulk_read(state->regmap[client_page], reg, val, reg_count);
+	if (err) {
+		adv_err(state, "error reading %02x, %02x-%02lx: %d\n",
+				client->addr, reg, reg + reg_count - 1, err);
+		return err;
+	}
+	return 0;
+}
+
 static int adv748x_read_check(struct adv748x_state *state,
 			      int client_page, u8 reg)
 {
diff --git a/drivers/media/i2c/adv748x/adv748x-hdmi.c b/drivers/media/i2c/adv748x/adv748x-hdmi.c
index f598acec3b5c..664930e55baf 100644
--- a/drivers/media/i2c/adv748x/adv748x-hdmi.c
+++ b/drivers/media/i2c/adv748x/adv748x-hdmi.c
@@ -7,6 +7,7 @@
 
 #include "adv748x.h"
 
+#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 
@@ -601,11 +602,189 @@ static const struct v4l2_subdev_pad_ops adv748x_pad_ops_hdmi = {
 	.enum_dv_timings = adv748x_hdmi_enum_dv_timings,
 };
 
+struct tmds_params {
+	u32 cts, n;
+	u16 tmdsfreq, tmdsfreq_frac;
+};
+
+static inline const char *cs_data_smpl_freq_str(u8 cs_data_3)
+{
+	switch (cs_data_3 & 0xf) {
+	case 0:
+		return "44.1";
+	case 2:
+		return "48";
+	case 3:
+		return "32";
+	case 8:
+		return "88.2";
+	case 10:
+		return "96";
+	case 12:
+		return "176";
+	case 14:
+		return "192";
+	}
+	return "reserved";
+}
+
+static inline const char *cs_data_clk_lvl_str(u8 cs_data_3)
+{
+	switch (cs_data_3 & 0x30) {
+	case 0:
+		return "Level II";
+	case 1:
+		return "Level I";
+	case 2:
+		return "Level III, variable pitch shifted";
+	}
+	return "reserved";
+}
+
+static inline const char *i2s_out_mode_str(u8 i2s_mode)
+{
+	switch (i2s_mode & ADV748X_HDMI_I2SOUTMODE_MASK) {
+	case 0 << ADV748X_HDMI_I2SOUTMODE_SHIFT:
+		return "I2S";
+	case 1 << ADV748X_HDMI_I2SOUTMODE_SHIFT:
+		return "right";
+	case 2 << ADV748X_HDMI_I2SOUTMODE_SHIFT:
+		return "left";
+	case 3 << ADV748X_HDMI_I2SOUTMODE_SHIFT:
+		return "spdif";
+	}
+	return "";
+}
+
+static int adv748x_hdmi_log_status(struct v4l2_subdev *sd)
+{
+	struct adv748x_hdmi *hdmi = adv748x_sd_to_hdmi(sd);
+	struct adv748x_state *state = adv748x_hdmi_to_state(hdmi);
+	u8 rv, i2s_tdm_mode_enable;
+	u8 cts_n[5];
+	u8 cs_data[0x3a - 0x36 + 1];
+	u8 tmdsfreq[2]; /* both tmdsfreq and tmdsfreq_frac */
+	struct tmds_params tmds_params;
+
+	/* Audio control and configuration */
+	rv = io_read(state, 0x71);
+	pr_info("cable_det_a_raw         %s\n",
+		rv & BIT(6) ? "detected" : "no cable");
+	pr_info("tmds_clk_a_raw          %s\n",
+		rv & BIT(3) ? "detected" : "no TMDS clock");
+	pr_info("tmdspll_lck_a_raw       %s\n",
+		rv & BIT(7) ? "locked to incoming clock" : "not locked");
+	pr_info("hdmi_encrpt_a_raw       %s\n",
+		rv & BIT(5) ? "current frame encrypted" : "not encrypted");
+	rv = hdmi_read(state, 0x04);
+	pr_info("audio_pll_locked        0x%02lx\n", rv & BIT(0));
+	pr_info("tmds_pll_locked         0x%02lx\n", rv & BIT(1));
+	rv = io_read(state, 0x6c);
+	pr_info("gamut_mdata_raw         %s\n",
+		rv & BIT(0) ? "received" : "-");
+	pr_info("audio_c_pckt_raw        %s\n",
+		rv & BIT(1) ? "ACR received" : "-");
+	pr_info("gen_ctl_pckt_raw        %s\n",
+		rv & BIT(2) ? "received" : "-");
+	pr_info("hdmi_mode_raw           %s\n",
+		rv & BIT(3) ? "HDMI/MHL" : "-");
+	pr_info("audio_ch_md_raw         %s\n",
+		rv & BIT(4) ? "multichannel" : "-");
+	pr_info("av_mute_raw             %s\n",
+		rv & BIT(5) ? "received" : "-");
+	pr_info("internal_mute_raw       %s\n",
+		rv & BIT(6) ? "asserted" : "-");
+	pr_info("cs_data_valid_raw       %s\n",
+		rv & BIT(7) ? "valid" : "-");
+	rv = hdmi_read(state, 0x6d);
+	pr_info("i2s_tdm_mode_enable     %s\n",
+		rv & BIT(7) ? "TDM (multichannel)" : "I2S (stereo)");
+	i2s_tdm_mode_enable = rv & BIT(7);
+
+	/* i2s_tdm_mode_enable must be unset */
+	if (adv748x_read_block(state, ADV748X_PAGE_HDMI, 0x36,
+			       cs_data, ARRAY_SIZE(cs_data)) == 0) {
+		pr_info("... cs_data %s\n",
+			cs_data[0] & BIT(0) ? "pro" : "consumer");
+		pr_info("... cs_data %s\n",
+			cs_data[0] & BIT(1) ? "other" : "L-PCM");
+		pr_info("... cs_data %s copyright\n",
+			cs_data[0] & BIT(2) ? "no" : "asserted");
+		pr_info("... cs_data %s (%lu)\n",
+			cs_data[0] & GENMASK(5, 3) ?
+			"50/15" : "no pre-emphasis",
+			(cs_data[0] & GENMASK(5, 3)) >> 4);
+		pr_info("... cs_data channels status mode %lu\n",
+			(cs_data[0] & GENMASK(7, 6)) >> 7);
+		pr_info("... cs_data category code 0x%02x\n", cs_data[1]);
+		pr_info("... cs_data source number %u\n", cs_data[2] & 0xf);
+		pr_info("... cs_data channel number %u\n",
+			(cs_data[2] & 0xf0) >> 4);
+		pr_info("... cs_data sampling frequency %s (%u)\n",
+			cs_data_smpl_freq_str(cs_data[3]), cs_data[3] & 0xf);
+		pr_info("... cs_data clock accuracy %s\n",
+			cs_data_clk_lvl_str(cs_data[3]));
+	}
+	rv = hdmi_read(state, ADV748X_HDMI_I2S);
+	pr_info("i2soutmode              %s\n", i2s_out_mode_str(rv));
+	pr_info("i2sbitwidth             %u\n", rv & 0x1fu);
+	rv = hdmi_read(state, 0x05);
+	pr_info("hdmi_mode               %s\n", rv & BIT(7) ? "HDMI" : "DVI");
+	rv = hdmi_read(state, 0x07);
+	pr_info("audio_channel_mode      %s\n",
+		rv & BIT(6) ? "multichannel" : "stereo or compressed");
+	rv = hdmi_read(state, 0x0f);
+	/* The bits 6 and 7 must be 1 if TDM mode */
+	pr_info("man_audio_dl_bypass     0x%02lx\n", rv & BIT(7));
+	pr_info("audio_delay_line_bypass 0x%02lx\n", rv & BIT(6));
+	rv = hdmi_read(state, 0x6e);
+	pr_info("mux_spdif_to_i2s_enable %s\n", rv & BIT(3) ? "SPDIF" : "I2S");
+	rv = dpll_read(state, ADV748X_DPLL_MCLK_FS);
+	pr_info("mclk_fs_n               %lu\n",
+		((rv & ADV748X_DPLL_MCLK_FS_N_MASK) + 1) * 128);
+
+	/* i2s_tdm_mode_enable must be set */
+	memset(&tmds_params, 0, sizeof(tmds_params));
+	if (adv748x_read_block(state, ADV748X_PAGE_HDMI, 0x5b, cts_n, 5) == 0) {
+		tmds_params.cts  = cts_n[0] << 12;
+		tmds_params.cts |= cts_n[1] << 4;
+		tmds_params.cts |= cts_n[2] >> 4;
+		tmds_params.n  = (cts_n[2] & 0xf) << 16;
+		tmds_params.n |= cts_n[3] << 8;
+		tmds_params.n |= cts_n[4];
+		pr_info("... TDM: ACR cts  %u\n", tmds_params.cts);
+		pr_info("... TDM: ACR n    %u\n", tmds_params.n);
+	}
+	if (adv748x_read_block(state, ADV748X_PAGE_HDMI, 0x51,
+			       tmdsfreq, 2) == 0) {
+		tmds_params.tmdsfreq  = tmdsfreq[0] << 1;
+		tmds_params.tmdsfreq |= tmdsfreq[1] >> 7;
+		tmds_params.tmdsfreq_frac = tmdsfreq[1] & 0x7f;
+		pr_info("... TDM: tmdsfreq       %d MHz\n",
+			tmds_params.tmdsfreq);
+		pr_info("... TDM: tmdsfreq_frac  %d 1/128\n",
+			tmds_params.tmdsfreq_frac);
+	}
+	if (i2s_tdm_mode_enable)
+		pr_info("... TDM: sampling frequency %u Hz\n",
+			tmds_params.cts ?
+			(tmds_params.tmdsfreq * tmds_params.n +
+			 tmds_params.tmdsfreq_frac * tmds_params.n / 128) *
+			1000 / (128 * tmds_params.cts / 1000) :
+			UINT_MAX);
+	return 0;
+}
+
+static const struct v4l2_subdev_core_ops adv748x_core_ops_hdmi = {
+	.log_status = adv748x_hdmi_log_status,
+};
+
 /* -----------------------------------------------------------------------------
  * v4l2_subdev_ops
  */
 
 static const struct v4l2_subdev_ops adv748x_ops_hdmi = {
+	.core = &adv748x_core_ops_hdmi,
 	.video = &adv748x_video_ops_hdmi,
 	.pad = &adv748x_pad_ops_hdmi,
 };
diff --git a/drivers/media/i2c/adv748x/adv748x.h b/drivers/media/i2c/adv748x/adv748x.h
index b0735de0ced5..6421a4c02c60 100644
--- a/drivers/media/i2c/adv748x/adv748x.h
+++ b/drivers/media/i2c/adv748x/adv748x.h
@@ -433,6 +433,8 @@ struct adv748x_state {
 /* Register handling */
 
 int adv748x_read(struct adv748x_state *state, u8 addr, u8 reg);
+int adv748x_read_block(struct adv748x_state *state, u8 page, u8 reg,
+		       void *val, size_t reg_count);
 int adv748x_write(struct adv748x_state *state, u8 page, u8 reg, u8 value);
 int adv748x_write_block(struct adv748x_state *state, int client_page,
 			unsigned int init_reg, const void *val,
-- 
2.25.1.25.g9ecbe7eb18


