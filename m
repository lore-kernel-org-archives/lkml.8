Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BB8C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B7B20737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ReF/knYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgGWIpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:45:39 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:61471 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGWIpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1595493939;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=72O9Vq2KCcfxQZ+2XMr33XBH+Ul/LT1ze0PUb6UVYmA=;
  b=ReF/knYEnrbbuatmtTEBzsIkLrqomi1Uj8Bqx874nl9OJSOhsS2xSnFc
   HS40vKh3dQL5vDkH3i9SatKZL3IGoaiyn1K1gYqTS1O6hV1bNtKcrOo9+
   ptNlT4wksDtXRitCZ6YoyjNAcLRS4SkkJu70vJVOiP+RIzbdFAX4jOU0Q
   M=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: f7/VECJkUrZI6D9AU9fZyXFnzqE7fxOOJW8CSc/x4arrsRiDYsnH7BAo3Xdo92ixKIqxZ2NwCg
 it28KI7hnbx7sNR/Sziev+cmHmfTTr0wwtMz25hUj1rgU6ODGWnX3fOhYmVitmvcgd3SQ2XS7H
 pfekBXi7utIwA3ue+p7Uc/0oSkMmBm/WSnOk0/kYIWzlXgWUNqY9bXXJj+58LIlc8qskCis/+N
 LhNTFkVkCnPNGlLUottO+4pJX2Uw5TF/j27GkvDiLyA1vEehq8K15OB0EiFrlvD6bMpwUybw4Y
 0cI=
X-SBRS: 2.7
X-MesageID: 23016163
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,386,1589256000"; 
   d="scan'208";a="23016163"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>
Subject: [PATCH 0/3] xen/balloon: fixes for memory hotplug
Date:   Thu, 23 Jul 2020 10:45:20 +0200
Message-ID: <20200723084523.42109-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following series contain some fixes in order to make Xen balloon
memory hotplug function properly. Fix two patches are bugfixes that IMO
should be backported to stable branches, last patch might be more
controversial (to backport) since it includes a small change to the
generic memory hotplug interface.

Thanks, Roger.

Roger Pau Monne (3):
  xen/balloon: fix accounting in alloc_xenballooned_pages error path
  xen/balloon: make the balloon wait interruptible
  memory: introduce an option to force onlining of hotplug memory

 drivers/xen/balloon.c          | 14 +++++++++++---
 include/linux/memory_hotplug.h |  3 ++-
 mm/memory_hotplug.c            | 16 ++++++++++------
 3 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.27.0

