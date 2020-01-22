Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1E3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B93A21835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI0Q8ynN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAVQjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:39:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56068 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVQjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:39:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so7493575wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 08:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vYv6iD1pZWL1+3b/sqFs+t3oIl63DwgZ1fMx7OzmI8k=;
        b=EI0Q8ynN00aMv8cpcGbqfUnTvFCOd16NoztgS/oTZTy6Ne8E6SUxVb4/7UI9lYmId9
         Cziv+fQHAwGZTTu0LF0TAbFDjnZxACh37XQF8Wi/UktzuUtZpK+x/uuFgUMhu+KPV8Sc
         MA/M5t1xZv/s5Ubc4Dvo7H8Wg4WXWS0S78roqRmWW+v7dfwOsFMSoJ4QjXm6fOVMwTqV
         DnbSzjn5kwPPUPmoaYnT+3NLKGP52NiPuJEg2liN+se7J4TFCplfNMrCKH93viwuIeNx
         PuxrGwURnqBQRRadotrqef6Ht4GTtwWK9cHCwsHzXVT2rcq9h2vywjtNpH1vaJfVdH+y
         ybTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vYv6iD1pZWL1+3b/sqFs+t3oIl63DwgZ1fMx7OzmI8k=;
        b=MDFWYLkJPvuTEFXAK4aWiVU4vWAIs6JZ2RQSoWIExXT41jo3FnsqWm2kRTZsG/itrV
         s2maxOlXC7GkDvvKX3LQT0i+KlGhBgjK6ZTYfngj9QkvsZR/FZxFuEgsAL7+c5OaZGQI
         cSXO/JFoH7eyShyqJhLBproNyVRF2Ql6vrCJiq/RkKNeVH5c+Za4zZS5Hi143kFrDc5K
         w7pKwJQnQMbMngA+QsQt2juG9TkQzvTMV6RYXh6d4HfXpqtSQyw4QhaUKFekS8VBzUh7
         68HyuP+dz7lZtl9G8J1JwGATX1KjomYHPRfAxA1jDB8mYRxfA2CF2eEnB7SaFcAmL2Gl
         igzw==
X-Gm-Message-State: APjAAAXgMG/bGYEnfNGCQOqxYvohsm29++zspjAHttk9r0XPV+H6eMX5
        t6vWSIn9zIMfr00TAZGgT0uFqyMSVrM=
X-Google-Smtp-Source: APXvYqxBCCNMu8Tlc2ehvKLFI2ujd6wvL2JqS7tKYI2Jzgfh81/L0JGl9ERzuwbjuZ3HNGYA9UP8cQ==
X-Received: by 2002:a7b:cd87:: with SMTP id y7mr3175120wmj.61.1579711192694;
        Wed, 22 Jan 2020 08:39:52 -0800 (PST)
Received: from localhost.localdomain (lneuilly-657-1-69-3.w80-11.abo.wanadoo.fr. [80.11.53.3])
        by smtp.gmail.com with ESMTPSA id j2sm4908557wmk.23.2020.01.22.08.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:39:51 -0800 (PST)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     Antonio Borneo <borneo.antonio@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3] checkpatch: fix multiple const * types
Date:   Wed, 22 Jan 2020 17:38:50 +0100
Message-Id: <20200122163852.124417-1-borneo.antonio@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20190508122721.7513-1-borneo.antonio@gmail.com>
References: <20190508122721.7513-1-borneo.antonio@gmail.com> <4517dfca6c4692b28c4914410f475d3f521cd230.camel@perches.com> <20190508174347.13901-1-borneo.antonio@gmail.com> <CAAj6DX1KvpYM+xc+dho8tkbMDxGBKAFaenqXYKaU5qYVVUvrzg@mail.gmail.com> <CAAj6DX0Gaym5ftcAdsAwTiaN9qvfJWxX0UN==VKzUT-4GPDtHg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1574a29f8e76 ("checkpatch: allow multiple const * types")
claims to support repetition of pattern "const *", but it actually
allows only one extra instance.
Check the following lines
	int a(char const * const x[]);
	int b(char const * const *x);
	int c(char const * const * const x[]);
	int d(char const * const * const *x);
with command
	./scripts/checkpatch.pl --show-types -f filename
to find that only the first line passes the test, while a warning
is triggered by the other 3 lines:
	WARNING:FUNCTION_ARGUMENTS: function definition argument
	'char const * const' should also have an identifier name
The reason is that the pattern match halts at the second asterisk
in the line, thus the remaining text starting with asterisk fails
to match a valid name for a variable.

Fixed by replacing "?" (Match 1 or 0 times) with "{0,4}" (Match
no more than 4 times) in the regular expression.
Fix also the similar test for types in unusual order.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
Fixes: 1574a29f8e76 ("checkpatch: allow multiple const * types")

---

V1->V2
	use a max match {0,4} instead of *, to limit the memory
	used by perl

V2->V3
	rebased

---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a63380c6b0d2..30da08d9646a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -804,12 +804,12 @@ sub build_types {
 		  }x;
 	$Type	= qr{
 			$NonptrType
-			(?:(?:\s|\*|\[\])+\s*const|(?:\s|\*\s*(?:const\s*)?|\[\])+|(?:\s*\[\s*\])+)?
+			(?:(?:\s|\*|\[\])+\s*const|(?:\s|\*\s*(?:const\s*)?|\[\])+|(?:\s*\[\s*\])+){0,4}
 			(?:\s+$Inline|\s+$Modifier)*
 		  }x;
 	$TypeMisordered	= qr{
 			$NonptrTypeMisordered
-			(?:(?:\s|\*|\[\])+\s*const|(?:\s|\*\s*(?:const\s*)?|\[\])+|(?:\s*\[\s*\])+)?
+			(?:(?:\s|\*|\[\])+\s*const|(?:\s|\*\s*(?:const\s*)?|\[\])+|(?:\s*\[\s*\])+){0,4}
 			(?:\s+$Inline|\s+$Modifier)*
 		  }x;
 	$Declare	= qr{(?:$Storage\s+(?:$Inline\s+)?)?$Type};
-- 
2.25.0

