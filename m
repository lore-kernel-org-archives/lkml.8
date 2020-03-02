Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3CAC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B8A246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583136029;
	bh=O7Nz5bXTFhp3PnnkjvSOQ1ZupYcl5S544B2JAVRdgnU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vp0vhJ2fhjGWp4w+UQe33PfELpcj6sBqGnBZbzxEXyCd+m+0gPxucIzep5GvX5n6H
	 ontA3yLIVUYRWaQENQf2qW28YJ60wIM3Sivh4ppZ4uq5r9LqsP/WFo84NBNb/SgAZ5
	 CmJiGdHJJDVa9aRNar+SSYzBXTFK8AasGnbuSyt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCBIA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:00:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBH7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:59:42 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC4E24699;
        Mon,  2 Mar 2020 07:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583135981;
        bh=O7Nz5bXTFhp3PnnkjvSOQ1ZupYcl5S544B2JAVRdgnU=;
        h=From:To:Cc:Subject:Date:From;
        b=rm8uxl6V/z1+8+OW9CpDdrLeTick0x3xpfrOk1J2nO3QIzyuAYLjXtXkpY0F1KXbG
         B+6I1EHStHqptZ3KI1l0hHrNv2Qw2w8HEzADEktv7iRv011iOiw9uiykbtAEKIyLpd
         7VDn2QT8bxJr8KLxlAwQDlkrQuypqmS/GcQ7tRtg=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8fzG-0003gK-WF; Mon, 02 Mar 2020 08:59:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 00/12] Convert some DT documentation files to ReST
Date:   Mon,  2 Mar 2020 08:59:25 +0100
Message-Id: <cover.1583135507.git.mchehab+huawei@kernel.org>
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

This series is available on this devel branch:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=dt-docs-20200228

and it is based on next-20200228

-

v2: Fixed my email address and removed extra wrong SoB on all patches.


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


