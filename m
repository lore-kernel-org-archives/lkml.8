Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965B2C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7378620705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgAaNFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:05:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:9750 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbgAaNFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:05:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2020 05:05:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,385,1574150400"; 
   d="scan'208";a="262540186"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 31 Jan 2020 05:05:16 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ixVz1-0001uT-On; Fri, 31 Jan 2020 21:05:15 +0800
Date:   Fri, 31 Jan 2020 21:04:21 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] fs_param_bad_value() can be static
Message-ID: <20200131130421.26qcmfvgaspqdqjr@f53c9c00458a>
References: <202001312114.IkYUPqKR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202001312114.IkYUPqKR%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 2552e0ea2d71 ("turn fs_param_is_... into functions")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 fs_parser.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 834e0902fe7d3..5e059592d4b6c 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -188,7 +188,7 @@ int fs_lookup_param(struct fs_context *fc,
 }
 EXPORT_SYMBOL(fs_lookup_param);
 
-int fs_param_bad_value(struct p_log *log, struct fs_parameter *param)
+static int fs_param_bad_value(struct p_log *log, struct fs_parameter *param)
 {
 	return inval_plog(log, "Bad value for '%s'", param->key);
 }
