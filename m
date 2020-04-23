Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2368CC55193
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F5320704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lf1pTmPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgDWQ0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729603AbgDWQ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:26:14 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B88C09B044
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:26:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so1977493pfv.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zZlcGVadVdEpLNyfHKBCxVoYP+eDFysUlR7Z8EL21Ao=;
        b=lf1pTmPTuoPW/fMw9LZyYZ3xaPgoZOKRYySuTtP4ssnuOzvLX5tWQt69+KsPH+Suq/
         Mojoe+buQtYvkWVJ9oo4c0RLs+JVbqCGo4GxErqNzRQVD4vk70Al9WbF7xXXaZ8+bsxG
         OO0vnx3orqPluBcOLJm16dj/cktK5W/bRVFBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zZlcGVadVdEpLNyfHKBCxVoYP+eDFysUlR7Z8EL21Ao=;
        b=VNvYw7fx2o328zJF15GvE63S+yBTdajzoV+FtJ3fOkEYU8IXTkHeKlvsJsi6NYJ39S
         WSvMbEvVjNWauAIVwu7Z2XMGBq1RD6Wz0QeIXiqAcbYBpAYh3jymsc+rMM2bNJmfwjbh
         dw9B5XVl2epvjj/I68RJQFz33jr7PigvsSV3bZ5cJZiDCJ9SJ0elfJEYVcztVIIrzXFJ
         6/WNL2zFDPK6X7Vwq0wtUjS0hSGpJsPJKj56EfEgfuOMl+RYYd8mFLYa6iiLhUchYkwo
         HSzed1U+4GfqK4aMXxO8gFxjAOxMkxyp9sdXRCy28ufb0qLVOgghLmbj8FO19vnMB2AM
         RwQQ==
X-Gm-Message-State: AGi0PuaKRze13wdx1aEZ6YglPOpoJ8nUP5GUof1S8vfrlEwO0qwI4dnB
        6qhLefD/w6yW+NMq9DqoEhq+fw==
X-Google-Smtp-Source: APiQypK5TKkM8oN6lqsOUTDG3KiL44KtRDXeFj89W9c9dN27BNr4FJvhZVuJWmf7ujDA95KjhTwycQ==
X-Received: by 2002:a62:13:: with SMTP id 19mr4346826pfa.64.1587659172120;
        Thu, 23 Apr 2020 09:26:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d12sm2841927pfq.36.2020.04.23.09.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 09:26:11 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        narmstrong@baylibre.com, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, spanda@codeaurora.org
Cc:     swboyd@chromium.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, jeffrey.l.hugo@gmail.com,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        robdclark@chromium.org, jernej.skrabec@siol.net, jonas@kwiboo.se,
        bjorn.andersson@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Linux
Date:   Thu, 23 Apr 2020 09:25:43 -0700
Message-Id: <20200423092431.v3.1.Ia50267a5549392af8b37e67092ca653a59c95886@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200423162548.129661-1-dianders@chromium.org>
References: <20200423162548.129661-1-dianders@chromium.org>
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

Because of all of the above limitations we just need to implement a
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

Changes in v3:
- Becaue => Because
- Add a kernel-doc to our pdata to clarify double-duty of gchip_output.
- More comments about how powering off affects us (get_dir, dir_input).
- Cleanup tail of ti_sn_setup_gpio_controller() to avoid one "return".
- Use a bitmap rather than rolling my own.

Changes in v2:
- ("Export...GPIOs") is 1/2 of replacement for ("Allow...bridge GPIOs")

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 194 ++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 6ad688b320ae..fcd817835c43 100644
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
@@ -88,6 +97,31 @@
 
 #define SN_REGULATOR_SUPPLY_NUM		4
 
+#define SN_NUM_GPIOS			4
+
+/**
+ * struct ti_sn_bridge - Platform data for ti-sn65dsi86 driver.
+ * @dev:          Pointer to our device.
+ * @regmap:       Regmap for accessing i2c.
+ * @aux:          Our aux channel.
+ * @bridge:       Our bridge.
+ * @connector:    Our connector.
+ * @debugfs:      Used for managing our debugfs.
+ * @host_node:    Remote DSI node.
+ * @dsi:          Our MIPI DSI source.
+ * @refclk:       Our reference clock.
+ * @panel:        Our panel.
+ * @enable_gpio:  The GPIO we toggle to enable the bridge.
+ * @supplies:     Data for bulk enabling/disabling our regulators.
+ * @dp_lanes:     Count of dp_lanes we're using.
+ *
+ * @gchip:        If we expose our GPIOs, this is used.
+ * @gchip_output: A cache of whether we've set GPIOs to output.  This
+ *                serves double-duty of keeping track of the direction and
+ *                also keeping track of whether we've incremented the
+ *                pm_runtime reference count for this pin, which we do
+ *                whenever a pin is configured as an output.
+ */
 struct ti_sn_bridge {
 	struct device			*dev;
 	struct regmap			*regmap;
@@ -102,6 +136,9 @@ struct ti_sn_bridge {
 	struct gpio_desc		*enable_gpio;
 	struct regulator_bulk_data	supplies[SN_REGULATOR_SUPPLY_NUM];
 	int				dp_lanes;
+
+	struct gpio_chip		gchip;
+	DECLARE_BITMAP(gchip_output, SN_NUM_GPIOS);
 };
 
 static const struct regmap_range ti_sn_bridge_volatile_ranges[] = {
@@ -874,6 +911,157 @@ static int ti_sn_bridge_parse_dsi_host(struct ti_sn_bridge *pdata)
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
+	/*
+	 * We already have to keep track of the direction because we use
+	 * that to figure out whether we've powered the device.  We can
+	 * just return that rather than (maybe) powering up the device
+	 * to ask its direction.
+	 */
+	return test_bit(offset, pdata->gchip_output) ?
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
+	 * the reason this works is that the bridge defaults (when
+	 * powered back on) to all 4 GPIOs being configured as GPIO input.
+	 * Also note that if something else is keeping the chip powered the
+	 * pm_runtime functions are lightweight increments of a refcount.
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
+	if (!test_bit(offset, pdata->gchip_output)) {
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
+	int ret;
+
+	if (!test_and_clear_bit(offset, pdata->gchip_output))
+		return 0;
+
+	ret = regmap_update_bits(pdata->regmap, SN_GPIO_CTRL_REG,
+				 0x3 << shift, SN_GPIO_MUX_INPUT << shift);
+	if (ret) {
+		set_bit(offset, pdata->gchip_output);
+		return ret;
+	}
+
+	/*
+	 * NOTE: if nobody else is powering the device this may fully power
+	 * it off and when it comes back it will have lost all state, but
+	 * that's OK because the default is input and we're now an input.
+	 */
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
+	int ret;
+
+	if (test_and_set_bit(offset, pdata->gchip_output))
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
+		clear_bit(offset, pdata->gchip_output);
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
+static const char * const ti_sn_bridge_gpio_names[SN_NUM_GPIOS] = {
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
+	pdata->gchip.ngpio = SN_NUM_GPIOS;
+	ret = devm_gpiochip_add_data(pdata->dev, &pdata->gchip, pdata);
+	if (ret)
+		dev_err(pdata->dev, "can't add gpio chip\n");
+
+	return ret;
+}
+
 static int ti_sn_bridge_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
@@ -937,6 +1125,12 @@ static int ti_sn_bridge_probe(struct i2c_client *client,
 
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

