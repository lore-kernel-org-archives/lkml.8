Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071EBC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0D420715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341462;
	bh=W/2CqJ/CeruJ+aclgCpudKPpjiVPCXPV04Yi/+GRmLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=frS/qDEMoRK/kjsuwZsHzjfmaHaD6opHerkiVVblQd47YMhXTRpNOqxv3cEH+Q91M
	 GusAsSpfAVsmfXcwYhTLKD14Gki0wAn8eEm0+GJqlYWQPeB8hCnfY6mP8Wp5C/JgEj
	 XF7CjzrwxKfRUV1rYKN8DDGtTIlxEnufpadNX9KE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbgBJNbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:31:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:54742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbgBJMgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:06 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 633D320842;
        Mon, 10 Feb 2020 12:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338165;
        bh=W/2CqJ/CeruJ+aclgCpudKPpjiVPCXPV04Yi/+GRmLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sOY7bVSYXazwApIHBLBNy6WlsRpyMC0olqRgrWE4O0T3sNKzSUbF/9p1dXgARuzVe
         xifzM2dzFtjRYWyRsTZC+sq+lr7PwvoaQUDCqsqH9+zoII0mTOooEgTko42Kzn2JM9
         ND9Y4w0WKZ42rBU9be62WxdXs8nyw0CPiqHcIzSM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erdem Aktas <erdemaktas@google.com>,
        David Rientjes <rientjes@google.com>,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 4.19 144/195] percpu: Separate decrypted varaibles anytime encryption can be enabled
Date:   Mon, 10 Feb 2020 04:33:22 -0800
Message-Id: <20200210122319.360630770@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
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
@@ -176,8 +176,7 @@
  * Declaration/definition used for per-CPU variables that should be accessed
  * as decrypted when memory encryption is enabled in the guest.
  */
-#if defined(CONFIG_VIRTUALIZATION) && defined(CONFIG_AMD_MEM_ENCRYPT)
-
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 #define DECLARE_PER_CPU_DECRYPTED(type, name)				\
 	DECLARE_PER_CPU_SECTION(type, name, "..decrypted")
 


