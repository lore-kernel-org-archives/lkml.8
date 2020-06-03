Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397B3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B5D02067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgFCAIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 20:08:25 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57956 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFCAIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 20:08:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 947248030835;
        Wed,  3 Jun 2020 00:08:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id crSB_BARp40X; Wed,  3 Jun 2020 03:08:22 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] hwmon: bt1-pvt: Define Temp- and Volt-to-N poly as maybe-unused
Date:   Wed, 3 Jun 2020 03:07:53 +0300
Message-ID: <20200603000753.391-1-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200602091219.24404-1-Sergey.Semin@baikalelectronics.ru>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang-based kernel building with W=1 warns that some static const
variables are unused:

drivers/hwmon/bt1-pvt.c:67:30: warning: unused variable 'poly_temp_to_N' [-Wunused-const-variable]
static const struct pvt_poly poly_temp_to_N = {
                             ^
drivers/hwmon/bt1-pvt.c:99:30: warning: unused variable 'poly_volt_to_N' [-Wunused-const-variable]
static const struct pvt_poly poly_volt_to_N = {
                             ^

Indeed these polynomials are utilized only when the PVT sensor alarms are
enabled. In that case they are used to convert the temperature and
voltage alarm limits from normal quantities (Volts and degree Celsius) to
the sensor data representation N = [0, 1023]. Otherwise when alarms are
disabled the driver only does the detected data conversion to the human
readable form and doesn't need that polynomials defined. So let's mark the
Temp-to-N and Volt-to-N polynomials with __maybe_unused attribute.

Note gcc with W=1 doesn't notice the problem.

Fixes: 87976ce2825d ("hwmon: Add Baikal-T1 PVT sensor driver")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>

---

Link: https://lore.kernel.org/linux-hwmon/20200602091219.24404-1-Sergey.Semin@baikalelectronics.ru
Changelog v2:
- Repalce if-defs with __maybe_unused attribute.
---
 drivers/hwmon/bt1-pvt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/bt1-pvt.c b/drivers/hwmon/bt1-pvt.c
index 1a9772fb1f73..8709b3f54086 100644
--- a/drivers/hwmon/bt1-pvt.c
+++ b/drivers/hwmon/bt1-pvt.c
@@ -64,7 +64,7 @@ static const struct pvt_sensor_info pvt_info[] = {
  *     48380,
  * where T = [-48380, 147438] mC and N = [0, 1023].
  */
-static const struct pvt_poly poly_temp_to_N = {
+static const struct pvt_poly __maybe_unused poly_temp_to_N = {
 	.total_divider = 10000,
 	.terms = {
 		{4, 18322, 10000, 10000},
@@ -96,7 +96,7 @@ static const struct pvt_poly poly_N_to_temp = {
  * N = (18658e-3*V - 11572) / 10,
  * V = N * 10^5 / 18658 + 11572 * 10^4 / 18658.
  */
-static const struct pvt_poly poly_volt_to_N = {
+static const struct pvt_poly __maybe_unused poly_volt_to_N = {
 	.total_divider = 10,
 	.terms = {
 		{1, 18658, 1000, 1},
-- 
2.26.2

