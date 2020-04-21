Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BB4C5518C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9859F206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LyU/7qBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgDUFGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 01:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726541AbgDUFGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 01:06:52 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7B5C0610D6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 22:06:51 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a7so871639pju.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 22:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kSeuRl9u6GyicN//nHBoTuV+Y0T22TYVbPnayCqsBO8=;
        b=LyU/7qBiH/aG71draN5jUS2+mq97YNmFoEqf+sblKY9Kb1Nm1gPztdPY4WZ8PaqNbH
         oqikhJbyQ2BKNRLsg9jHEVPFG6hON/3WpanZx958wyihOFFNzqRSudzpR55RIgiLzfyq
         qTiVlBx1/z2Ob78BDAQ9PxqTc1nTl5uIviV70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kSeuRl9u6GyicN//nHBoTuV+Y0T22TYVbPnayCqsBO8=;
        b=mZhA5kHf52TMn7fLNnLs3fBXTCqmM9mQ08qvCjOOMk8+99bCmskb1Oa+g1VzrrbNXi
         Lq+2kKWsnbOd+qhIX9OgmmN5kIO2L76DnhAuAKsi18S8vPIS994dgiSFEkvpTwuOPoti
         GDOT858gx0PfqXprAiFzCvR3I3o3NqbN86oYHYlmTmv5NKE/gg7P9mim+HKPoFhHuP/e
         MI++S6UX/CcshH1YJOvzYiBPWcIc2VJg1iXTAePnyp33L3ChoxwXPcAHsMbo1HVCqHdI
         uY6rDrYJgD4egxZyr/W9BhmsBW4e1le61DhatRtC9b7gK28yZs2l41JouonEnCA2Bj8q
         3uZQ==
X-Gm-Message-State: AGi0Puat0K0WwegfDKwZI3m1A5W5PG1Dl+aDf1skqi57INYzZ0ExodmD
        v8sJGxGoewsaKm43rHCtVLKosg==
X-Google-Smtp-Source: APiQypJzFod9tNAuAnsTCpNj/cBg+/8U/+LymAlvnSKQAem9cQnrWeTZHNYSnYef18mwk6N/WqT05w==
X-Received: by 2002:a17:90a:f995:: with SMTP id cq21mr3440366pjb.56.1587445610633;
        Mon, 20 Apr 2020 22:06:50 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p68sm1184780pfb.89.2020.04.20.22.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 22:06:50 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        narmstrong@baylibre.com, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, spanda@codeaurora.org
Cc:     jonas@kwiboo.se, jeffrey.l.hugo@gmail.com,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        jernej.skrabec@siol.net, swboyd@chromium.org,
        bjorn.andersson@linaro.org, robdclark@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Linux
Date:   Mon, 20 Apr 2020 22:06:17 -0700
Message-Id: <20200420220458.v2.1.Ia50267a5549392af8b37e67092ca653a59c95886@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200421050622.8113-1-dianders@chromium.org>
References: <20200421050622.8113-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ti-sn65dsi86 MIPI DSI to eDP bridge chip has 4 pins on it that can
be used as GPIOs in a system.  Each pin can be configured as input,
output, or a special function for the bridge chip.  These are:
- GPIO1: SUSPEND Input
- GPIO2: DSIA VSYNC
- GPIO3: DSIA HSYNC or VSYNC
- GPIO4: PWM

Let's expose these pins as GPIOs.  A few notes:
- Access to ti-sn65dsi86 is via i2c so we set "can_sleep".
- These pins can't be configured for IRQ.
- There are no programmable pulls or other fancy features.
- Keeping the bridge chip powered might be expensive.  The driver is
  setup such that if all used GPIOs are only inputs we'll power the
  bridge chip on just long enough to read the GPIO and then power it
  off again.  Setting a GPIO as output will keep the bridge powered.
- If someone releases a GPIO we'll implicitly switch it to an input so
  we no longer need to keep the bridge powered for it.

Becaue of all of the above limitations we just need to implement a
bare-bones GPIO driver.  The device tree bindings already account for
this device being a GPIO controller so we only need the driver changes
for it.

NOTE: Despite the fact that these pins are nominally muxable I don't
believe it makes sense to expose them through the pinctrl interface as
well as the GPIO interface.  The special functions are things that the
bridge chip driver itself would care about and it can just configure
the pins as needed.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---

Changes in v2:
- ("Export...GPIOs") is 1/2 of replacement for ("Allow...bridge GPIOs")

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 165 ++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 6ad688b320ae..d04c2b83d699 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -7,6 +7,8 @@
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
@@ -54,6 +56,13 @@
 #define  BPP_18_RGB				BIT(0)
 #define SN_HPD_DISABLE_REG			0x5C
 #define  HPD_DISABLE				BIT(0)
+#define SN_GPIO_IO_REG				0x5E
+#define  SN_GPIO_INPUT_SHIFT			4
+#define  SN_GPIO_OUTPUT_SHIFT			0
+#define SN_GPIO_CTRL_REG			0x5F
+#define  SN_GPIO_MUX_INPUT			0
+#define  SN_GPIO_MUX_OUTPUT			1
+#define  SN_GPIO_MUX_SPECIAL			2
 #define SN_AUX_WDATA_REG(x)			(0x64 + (x))
 #define SN_AUX_ADDR_19_16_REG			0x74
 #define SN_AUX_ADDR_15_8_REG			0x75
@@ -102,6 +111,9 @@ struct ti_sn_bridge {
 	struct gpio_desc		*enable_gpio;
 	struct regulator_bulk_data	supplies[SN_REGULATOR_SUPPLY_NUM];
 	int				dp_lanes;
+
+	struct gpio_chip		gchip;
+	atomic_t			gchip_output;
 };
 
 static const struct regmap_range ti_sn_bridge_volatile_ranges[] = {
@@ -874,6 +886,153 @@ static int ti_sn_bridge_parse_dsi_host(struct ti_sn_bridge *pdata)
 	return 0;
 }
 
+static struct ti_sn_bridge *gchip_to_pdata(struct gpio_chip *chip)
+{
+	return container_of(chip, struct ti_sn_bridge, gchip);
+}
+
+static int ti_sn_bridge_gpio_get_direction(struct gpio_chip *chip,
+					   unsigned int offset)
+{
+	struct ti_sn_bridge *pdata = gchip_to_pdata(chip);
+
+	return (atomic_read(&pdata->gchip_output) & BIT(offset)) ?
+		GPIOF_DIR_OUT : GPIOF_DIR_IN;
+}
+
+static int ti_sn_bridge_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct ti_sn_bridge *pdata = gchip_to_pdata(chip);
+	unsigned int val;
+	int ret;
+
+	/*
+	 * When the pin is an input we don't forcibly keep the bridge
+	 * powered--we just power it on to read the pin.  NOTE: part of
+	 * the reason this works is that the bridge defaults to all 4
+	 * GPIOs being configured as GPIO input.  Also note that if
+	 * something else is keeping the chip powered the pm_runtime
+	 * functions are lightweight increments of a refcount.
+	 */
+	pm_runtime_get_sync(pdata->dev);
+	ret = regmap_read(pdata->regmap, SN_GPIO_IO_REG, &val);
+	pm_runtime_put(pdata->dev);
+
+	if (ret)
+		return ret;
+
+	return (val >> (SN_GPIO_INPUT_SHIFT + offset)) & 1;
+}
+
+static void ti_sn_bridge_gpio_set(struct gpio_chip *chip, unsigned int offset,
+				  int val)
+{
+	struct ti_sn_bridge *pdata = gchip_to_pdata(chip);
+	int ret;
+
+	if (!(atomic_read(&pdata->gchip_output) & BIT(offset))) {
+		dev_err(pdata->dev, "Ignoring GPIO set while input\n");
+		return;
+	}
+
+	val &= 1;
+	ret = regmap_update_bits(pdata->regmap, SN_GPIO_IO_REG,
+				 BIT(SN_GPIO_OUTPUT_SHIFT + offset),
+				 val << (SN_GPIO_OUTPUT_SHIFT + offset));
+}
+
+static int ti_sn_bridge_gpio_direction_input(struct gpio_chip *chip,
+					     unsigned int offset)
+{
+	struct ti_sn_bridge *pdata = gchip_to_pdata(chip);
+	int shift = offset * 2;
+	int old_gchip_output;
+	int ret;
+
+	old_gchip_output = atomic_fetch_andnot(BIT(offset),
+					       &pdata->gchip_output);
+	if (!(old_gchip_output & BIT(offset)))
+		return 0;
+
+	ret = regmap_update_bits(pdata->regmap, SN_GPIO_CTRL_REG,
+				 0x3 << shift, SN_GPIO_MUX_INPUT << shift);
+	if (ret) {
+		atomic_or(BIT(offset), &pdata->gchip_output);
+		return ret;
+	}
+
+	pm_runtime_put(pdata->dev);
+
+	return 0;
+}
+
+static int ti_sn_bridge_gpio_direction_output(struct gpio_chip *chip,
+					      unsigned int offset, int val)
+{
+	struct ti_sn_bridge *pdata = gchip_to_pdata(chip);
+	int shift = offset * 2;
+	int old_gchip_output;
+	int ret;
+
+	old_gchip_output = atomic_fetch_or(BIT(offset), &pdata->gchip_output);
+	if (old_gchip_output & BIT(offset))
+		return 0;
+
+	pm_runtime_get_sync(pdata->dev);
+
+	/* Set value first to avoid glitching */
+	ti_sn_bridge_gpio_set(chip, offset, val);
+
+	/* Set direction */
+	ret = regmap_update_bits(pdata->regmap, SN_GPIO_CTRL_REG,
+				 0x3 << shift, SN_GPIO_MUX_OUTPUT << shift);
+	if (ret) {
+		atomic_andnot(BIT(offset), &pdata->gchip_output);
+		pm_runtime_put(pdata->dev);
+	}
+
+	return ret;
+}
+
+static void ti_sn_bridge_gpio_free(struct gpio_chip *chip, unsigned int offset)
+{
+	/* We won't keep pm_runtime if we're input, so switch there on free */
+	ti_sn_bridge_gpio_direction_input(chip, offset);
+}
+
+static const char * const ti_sn_bridge_gpio_names[] = {
+	"GPIO1", "GPIO2", "GPIO3", "GPIO4"
+};
+
+static int ti_sn_setup_gpio_controller(struct ti_sn_bridge *pdata)
+{
+	int ret;
+
+	/* Only init if someone is going to use us as a GPIO controller */
+	if (!of_property_read_bool(pdata->dev->of_node, "gpio-controller"))
+		return 0;
+
+	pdata->gchip.label = dev_name(pdata->dev);
+	pdata->gchip.parent = pdata->dev;
+	pdata->gchip.owner = THIS_MODULE;
+	pdata->gchip.free = ti_sn_bridge_gpio_free;
+	pdata->gchip.get_direction = ti_sn_bridge_gpio_get_direction;
+	pdata->gchip.direction_input = ti_sn_bridge_gpio_direction_input;
+	pdata->gchip.direction_output = ti_sn_bridge_gpio_direction_output;
+	pdata->gchip.get = ti_sn_bridge_gpio_get;
+	pdata->gchip.set = ti_sn_bridge_gpio_set;
+	pdata->gchip.can_sleep = true;
+	pdata->gchip.names = ti_sn_bridge_gpio_names;
+	pdata->gchip.ngpio = ARRAY_SIZE(ti_sn_bridge_gpio_names);
+	ret = devm_gpiochip_add_data(pdata->dev, &pdata->gchip, pdata);
+	if (ret) {
+		dev_err(pdata->dev, "can't add gpio chip\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int ti_sn_bridge_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
@@ -937,6 +1096,12 @@ static int ti_sn_bridge_probe(struct i2c_client *client,
 
 	pm_runtime_enable(pdata->dev);
 
+	ret = ti_sn_setup_gpio_controller(pdata);
+	if (ret) {
+		pm_runtime_disable(pdata->dev);
+		return ret;
+	}
+
 	i2c_set_clientdata(client, pdata);
 
 	pdata->aux.name = "ti-sn65dsi86-aux";
-- 
2.26.1.301.g55bc3eb7cb9-goog

