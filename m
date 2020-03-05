Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3803C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27AE2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgCEGt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 01:49:29 -0500
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:22693 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726204AbgCEGt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 01:49:29 -0500
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Thu, 5 Mar
 2020 14:49:16 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.64.44) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Thu, 5 Mar
 2020 14:49:14 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
Subject: [PATCH v1 0/2] x86/Kconfig: modify X86_UMIP depends on CPUs
Date:   Thu, 5 Mar 2020 14:49:09 +0800
Message-ID: <1583390951-4103-1-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.64.44]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_X86_UMIP is generic since commit b971880fe79f (x86/Kconfig:
Rename UMIP config parameter).

Some Centaur family 7 CPUs and Zhaoxin family 7 CPUs support the UMIP
feature. So, modify X86_UMIP to cover these CPUs too.

Tony W Wang-oc (2):
  x86/Kconfig: Make X86_UMIP to cover Centaur CPUs
  x86/Kconfig: Make X86_UMIP to cover Zhaoxin CPUs

 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4

