Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD09C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F302078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rO+v0VTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgFIMZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:25:33 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:22150 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgFIMZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591705532; x=1623241532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=7X8FiA3me7TPMvFE9ad5LnLwzdMbCB+eU+xJvgSdv5A=;
  b=rO+v0VTW3xwLeR0VLV/s9Bqq7bmQMuG1n0nLJhV3NWotsTaYudTqED/Y
   cMopDycT93CHU9bgJIXdMwKksOXB4sGp5jXpMh6EKdHnBIUFSuCPFYMA2
   LYJribd6kZHXCNp4QGW7kyhpvjayv4wVh70JGzKhQuEKTOiqiKMjVFtxn
   g=;
IronPort-SDR: wtuvN4RmzP2Vo+OSj4dmxNhETKKTUVaabPG9qE5jtrAaS7bNLrO0od8oq18iN3XC546NdVSIh9
 vmJcjErtV5XA==
X-IronPort-AV: E=Sophos;i="5.73,492,1583193600"; 
   d="scan'208";a="35175724"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 09 Jun 2020 12:25:30 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id B40AE140225;
        Tue,  9 Jun 2020 12:25:28 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 12:25:27 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.53) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 12:25:23 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, <colin.king@canonical.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH] scripts/spelling: Recommend blocklist/allowlist instead of blacklist/whitelist
Date:   Tue, 9 Jun 2020 14:24:50 +0200
Message-ID: <20200609122450.25842-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609121843.24147-1-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D40UWC002.ant.amazon.com (10.43.162.191) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jun 2020 14:18:43 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit recommends the patches to replace 'blacklist' and
> 'whitelist' with the 'blocklist' and 'allowlist', because the new
> suggestions are incontrovertible, doesn't make people hurt, and more
> self-explanatory.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> cr https://code.amazon.com/reviews/CR-27247203

Oops, sorry for leaving this unnecessary text.  Will post the 2nd version soon,
please ignore this patch.


Thanks,
SeongJae Park

> ---
>  scripts/spelling.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> index d9cd24cf0d40..ea785568d8b8 100644
> --- a/scripts/spelling.txt
> +++ b/scripts/spelling.txt
> @@ -230,6 +230,7 @@ beter||better
>  betweeen||between
>  bianries||binaries
>  bitmast||bitmask
> +blacklist||blocklist
>  boardcast||broadcast
>  borad||board
>  boundry||boundary
> @@ -1495,6 +1496,7 @@ whcih||which
>  whenver||whenever
>  wheter||whether
>  whe||when
> +whitelist||allowlist
>  wierd||weird
>  wiil||will
>  wirte||write
> -- 
> 2.17.1
> 
