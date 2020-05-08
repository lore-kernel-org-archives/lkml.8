Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9706C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AD724973
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941788;
	bh=SRf+a/x2mhrkqpjLlCdHr3nnCS44RaW/UzT8W01MYRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vSw4w40Iq8Xn8GEuSbhuPjC9o+DtubxMcTPXu6s+oUc48lbf2zWsRGXwQHbeDkSeM
	 33jZOs/5/01AeRidkMm0JjzUzVbQCZzgZmS+9DV1NqLfKfFX/GYBECC7R1EWxOkhqz
	 jg6nUMIT5OS2MlOHxKptnMH3W1SuTtaXtUyXhM2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgEHMnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgEHMnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:43:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D4624968;
        Fri,  8 May 2020 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941781;
        bh=SRf+a/x2mhrkqpjLlCdHr3nnCS44RaW/UzT8W01MYRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFCb9n2p6d/y31bWDYTlVom7hJN2miTZt+WC3uZQ7wW4R0jdD9ji3mW6q0kuHWMzP
         tezzwmfAOc3NgI5N6ND493tcj2vLqg76BL47HLXulOjUVTjRFJINrS+ux1f0SfFNSh
         bLwZqAeACGEa6xlqalxcCoFwgLotWnOd6sDRjd5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: [PATCH 4.4 169/312] [media] rc: allow rc modules to be loaded if rc-main is not a module
Date:   Fri,  8 May 2020 14:32:40 +0200
Message-Id: <20200508123136.366163122@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

commit 2ff56fadd94cdaeeaeccbc0a9b703a0101ada128 upstream.

rc-main mistakenly uses #ifdef MODULE to determine whether it should
load the rc keymap modules.  This symbol is only defined if rc-main
is being built as a module itself, and bears no relation to whether
the rc keymaps are modules.

Fix this to use CONFIG_MODULES instead.

Fixes: 631493ecacd8 ("[media] rc-core: merge rc-map.c into rc-main.c")

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/rc/rc-main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -61,7 +61,7 @@ struct rc_map *rc_map_get(const char *na
 	struct rc_map_list *map;
 
 	map = seek_rc_map(name);
-#ifdef MODULE
+#ifdef CONFIG_MODULES
 	if (!map) {
 		int rc = request_module("%s", name);
 		if (rc < 0) {


