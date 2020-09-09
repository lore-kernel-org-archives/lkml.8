Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28121C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11A021D47
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599628493;
	bh=EONsNBav4eRxYlNYFP1LXxj6M47uluI/f56SSBbZ0l4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XwO8W6hAWzZcVE68g2+U+T8g3U04Hgqj6rJJb0+5bhsJtT75mxYqeMHpKgwFyvjWb
	 RfA9UoLTQC+j+68bQmDbrY6rXaITXVjdZb9ustDuMzl1K+RbW2uOoslEhOLEgFvNhm
	 Vc86oELtHQA72MqQnGsgM846IZ06m+RZeM/71k8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgIIFOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 01:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIIFOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 01:14:49 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E249221D43;
        Wed,  9 Sep 2020 05:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599628489;
        bh=EONsNBav4eRxYlNYFP1LXxj6M47uluI/f56SSBbZ0l4=;
        h=From:To:Cc:Subject:Date:From;
        b=TxavcDTMMDYy1W7yt+Z+2Bx1j5IsglpAdi6VtwDPKb/QJld9ieLQjFbpXAodG3VAO
         gwx+rNpg0xf3DV6pl3C5YTQ441dUP5FSnBiLOZClk+oXrwmAZOTT4ao8sUszr11aGN
         iCOCdn4DWG9igU68jVw6D38iEKLX6hdrPJgiXw/8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kFsRS-00BfBp-AL; Wed, 09 Sep 2020 07:14:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v3 0/2] use SPDX also for GFDL documents
Date:   Wed,  9 Sep 2020 07:14:31 +0200
Message-Id: <cover.1599628249.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 438 document files that were licensed under the
free versions of GNU Free Document License.

The free versions are the one that doesn't contain invariant
parts.

The first patch adds the license files.  As newer documents
aren't supposed to use them without being dual-licensed
with GPLv2, add them under LICENSE/deprecated.

The second patch replaces a boilerplate text from 
ring-buffer-design.rst by the corresponding SPDX header.

The other documents are all under Documentation/uapi/media.

A separate patchset, to be merged via the linux-media tree
will cover those.

---

v3:
  - Added Valid-License-Identifier, SPDX_URL, Usage-Guide and License-Text 
    meta-tags.

Mauro Carvalho Chehab (2):
  LICENSE: add GFDL deprecated licenses
  docs: trace: ring-buffer-design.rst: use the new SPDX tag

 Documentation/trace/ring-buffer-design.rst |  26 +-
 LICENSES/deprecated/GFDL-1.1               | 377 +++++++++++++++++++
 LICENSES/deprecated/GFDL-1.2               | 417 +++++++++++++++++++++
 3 files changed, 795 insertions(+), 25 deletions(-)
 create mode 100644 LICENSES/deprecated/GFDL-1.1
 create mode 100644 LICENSES/deprecated/GFDL-1.2

-- 
2.26.2


