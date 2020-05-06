Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAFEC54E4B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665DC2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgEGOLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:11:06 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.3]:13694 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728079AbgEGOLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:11:03 -0400
Received: from [100.113.2.173] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-central-1.aws.symcld.net id D2/28-40432-4F614BE5; Thu, 07 May 2020 14:11:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRWlGSWpSXmKPExsVy8MN7Xd0vYlv
  iDNacZLaYc76FxaJ58Xo2i1ULr7FZXN41h83i/adOJov/e3awO7B5bFl5k8mj5chbVo9NqzrZ
  PPbPXcPu8XmTXABrFGtmXlJ+RQJrxo+XuxgL2rgqVramNjB+4ehi5OIQEljDKLH7yR6WLkZOI
  KdS4t/8FWwgNq9AhMT3eS3MIDangJnE/lvr2LsYOYBqTCUuL1UECbMJ6Eg8mrmeCcRmEVCRmP
  PqFJDNziEsECfREgIyXUTgIqPEk8d/wCYyA4VnNSxnhZguKHFy5hMWiLiExMEXL5ghLtCSOLd
  mFeMERt5ZSMpmISlbwMi0itEyqSgzPaMkNzEzR9fQwEDX0NBY10jXyNhYL7FKN1EvtVQ3OTWv
  pCgRKKuXWF6sV1yZm5yTopeXWrKJERiyKYVML3cwblv7Xu8QoyQHk5Io75LPm+OE+JLyUyozE
  osz4otKc1KLDzHKcHAoSfDuF9kSJyRYlJqeWpGWmQOMH5i0BAePkgjvN5A0b3FBYm5xZjpE6h
  SjLsfOo/MWMQux5OXnpUqJ87qJAhUJgBRllObBjYDF8iVGWSlhXkYGBgYhnoLUotzMElT5V4z
  iHIxKwrwZIKt4MvNK4Da9AjqCCeiIz582gRxRkoiQkmpgOqPevHaNiMeFn9sbRK2PGy3YnzpB
  3pGBMeeqWsNx748WYdHixbx3W9c5ixWoX+/PKt/0ROp3S4faxnQXb7cjJit3yBX6/rqxTOJti
  abOhe1K1oGWGXwLijclnz+XybferaszT3StsuOhrM133N487p534ahTbtyJawt113bdU5rK9G
  M/H9eM+VxbSqaa8+suVrjsVLc/03JG3jYTn25Gt0N3q7Ra5s/gq+F2+Wkbx/V8aWD7pWNaWe/
  vi6/mO1Akt9mqyTpQ88S6fqbtep8mX+AzW/jy2xffDrklZ/fUvPocsDS62flVwL4XDn+Tt8xe
  VMy95smeRW3ihUbRltPC7j+IdL/HFCj44Lh29W9rJZbijERDLeai4kQAUkmTmmADAAA=
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-19.tower-223.messagelabs.com!1588860659!2836654!1
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13049 invoked from network); 7 May 2020 14:11:00 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-19.tower-223.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 7 May 2020 14:11:00 -0000
Received: from krsrvapps-03.diasemi.com (10.95.17.51) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Thu, 7 May 2020 16:10:58 +0200
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 182A413F670; Thu,  7 May 2020 23:10:57 +0900 (KST)
Message-ID: <0bf1ec7205df862f117644b280ed4ac88fee5b0b.1588781316.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1588781316.git.Roy.Im@diasemi.com>
References: <cover.1588781316.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Thu, 7 May 2020 01:08:35 +0900
Subject: [PATCH V13 1/3] MAINTAINERS: da7280 updates to the Dialog
 Semiconductor search terms
To:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
v13: No changes.
v12: Corrected file list order.
v11: No changes.
v10: No changes.
v9: No changes.
v8: No changes.
v7: No changes.
v6: No changes.
v5: No changes.
v4: No changes.
v3: No changes.
v2: No changes.


 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2926327..56e83e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4942,6 +4942,7 @@ M:	Support Opensource <support.opensource@diasemi.com>
 S:	Supported
 W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
@@ -4952,6 +4953,7 @@ F:	Documentation/hwmon/da90??.rst
 F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/misc/da90??_onkey.c
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
-- 
end-of-patch for PATCH V13

