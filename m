Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A3EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F91F20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598443425;
	bh=zg2y64rSQ9eu1VZL1FA/EuqhhlIjDNS7oCgBbbjbQPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oSphHdQ6c3MTlk8xTSt8fnJv6JY6i4F2//504JAW0cjxdyAYgRu1LMwJlw6Q5QAVm
	 Kdyti8ZD++VxUHe8ZOmSanWbGhlLq9GWsJ5nqfeZr224CdZokKYMup1EfDbkIvOZUr
	 2Oh/7S0XhMNWpJWzF9Xk/hkdeph/aZTcZAJsVn9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgHZMDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729469AbgHZMCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:02:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ECEB20786;
        Wed, 26 Aug 2020 12:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598443367;
        bh=zg2y64rSQ9eu1VZL1FA/EuqhhlIjDNS7oCgBbbjbQPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=en3HoARbH6Bvf5omNtq9d+kunMg+KKAQQWgbEyRehCw+A7bss2fkDC02R4ESGMH46
         hrGsMrhJKf3Se34TJ7vRgM3S3TYdXC0H7+RUwLqFumTl6MpIT+ipnl1Di2uRTo7RtD
         ucg7nWN0JiEgX7Qh1sr3YHsjHjYAZobu0NcfcgL8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alaa Hleihel <alaa@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 05/15] net/sched: act_ct: Fix skb double-free in tcf_ct_handle_fragments() error flow
Date:   Wed, 26 Aug 2020 14:02:33 +0200
Message-Id: <20200826114849.556452061@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826114849.295321031@linuxfoundation.org>
References: <20200826114849.295321031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alaa Hleihel <alaa@mellanox.com>

[ Upstream commit eda814b97dfb8d9f4808eb2f65af9bd3705c4cae ]

tcf_ct_handle_fragments() shouldn't free the skb when ip_defrag() call
fails. Otherwise, we will cause a double-free bug.
In such cases, just return the error to the caller.

Fixes: b57dc7c13ea9 ("net/sched: Introduce action ct")
Signed-off-by: Alaa Hleihel <alaa@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_ct.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -702,7 +702,7 @@ static int tcf_ct_handle_fragments(struc
 		err = ip_defrag(net, skb, user);
 		local_bh_enable();
 		if (err && err != -EINPROGRESS)
-			goto out_free;
+			return err;
 
 		if (!err) {
 			*defrag = true;


