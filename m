Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC05C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C072206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943955;
	bh=9IyFQ1LxdVrwBZSwUEShij5X2ILrV9XEJsqS8gNrNjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FhHfmg/cqbNkP43XAxumwCjHJ6wFQp8jzdtgsZ0z3Vtp3SyMyFCg/2s8F2jiD+MW/
	 Skk5fXc0T9aBUNZmAqXov/gVbtZXBc6PuYfT2b/dSGuy5QblS+HFwtc1cPHfuH5smk
	 oVx9aenmKWUYmATm3Rzd+bSZMx8MefRe7Uza9g08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389478AbgFWUZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390329AbgFWUZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:25:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFC8F206EB;
        Tue, 23 Jun 2020 20:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943945;
        bh=9IyFQ1LxdVrwBZSwUEShij5X2ILrV9XEJsqS8gNrNjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TXdQuyuDe1SFgvItjpqkDdvWM3fVkNSD/eR6PFyXsntrX7BO0OCX534kvTAfWXsLi
         OLgykoAPB+FLFnz+1JF8686YTJvJZReqaWZPpzMjywZpFj9kkPJJLv6obPhGWSNB5n
         ZcRDWxrby0c7/yk2rADB1dTGISufLl7EEbJ6jNyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 113/314] HID: intel-ish-hid: avoid bogus uninitialized-variable warning
Date:   Tue, 23 Jun 2020 21:55:08 +0200
Message-Id: <20200623195344.257639843@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 0b66fb3e6b7a53688f8e20945ac78cd3d832c65f ]

Older compilers like gcc-4.8 don't see that the variable is
initialized when it is used:

In file included from include/linux/compiler_types.h:68:0,
                 from <command-line>:0:
drivers/hid/intel-ish-hid/ishtp-fw-loader.c: In function 'load_fw_from_host':
include/linux/compiler-gcc.h:75:45: warning: 'fw_info.ldr_capability.max_dma_buf_size' may be used uninitialized in this function [-Wmaybe-uninitialized]
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                             ^
drivers/hid/intel-ish-hid/ishtp-fw-loader.c:770:22: note: 'fw_info.ldr_capability.max_dma_buf_size' was declared here
  struct shim_fw_info fw_info;
                      ^

Make sure to initialize it before returning an error from ish_query_loader_prop().

Fixes: 91b228107da3 ("HID: intel-ish-hid: ISH firmware loader client driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp-fw-loader.c b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
index aa2dbed30fc36..6cf59fd26ad78 100644
--- a/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
+++ b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
@@ -480,6 +480,7 @@ static int ish_query_loader_prop(struct ishtp_cl_data *client_data,
 			    sizeof(ldr_xfer_query_resp));
 	if (rv < 0) {
 		client_data->flag_retry = true;
+		*fw_info = (struct shim_fw_info){};
 		return rv;
 	}
 
@@ -489,6 +490,7 @@ static int ish_query_loader_prop(struct ishtp_cl_data *client_data,
 			"data size %d is not equal to size of loader_xfer_query_response %zu\n",
 			rv, sizeof(struct loader_xfer_query_response));
 		client_data->flag_retry = true;
+		*fw_info = (struct shim_fw_info){};
 		return -EMSGSIZE;
 	}
 
-- 
2.25.1



