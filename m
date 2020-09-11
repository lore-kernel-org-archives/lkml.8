Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF312C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65C4206CA
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgIKQKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:10:05 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:43667 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgIKPnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:43:37 -0400
Received: from methusalix.internal.home.lespocky.de ([109.250.103.56]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M8yU2-1kCtYW2lIE-0069sH; Fri, 11 Sep 2020 17:41:02 +0200
Received: from lemmy.internal.home.lespocky.de ([192.168.243.176] helo=lemmy.home.lespocky.de)
        by methusalix.internal.home.lespocky.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <alex@home.lespocky.de>)
        id 1kGlAa-000135-BL; Fri, 11 Sep 2020 17:41:01 +0200
Received: (nullmailer pid 28463 invoked by uid 2001);
        Fri, 11 Sep 2020 15:41:00 -0000
From:   Alexander Dahl <post@lespocky.de>
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Alexander Dahl <ada@thorsis.com>,
        Alexander Dahl <post@lespocky.de>
Subject: [PATCH v4 1/3] leds: Require valid fwnode pointer for composing name
Date:   Fri, 11 Sep 2020 17:40:02 +0200
Message-Id: <20200911154004.28354-2-post@lespocky.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911154004.28354-1-post@lespocky.de>
References: <20200911154004.28354-1-post@lespocky.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scan-Signature: 2c58665afdcdd1fd53023359626f008f
X-Provags-ID: V03:K1:LYC8iw1IV1lNMsuBweYlQBm4S8YlGnqKIC8zMdEBw3RCUlYAB2c
 PrN32EnGnTiai7GDG1bbSZQx9SvV8xFXJcNRgVGW233JNEtp8Wc9IMKUGnHe3nASQID774P
 qCGms4EK7yU2auAuGu9y7cw4k48vHJvBRzzrJGLN3N3dgNCy+96pljzsgrHm6N08hwD18Y7
 fr8z07kKHzujpkFkoBebA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qcQEAlD1CsA=:7jt+4zYANct2HOHggDoDdS
 UHChqMVXTsDyNmMc+EhWY4Y/1qUoczXaluerEu8wAs4T6q6N6ko3TGBVXzmeYBXawt/0XRzVy
 de06iRx/SXZeyqoQQbRYW59qpC/MKvN1kDZRAoJ9ARsAUmL+933UfG1WLXwu7BSj9gR3NqUlf
 owON7u3PEbZ32xYlxhGpIBzgggqu47KTzoU386bb1aFeKkQgzRvv+gAVqAp/ITOXlCVOz2HY7
 EaUQ3rlxb8hrIFx48WhLKXYmoRhE1ZJ6e2zEc2CMRY2KLTglpyKuI1nXurnJz+UgafoYXdXFA
 XXq/Hn/0/uU/sZ5orN1BJEeqOroDGEyY3TPvv+SnuVncfyO0Vii/bmXseRMsJyQULHAK2iTgc
 dbNY6XEI3XyYouiyrYGnQoqXxkC1XsZh2fgpbi5Amd3jfB+IvKqir+5B2YgkS81EVBMSXnpMa
 DXsPP0CrpMQrlDwwHMo0C2isk5Fu0+L3Ei42oLI4SAPrtkpV4Edjk0rZ7kap70pvTf4la1Q8j
 o6c9Cd9vWI4kjqZY0yQNGqgswyGjIDPamGgkHogY25c/lOJASYFq9S8Yvf33ndy28zDJI0rrz
 xTg8pr70b0DmhgMUFtdKpGnzcxPCI+SZkqcvcUj+C0BzcZaK8Sl0o+ttPH/QKgBuyATbdcVLt
 SABghWiEdTwSX6qiQ5DlUdcRMfsYLfgb2Usx9wboZ5WcrZvTyn/I/w3bUFfwDCHcgJzqZJ8dX
 4WHlXpN4ZD/3R5BfKd+ArX+toxs6bsFftUm4FQKBt13G6MPh1ULcguVYyFV17gxSbW4uRkNTQ
 PeM7cTrH3Cvg03mqr7ABCT6a0LXdTx3HcMmMoKTsFpzIVpxBwoG4amh80WrAkeQ5AFt2bcl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function 'led_compose_name()' is called in
'led_classdev_register_ext(()' only and in its implementation it always
parses the fwnode passed with the init_data struct.  If there's no
fwnode, EINVAL is returned and 'led_classdev_register_ext()' returns
early.

If this is detected early the same fallback mechanism can be used , as
if init_data itself is NULL.  This will allow drivers to pass fully
populated 'init_data' or sparse initialized 'init_data' with a NULL
fwnode in a more elegant way with only one function call.

Fixes: bb4e9af0348d ("leds: core: Add support for composing LED class device names")
Suggested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Alexander Dahl <post@lespocky.de>
---

Notes:
    v4:
      * added this patch to series (Suggested-by: Pavel Machek)

 drivers/leds/led-class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index cc3929f858b6..3da50c7ecfe7 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -346,7 +346,7 @@ int led_classdev_register_ext(struct device *parent,
 	const char *proposed_name = composed_name;
 	int ret;
 
-	if (init_data) {
+	if (init_data && init_data->fwnode) {
 		if (init_data->devname_mandatory && !init_data->devicename) {
 			dev_err(parent, "Mandatory device name is missing");
 			return -EINVAL;
-- 
2.20.1

