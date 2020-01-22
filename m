Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244BDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B6B2467E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699149;
	bh=eGTOKWP2cniC/6Pqoc89aEbuIcifSHcRzi2ZdvM2NrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Awzo4vjWqaAu6lefJH38Ww+RkNcyN9Vs81o14bJzSQtHw2qmBOnFEGYR30Cpr0F4l
	 3DJIoTv51MZ3RBsSGTRDi9Mvgqg0O3A79OZxP6bYwtgmK7+kk2JtHmlvPir3f3w0G/
	 0z+ca4fTQRaGA4DpfTFZ4cZBd6wUlQayrzVcqXII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgAVNTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:19:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729534AbgAVNTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:19:02 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC335205F4;
        Wed, 22 Jan 2020 13:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699142;
        bh=eGTOKWP2cniC/6Pqoc89aEbuIcifSHcRzi2ZdvM2NrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9BJTv+7xrgVij1llbfBAHiLK4gAbKnsaIt40W2UWbDAjGdeWnRnVBKgzS5GR8O42
         gNHLsBeBqq+pJAZJE3n+ulkzw4oAZ8xlWjOBjb+aK4E2htZJdd/VQp8wJhg9BZJvGL
         M/ZAmSILxaTQNxydyUBjHzD8klz9aSpTJoPUQdRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Spencer E. Olson" <olsonse@umich.edu>,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 5.4 053/222] staging: comedi: ni_routes: fix null dereference in ni_find_route_source()
Date:   Wed, 22 Jan 2020 10:27:19 +0100
Message-Id: <20200122092837.416673594@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Abbott <abbotti@mev.co.uk>

commit 01e20b664f808a4f3048ca3f930911fd257209bd upstream.

In `ni_find_route_source()`, `tables->route_values` gets dereferenced.
However it is possible that `tables->route_values` is `NULL`, leading to
a null pointer dereference.  `tables->route_values` will be `NULL` if
the call to `ni_assign_device_routes()` during board initialization
returned an error due to missing device family routing information or
missing board-specific routing information.  For example, there is
currently no board-specific routing information provided for the
PCIe-6251 board and several other boards, so those are affected by this
bug.

The bug is triggered when `ni_find_route_source()` is called via
`ni_check_trigger_arg()` or `ni_check_trigger_arg_roffs()` when checking
the arguments for setting up asynchronous commands.  Fix it by returning
`-EINVAL` if `tables->route_values` is `NULL`.

Even with this fix, setting up asynchronous commands to use external
trigger sources for boards with missing routing information will still
fail gracefully.  Since `ni_find_route_source()` only depends on the
device family routing information, it would be better if that was made
available even if the board-specific routing information is missing.
That will be addressed by another patch.

Fixes: 4bb90c87abbe ("staging: comedi: add interface to ni routing table information")
Cc: <stable@vger.kernel.org> # 4.20+
Cc: Spencer E. Olson <olsonse@umich.edu>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20200114182532.132058-2-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers/ni_routes.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/staging/comedi/drivers/ni_routes.c
+++ b/drivers/staging/comedi/drivers/ni_routes.c
@@ -489,6 +489,9 @@ int ni_find_route_source(const u8 src_se
 {
 	int src;
 
+	if (!tables->route_values)
+		return -EINVAL;
+
 	dest = B(dest); /* subtract NI names offset */
 	/* ensure we are not going to under/over run the route value table */
 	if (dest < 0 || dest >= NI_NUM_NAMES)


