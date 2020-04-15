Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E31C38A29
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB372078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586961952;
	bh=LBRibY2+edxEVgU7UWVvu+ttauPTs/x7bDvivBGYcDM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AIU3cDwzAC5QTGW/CEUCCMp/aYhPrudCv4kJXU6U/YuysbgVEiGeWnHoK4o5tIurv
	 m7fZFDmj5iMkGKcS04CFf9a7Xep/9MOryaRfhpfSBUwJhfSthMqmgBPbAp/CKy3MqO
	 g7cqshs17GjauQNW6i2Q/lMfAM3VYid6AKhwXrpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636810AbgDOOpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634626AbgDOOpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:45:30 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D95C7208FE;
        Wed, 15 Apr 2020 14:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961929;
        bh=LBRibY2+edxEVgU7UWVvu+ttauPTs/x7bDvivBGYcDM=;
        h=From:To:Cc:Subject:Date:From;
        b=n4PNln3zdNelJMiElhbfb9f5iXXBeQXqhu/3vBtCDuyrMr+CvLYnl1L2YPSbo4//J
         zgJVH8OYkZ14CECkqwXlstWPSgeB0OlKPSoWURDRZ/JOSIcTgB7GFI0G1nas/LEB7W
         Wo80tmACWbn1qYlO9vCJYnLnfOSb8Se5rWL26R1w=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOjI7-006kZ8-0p; Wed, 15 Apr 2020 16:45:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Joe Perches <joe@perches.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Andy Whitcroft <apw@canonical.com>, devicetree@vger.kernel.org,
        Harry Wei <harryxiyou@gmail.com>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v3 00/12] Convert some DT documentation files to ReST
Date:   Wed, 15 Apr 2020 16:45:14 +0200
Message-Id: <cover.1586961793.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While most of the devicetree stuff has its own format (with is now being
converted to YAML format), some documents there are actually
describing the DT concepts and how to contribute to it.

IMHO, those documents would fit perfectly as part of the documentation
body, as part of the firmare documents set.

This patch series manually converts some DT documents that, on my
opinion, would belong to it.

If you want to see how this would show at the documentation body,
a sneak peak of this series (together with the other pending
doc patches from me) is available at:

	https://www.infradead.org/~mchehab/kernel_docs/devicetree/index.html

-

v3:
   - rebased on the top of next-20200414

Mauro Carvalho Chehab (12):
  docs: dt: add an index.rst file for devicetree
  docs: dt: convert usage-model.txt to ReST
  docs: dt: usage_model.rst: fix link for DT usage
  docs: dt: convert booting-without-of.txt to ReST format
  docs: dt: convert changesets to ReST
  docs: dt: convert dynamic-resolution-notes.txt to ReST
  docs: dt: convert of_unittest.txt to ReST
  docs: dt: convert overlay-notes.txt to ReST format
  docs: dt: minor adjustments at writing-schema.rst
  docs: dt: convert ABI.txt to ReST format
  docs: dt: convert submitting-patches.txt to ReST format
  docs: dt: convert writing-bindings.txt to ReST

 Documentation/arm/booting.rst                 |   2 +-
 Documentation/arm/microchip.rst               |   2 +-
 .../devicetree/bindings/{ABI.txt => ABI.rst}  |   5 +-
 .../devicetree/bindings/arm/amlogic.yaml      |   2 +-
 .../devicetree/bindings/arm/syna.txt          |   2 +-
 Documentation/devicetree/bindings/index.rst   |  12 +
 ...ing-patches.txt => submitting-patches.rst} |  12 +-
 ...ting-bindings.txt => writing-bindings.rst} |   9 +-
 ...-without-of.txt => booting-without-of.rst} | 299 ++++++++++--------
 .../{changesets.txt => changesets.rst}        |  24 +-
 ...notes.txt => dynamic-resolution-notes.rst} |   5 +-
 Documentation/devicetree/index.rst            |  18 ++
 .../{of_unittest.txt => of_unittest.rst}      | 186 +++++------
 .../{overlay-notes.txt => overlay-notes.rst}  | 143 +++++----
 .../{usage-model.txt => usage-model.rst}      |  35 +-
 Documentation/devicetree/writing-schema.rst   |   9 +-
 Documentation/index.rst                       |   3 +
 Documentation/process/submitting-patches.rst  |   2 +-
 .../it_IT/process/submitting-patches.rst      |   2 +-
 Documentation/translations/zh_CN/arm/Booting  |   2 +-
 MAINTAINERS                                   |   4 +-
 include/linux/mfd/core.h                      |   2 +-
 scripts/checkpatch.pl                         |   2 +-
 23 files changed, 446 insertions(+), 336 deletions(-)
 rename Documentation/devicetree/bindings/{ABI.txt => ABI.rst} (94%)
 create mode 100644 Documentation/devicetree/bindings/index.rst
 rename Documentation/devicetree/bindings/{submitting-patches.txt => submitting-patches.rst} (92%)
 rename Documentation/devicetree/bindings/{writing-bindings.txt => writing-bindings.rst} (89%)
 rename Documentation/devicetree/{booting-without-of.txt => booting-without-of.rst} (90%)
 rename Documentation/devicetree/{changesets.txt => changesets.rst} (59%)
 rename Documentation/devicetree/{dynamic-resolution-notes.txt => dynamic-resolution-notes.rst} (90%)
 create mode 100644 Documentation/devicetree/index.rst
 rename Documentation/devicetree/{of_unittest.txt => of_unittest.rst} (54%)
 rename Documentation/devicetree/{overlay-notes.txt => overlay-notes.rst} (56%)
 rename Documentation/devicetree/{usage-model.txt => usage-model.rst} (97%)

-- 
2.25.2


