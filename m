Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1826CC33CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 01:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A232072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 01:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aqo+FQ8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387847AbgAQBIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 20:08:44 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:10265 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgAQBIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 20:08:43 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200117010840epoutp03ab931812f81c3855a519585e06dd61f7~qhz4zug9F0857908579epoutp03i
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 01:08:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200117010840epoutp03ab931812f81c3855a519585e06dd61f7~qhz4zug9F0857908579epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579223320;
        bh=F1OLJjD1bzvosiYuhzkIsB0cTTcqNdGLpnJjQsxFvIg=;
        h=From:Subject:To:Cc:Date:References:From;
        b=aqo+FQ8DQpY6nQvJQB9sCF9V+Yb5Q1kNSWEq7p68hFgCiGPdspQtWRwt8zu2+03E6
         Fm5lN/78ULnsDFhCyWuAXpvm5gXlS1639GkXJqEFXVgd79eXT6NHfdgwU+06r7g3Os
         bVuWJrT/4jrZepXAL0hpxwhtFYq2HjiEHmq0viXE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200117010840epcas1p371627093e16e0bfa55c7c01aa33f1128~qhz4Ww6Pd1231912319epcas1p3r;
        Fri, 17 Jan 2020 01:08:40 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47zNH81fXCzMqYkh; Fri, 17 Jan
        2020 01:08:36 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.73.57028.419012E5; Fri, 17 Jan 2020 10:08:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200117010835epcas1p46fbb88eb5e5dc008bfb7e403b215650d~qhz0I55_M0684806848epcas1p4p;
        Fri, 17 Jan 2020 01:08:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200117010835epsmtrp12215b6dbde4837719210cad75a99fac7~qhz0IO-2i1184511845epsmtrp1V;
        Fri, 17 Jan 2020 01:08:35 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-45-5e210914827c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.23.10238.319012E5; Fri, 17 Jan 2020 10:08:35 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200117010835epsmtip17acd3c7afb1e5382e9c131494d0ac87d~qhzz70jki2888428884epsmtip1v;
        Fri, 17 Jan 2020 01:08:35 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] extcon next for v5.6
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Organization: Samsung Electronics
Message-ID: <419d4b76-3973-9167-ea09-24be742f2c3c@samsung.com>
Date:   Fri, 17 Jan 2020 10:15:56 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmvq4Ip2Kcwed53BYTb1xhsbj+5Tmr
        RfPi9WwWl3fNYbO43biCzYHVY9OqTjaP/XPXsHv0bVnF6PF5k1wAS1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdkbD42mMBdP5K3qPPmVu
        YFzK08XIySEhYCLxYv4Wli5GLg4hgR2MEvd+r2GEcD4xShzqfcQE4XxjlNj87ig7TMvKljlQ
        LXsZJea13oSqes8osbLzN1gVm4CWxP4XN9hAbGEBDYnt6zezgtgiQPbLo7fAupkF3jBK7Jq/
        kBkkwS+gKHH1x2NGEJtXwE5iz75pLCA2i4CqxJMrz8AGiQqESZzc1gJVIyhxcuYTsBpmAXGJ
        W0/mM0HY8hLb385hhjj1CJvE6rXcELaLxIRzG6FeEJZ4dXwLlC0l8bK/Dcqullh58ggbyHES
        Ah2MElv2X2CFSBhL7F86GWgBB9ACTYn1u/QhwooSO3/PZYTYyyfx7msPK0iJhACvREebEESJ
        ssTlB3eZIGxJicXtnWwQJR4Sf86LTGBUnIXkmVlInpmF5JlZCHsXMLKsYhRLLSjOTU8tNiww
        RI7tTYzgNKlluoNxyjmfQ4wCHIxKPLwzghTihFgTy4orcw8xSnAwK4nwnpwhGyfEm5JYWZVa
        lB9fVJqTWnyI0RQY1hOZpUST84EpPK8k3tDUyNjY2MLE0MzU0FBJnHe6C9AcgfTEktTs1NSC
        1CKYPiYOTqkGRu+kvoMiWTxBKxt1tJcxNzP/fdexY3lk7zWr51/bDVgtnebmPNXcELdhzeVf
        auURrrVuWqwn4jhbJCw9Z6z9s8p+6uQVQbvkDM9vsOmTuTCpzqFE7EC+VSaXRJtvxpK95gLB
        3nMWBuuIFL1js/m+I2214SHP7HnL/iY/j/sgeKzE8l182rVbSizFGYmGWsxFxYkAMEPg0qkD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnK4wp2Kcwe/lMhYTb1xhsbj+5Tmr
        RfPi9WwWl3fNYbO43biCzYHVY9OqTjaP/XPXsHv0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJX
        RsPjaYwF0/kreo8+ZW5gXMrTxcjJISFgIrGyZQ5LFyMXh5DAbkaJ9m8/mSASkhLTLh5l7mLk
        ALKFJQ4fLgYJCwm8ZZTo25MIYrMJaEnsf3GDDcQWFtCQ2L5+MyuILQJkvzx6C2wms8AbRonZ
        E18xgiT4BRQlrv54DGbzCthJ7Nk3jQXEZhFQlXhy5RnYIFGBMImdSx4zQdQISpyc+QSshllA
        XeLPvEvMELa4xK0n85kgbHmJ7W/nME9gFJyFpGUWkpZZSFpmIWlZwMiyilEytaA4Nz232LDA
        MC+1XK84Mbe4NC9dLzk/dxMjOPy1NHcwXl4Sf4hRgINRiYd3RpBCnBBrYllxZe4hRgkOZiUR
        3pMzZOOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8z7NOxYpJJCeWJKanZpakFoEk2Xi4JRqYPT3
        uX7wPXd5tff5kP+eM+9ed11z2Do6/cK9a5FJpt4PFbc8zL3St9fvctbx3nd/owp/a0+/dnOF
        0vnHC01/r9i09KSIr1r0syPPFwu2HN4mI+ItkHSlmm3PjMXtBWyPmX/qXNMtj2NXLtvc9e5n
        v5dkiPLDF19e+Qr9fcog4c+cnWv5Y92yihQlluKMREMt5qLiRADH+TfQewIAAA==
X-CMS-MailID: 20200117010835epcas1p46fbb88eb5e5dc008bfb7e403b215650d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200117010835epcas1p46fbb88eb5e5dc008bfb7e403b215650d
References: <CGME20200117010835epcas1p46fbb88eb5e5dc008bfb7e403b215650d@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.6. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Detailed description for this pull request:
1. Remove unneeded 'extern' keyword from extcon.h header file
2. Clean-up the extcon provider
- Clean-up the code for readability of extcon-arizona/sm5502.c

Best Regards,
Chanwoo Choi

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.6

for you to fetch changes up to b7365587f513540c962a734c12cf422ca9a111a5:

  extcon: Remove unneeded extern keyword from extcon.h (2020-01-13 14:15:27 +0900)

----------------------------------------------------------------
Chanwoo Choi (1):
      extcon: Remove unneeded extern keyword from extcon.h

Charles Keepax (10):
      extcon: arizona: Correct clean up if arizona_identify_headphone fails
      extcon: arizona: Make rev A register sequences atomic
      extcon: arizona: Move pdata extraction to probe
      extcon: arizona: Clear jack status regardless of detection type
      extcon: arizona: Tidy up transition from mic to headphone detect
      extcon: arizona: Remove unnecessary sets of ACCDET_MODE
      extcon: arizona: Remove excessive WARN_ON
      extcon: arizona: Invert logic of check in arizona_hpdet_do_id
      extcon: arizona: Factor out microphone impedance into a function
      extcon: arizona: Factor out microphone and button detection

Xu Wang (1):
      extcon: sm5502: Remove unneeded semicolon

 drivers/extcon/extcon-arizona.c | 354 ++++++++++++++++++++++------------------
 drivers/extcon/extcon-sm5502.c  |  10 +-
 include/linux/extcon.h          |  30 ++--
 3 files changed, 214 insertions(+), 180 deletions(-)
