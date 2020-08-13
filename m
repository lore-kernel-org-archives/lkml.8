Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0669C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 03:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9D22076C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 03:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EoGmj8wJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHMDIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 23:08:17 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:32324 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgHMDIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 23:08:16 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200813030812epoutp0322ed98a82d2d9d6d861ec39677897409~qtQ6WrcQb0726507265epoutp03J
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 03:08:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200813030812epoutp0322ed98a82d2d9d6d861ec39677897409~qtQ6WrcQb0726507265epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597288092;
        bh=CESfa1yDWoOQu7bTQ2QDKDIcx/TcB4vJLS+NeETuFco=;
        h=From:To:Cc:Subject:Date:References:From;
        b=EoGmj8wJDwNQOAv+Kda6ThWf+vTlRTqlUrwgLR20SYw/zVKJp3awqPQgZE6y+/UL9
         3mQT7LjE9PA+piOMvzsSgfnrloB2WOPcnl+QohyHL2RiRCDcS+dsijMTNB3kZdo6N0
         z0hr+nvbZs8iGZ41h8FGvsugZbVoH/Q2UftQmc2s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200813030811epcas1p1590fbc952ca00a030366769d6be6f523~qtQ55Vcmn0056800568epcas1p1O;
        Thu, 13 Aug 2020 03:08:11 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BRs2f2pd2zMqYkW; Thu, 13 Aug
        2020 03:08:10 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.32.28581.A9EA43F5; Thu, 13 Aug 2020 12:08:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200813030810epcas1p39ad56c069ab4fa41312f91f994c17cac~qtQ4a8-Ft2467324673epcas1p3e;
        Thu, 13 Aug 2020 03:08:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200813030810epsmtrp2e2c65c8fa9a934239dc2fd47de89af8e~qtQ4aMk1G0107701077epsmtrp2a;
        Thu, 13 Aug 2020 03:08:10 +0000 (GMT)
X-AuditID: b6c32a38-2e3ff70000006fa5-ad-5f34ae9a542f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.55.08303.99EA43F5; Thu, 13 Aug 2020 12:08:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.104.227]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200813030809epsmtip2da208a96f76ecab2483506e2dcc9ba6a~qtQ4OpXSq0426604266epsmtip2N;
        Thu, 13 Aug 2020 03:08:09 +0000 (GMT)
From:   Seungil Kang <sil.kang@samsung.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     bhe@redhat.com, mingo@kernel.org, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, herbert@gondor.apana.org.au,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Seungil Kang <sil.kang@samsung.com>
Subject: [PATCH v2] lib/cmdline: prevent unintented access to address
Date:   Thu, 13 Aug 2020 12:07:41 +0900
Message-Id: <20200813030741.6896-1-sil.kang@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmvu6sdSbxBtffC1vMWb+GzaK3aTqT
        xfkHv9gsmhevZ7PofiVjcXnXHDaL1f9OMVpc2P+OxWLzpqnMDpwe2w6oemxa1cnm8e7cOXaP
        EzN+s3jMOxnosX/uGnaP9/uusnn0bVnF6PF5k1wAZ1SOTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8
        c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QhUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OIS
        W6XUgpScAkODAr3ixNzi0rx0veT8XCtDAwMjU6DKhJyMjneLWApOS1U8aS5uYPzL38XIySEh
        YCIx881B5i5GLg4hgR2MEmsezGCFcD4xSpz8tQoq85lRYtfzLlaYlnvv+xghErsYJZ5/ecsE
        4XxhlLj2cDYbSBWbgKbE0mlPwTpEBFQlfnXtA+tgFrjMKHHs4kL2LkZ2DmEBV4l9tV2MHBws
        QCUf7sSAVPMKWEicu3efBWKXvMTqDQfAjpAQuMYu0XYYxAFJuEhcOzIF6iBhiVfHt7BD2FIS
        n9/tZYNoaAd64fshRging1Hi79lfUN3GEr09F5hBNjMDHbp+lz5EWFFi5++5jCA2swCfxLuv
        PawgJRICvBIdbUIQJUoSL49PgpoiIbFw4Q2ovR4SDdv+MIHYQgKxEi+W/GScwCg7C2HBAkbG
        VYxiqQXFuempxYYFJsiRtIkRnOq0LHYwzn37Qe8QIxMH4yFGCQ5mJRFe5svG8UK8KYmVValF
        +fFFpTmpxYcYTYEBNpFZSjQ5H5hs80riDU2NjI2NLUzMzM1MjZXEeR/eUogXEkhPLEnNTk0t
        SC2C6WPi4JRqYGp3ZM+bcD9R9X12tYe05oUGuRm55bo6RVEnXwRl7OFObPmwcTZr2ao9ttcr
        M3wZ7jWzvzkrftt888u76bs9vV3WCecZaJwqkq/SuTbB/MCM6Ju/parbXARz64/vN+o8FL1q
        /srvMzrZP1rvEjqiPuVesUPWZgWrkgk7Yms751/7KaoSWT75y5b6F1kL0ozP+E1oncR09wVT
        18r1Hideur3g3/lxxfJ3mXXKNmYeQg2ZdvUirMej1rHXTY+dw3KIL4SLZ8GZtZ73Jj7Oq4xs
        n341bWtwfP08QfmaZXU1dZZv/CdeevSz/mFSq95eOZXUvB9P7H9OSb3OXVHdfbHFM3xRXBT/
        0ek2yZ++5Bu8UmIpzkg01GIuKk4EAO8taNH+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsWy7bCSvO7MdSbxBltnW1rMWb+GzaK3aTqT
        xfkHv9gsmhevZ7PofiVjcXnXHDaL1f9OMVpc2P+OxWLzpqnMDpwe2w6oemxa1cnm8e7cOXaP
        EzN+s3jMOxnosX/uGnaP9/uusnn0bVnF6PF5k1wAZxSXTUpqTmZZapG+XQJXRse7RSwFp6Uq
        njQXNzD+5e9i5OSQEDCRuPe+j7GLkYtDSGAHo8Tc6w/ZIBISEgdeH2TpYuQAsoUlDh8uhqj5
        xChxtvc1M0gNm4CmxNJpT1lBbBEBVYlfXfvABjEL3GWUOLnnD1ARO4ewgKvEvlqQMSxAJR/u
        xIBU8wpYSJy7d58FYpO8xOoNB5gnMPIsYGRYxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yf
        u4kRHHRaWjsY96z6oHeIkYmD8RCjBAezkggv82XjeCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
        X2ctjBMSSE8sSc1OTS1ILYLJMnFwSjUwxTRa9ipd4dp8RN4t99+Rk5UfVbZo3+6znvJqUfbC
        8k3LHzd9dCzhi91lpnVwo+1GFqsJkY0n1J5Nzvc2P7in4nzEzApRod9b3qp4ma9uO1xibCQg
        8eL+pqTWhd+ZV8fdmFPJmmTao+tY5+lwd9eWw8Gh06+uu5PqPOdVZ9jUgrxnu176qj9e3hAb
        F5ok/v7pUynWA72Wehbxfe0xKxVNCrMe/xENenr1knDMhH3ZV55FcjWuMD6idbkvcab2i0Cl
        41vWV6ysvLc9mnXhW86fp66YhcVl3t/1tevENP8jT2drs7T+3CxwOn/vz9a4iy2V21ZIOvJ9
        97uSdsQ/q0aRz5H5tZdJlXTn2XeTyh2fK7EUZyQaajEXFScCAB3eWIupAgAA
X-CMS-MailID: 20200813030810epcas1p39ad56c069ab4fa41312f91f994c17cac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200813030810epcas1p39ad56c069ab4fa41312f91f994c17cac
References: <CGME20200813030810epcas1p39ad56c069ab4fa41312f91f994c17cac@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When args = "\"\0", "i" will be 0 and args[i-1] is used. (*lib/cmdline.c +238)
Because of "i" is an unsigned int type, the function will access at args[0xFFFFFFFF].
It can make a crash.

Signed-off-by: Seungil Kang <sil.kang@samsung.com>
---

Thanks for your review, my comments below

> Can you be less ambiguous with the args value? (Perhaps provide a hexdump of it
for better understanding)

 This kind of args as hexdump below can cause crash.
 
 00000000: 736f 6d65 7468 696e 6731 3d73 6f6d 655f  something1=some_
 00000010: 7661 6c75 6573 2022 0000 0000 0000 0000  values "        
 
 The args end with "\"\0".

> Please, use proper punctuation, I'm lost where is the sentence and what are the
logical parts of them.

 I'm sorry to confuse you. I fix the commit msg

> Can you point out to the code that calls this and leads to a crash?

 *lib/cmdlinc + 201 ~, next_arg function with args = "\"\0"
 
 char *next_arg(char *args, char **param, char **val) <-- args = "\"\0".
 {
        unsigned int i, equals = 0;
        int in_quote = 0, quoted = 0;
        char *next;

        if (*args == '"') {   <-- *args == '"' is a true condition,
                args++;       <-- args++, so *args = '\0'.
                in_quote = 1;
                quoted = 1;   <-- quoted also set 1.
        }

        for (i = 0; args[i]; i++) { <-- when reached this point, i = 0, and arg[0] == '\0',
                                        so for loop is skipped.
                if (isspace(args[i]) && !in_quote)
                        break;
                if (equals == 0) {
                        if (args[i] == '=')
                                equals = i;
                }
                if (args[i] == '"')
                        in_quote = !in_quote;
        }

        *param = args;
        if (!equals)
                *val = NULL;
        else {
                args[equals] = '\0';
                *val = args + equals + 1;

        /* Don't include quotes in value. */
        if (**val == '"') {
                (*val)++;
                if (args[i-1] == '"')
                        args[i-1] = '\0';
                }
        }
        if (quoted && args[i-1] == '"') <-- When reached this point, quoted is still set 1, 
                                            "i" is still 0, and "i" is unsigned int type,
                                            so address will be {address of args} + 0xFFFFFFFF.
                                            It can make a crash.
                args[i-1] = '\0';

        if (args[i]) {
                args[i] = '\0';
                next = args + i + 1;
        } else
                next = args + i;

        /* Chew up trailing spaces. */
        return skip_spaces(next);
 }


> Can you provide a KUnit test module which can check the case?

 If necessary, I will make it and share it.

 lib/cmdline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index fbb9981a04a4..2fd29d7723b2 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -200,7 +200,7 @@ bool parse_option_str(const char *str, const char *option)
  */
 char *next_arg(char *args, char **param, char **val)
 {
-	unsigned int i, equals = 0;
+	int i, equals = 0;
 	int in_quote = 0, quoted = 0;
 	char *next;
 
-- 
2.17.1

