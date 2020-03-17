Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509F5C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2018A20752
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443179;
	bh=IgoHmprwYnVlogtyr7RHzIGPj4uLpyVJtM8KO1ZSjaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FCbhIn4/0CfKUB+7XC3gexqr7kPOKlq8p4JCRlS3Wk+5ASKK4+Y6ehAaWzYquTHWD
	 ssHSTM9gTtr36CSkzcJd+115L/kNaLpqNe5LxCPOfcqIOitsrBliDNYXEYGPuF4jlm
	 LHYscRPdoCzx7HZRYPB2RiTvNbRgNuZW8RTKpLoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgCQLGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728539AbgCQLGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:06:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B12F720658;
        Tue, 17 Mar 2020 11:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443174;
        bh=IgoHmprwYnVlogtyr7RHzIGPj4uLpyVJtM8KO1ZSjaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KcRCgkW0LkMkYP5PFOlteGkZbnfjQr8d3jsqaQQc5c9cZ9xeQWLfAiZbclndQPi0S
         9i05ht88qJ/oA7GNOFDpcW6ODfFEQoiXyg0cmvBusvzys7Kh7hqMiQ0R0l4IDceiAi
         jB9IiQOmPcIr9zuF8Uo7stfOdDlSEd2wYeISAw5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+84484ccebdd4e5451d91@syzkaller.appspotmail.com,
        Karsten Graul <kgraul@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 122/123] net/smc: check for valid ib_client_data
Date:   Tue, 17 Mar 2020 11:55:49 +0100
Message-Id: <20200317103319.712718198@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karsten Graul <kgraul@linux.ibm.com>

commit a2f2ef4a54c0d97aa6a8386f4ff23f36ebb488cf upstream.

In smc_ib_remove_dev() check if the provided ib device was actually
initialized for SMC before.

Reported-by: syzbot+84484ccebdd4e5451d91@syzkaller.appspotmail.com
Fixes: a4cf0443c414 ("smc: introduce SMC as an IB-client")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/smc/smc_ib.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -560,6 +560,8 @@ static void smc_ib_remove_dev(struct ib_
 	struct smc_ib_device *smcibdev;
 
 	smcibdev = ib_get_client_data(ibdev, &smc_ib_client);
+	if (!smcibdev || smcibdev->ibdev != ibdev)
+		return;
 	ib_set_client_data(ibdev, &smc_ib_client, NULL);
 	spin_lock(&smc_ib_devices.lock);
 	list_del_init(&smcibdev->list); /* remove from smc_ib_devices */


