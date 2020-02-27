Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DB5C7659B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A771224688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813769;
	bh=XpnBttSLc8xUIzI/h+JjzrXocDxEK+hidNJfISLZMg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jhgf1LIdro89fapeZVkxmPzCOtXgJyoINQLlUMbf9uYrQLfZmSPw+Bb6HgaQrxL/T
	 A4BnvVLsdSy12wMO+tQVG7bDZiBmZH32MWadoRcvl+CweavAMbK3jLk/HMr0zodlRc
	 KJJ8zPDz9g9zs7MGK+ZMzqmU9cRwea1JLeT5kh+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbgB0OGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:06:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387514AbgB0OGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:06:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FBBB20578;
        Thu, 27 Feb 2020 14:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812373;
        bh=XpnBttSLc8xUIzI/h+JjzrXocDxEK+hidNJfISLZMg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K99QoxRyG8EzMDfJQGnrQTNYExx7/p/EK4vXSaOPcPUkW9dq+LG0DiWhs5ZsMwq7I
         aqw/fWf79h5v9QMmtHuhmEvWJDlW7ni3y+V6WKyrUpZS/i7ld/NIHUbOLaM9Ugv/eq
         hHxvODMblpf6vDFJxvay9lQT8ydyrEJJ8X4lJDYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Krude <johannes@krude.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.19 89/97] bpf, offload: Replace bitwise AND by logical AND in bpf_prog_offload_info_fill
Date:   Thu, 27 Feb 2020 14:37:37 +0100
Message-Id: <20200227132229.139895694@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132214.553656188@linuxfoundation.org>
References: <20200227132214.553656188@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Krude <johannes@krude.de>

commit e20d3a055a457a10a4c748ce5b7c2ed3173a1324 upstream.

This if guards whether user-space wants a copy of the offload-jited
bytecode and whether this bytecode exists. By erroneously doing a bitwise
AND instead of a logical AND on user- and kernel-space buffer-size can lead
to no data being copied to user-space especially when user-space size is a
power of two and bigger then the kernel-space buffer.

Fixes: fcfb126defda ("bpf: add new jited info fields in bpf_dev_offload and bpf_prog_info")
Signed-off-by: Johannes Krude <johannes@krude.de>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/bpf/20200212193227.GA3769@phlox.h.transitiv.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/offload.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -289,7 +289,7 @@ int bpf_prog_offload_info_fill(struct bp
 
 	ulen = info->jited_prog_len;
 	info->jited_prog_len = aux->offload->jited_len;
-	if (info->jited_prog_len & ulen) {
+	if (info->jited_prog_len && ulen) {
 		uinsns = u64_to_user_ptr(info->jited_prog_insns);
 		ulen = min_t(u32, info->jited_prog_len, ulen);
 		if (copy_to_user(uinsns, aux->offload->jited_image, ulen)) {


