Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574BFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3341B22CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597927387;
	bh=KeEH0WupS7fRmMINjiXxfqHe6+xAUW4yTIKaP19lwrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hONW9dO0YWVL6Km3WEwlnkEQPsTTdnTrrOwpIrFgWA5zwcH6oMdX8j8LvoTqCLJWk
	 LfAEE7XaFVbK46pqhYNacjOmI0YimlScqLrJgEJErh15nl4+6gRFbDrQamObcdbrvZ
	 vpqG44xFg7lEmd0mW+g+F8MFqsoe7rN0OOCbDcL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgHTMnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbgHTJpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:45:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B83F2173E;
        Thu, 20 Aug 2020 09:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916755;
        bh=KeEH0WupS7fRmMINjiXxfqHe6+xAUW4yTIKaP19lwrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1RW3bb2twDAuqs2GxSmsHG9OvkCvs9Qvx2Ycsx9URRPCZC/b9VH9bhI0FCuWL6001
         4b5ibUwowawPDKnTMgZopazy2ybsR7RXCZ4HNn3GPkvloVee+oQG0v64YEQt/GFOHV
         NfErSFbA9gTfEXWjg8LbdaEcdpxx7hZVB1wkEoVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 5.4 034/152] xtensa: fix xtensa_pmu_setup prototype
Date:   Thu, 20 Aug 2020 11:20:01 +0200
Message-Id: <20200820091555.409042072@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

commit 6d65d3769d1910379e1cfa61ebf387efc6bfb22c upstream.

Fix the following build error in configurations with
CONFIG_XTENSA_VARIANT_HAVE_PERF_EVENTS=y:

  arch/xtensa/kernel/perf_event.c:420:29: error: passing argument 3 of
  ‘cpuhp_setup_state’ from incompatible pointer type

Cc: stable@vger.kernel.org
Fixes: 25a77b55e74c ("xtensa/perf: Convert the hotplug notifier to state machine callbacks")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/kernel/perf_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/xtensa/kernel/perf_event.c
+++ b/arch/xtensa/kernel/perf_event.c
@@ -401,7 +401,7 @@ static struct pmu xtensa_pmu = {
 	.read = xtensa_pmu_read,
 };
 
-static int xtensa_pmu_setup(int cpu)
+static int xtensa_pmu_setup(unsigned int cpu)
 {
 	unsigned i;
 


