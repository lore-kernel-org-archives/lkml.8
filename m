Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117EAC3403F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB38207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QgZ4EvQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgBRPUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:20:41 -0500
Received: from mout.gmx.net ([212.227.17.20]:34235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgBRPUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582039215;
        bh=YhImMGYbcuWObc/HIX9Fh3xzoRfBdQCW4zGMAPs01B8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=QgZ4EvQkvC6QJg9OKShSkwuTDe5Q15IBF4VjI8YAG6IE3KFLrOLZl6cJVe/qBJCq3
         oLUNvtDiSGKs16WQV3AYj1c4dI3V5+qGIGm6MofOZsMSaWZnohKNp/ETV+RfvjCy9L
         9mf1Hj+9+AaQtlgvv9cS6msO6U3oDfIB4+eWgjeI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.223]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdeX-1jGVOU0Zm9-00Ecvi; Tue, 18
 Feb 2020 16:20:15 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Xiong <xndchn@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH] scripts/spelling.txt: Add syfs/sysfs pattern
Date:   Tue, 18 Feb 2020 16:20:08 +0100
Message-Id: <20200218152010.27349-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TkCqogpvjeqc2kwA0Pwv/hL3fl37AUqYTTUwr6HbiWSaHld1OwR
 Xo0X9Uw2D8+Hsr4PdPr+X4Nr9KUcS1EBGgkg3j05Oil2Y9srxO0OZmOQ3ATOdFrMT7g/MRr
 C/+uCS1Abgble1rvPNIlP/0dAyixLY0Lx5vjbJZtdn8uAFhWxUZ5OJvv6tQaTM28Bcb44Eo
 Wpwq5bUKFrKxfJWSGpWXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AY8hb9fYS9U=:zDnbtpz+5/YrqWQ6ExKvMI
 bZNsH9KW0/QLr5jx/7IQZ4QUE840MyO3Ff02pvwaRUhsUlXxdkTqqQH8jnIa3rWttv24rexNx
 SPXJkWqJHxIe+j5/8EUflYVb35AvFeGNY4jRk8KG9/a6dDIqguR+himXavVTlKT09CoNG5PSh
 E1FAdesOuvYUtJ/c8GITzMdcmfFncvrFzd0aX0qiuFWv7fKaxADNc0BmDtO3RU2K7vFs4pg/Z
 JcO8VVCDxwMJnycpiJEJ8SVuVHcuIHxeZluQAInSa/WDz2P17Fn48dmoeBFhiBjaCcbRsmLsY
 yjDiStxw6TfaSbD+23cy7Pf/INOt71eCyqhiwFj7oUMHE9jHy0v8kI9udSVMQKw6y62x9Bf+c
 NlQOvw2ZGSC8MPGAmmVQf2SEignfLKgDR8wduypOTBhnZ2iCSrQRSz5NyQTXZE7MO/RA2o7g0
 DGPycBKPlfFOTrw+A4pDxWt/ellbNriL/nqMbXjQyBcGkzKlYDKSl9NQZ4vE4EaPa8gmiu9/h
 kemxas0DsMfnO2qM92d92oTfUChaonMWXoqXqKnURY3Q+cvkCij4GF4YtIR0G5Rmif8VAFtl4
 rESxzpbm8ioIPmvuWGmrkSsNVPjn3L4hplyKnFaqRY/QDHa6mAiBkS0ktgXZ8YQ+5n9IheTEh
 Q8tsKVg/8l7a5x10Z7cvKecR8LnulEzJ9SZ884W6MkjEknPEqiUOaKYrdCkOtrjnjQo3it9rS
 hG2DeJV81VxQTKKKXIHGRmea4FIhWulODB2FHk7uHWOT9eQdNDgTcRbZs9H4OzC1aVeR1FR4K
 4fcuOMF3gCZcKBDaXuKLO+e5K/a6ryUBELl/SSi0mfLe9qxR3khC1YPpNa1LLxzEj10mfxs3M
 2f4LMHkaoXrpbeQIL11TzTb1RW6scVNO5Obb/y0myrPdgoE8/IW1Ifqnhtb2A/Vg65z91wZOm
 5DWDr9LYsEBP2/MpW3mIxHrxrUJf+PPYhG4tEuXmvC5pfg2FK/28rOTqR3tKoufvYonznG1YS
 wHLkMpKWZpHrVdA5jT2q4HkdKNMpLQj0pn1uhb05B3x49QVGnEFLXSnTkRDKtDXM3ViE/KAWT
 8bGSulfTOFwtebl8ucf90CVQ2Afp1/G8scNZIn6CmvH1OK+bmPhC2vCTNP0q2OzkOTxxb+HLS
 hMU+2H6NlRVJaVgtVYU5xG1VReQfeCu9JjfcGLMx7ECoObd6z5SYMWqugNRJSxLxPXcaiXAJu
 pt/qNJrz3ZCq1Ys5R
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few cases in the tree where "sysfs" is misspelled as "syfs".

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index ffa838f3a2b5..6d5243904e76 100644
=2D-- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1328,6 +1328,7 @@ swithcing||switching
 swithed||switched
 swithing||switching
 swtich||switch
+syfs||sysfs
 symetric||symmetric
 synax||syntax
 synchonized||synchronized
=2D-
2.20.1

