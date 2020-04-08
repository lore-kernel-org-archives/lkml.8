Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC461C2BA16
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D472078C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586318201;
	bh=Unyf0gb7uQ2s9ZRaDRE+7kEFjvuE3W3lCvCDOO+M5fA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CZQvtSTAocL8Cps8IIcjc2ktUqeNOLdVwUqmuP8QZcwOFrd2w4WC4qu4ckmhR1Bq4
	 1x9BRTbUlyz53Rfpvhf3NvJRv7oLCyWyraMfu0KGWDZf4ERVZYSwijTzrjdV+UrCuY
	 cZ8/wGx6GlVnWhGbFFdaLy7pKlMPH1p5HKxJnL6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgDHD4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 23:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgDHD4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 23:56:40 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44AE02078C;
        Wed,  8 Apr 2020 03:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586318198;
        bh=Unyf0gb7uQ2s9ZRaDRE+7kEFjvuE3W3lCvCDOO+M5fA=;
        h=From:To:Cc:Subject:Date:From;
        b=b1/JaD8JVBCTcuWP16cx+lb4QqMG0RrgcAAT9T/TVsuirzCLS+p4XHbzd/k6jZwIq
         N338MKgpr5bjHXe/8kr2Sp4KR2UUnWX926nE24WG2YbqlMjFJEFV0HZMu2iTvJKt8U
         Qq/e6z/wSy2a+lDHBMhxeqd7cTWPbtgw/WzH5g+4=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com
Subject: [PATCH/RFC] clk: gate: Add some kunit test suites
Date:   Tue,  7 Apr 2020 20:56:37 -0700
Message-Id: <20200408035637.110858-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test various parts of the clk gate implementation with the kunit testing
framework.

Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: <kunit-dev@googlegroups.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

This patch is on top of this series[1] that allows the clk
framework to be selected by Kconfig language.

[1] https://lore.kernel.org/r/20200405025123.154688-1-sboyd@kernel.org

 drivers/clk/Kconfig         |   8 +
 drivers/clk/Makefile        |   1 +
 drivers/clk/clk-gate-test.c | 481 ++++++++++++++++++++++++++++++++++++
 3 files changed, 490 insertions(+)
 create mode 100644 drivers/clk/clk-gate-test.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 6ea0631e3956..66193673bcdf 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -377,4 +377,12 @@ source "drivers/clk/ti/Kconfig"
 source "drivers/clk/uniphier/Kconfig"
 source "drivers/clk/zynqmp/Kconfig"
 
+# Kunit test cases
+config CLK_GATE_TEST
+	tristate "Basic gate type Kunit test"
+	depends on KUNIT
+	default KUNIT
+	help
+	  Kunit test for the basic clk gate type.
+
 endif
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index f4169cc2fd31..0785092880fd 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-divider.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-factor.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-rate.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-gate.o
+obj-$(CONFIG_CLK_GATE_TEST)	+= clk-gate-test.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-multiplier.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-mux.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-composite.o
diff --git a/drivers/clk/clk-gate-test.c b/drivers/clk/clk-gate-test.c
new file mode 100644
index 000000000000..b1d6c21e9698
--- /dev/null
+++ b/drivers/clk/clk-gate-test.c
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for clk gate basic type
+ */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include <kunit/test.h>
+
+static void clk_gate_register_test_dev(struct kunit *test)
+{
+	struct clk_hw *ret;
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_simple("test_gate_device", -1, NULL, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	ret = clk_hw_register_gate(&pdev->dev, "test_gate", NULL, 0, NULL,
+				   0, 0, NULL);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ret);
+	KUNIT_EXPECT_STREQ(test, "test_gate", clk_hw_get_name(ret));
+	KUNIT_EXPECT_EQ(test, 0UL, clk_hw_get_flags(ret));
+
+	clk_hw_unregister_gate(ret);
+	platform_device_put(pdev);
+}
+
+static void clk_gate_register_test_parent_names(struct kunit *test)
+{
+	struct clk_hw *parent;
+	struct clk_hw *ret;
+
+	parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
+					    1000000);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+
+	ret = clk_hw_register_gate(NULL, "test_gate", "test_parent", 0, NULL,
+				   0, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
+	KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
+
+	clk_hw_unregister_gate(ret);
+	clk_hw_unregister_fixed_rate(parent);
+}
+
+static void clk_gate_register_test_parent_data(struct kunit *test)
+{
+	struct clk_hw *parent;
+	struct clk_hw *ret;
+	struct clk_parent_data pdata = { };
+
+	parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
+					    1000000);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+	pdata.hw = parent;
+
+	ret = clk_hw_register_gate_parent_data(NULL, "test_gate", &pdata, 0,
+					       NULL, 0, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
+	KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
+
+	clk_hw_unregister_gate(ret);
+	clk_hw_unregister_fixed_rate(parent);
+}
+
+static void clk_gate_register_test_parent_data_legacy(struct kunit *test)
+{
+	struct clk_hw *parent;
+	struct clk_hw *ret;
+	struct clk_parent_data pdata = { };
+
+	parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
+					    1000000);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+	pdata.name = "test_parent";
+
+	ret = clk_hw_register_gate_parent_data(NULL, "test_gate", &pdata, 0,
+					       NULL, 0, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
+	KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
+
+	clk_hw_unregister_gate(ret);
+	clk_hw_unregister_fixed_rate(parent);
+}
+
+static void clk_gate_register_test_parent_hw(struct kunit *test)
+{
+	struct clk_hw *parent;
+	struct clk_hw *ret;
+
+	parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
+					    1000000);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+
+	ret = clk_hw_register_gate_parent_hw(NULL, "test_gate", parent, 0, NULL,
+					     0, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
+	KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
+
+	clk_hw_unregister_gate(ret);
+	clk_hw_unregister_fixed_rate(parent);
+}
+
+static void clk_gate_register_test_hiword_invalid(struct kunit *test)
+{
+	struct clk_hw *ret;
+
+	ret = clk_hw_register_gate(NULL, "test_gate", NULL, 0, NULL,
+				   20, CLK_GATE_HIWORD_MASK, NULL);
+
+	KUNIT_EXPECT_TRUE(test, IS_ERR(ret));
+}
+
+static struct kunit_case clk_gate_register_test_cases[] = {
+	KUNIT_CASE(clk_gate_register_test_dev),
+	KUNIT_CASE(clk_gate_register_test_parent_names),
+	KUNIT_CASE(clk_gate_register_test_parent_data),
+	KUNIT_CASE(clk_gate_register_test_parent_data_legacy),
+	KUNIT_CASE(clk_gate_register_test_parent_hw),
+	KUNIT_CASE(clk_gate_register_test_hiword_invalid),
+	{}
+};
+
+static struct kunit_suite clk_gate_register_test_suite = {
+	.name = "clk-gate-register-test",
+	.test_cases = clk_gate_register_test_cases,
+};
+
+struct clk_gate_test_context {
+	void __iomem *fake_mem;
+	struct clk_hw *hw;
+	struct clk_hw *parent;
+	u32 fake_reg; /* Keep at end, KASAN can detect out of bounds */
+};
+
+static struct clk_gate_test_context *clk_gate_test_alloc_ctx(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx;
+
+	test->priv = ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	ctx->fake_mem = (void __force __iomem *)&ctx->fake_reg;
+
+	return ctx;
+}
+
+static void clk_gate_test_parent_rate(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx = test->priv;
+	struct clk_hw *parent = ctx->parent;
+	struct clk_hw *hw = ctx->hw;
+	unsigned long prate = clk_hw_get_rate(parent);
+	unsigned long rate = clk_hw_get_rate(hw);
+
+	KUNIT_EXPECT_EQ(test, prate, rate);
+}
+
+static void clk_gate_test_enable(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx = test->priv;
+	struct clk_hw *parent = ctx->parent;
+	struct clk_hw *hw = ctx->hw;
+	struct clk *clk = hw->clk;
+	int ret;
+	u32 enable_val = BIT(5);
+
+	ret = clk_prepare_enable(clk);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(parent));
+}
+
+static void clk_gate_test_disable(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx = test->priv;
+	struct clk_hw *parent = ctx->parent;
+	struct clk_hw *hw = ctx->hw;
+	struct clk *clk = hw->clk;
+	int ret;
+	u32 enable_val = BIT(5);
+	u32 disable_val = 0;
+
+	ret = clk_prepare_enable(clk);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
+
+	clk_disable_unprepare(clk);
+	KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(parent));
+}
+
+static struct kunit_case clk_gate_test_cases[] = {
+	KUNIT_CASE(clk_gate_test_parent_rate),
+	KUNIT_CASE(clk_gate_test_enable),
+	KUNIT_CASE(clk_gate_test_disable),
+	{}
+};
+
+static int clk_gate_test_init(struct kunit *test)
+{
+	struct clk_hw *parent;
+	struct clk_hw *hw;
+	struct clk_gate_test_context *ctx;
+
+	ctx = clk_gate_test_alloc_ctx(test);
+	parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
+					    2000000);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+
+	hw = clk_hw_register_gate_parent_hw(NULL, "test_gate", parent, 0,
+					    ctx->fake_mem, 5, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+
+	ctx->hw = hw;
+	ctx->parent = parent;
+
+	return 0;
+}
+
+static void clk_gate_test_exit(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx = test->priv;
+
+	clk_hw_unregister_gate(ctx->hw);
+	clk_hw_unregister_fixed_rate(ctx->parent);
+	kfree(ctx);
+}
+
+static struct kunit_suite clk_gate_test_suite = {
+	.name = "clk-gate-test",
+	.init = clk_gate_test_init,
+	.exit = clk_gate_test_exit,
+	.test_cases = clk_gate_test_cases,
+};
+
+static void clk_gate_test_invert_enable(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx = test->priv;
+	struct clk_hw *parent = ctx->parent;
+	struct clk_hw *hw = ctx->hw;
+	struct clk *clk = hw->clk;
+	int ret;
+	u32 enable_val = 0;
+
+	ret = clk_prepare_enable(clk);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(parent));
+}
+
+static void clk_gate_test_invert_disable(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx = test->priv;
+	struct clk_hw *parent = ctx->parent;
+	struct clk_hw *hw = ctx->hw;
+	struct clk *clk = hw->clk;
+	int ret;
+	u32 enable_val = 0;
+	u32 disable_val = BIT(15);
+
+	ret = clk_prepare_enable(clk);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
+
+	clk_disable_unprepare(clk);
+	KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(parent));
+}
+
+static struct kunit_case clk_gate_test_invert_cases[] = {
+	KUNIT_CASE(clk_gate_test_invert_enable),
+	KUNIT_CASE(clk_gate_test_invert_disable),
+	{}
+};
+
+static int clk_gate_test_invert_init(struct kunit *test)
+{
+	struct clk_hw *parent;
+	struct clk_hw *hw;
+	struct clk_gate_test_context *ctx;
+
+	ctx = clk_gate_test_alloc_ctx(test);
+	parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
+					    2000000);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+
+	ctx->fake_reg = BIT(15); /* Default to off */
+	hw = clk_hw_register_gate_parent_hw(NULL, "test_gate", parent, 0,
+					    ctx->fake_mem, 15,
+					    CLK_GATE_SET_TO_DISABLE, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+
+	ctx->hw = hw;
+	ctx->parent = parent;
+
+	return 0;
+}
+
+static struct kunit_suite clk_gate_test_invert_suite = {
+	.name = "clk-gate-invert-test",
+	.init = clk_gate_test_invert_init,
+	.exit = clk_gate_test_exit,
+	.test_cases = clk_gate_test_invert_cases,
+};
+
+static void clk_gate_test_hiword_enable(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx = test->priv;
+	struct clk_hw *parent = ctx->parent;
+	struct clk_hw *hw = ctx->hw;
+	struct clk *clk = hw->clk;
+	int ret;
+	u32 enable_val = BIT(9) | BIT(9 + 16);
+
+	ret = clk_prepare_enable(clk);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(parent));
+}
+
+static void clk_gate_test_hiword_disable(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx = test->priv;
+	struct clk_hw *parent = ctx->parent;
+	struct clk_hw *hw = ctx->hw;
+	struct clk *clk = hw->clk;
+	int ret;
+	u32 enable_val = BIT(9) | BIT(9 + 16);
+	u32 disable_val = BIT(9 + 16);
+
+	ret = clk_prepare_enable(clk);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
+
+	clk_disable_unprepare(clk);
+	KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(parent));
+}
+
+static struct kunit_case clk_gate_test_hiword_cases[] = {
+	KUNIT_CASE(clk_gate_test_hiword_enable),
+	KUNIT_CASE(clk_gate_test_hiword_disable),
+	{}
+};
+
+static int clk_gate_test_hiword_init(struct kunit *test)
+{
+	struct clk_hw *parent;
+	struct clk_hw *hw;
+	struct clk_gate_test_context *ctx;
+
+	ctx = clk_gate_test_alloc_ctx(test);
+	parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
+					    2000000);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+
+	hw = clk_hw_register_gate_parent_hw(NULL, "test_gate", parent, 0,
+					    ctx->fake_mem, 9,
+					    CLK_GATE_HIWORD_MASK, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+
+	ctx->hw = hw;
+	ctx->parent = parent;
+
+	return 0;
+}
+
+static struct kunit_suite clk_gate_test_hiword_suite = {
+	.name = "clk-gate-hiword-test",
+	.init = clk_gate_test_hiword_init,
+	.exit = clk_gate_test_exit,
+	.test_cases = clk_gate_test_hiword_cases,
+};
+
+static void clk_gate_test_is_enabled(struct kunit *test)
+{
+	struct clk_hw *hw;
+	struct clk_gate_test_context *ctx;
+
+	ctx = clk_gate_test_alloc_ctx(test);
+	ctx->fake_reg = BIT(7);
+	hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 7,
+				  0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+	KUNIT_ASSERT_TRUE(test, clk_hw_is_enabled(hw));
+
+	clk_hw_unregister_gate(hw);
+	kfree(ctx);
+}
+
+static void clk_gate_test_is_disabled(struct kunit *test)
+{
+	struct clk_hw *hw;
+	struct clk_gate_test_context *ctx;
+
+	ctx = clk_gate_test_alloc_ctx(test);
+	ctx->fake_reg = BIT(4);
+	hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 7,
+				  0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+	KUNIT_ASSERT_FALSE(test, clk_hw_is_enabled(hw));
+
+	clk_hw_unregister_gate(hw);
+	kfree(ctx);
+}
+
+static void clk_gate_test_is_enabled_inverted(struct kunit *test)
+{
+	struct clk_hw *hw;
+	struct clk_gate_test_context *ctx;
+
+	ctx = clk_gate_test_alloc_ctx(test);
+	ctx->fake_reg = BIT(31);
+	hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 2,
+				  CLK_GATE_SET_TO_DISABLE, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+	KUNIT_ASSERT_TRUE(test, clk_hw_is_enabled(hw));
+
+	clk_hw_unregister_gate(hw);
+	kfree(ctx);
+}
+
+static void clk_gate_test_is_disabled_inverted(struct kunit *test)
+{
+	struct clk_hw *hw;
+	struct clk_gate_test_context *ctx;
+
+	ctx = clk_gate_test_alloc_ctx(test);
+	ctx->fake_reg = BIT(29);
+	hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 29,
+				  CLK_GATE_SET_TO_DISABLE, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+	KUNIT_ASSERT_FALSE(test, clk_hw_is_enabled(hw));
+
+	clk_hw_unregister_gate(hw);
+	kfree(ctx);
+}
+
+static struct kunit_case clk_gate_test_enabled_cases[] = {
+	KUNIT_CASE(clk_gate_test_is_enabled),
+	KUNIT_CASE(clk_gate_test_is_disabled),
+	KUNIT_CASE(clk_gate_test_is_enabled_inverted),
+	KUNIT_CASE(clk_gate_test_is_disabled_inverted),
+	{}
+};
+
+static struct kunit_suite clk_gate_test_enabled_suite = {
+	.name = "clk-gate-is_enabled-test",
+	.test_cases = clk_gate_test_enabled_cases,
+};
+
+kunit_test_suites(
+	&clk_gate_register_test_suite,
+	&clk_gate_test_suite,
+	&clk_gate_test_invert_suite,
+	&clk_gate_test_hiword_suite,
+	&clk_gate_test_enabled_suite
+);
+MODULE_LICENSE("GPL v2");

base-commit: 7111951b8d4973bda27ff663f2cf18b663d15b48
prerequisite-patch-id: e066e74d3e3848a69239083647017b9e4b2a7b87
prerequisite-patch-id: ab1cc18da4a59b8973b4c8d85b6ea90eb6200df0
prerequisite-patch-id: 5608c2059c4ad2d76aae62cd9897862a1f447cfb
prerequisite-patch-id: 3a2300fc681af075232bfe62dbd1eb81290ca5a1
prerequisite-patch-id: 6268382cce3446e3eb3cec7fec86973ab3dc9e7c
prerequisite-patch-id: 57b540a6a65ffb9cc53bb4b9c3fd8c4f55a4ce05
prerequisite-patch-id: 2ec56bc3f971534850ebe7253d5ae023dfc87410
prerequisite-patch-id: 9500860f59b801c734ab22f18737ca0ceff8208c
prerequisite-patch-id: 09a4d90ae718ab61fc9423862b1c2044ea898e3e
-- 
Sent by a computer, using git, on the internet

