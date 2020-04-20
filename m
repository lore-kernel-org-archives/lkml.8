Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E972C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2442072B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386627;
	bh=7CwSGAnApzkj0TifNjJBsWcj8qqd9Xu9EoZHAW2GmvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cdCmhTo+ccMGo9uGVRu62BVDq4uq7vY84pkVd3CGrybfqur9DT4CWHlCIrn9qJunk
	 e5kPlbkEALwL9WdK1+QJzPN6osg428TnxNwIx9qod++0yr/upkVjJo5RCqLArcJmE8
	 6YnrSatXNTvZ+62UK8BqyvqBA2CzNWF031IptNWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgDTMnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:43:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbgDTMnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:43:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B8820724;
        Mon, 20 Apr 2020 12:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386620;
        bh=7CwSGAnApzkj0TifNjJBsWcj8qqd9Xu9EoZHAW2GmvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dau61tKXpv9Hr7WIsnWF49MyMXe9I/wE8eUCcfgwcMAS/HqBLz1GydCG0RQziNKaC
         RCHOcag8yzsmAMSFWTiPOUkSf2ue9zIPWoyhwO4nj6Aw2eGW5KeEz8WK2W92edB9Ia
         3Q8LnTRvuMr0mw8J9nvuEJl5DGzMFqxYFNaG6bdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bruno Meneguele <bmeneg@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 31/71] net/bpfilter: remove superfluous testing message
Date:   Mon, 20 Apr 2020 14:38:45 +0200
Message-Id: <20200420121514.928669975@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121508.491252919@linuxfoundation.org>
References: <20200420121508.491252919@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bruno Meneguele <bmeneg@redhat.com>

commit 41c55ea6c2a7ca4c663eeec05bdf54f4e2419699 upstream.

A testing message was brought by 13d0f7b814d9 ("net/bpfilter: fix dprintf
usage for /dev/kmsg") but should've been deleted before patch submission.
Although it doesn't cause any harm to the code or functionality itself, it's
totally unpleasant to have it displayed on every loop iteration with no real
use case. Thus remove it unconditionally.

Fixes: 13d0f7b814d9 ("net/bpfilter: fix dprintf usage for /dev/kmsg")
Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bpfilter/main.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/bpfilter/main.c
+++ b/net/bpfilter/main.c
@@ -35,7 +35,6 @@ static void loop(void)
 		struct mbox_reply reply;
 		int n;
 
-		fprintf(debug_f, "testing the buffer\n");
 		n = read(0, &req, sizeof(req));
 		if (n != sizeof(req)) {
 			fprintf(debug_f, "invalid request %d\n", n);


