Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CB3C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CF5C2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670879;
	bh=ZAqFDUbAQnshYyeAZPTeWfhhhKw5ZnGe0nFl24scgYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wttdpmWt+sL8roxUTsvhfz9kVvbm2Oxk+beyECbw8EHmwolLrXXcvWTMbIgVhyc9g
	 /zKyR1U1++t8eTIZu2g7D45HweNLqPUhcIFOAJgaWTSKoH2xSZ/kisGb36AKLqVesg
	 Y7J5U0dGXG9QmmdtlyjitBW0woyevt7973y22J44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbgIIRBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbgIIPuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:50:54 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B9A821D92;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=ZAqFDUbAQnshYyeAZPTeWfhhhKw5ZnGe0nFl24scgYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vAF+I08h+Unlf9rDt9AHKSOww4ZBXJF2Op3tE+IZayVh6gylxp75BhCEJY84zeHZ9
         oeeYrU9AFo1MXoP9duBOfPwdKvAdJ/MIkbJF1DO2bu53W5qCfNsDCxlofNGDzxBJJ+
         TVw+6HLJbBeZUL7AcvBAejcU6hCtT7BdaGkvJVJg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUWa-1V; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/30] kernel-doc: include line numbers for function prototypes
Date:   Wed,  9 Sep 2020 16:10:33 +0200
Message-Id: <56eed0ba50cd726236acd12b11b55ce54854c5ea.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should solve bad error reports like this one:

	./include/linux/iio/iio.h:0: WARNING: Unknown target name: "devm".

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index d1b445665ad6..3982d47048a7 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1594,6 +1594,8 @@ sub dump_function($$) {
     my $file = shift;
     my $noret = 0;
 
+    print_lineno($.);
+
     $prototype =~ s/^static +//;
     $prototype =~ s/^extern +//;
     $prototype =~ s/^asmlinkage +//;
-- 
2.26.2

