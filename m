Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56899C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D1D20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339430;
	bh=xPjFRomVxdpO+HM2q+A9172l/tUjWzy5wahhYlj59YE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TLfqXeefq6n+tQZdEHHKDpPnCsBZojtVKhtqZAYHGLNobNG3+8fe0Gjgsa+VHpXof
	 fKO7HEmb6M+VwvXt+MIKCx9tJNqjuQZoSLci5x22swlkvm6jHX/xv+GyPxA+mDjVgg
	 NjCrVZBQm7UygiK3fJrGhkGawJyLsv714ldU6gY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgBJM5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:57:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730012AbgBJMlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:32 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62E7C20842;
        Mon, 10 Feb 2020 12:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338492;
        bh=xPjFRomVxdpO+HM2q+A9172l/tUjWzy5wahhYlj59YE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TV6sK0IfZoiiW+f8p37JI9FkIaHhqCqMghBqkti2ctElJ6XqklJrLziWsPAb7ScxL
         EnzUSBH65HdT69UWImvvGubpXIfTfCkg/UEAn4Npqfmw9HDtgw3nxgsnzHQf11UWA+
         VNfv1dBzIbw5sIgJzUQDJGG/YRFfZtuiXFhyvC6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erdem Aktas <erdemaktas@google.com>,
        David Rientjes <rientjes@google.com>,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 5.5 278/367] percpu: Separate decrypted varaibles anytime encryption can be enabled
Date:   Mon, 10 Feb 2020 04:33:11 -0800
Message-Id: <20200210122449.770564832@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erdem Aktas <erdemaktas@google.com>

commit 264b0d2bee148073c117e7bbbde5be7125a53be1 upstream.

CONFIG_VIRTUALIZATION may not be enabled for memory encrypted guests.  If
disabled, decrypted per-CPU variables may end up sharing the same page
with variables that should be left encrypted.

Always separate per-CPU variables that should be decrypted into their own
page anytime memory encryption can be enabled in the guest rather than
rely on any other config option that may not be enabled.

Fixes: ac26963a1175 ("percpu: Introduce DEFINE_PER_CPU_DECRYPTED")
Cc: stable@vger.kernel.org # 4.15+
Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: David Rientjes <rientjes@google.com>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/percpu-defs.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -175,8 +175,7 @@
  * Declaration/definition used for per-CPU variables that should be accessed
  * as decrypted when memory encryption is enabled in the guest.
  */
-#if defined(CONFIG_VIRTUALIZATION) && defined(CONFIG_AMD_MEM_ENCRYPT)
-
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 #define DECLARE_PER_CPU_DECRYPTED(type, name)				\
 	DECLARE_PER_CPU_SECTION(type, name, "..decrypted")
 


