Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E52CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E672F20842
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgG3GG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:06:57 -0400
Received: from verein.lst.de ([213.95.11.211]:54622 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgG3GG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:06:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 12ED068AFE; Thu, 30 Jul 2020 08:06:55 +0200 (CEST)
Date:   Thu, 30 Jul 2020 08:06:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rodrigo Madera <rodrigo.madera@gmail.com>
Cc:     hch@lst.de, christian.brauner@ubuntu.com,
        linux-kernel@vger.kernel.org
Subject: Re: bpfilter logging write errors in dmesg
Message-ID: <20200730060654.GA17803@lst.de>
References: <20200727145013.GA2154@lst.de> <20200730005902.236086-1-madera@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730005902.236086-1-madera@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ho Rodrigo,

please try this patch:

diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 1905e01c3aa9a7..4494ea6056cdb8 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -39,7 +39,7 @@ static int __bpfilter_process_sockopt(struct sock *sk, int optname,
 {
 	struct mbox_request req;
 	struct mbox_reply reply;
-	loff_t pos;
+	loff_t pos = 0;
 	ssize_t n;
 	int ret = -EFAULT;
 
