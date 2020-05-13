Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89558CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 609C9206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363505;
	bh=lbc0ZkuPyvr62w63DEgAjqvxm+QSLWvjl3b/t0QNdjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ej5wT2G777oxz1SjVmZzomqm0UCu6vereUhluBJAz+hbbIroh/+2l8sWToc5jZnDp
	 Xu7YmZHF6VFj7YelCt4DMPl0E+Qc2A/v/SxHaHvXdvREZpoFIgRd6uicdIYBFWB3YZ
	 Z2Vnh1oVLfIx/JFiyVDHAZyZGpjfXqSnp41V4MkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387694AbgEMJvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387682AbgEMJvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:51:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8927B206D6;
        Wed, 13 May 2020 09:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363499;
        bh=lbc0ZkuPyvr62w63DEgAjqvxm+QSLWvjl3b/t0QNdjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PqmB9nB8Aa5us0IZXAXVjSvB4lls5JKhUjh5qPqIFsa+TXw5qm3M+sYCCNTUCi91w
         gVnF6qgzg1xR6t8pDMlwHhZMaAI1YLYsFXNTMXY6TdKalHjNED7rpqsakxLrnrnexD
         r9FilP+jnZ0dLvUvrmH8DtOFTQCuL8e7ST0XNgTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <yehezkelshb@gmail.com>
Subject: [PATCH 5.6 001/118] thunderbolt: Check return value of tb_sw_read() in usb4_switch_op()
Date:   Wed, 13 May 2020 11:43:40 +0200
Message-Id: <20200513094417.748040775@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit c3bf9930921b33edb31909006607e478751a6f5e upstream.

The function misses checking return value of tb_sw_read() before it
accesses the value that was read. Fix this by checking the return value
first.

Fixes: b04079837b20 ("thunderbolt: Add initial support for USB4")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Yehezkel Bernat <yehezkelshb@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thunderbolt/usb4.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -182,6 +182,9 @@ static int usb4_switch_op(struct tb_swit
 		return ret;
 
 	ret = tb_sw_read(sw, &val, TB_CFG_SWITCH, ROUTER_CS_26, 1);
+	if (ret)
+		return ret;
+
 	if (val & ROUTER_CS_26_ONS)
 		return -EOPNOTSUPP;
 


