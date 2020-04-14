Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E1FC38A29
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33232075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hulmzico"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391008AbgDNOhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390985AbgDNOhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:37:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78EDC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:37:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d27so5398497wra.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sy3FLH1QOIbbQGSDq/U1c7G9pk2vMUBH3y2QGrYXYXk=;
        b=HulmzicoOJSYq0+UgPj+2NrR0l+4s2ydo6qcGPJQTqvZg7G2plki/AyiTvqPmC3JJ2
         jOx6t8i6Byn8s/n+shsmyfgqcwFBFJqidTzfug1/QHu2ZSOcaZuPFkNoHMwXG6qRTvm3
         EeC04zkdgZMs/eBulOfGIOAaPsh9xmF+FOyzUlh0jdIczzuLWG3IZm/loLEjDO1+D9jv
         T5dWqYr8kp/piQmJX22XM6EhxKIN2IckIHMcMbmDj5OooL5a2IowyboVv5nTwX4Em6UR
         uvaaDWp2ZFbrugTNpn4eUHXZzA7OMCYmAdelZR6ZlnNJJsIcmxugBkZHrvZxERWJ0yvR
         e9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sy3FLH1QOIbbQGSDq/U1c7G9pk2vMUBH3y2QGrYXYXk=;
        b=SQRs/6jvgVLUcGZV3YS38nXpmwEC5Ey+QdIfJwK3KloJxKKjwHDcIJ7pl9tydY6irS
         9rYHheTKCROUl/2YaV3lfncDnVQSUrILftiuj6WQbBE6iFDev3j9lOBweM1IUVBXaj6W
         R4Sk+qwryVzj2yYN0S73IkfsMwEa9rxdGRcMgllZoZPMUXdIprwJDEKkiR8rSc1o4lL+
         9/o/KXuxgTE1nHzDZUJZ6eQrydUVb6IGdcH7ooW1iYlSiE8z+by//SkV7jL9+S6Qek0k
         Qq9zAovK75aMjP3o+FAKJ/lJHyMHY63BXmc/2l70GgzHV7+AxeQqmB7oPtfcNVv3dVht
         9lRg==
X-Gm-Message-State: AGi0PuYVSovznodR2e3aCUAFC5/16LcMra5OxcX7i7o0os65MljuAqP/
        I7tpUAVLKy5dMRK+nh4URK7I0g==
X-Google-Smtp-Source: APiQypKjkhw2ih9tm4pmUBKh5zgTPT/tJqaIwwTcrxbve7v1TDlDdDcVWDSXqWCfL3dg0mirmW3gGQ==
X-Received: by 2002:a5d:4fcf:: with SMTP id h15mr23736578wrw.262.1586875065551;
        Tue, 14 Apr 2020 07:37:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
        by smtp.gmail.com with ESMTPSA id h16sm21142433wrw.36.2020.04.14.07.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 07:37:45 -0700 (PDT)
From:   Peter Maydell <peter.maydell@linaro.org>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] scripts/kernel-doc: Add missing close-paren in c:function directives
Date:   Tue, 14 Apr 2020 15:37:43 +0100
Message-Id: <20200414143743.32677-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel-doc generates a 'c:function' directive for a function
one of whose arguments is a function pointer, it fails to print
the close-paren after the argument list of the function pointer
argument. For instance:

 long work_on_cpu(int cpu, long (*fn) (void *, void * arg)

in driver-api/basics.html is missing a ')' separating the
"void *" of the 'fn' arguments from the ", void * arg" which
is an argument to work_on_cpu().

Add the missing close-paren, so that we render the prototype
correctly:

 long work_on_cpu(int cpu, long (*fn)(void *), void * arg)

(Note that Sphinx stops rendering a space between the '(fn*)' and the
'(void *)' once it gets something that's syntactically valid.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I noticed this first in the copy of kernel-doc that QEMU is using for
its Sphinx documentation.  Older versions of Sphinx don't try to
parse the argument to c:function, so the only effect is incorrect
output, but Sphinx 3.0 does do this and will complain:
  Invalid C declaration: Expecting "," or ")" in parameters, got "EOF".

It looks like the kernel docs currently won't build at all
with Sphinx 3.0; https://github.com/sphinx-doc/sphinx/issues/7421
so I don't have an example of the error for the kernel docs.

QEMU is currently carrying another patch to our kernel-doc:
 https://patchew.org/QEMU/20200411182934.28678-1-peter.maydell@linaro.org/20200411182934.28678-4-peter.maydell@linaro.org/
which makes it use the new-in-3.0 "c:struct::" directive now
that "c:type::" no longer accepts "struct foo". Does anybody
have a plan for how the kernel kernel-doc is going to deal with
that non-back-compatible Sphinx change?
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index f2d73f04e71d..f746ca8fa403 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -853,7 +853,7 @@ sub output_function_rst(%) {
 
 	if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
 	    # pointer-to-function
-	    print $1 . $parameter . ") (" . $2;
+	    print $1 . $parameter . ") (" . $2 . ")";
 	} else {
 	    print $type . " " . $parameter;
 	}
-- 
2.20.1

