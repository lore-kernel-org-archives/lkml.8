Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F6CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A263820888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520689;
	bh=aGSkKgSOvYQfQlZ2A9zyiq/PE8Y9abBefhMktsu3diI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GN+i0d95ttl/Bs6WuOT6l6lU1VJbGs5w8l3LPa7ST78ZupwvqTaujqpvSnpRUmqXz
	 KDCXHSwEMvrcbTo11tKaEDpqMzd7opeu8tN3o3WPt5PykGgPqtulEaOcWbeCEniTNA
	 eA2AbEU54Cm2GdlCDvALqqQU5F72jkl57FSCBFGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392366AbgEZTSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:18:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391841AbgEZTNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:13:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27730208B3;
        Tue, 26 May 2020 19:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520434;
        bh=aGSkKgSOvYQfQlZ2A9zyiq/PE8Y9abBefhMktsu3diI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ehbzl3lfEkFYNLFXCDsPDq5PCaA3//ACx9DRC7pk6Xd7/cYOys6uly+SaMn06tZUH
         OhM/2NEZttSNAWQ9chogrLysbv+gLFgyhT6Ojo7e8m3qG3JUnJ0rzQMfQTEVcyFdwS
         YVxbjt8U3FFc+I3xtlKe0aFSNMNyij3FjOKGYhCg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dijil Mohan <Dijil.Mohan@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.6 079/126] dmaengine: dmatest: Restore default for channel
Date:   Tue, 26 May 2020 20:53:36 +0200
Message-Id: <20200526183944.776994168@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

commit 6b41030fdc79086db5d673c5ed7169f3ee8c13b9 upstream.

In case of dmatest is built-in and no channel was configured test
doesn't run with:

dmatest: Could not start test, no channels configured

Even though description to "channel" parameter claims that default is
any.

Add default channel back as it used to be rather than reject test with
no channel configuration.

Fixes: d53513d5dc285d9a95a534fc41c5c08af6b60eac ("dmaengine: dmatest: Add support for multi channel testing)
Reported-by: Dijil Mohan <Dijil.Mohan@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Link: https://lore.kernel.org/r/20200429071522.58148-1-vladimir.murzin@arm.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/dmatest.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -1166,10 +1166,11 @@ static int dmatest_run_set(const char *v
 		mutex_unlock(&info->lock);
 		return ret;
 	} else if (dmatest_run) {
-		if (is_threaded_test_pending(info))
-			start_threaded_tests(info);
-		else
-			pr_info("Could not start test, no channels configured\n");
+		if (!is_threaded_test_pending(info)) {
+			pr_info("No channels configured, continue with any\n");
+			add_threaded_test(info);
+		}
+		start_threaded_tests(info);
 	} else {
 		stop_threaded_test(info);
 	}


