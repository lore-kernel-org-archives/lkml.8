Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D70CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F5E2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580219957;
	bh=irdt0xLdWjAFLPL8/CXs3avNPS/yE86ffPVP2l74FhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dsXzdsEt3PGYqVZ6sYvdBAqA1YaikFQq9uovHWr++V/z/B6Gau2MNEZWCZOhxsPYp
	 GAPNYAFFCu5MUWZIvqhKUKH8WuB+0ICupUlPs4gFibcn+YTAnqFO/vaQNa1RkkOC/b
	 mszq13JFe+Duoy82GDo/MwtLfxNrBeAjEozEDm8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgA1N7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:59:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbgA1N7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:59:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EA8624691;
        Tue, 28 Jan 2020 13:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580219950;
        bh=irdt0xLdWjAFLPL8/CXs3avNPS/yE86ffPVP2l74FhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z3ngUtuYXhljMH+B4vWsB5zi9t+cPsc02f9YCsC3Wcko9Ff82BU8HDhfSyCXsZDHE
         nkWhfG6S+q5gSU1Rp/Dn3s83qQ8flylEoJRHqG2tb6/mcjF6JpcmBqobH0f+/c62HW
         Rr5u5riEeKL6cgjNZp6RcFGQqBF8WNBkqwlvvnVk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 4.14 26/46] Documentation: Document arm64 kpti control
Date:   Tue, 28 Jan 2020 14:58:00 +0100
Message-Id: <20200128135753.205297926@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135749.822297911@linuxfoundation.org>
References: <20200128135749.822297911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Linton <jeremy.linton@arm.com>

commit de19055564c8f8f9d366f8db3395836da0b2176c upstream.

For a while Arm64 has been capable of force enabling
or disabling the kpti mitigations. Lets make sure the
documentation reflects that.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/admin-guide/kernel-parameters.txt |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1845,6 +1845,12 @@
 			Built with CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y,
 			the default is off.
 
+	kpti=		[ARM64] Control page table isolation of user
+			and kernel address spaces.
+			Default: enabled on cores which need mitigation.
+			0: force disabled
+			1: force enabled
+
 	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
 			Default is 0 (don't ignore, but inject #GP)
 


