Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DCCC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AECF246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583134713;
	bh=T8vFYILzC45eCW4Wh3WxrKNUOWDY4EPays1rr51QIiU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hYyXOr33lHQ41agQHktDLvYyNXafgJC5RaiYbMFqTq19YQ3ky2IyktwgWPEVwndmQ
	 kZj7yTcFBpWtK7ZaoBVeP+nopNQCai4NdiF/rggQDgNapkwRUlRZYklnRGkZA/pajn
	 dwiJM0GBQYUjV8Emw3UcDK/oJ1oRoXrKlhyxyATc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgCBHiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:38:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:44750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgCBHiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:38:16 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75907246C3;
        Mon,  2 Mar 2020 07:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583134694;
        bh=T8vFYILzC45eCW4Wh3WxrKNUOWDY4EPays1rr51QIiU=;
        h=From:To:Cc:Subject:Date:From;
        b=wzERUhC5bF+eOidCDFaJu9O4eO82gm15t2C5lmq0HYjReq3+oK2NBuEGyERqazTar
         +CorwDJFnpmzkcHGkjXl42afKcuAwl48VntNy7JTAB7XnzL8p85eCpZWmaHxw8Xf3T
         hYlyhvPZnC4zd4uIEAgzMO78fnMi0DLB+1CtA7aA=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8feV-0003VO-OT; Mon, 02 Mar 2020 08:38:11 +0100
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andy Whitcroft <apw@canonical.com>, devicetree@vger.kernel.org,
        Harry Wei <harryxiyou@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Joe Perches <joe@perches.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 00/12] Convert some DT documentation files to ReST
Date:   Mon,  2 Mar 2020 08:37:55 +0100
Message-Id: <cover.1583134242.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.1
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
2.21.1


