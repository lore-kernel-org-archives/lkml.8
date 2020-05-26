Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25ABC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71914208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519934;
	bh=BWfUhi6QYQqiecRQFU7Lv31BU1wSKaNQc+VwZW0cAFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EBm3JfQOfsbxnnOUnQATvbdNSvAdVyWQFeryM5ioE+DEW5rjdzQyRC7HYVvqA2L3L
	 VYnJcvfFRttOysYFnoU0djiuZM7/+91c3UfQDjHDLotTez9t3mxSayEN3UFvp61xjk
	 ffN1RXrZnAgT2KU4LO64YespEbz45ocyFhCwNR3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391509AbgEZTFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391501AbgEZTFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:05:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA76420776;
        Tue, 26 May 2020 19:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519923;
        bh=BWfUhi6QYQqiecRQFU7Lv31BU1wSKaNQc+VwZW0cAFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qmp1CtZlDF7+QEe249B8zECTycbyCx4/d+sqPghBTZUYwk9BJFreny7Kjchqw55uo
         DTg4hVKf2O3Lov7DOjalNtISByuqZIHssXbDeBc8keCjJ56I6hSb7KsZVK2uFqGt9c
         6pYmKy2EkJqF2yYTPeKSEbWfkao2kMsdQ6usphGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>
Subject: [PATCH 4.19 71/81] ipack: tpci200: fix error return code in tpci200_register()
Date:   Tue, 26 May 2020 20:53:46 +0200
Message-Id: <20200526183934.932044758@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

commit 133317479f0324f6faaf797c4f5f3e9b1b36ce35 upstream.

Fix to return negative error code -ENOMEM from the ioremap() error handling
case instead of 0, as done elsewhere in this function.

Fixes: 43986798fd50 ("ipack: add error handling for ioremap_nocache")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Cc: stable <stable@vger.kernel.org>
Acked-by: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
Link: https://lore.kernel.org/r/20200507094237.13599-1-weiyongjun1@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ipack/carriers/tpci200.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/ipack/carriers/tpci200.c
+++ b/drivers/ipack/carriers/tpci200.c
@@ -309,6 +309,7 @@ static int tpci200_register(struct tpci2
 			"(bn 0x%X, sn 0x%X) failed to map driver user space!",
 			tpci200->info->pdev->bus->number,
 			tpci200->info->pdev->devfn);
+		res = -ENOMEM;
 		goto out_release_mem8_space;
 	}
 


