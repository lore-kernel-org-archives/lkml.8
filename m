Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79D4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 02:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F7A62076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 02:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Lgtvz6oM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHLCyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 22:54:38 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:18221 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgHLCyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 22:54:37 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200812025435epoutp018c02b82807b3e36c476575eb85a15228~qZbvRH63a2024520245epoutp01k
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 02:54:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200812025435epoutp018c02b82807b3e36c476575eb85a15228~qZbvRH63a2024520245epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597200875;
        bh=SlJAjpqFM1tfamie3h/SxDvXSjGu2uPDYkxiOzNSqs0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Lgtvz6oMa2+4XGtQLEhngTNn113TGyGNj0PwsMoeqyIieoiSde042d7guDqn3Tk6F
         spzpYh0IwbaynMutjBssqtInrf0S7vyuE/k2Fa9wAYca8XPt0Enl5fXgU30wUIEKAj
         g+LhfU7VLCu4r5aMJMFTch2vDjnVazbWub4TEAo0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200812025434epcas1p258c81b03f09994aa15ab8a2f37aca57d~qZbuvqMp32881628816epcas1p2D;
        Wed, 12 Aug 2020 02:54:34 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.159]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BRDnP16d9zMqYkX; Wed, 12 Aug
        2020 02:54:33 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.11.18978.8E9533F5; Wed, 12 Aug 2020 11:54:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200812025432epcas1p1b810c6b94adf533d5cae3ef6a24ca9a2~qZbtA0_1c3128531285epcas1p1z;
        Wed, 12 Aug 2020 02:54:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200812025432epsmtrp1e3a8a18ae9206dbed1911565a638a19f~qZbtAKEDA0651206512epsmtrp1v;
        Wed, 12 Aug 2020 02:54:32 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-90-5f3359e8ce6f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.38.08303.8E9533F5; Wed, 12 Aug 2020 11:54:32 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.104.227]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200812025432epsmtip2bfa2b92c1c7b7927ee36aab22cf121ec~qZbszv2zm0979609796epsmtip2z;
        Wed, 12 Aug 2020 02:54:32 +0000 (GMT)
From:   Seungil Kang <sil.kang@samsung.com>
To:     bhe@redhat.com, mingo@kernel.org
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        herbert@gondor.apana.org.au, andriy.shevchenko@linux.intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Seungil Kang <sil.kang@samsung.com>
Subject: [PATCH] lib/cmdline: prevent unintented access to address
Date:   Wed, 12 Aug 2020 11:54:02 +0900
Message-Id: <20200812025402.15695-1-sil.kang@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmvu7LSON4g4UdzBZz1q9hs+htms5k
        cf7BLzaL5sXr2Sy6X8lYXN41h81i9b9TjBYX9r9jsdi8aSqzA6fHtgOqHptWdbJ5vDt3jt3j
        xIzfLB7zTgZ67J+7ht3j/b6rbB59W1YxenzeJBfAGZVjk5GamJJapJCal5yfkpmXbqvkHRzv
        HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
        Vim1ICWnwNCgQK84Mbe4NC9dLzk/18rQwMDIFKgyISej8exF1oLdrBX9rQeZGhhXsXQxcnJI
        CJhIXLl5mRnEFhLYwSix6JlgFyMXkP2JUeLk3ZVMEM5nRolHZ96ywXTse7eFDSKxi1Hi2orn
        LBDOF0aJffd7weayCWhKLJ32lBXEFhFQkfh/fTsrSBGzwDVGiT1busEWCgs4Say8/BBsLIuA
        qsSeZTvB4rwClhJ9d2axQqyTl1i94QAzSLOEwDV2ibd7dzFDJFwk9jV0QhUJS7w6voUdwpaS
        eNnfxg7R0A70xfdDjBBOB6PE37O/oLqNJXp7LgDZHEA3aUqs36UPEVaU2Pl7LiOIzSzAJ/Hu
        aw8rSImEAK9ER5sQRImSxMvjk6CmSEgsXHiDHaLEQ2L2gRxIQMZKPLjZwDSBUXYWwvwFjIyr
        GMVSC4pz01OLDQsMkaNpEyM43WmZ7mCc+PaD3iFGJg7GQ4wSHMxKIrx2d/XjhXhTEiurUovy
        44tKc1KLDzGaAgNsIrOUaHI+MOHmlcQbmhoZGxtbmJiZm5kaK4nzPrylEC8kkJ5YkpqdmlqQ
        WgTTx8TBKdXAFLbJl9fo35uCj1sfP7S4Z/Vca/GBv99/HPSzdGrMzpg168zeSrv8WwmHyk7p
        7ONjuX6X0zlJa53Jv+tPXnNZlx9tSi+88sajWldjtsG8RxpXnX9OPfuW4659ZpQH57+XKzYu
        qdzb+XJ/SYJ8zYT4+TJlS++6G9Xd/OOaHnevf8+KuDu8T/om1G1ptrO7+36hhaYFe0jbrNii
        kyE6y6QmllspH1zj+qTq4K7ZC+zPqG7dYc6pUXw/9x3b3pqFp1gbbk6T4ejSq1AT9SzYsXLr
        feaDH+2mChVoVud67LD2LJDvDbygN9+COb6z9vTj7IkCnP5KKt8XMCXei/TYqJ5+8uwE+Un2
        gemP+kMM+e72KbEUZyQaajEXFScCAIaHQv8ABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsWy7bCSvO6LSON4g4nPtSzmrF/DZtHbNJ3J
        4vyDX2wWzYvXs1l0v5KxuLxrDpvF6n+nGC0u7H/HYrF501RmB06PbQdUPTat6mTzeHfuHLvH
        iRm/WTzmnQz02D93DbvH+31X2Tz6tqxi9Pi8SS6AM4rLJiU1J7MstUjfLoEro/HsRdaC3awV
        /a0HmRoYV7F0MXJySAiYSOx7t4Wti5GLQ0hgB6NE05WjrBAJCYkDrw8CFXEA2cIShw8XQ9R8
        YpT4e383O0gNm4CmxNJpT8HqRQTUJPY9e8QMUsQscIdR4nXLA7ANwgJOEisvP2QDsVkEVCX2
        LNvJDGLzClhK9N2ZBbVMXmL1hgPMExh5FjAyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vO
        z93ECA4+La0djHtWfdA7xMjEwXiIUYKDWUmE1+6ufrwQb0piZVVqUX58UWlOavEhRmkOFiVx
        3q+zFsYJCaQnlqRmp6YWpBbBZJk4OKUamA6ZVcSaBi/+d2Z3gdT2R5UVPmX1V9UiJOofJ8u8
        fttQevHRT40Njzfky5/bPe9n/pHTm94szHWM+FSUe6ohyCuhy9yX96bcjb+zLU2ZLA1/Wtln
        N698efe4wNVfhxx/WsqVl3J1y7Zeu7n6PP+CBM06Ae6ZGqpnrrqW+yWnRd/W2bRzYVZg2rln
        AnMc1kZO2Z5Q4epYONVj7jfTmzHtD1dMuJfS5Dn5wFlhy3+XJIuZ4qL8ls871NTIwKTSrWvd
        77rWb/6FmdkOxzQ+Kmf9VbVv2hiym6f4W/u81WUi93zU2EsfheosUVSR2dcdsma5UZJaRlzr
        jqA1TwLuHA5577TzYXypy1u2pQKrTnQ9V2Ipzkg01GIuKk4EAIqqSYitAgAA
X-CMS-MailID: 20200812025432epcas1p1b810c6b94adf533d5cae3ef6a24ca9a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200812025432epcas1p1b810c6b94adf533d5cae3ef6a24ca9a2
References: <CGME20200812025432epcas1p1b810c6b94adf533d5cae3ef6a24ca9a2@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When args = "\"\0", "i" will be 0 and args[i-1] is used (line:238)
Because of "i" is an unsigned int type,
the function will access at args[0xFFFFFFFF]
It can make a crash

Signed-off-by: Seungil Kang <sil.kang@samsung.com>
---
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

