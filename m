Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2871FC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FDE2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579687029;
	bh=80qMqilDKb1q7yzrUTzmSO/ts7DiRjQ2oLgmnoGIPT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fJ4ewrVT4IqQR0LhkVyQ7mEV2ECOfAqTBz/RaV6JDga9c9i4ixNiFk4PTMZlD2/ge
	 oh9jOadttt3Rl5iD5OfTukJFHTQaBYuppyTIXtJGt4iebQbtqJFt5AeDqm7OnhJzbV
	 J+e4+DE5gStsL/3xLTSgzFyjCib7wjhy0/lO8QeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgAVJbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:31:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:43152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729537AbgAVJbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:31:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC5EA24672;
        Wed, 22 Jan 2020 09:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685473;
        bh=80qMqilDKb1q7yzrUTzmSO/ts7DiRjQ2oLgmnoGIPT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYuuaRUjleupadYmnfEhMlsQcLiN84Us/xpAH4fM7PoQOMNSS/EYo9M1EDLxu1DWT
         Fv1dhctOCH55O9zsgJFs3FOQI+9BaAD7y7NIHUm3lu7QmXCgHG+Uzm5p5hMemAbJ+G
         EaAcCNyRtaVTAlAYD8/oO9JbpuD9s9akxZ0EfzAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.4 28/76] mei: fix modalias documentation
Date:   Wed, 22 Jan 2020 10:28:44 +0100
Message-Id: <20200122092754.628553357@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092751.587775548@linuxfoundation.org>
References: <20200122092751.587775548@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

commit 73668309215285366c433489de70d31362987be9 upstream.

mei client bus added the client protocol version to the device alias,
but ABI documentation was not updated.

Fixes: b26864cad1c9 (mei: bus: add client protocol version to the device alias)
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Link: https://lore.kernel.org/r/20191008005735.12707-1-tomas.winkler@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/ABI/testing/sysfs-bus-mei |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/ABI/testing/sysfs-bus-mei
+++ b/Documentation/ABI/testing/sysfs-bus-mei
@@ -4,7 +4,7 @@ KernelVersion:	3.10
 Contact:	Samuel Ortiz <sameo@linux.intel.com>
 		linux-mei@linux.intel.com
 Description:	Stores the same MODALIAS value emitted by uevent
-		Format: mei:<mei device name>:<device uuid>:
+		Format: mei:<mei device name>:<device uuid>:<protocol version>
 
 What:		/sys/bus/mei/devices/.../name
 Date:		May 2015


