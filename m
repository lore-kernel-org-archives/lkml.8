Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2726C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92456246C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tb8TiCEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgCBHEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:04:32 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:44925 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgCBHEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:04:31 -0500
Received: by mail-pf1-f176.google.com with SMTP id y5so5095529pfb.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 23:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R5/1GmsMDRuvHs8Eg5j1TKFca+X1oMnEPhFcLO24O9U=;
        b=Tb8TiCEYbDpO95BnRwe4UuBaV0XYcxMv2Ehgm+Gt7SJ6XsysFXvQ1S2ZNyNVXhiAyR
         yZxahi+RWghyoemPF2cy4NXypQf2zbtZ9t57oFUjT0fBpdt4eB2F0mQlOt/YiDaXwYvE
         fI8lIjTffGo6vThX+f5FQzuqzhhELoauu+oYGeeAcZmKfew7bLPd5K1ay19xb4mSmBmd
         MlmchOoJM7N1C3n1QcHMTZgpYTKP24c3MtjJ7LGrCPRrDfnGcj3pJF7AFXyJTOBpu+0s
         SrDlqkbGUgG/mPeZiWi0r/zrIz+87S6u2ciwYi9+YJrsoXB2sLvfeWXjEs3noYYgWwGr
         M2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R5/1GmsMDRuvHs8Eg5j1TKFca+X1oMnEPhFcLO24O9U=;
        b=AhJAshCqcV8fJcDsz3KVbE4StG7SdaB77h/V22yQrbO1Tyff4/4jXlCWsoUu2vr6u0
         iM0GJaP9BGc9YJo5RasrwWLd7Mg74htZzmXK0iWud2lMXQT2MxNx6AIyQMbO7IBX++NS
         qBF85t3zHPGbkiDoCBixC1iuLiV50BbKsII1E7FooiIAuxQG9DurTubusWzil14Qfn+G
         OpzZ5B4MXPASaTiGnQbP1qZJzNHNtYCkAdDAM9qaEO5zONJYCo4npYYOPXxru09b+v0l
         1a1SogK0+nkYP1SFyZ3MRdUaaiGuY65HBaNIxXEn5maAhLtKjjwtOzJIVLQjnu7yeTv2
         WiNA==
X-Gm-Message-State: APjAAAX4iX3zW7uf1N9xHz1UoeAFHELcWK770aGSWP+FyWtowY1aTBwi
        q8p74Qr+op727J+7mxS8nCCRRw==
X-Google-Smtp-Source: APXvYqxKwsQQNvUjAEKUOsN0wYCClSgfFm5zZ4GfHEU52jXT2j+PYAYd9E1K/tNWo1PmZh6rJsHUJA==
X-Received: by 2002:a65:43cb:: with SMTP id n11mr17535148pgp.65.1583132671006;
        Sun, 01 Mar 2020 23:04:31 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b3sm19969551pft.73.2020.03.01.23.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 23:04:30 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/2] net: qrtr: Nameserver fixes
Date:   Sun,  1 Mar 2020 23:03:03 -0800
Message-Id: <20200302070305.612067-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The need to respond to the HELLO message from the firmware was lost in the
translation from the user space implementation of the nameserver. Fixing this
also means we can remove the FIXME related to launching the ns.

Bjorn Andersson (2):
  net: qrtr: Respond to HELLO message
  net: qrtr: Fix FIXME related to qrtr_ns_init()

 net/qrtr/ns.c   | 56 +++++++++++++++++++++++++++----------------------
 net/qrtr/qrtr.c | 10 +--------
 net/qrtr/qrtr.h |  2 +-
 3 files changed, 33 insertions(+), 35 deletions(-)

-- 
2.24.0

