Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6325FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9BF2073C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443080;
	bh=eYg53x1h58f7rl41capUo+qEjljpXzc3lYnFJUdcGOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xsiKpGSbhnof4ImP5SmxcMpE5q4ikuDt8SEMi3gmPoP5sj5QInFCAhy6qdikwvv8N
	 IlGqORIJyX5jTUUBaUpJJXMDvgnGYjrUBmWcTmkCoJKTEkUGGxSqXYd2TGN22OjZXE
	 vs0jNW/qNEgebMRmo9qLm8qzk+KpXnhM6Dnp+5lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgCQLEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbgCQLEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:04:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACC02206EC;
        Tue, 17 Mar 2020 11:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443075;
        bh=eYg53x1h58f7rl41capUo+qEjljpXzc3lYnFJUdcGOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ebG8g09Z0731Ca87VeVZ2awpXS0fCPMNFO3MnAG5rc/lPZycRyeIa5zk5nfk/r2sc
         zkRjbni0oQJBs0au2hTvrikoXJLWwE/1uCCJFl/nyaKIwj491XMxur+BH7OhZDkCL7
         e+J6gncVODkxG+Da9IZbirbGrJpnXXGyDFKw90XM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladis Dronov <vdronov@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5.4 088/123] efi: Add a sanity check to efivar_store_raw()
Date:   Tue, 17 Mar 2020 11:55:15 +0100
Message-Id: <20200317103316.759507923@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladis Dronov <vdronov@redhat.com>

commit d6c066fda90d578aacdf19771a027ed484a79825 upstream.

Add a sanity check to efivar_store_raw() the same way
efivar_{attr,size,data}_read() and efivar_show_raw() have it.

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200305084041.24053-3-vdronov@redhat.com
Link: https://lore.kernel.org/r/20200308080859.21568-25-ardb@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/efi/efivars.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -208,6 +208,9 @@ efivar_store_raw(struct efivar_entry *en
 	u8 *data;
 	int err;
 
+	if (!entry || !buf)
+		return -EINVAL;
+
 	if (in_compat_syscall()) {
 		struct compat_efi_variable *compat;
 


