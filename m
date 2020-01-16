Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2E1C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67E920661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217507;
	bh=zPjs+tVGI9LSJMOzn29WDkK/KTQw5p59s0ju7EurzYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EQEmw5aaUxSrisf5miAIenAV1RAUEL3Gm3DptKB4aZZ4hxTVr06ZIhQHetkmYrFPr
	 AqeIdjHii4cmbaAUAXMF6Z0WreGV62sF/4O3Yfr6X1eI4kKV1Nb30EYSDJZQNZiqce
	 bw1/LcOPTte+9JCyNJcZMqyahwf3fTDMM+GUYhR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390733AbgAPXbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:31:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391495AbgAPXbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:31:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE2AB2072B;
        Thu, 16 Jan 2020 23:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217478;
        bh=zPjs+tVGI9LSJMOzn29WDkK/KTQw5p59s0ju7EurzYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MdSGyxKwyuj2dKMoT/g8uKyd04r4zaJC/eUljeMogLTYPYWtfKOrIo0+QGqpgwsaA
         s/a7pnaAV+lhN1jF5CXW1te+Jvlv46CEHkAPE/e5vWMnxPulKifKcDKwqxha6erSFh
         mIfFTHehb2Ho7oZgeC1Wub8y+UG2LBxhFxU0DXeI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.14 15/71] wimax: i2400: fix memory leak
Date:   Fri, 17 Jan 2020 00:18:13 +0100
Message-Id: <20200116231711.667070476@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231709.377772748@linuxfoundation.org>
References: <20200116231709.377772748@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit 2507e6ab7a9a440773be476141a255934468c5ef upstream.

In i2400m_op_rfkill_sw_toggle cmd buffer should be released along with
skb response.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wimax/i2400m/op-rfkill.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wimax/i2400m/op-rfkill.c
+++ b/drivers/net/wimax/i2400m/op-rfkill.c
@@ -142,6 +142,7 @@ int i2400m_op_rfkill_sw_toggle(struct wi
 			"%d\n", result);
 	result = 0;
 error_cmd:
+	kfree(cmd);
 	kfree_skb(ack_skb);
 error_msg_to_dev:
 error_alloc:


