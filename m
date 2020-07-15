Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6500BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5D82078C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MkAgYiOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbgGOMxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 08:53:45 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:44529 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgGOMxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594817626; x=1626353626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=c56rH68Z45pjMbUku60zAt3+Wn6ginlmdSE+4jUBfnM=;
  b=MkAgYiOvVxgXt0ZutloT4Ig8yD3h7ESmUvhm1v8gV7YKv7DCVkq3terg
   KsR5YklQMB5gN0wW4u1gieOBWw1xG68E8m2OqDGOAI/oQP/N8hqQeG/PC
   ewP+TQIitS4Uzd6YKkSmlAw4bp+ZZu1Rl9RHNDuQ/scR4A0lSMBJp/pwg
   I=;
IronPort-SDR: lqe7EmNGVa6k7hM2W++M9ciRxUSkVmexvwrN+uhNBVzHRuibhQiAUDHQUXnymd1BvSdGto2lpa
 wEHO7d9xjynA==
X-IronPort-AV: E=Sophos;i="5.75,355,1589241600"; 
   d="scan'208";a="51809946"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 15 Jul 2020 12:53:43 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (Postfix) with ESMTPS id 5E95CA1D65;
        Wed, 15 Jul 2020 12:53:40 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 15 Jul 2020 12:53:39 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 15 Jul 2020 12:53:34 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
CC:     <trivial@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Colin Ian King" <colin.king@canonical.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Xiong <xndchn@gmail.com>, SeongJae Park <sjpark@amazon.de>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] scripts/spelling.txt: Add descriptors correction
Date:   Wed, 15 Jul 2020 14:53:18 +0200
Message-ID: <20200715125318.8550-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715124839.252822-9-kieran.bingham+renesas@ideasonboard.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D18UWA003.ant.amazon.com (10.43.160.238) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 13:48:39 +0100 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com> wrote:

> After coming across the s/decriptors/descriptors/ spelling error twice,
> a scan of the tree showed it was a pervasive mistake.
> 
> Update the spelling suggestions database to prevent it in both singular
> and plural form.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: SeongJae Park <sjpark@amazon.de>


Thanks,
SeongJae Park

> 
> ---
> v2:
>  - Use both singular and plural form.
> ---
>  scripts/spelling.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> index c45e9afaab2d..c56a6c36e6f2 100644
> --- a/scripts/spelling.txt
> +++ b/scripts/spelling.txt
> @@ -406,6 +406,8 @@ decendants||descendants
>  decompres||decompress
>  decsribed||described
>  decription||description
> +decriptor||descriptor
> +decriptors||descriptors
>  dectected||detected
>  defailt||default
>  deferal||deferral
> -- 
> 2.25.1
