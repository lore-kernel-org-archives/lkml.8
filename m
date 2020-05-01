Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786B7C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48AA8216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339995;
	bh=EjXI4xnL4Cjprb4Aa93w3O2TXHlJhQK22RWF6FH/Ry8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JdDxCV6gtmZ2nsaN/tUEcVoiRcY0nPrm5BZfPRSH/IA5C7DpE0SFlz5kRZ1+7o/+Z
	 C1Fwcw0EDLgmF2KLLjtQdB6Hl+ERIPIWJO/p0gIA3aQ55aIgkgYd6Eyhvrj0tMSNCy
	 DHAqueUpP2Xui5L3HZupxFs0W/iHjXCpbp90SH8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgEANdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730382AbgEANdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:33:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B853D208DB;
        Fri,  1 May 2020 13:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339987;
        bh=EjXI4xnL4Cjprb4Aa93w3O2TXHlJhQK22RWF6FH/Ry8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0IhigDqYbor3N+6W6zhQWHF/aI2A/uxO2t43EWOCEE14VL+/v3qN9OiVVgF5AYTLc
         mdRsJD3kUxcMm7gbc3KamDUWgB3rAZ0afnC/hFAnFXN5er8kBMnVQkSi292SFgzqqA
         7JfcWAB7XZK8cQF2BP5Ke6Nz2yG6CLlB53aRKIKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.14 048/117] overflow.h: Add arithmetic shift helper
Date:   Fri,  1 May 2020 15:21:24 +0200
Message-Id: <20200501131550.485127642@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

commit 0c66847793d1982d1083dc6f7adad60fa265ce9c upstream.

Add shift_overflow() helper to assist driver authors in ensuring that
shift operations don't cause overflows or other odd conditions.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
[kees: tweaked comments and commit log, dropped unneeded assignment]
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/overflow.h |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -202,4 +202,35 @@
 
 #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
 
+/** check_shl_overflow() - Calculate a left-shifted value and check overflow
+ *
+ * @a: Value to be shifted
+ * @s: How many bits left to shift
+ * @d: Pointer to where to store the result
+ *
+ * Computes *@d = (@a << @s)
+ *
+ * Returns true if '*d' cannot hold the result or when 'a << s' doesn't
+ * make sense. Example conditions:
+ * - 'a << s' causes bits to be lost when stored in *d.
+ * - 's' is garbage (e.g. negative) or so large that the result of
+ *   'a << s' is guaranteed to be 0.
+ * - 'a' is negative.
+ * - 'a << s' sets the sign bit, if any, in '*d'.
+ *
+ * '*d' will hold the results of the attempted shift, but is not
+ * considered "safe for use" if false is returned.
+ */
+#define check_shl_overflow(a, s, d) ({					\
+	typeof(a) _a = a;						\
+	typeof(s) _s = s;						\
+	typeof(d) _d = d;						\
+	u64 _a_full = _a;						\
+	unsigned int _to_shift =					\
+		_s >= 0 && _s < 8 * sizeof(*d) ? _s : 0;		\
+	*_d = (_a_full << _to_shift);					\
+	(_to_shift != _s || *_d < 0 || _a < 0 ||			\
+		(*_d >> _to_shift) != _a);				\
+})
+
 #endif /* __LINUX_OVERFLOW_H */


