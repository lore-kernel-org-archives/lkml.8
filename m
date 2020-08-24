Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85776C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595D022B43
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258309;
	bh=yQgp9Zxd61FTfd4hVpii1TzZB/t8HvRNO323rkfP/cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lBOoFL+HxTw6lknQpIHkQI5cKmstYMN4niKegUOEKhjDAVCn/CGhSiXgc6spM02x6
	 KkGjo/C7jLviszZLT9WFB8u0Q9cLos47RDq8HfdsdrkFXVLPLdV1UAN9bsULoC3WRr
	 WmjlYcZBEwlVwg9lxqoEpOwKtZZyfarh8V4onDts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgHXIi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgHXIiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:38:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5460F22B43;
        Mon, 24 Aug 2020 08:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258295;
        bh=yQgp9Zxd61FTfd4hVpii1TzZB/t8HvRNO323rkfP/cM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ybYZMybvHxFJf6vTB+bCMnm+PrOK3JlxsA3ntpDS+xCsM6UhSCopQGEpQThlWfA6l
         KE2Y95syE7M4N8uFYYT5iV+bn4JTch6DZ2uU6Z0+r4iXMJUjnWfLdErLBnx2rucBku
         IoXRSHfk+LfkZ0+MRX3i/QcvgjJk4LMEQxQNFBzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 5.8 145/148] efi/libstub: Stop parsing arguments at "--"
Date:   Mon, 24 Aug 2020 10:30:43 +0200
Message-Id: <20200824082420.969937630@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

commit 1fd9717d75df68e3c3509b8e7b1138ca63472f88 upstream.

Arguments after "--" are arguments for init, not for the kernel.

Cc: <stable@vger.kernel.org>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200725155916.1376773-1-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/efi/libstub/efi-stub-helper.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -201,6 +201,8 @@ efi_status_t efi_parse_options(char cons
 		char *param, *val;
 
 		str = next_arg(str, &param, &val);
+		if (!val && !strcmp(param, "--"))
+			break;
 
 		if (!strcmp(param, "nokaslr")) {
 			efi_nokaslr = true;


