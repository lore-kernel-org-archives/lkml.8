Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C91DC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D882080C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580746942;
	bh=FbqL9DxWWj8vs/OxbIAQM1UlvvUfqLzpDxKU81KI42M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YiDrNcQ72vMQqxmkAfbSVBMJgSOGgPGjFkK7TJHMS1vwEQQt7On9ljo5J2C9OvgVE
	 KR9Ogf5hlyPA14jCPu+uTcIQoSXtcNS16Mv2I9VTYl1G3ETXb/DyoEUGktQpXmmksh
	 5ddXOnLE2iy+6leZEdqR4gBDokE5R+XHhunIkBmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgBCQWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:22:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbgBCQVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:21:41 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A24D52080C;
        Mon,  3 Feb 2020 16:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580746900;
        bh=FbqL9DxWWj8vs/OxbIAQM1UlvvUfqLzpDxKU81KI42M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEbWf8aAlK/UQeq35T8tr0boSLiq3hPk/RTkAx/g5NoIozbA+KT46NNcWHPGAtv7d
         l+lLnExyY2oPmexWDt8tshTZAPeP+JZGmnSrDlukIm/Qy7mzzTxYDoHKmcwskIkOhy
         MCiFa1s7IZGUmWrlLKtQtGg5G49MgumJU+MtHLFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 37/53] wireless: wext: avoid gcc -O3 warning
Date:   Mon,  3 Feb 2020 16:19:29 +0000
Message-Id: <20200203161909.602727646@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.714326084@linuxfoundation.org>
References: <20200203161902.714326084@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit e16119655c9e6c4aa5767cd971baa9c491f41b13 ]

After the introduction of CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3,
the wext code produces a bogus warning:

In function 'iw_handler_get_iwstats',
    inlined from 'ioctl_standard_call' at net/wireless/wext-core.c:1015:9,
    inlined from 'wireless_process_ioctl' at net/wireless/wext-core.c:935:10,
    inlined from 'wext_ioctl_dispatch.part.8' at net/wireless/wext-core.c:986:8,
    inlined from 'wext_handle_ioctl':
net/wireless/wext-core.c:671:3: error: argument 1 null where non-null expected [-Werror=nonnull]
   memcpy(extra, stats, sizeof(struct iw_statistics));
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from arch/x86/include/asm/string.h:5,
net/wireless/wext-core.c: In function 'wext_handle_ioctl':
arch/x86/include/asm/string_64.h:14:14: note: in a call to function 'memcpy' declared here

The problem is that ioctl_standard_call() sometimes calls the handler
with a NULL argument that would cause a problem for iw_handler_get_iwstats.
However, iw_handler_get_iwstats never actually gets called that way.

Marking that function as noinline avoids the warning and leads
to slightly smaller object code as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20200107200741.3588770-1-arnd@arndb.de
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/wext-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index b50ee5d622e14..843d2cf1e6a6c 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -656,7 +656,8 @@ struct iw_statistics *get_wireless_stats(struct net_device *dev)
 	return NULL;
 }
 
-static int iw_handler_get_iwstats(struct net_device *		dev,
+/* noinline to avoid a bogus warning with -O3 */
+static noinline int iw_handler_get_iwstats(struct net_device *	dev,
 				  struct iw_request_info *	info,
 				  union iwreq_data *		wrqu,
 				  char *			extra)
-- 
2.20.1



