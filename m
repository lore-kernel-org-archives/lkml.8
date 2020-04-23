Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A0DC55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8082074F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZXnMBwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgDWMkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726117AbgDWMki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:40:38 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5837C08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:40:38 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g6so2815946pgs.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ORFx8U+R2M4J1V+Plu/JCbrkyV0/FqLvdrcYNeSHey8=;
        b=WZXnMBwOzD3C14ABZN9rmbdQK1R45hWzi2kzqYVsThBa16OYat+01AzsxAMFy4w8Nh
         3bLT8WSCJa7CvJVUVcGxUimjK0lj94ClkUtHgzck3ZlbJJg4lZwn1N1W+BflsL+1tWMe
         X9ve0B7xko2Cn9QmPbGIksmVk9NVZIjOy/kp2w+MZ+ooY16OXZ5xP5p0RK7euNKXRzhi
         S1stup8fc9Ab8bdPevYa4aPvvHz+j2H6Qw+QWsLPXeWN87y7f6Uf5v2rlexde1OFHx0+
         1xeBUWAj37EOGevEevSB6cyPp50Trt4f1Elk/zrDMFGwpWVkDOLur0HqrVpxosR7/kAd
         n6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ORFx8U+R2M4J1V+Plu/JCbrkyV0/FqLvdrcYNeSHey8=;
        b=JI15wVpkCZdYLOYHtz4JyVBSpbFlLmQUMsif2MBvavnhAurnjB6KzZTn2EvL9O9jDY
         btiIvJzg5cinPWhFZSOmnA/oU8VWTSRqOcf0o9nnNoU6sizfwtRJwyh+LscIF/7a5c0N
         EEpGuMSryVuybLkJfn/4+nLlAux1DFBAWqm8rB0It11V59s7ord3YwS3S+2/Bf52kVS5
         s5H8M048FMb7DS288s6rrJLV6wbfDzwwklph44jNtQK1R595jtYr6t5lOA9IGfpRpTDh
         18If/EazzVjJWzcBCICHW009wFSyT5zeU668q5FlBqvahvxX8d3946XfnUAKR9QUctbk
         ASZA==
X-Gm-Message-State: AGi0PuYCWmmPso+foK4W6JH0q7jPm88V03r0730R6uF6uu4wc0Mm5BnV
        Kzp27SPEmYSwnZ2oemJCeZY=
X-Google-Smtp-Source: APiQypISOiEZlAPduEsqfLInQeG385FqZv7uwQ7s2XB+2C0u8e4laylAg+Dbi5GZyaO6NQHuyWew8A==
X-Received: by 2002:a63:5009:: with SMTP id e9mr3612134pgb.381.1587645638286;
        Thu, 23 Apr 2020 05:40:38 -0700 (PDT)
Received: from localhost.localdomain ([122.181.63.84])
        by smtp.gmail.com with ESMTPSA id u8sm2248237pjy.16.2020.04.23.05.40.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 05:40:37 -0700 (PDT)
From:   Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc:     Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] x86: add kstrtoul() converter func to boot code
Date:   Thu, 23 Apr 2020 18:09:47 +0530
Message-Id: <1587645588-7130-2-git-send-email-vamshi.k.sthambamkadi@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587645588-7130-1-git-send-email-vamshi.k.sthambamkadi@gmail.com>
References: <1587645588-7130-1-git-send-email-vamshi.k.sthambamkadi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add str to unsigned long converter function to boot code.

Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
---
 arch/x86/boot/string.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 arch/x86/boot/string.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 8272a44..e06ebe1 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -335,3 +335,46 @@ int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
 		s++;
 	return _kstrtoull(s, base, res);
 }
+
+/* Internal, do not use. */
+int _kstrtoul(const char *s, unsigned int base, unsigned long *res)
+{
+	unsigned long long tmp;
+	int rv;
+
+	rv = kstrtoull(s, base, &tmp);
+	if (rv < 0)
+		return rv;
+	if (tmp != (unsigned long)tmp)
+		return -ERANGE;
+	*res = tmp;
+	return 0;
+}
+
+/**
+ * kstrtoul - convert a string to an unsigned long
+ * @s: The start of the string. The string must be null-terminated, and may also
+ *  include a single newline before its terminating null. The first character
+ *  may also be a plus sign, but not a minus sign.
+ * @base: The number base to use. The maximum supported base is 16. If base is
+ *  given as 0, then the base of the string is automatically detected with the
+ *  conventional semantics - If it begins with 0x the number will be parsed as a
+ *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
+ *  parsed as an octal number. Otherwise it will be parsed as a decimal.
+ * @res: Where to write the result of the conversion on success.
+ *
+ * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
+ * Used as a replacement for the simple_strtoull.
+ */
+int kstrtoul(const char *s, unsigned int base, unsigned long *res)
+{
+	/*
+	 * We want to shortcut function call, but
+	 * __builtin_types_compatible_p(unsigned long, unsigned long long) = 0.
+	 */
+	if (sizeof(unsigned long) == sizeof(unsigned long long) &&
+	    __alignof__(unsigned long) == __alignof__(unsigned long long))
+		return kstrtoull(s, base, (unsigned long long *)res);
+	else
+		return _kstrtoul(s, base, res);
+}
diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
index 38d8f2f..e8dd239 100644
--- a/arch/x86/boot/string.h
+++ b/arch/x86/boot/string.h
@@ -30,4 +30,5 @@ extern unsigned long long simple_strtoull(const char *cp, char **endp,
 					  unsigned int base);
 
 int kstrtoull(const char *s, unsigned int base, unsigned long long *res);
+int kstrtoul(const char *s, unsigned int base, unsigned long *res);
 #endif /* BOOT_STRING_H */
-- 
2.7.4

