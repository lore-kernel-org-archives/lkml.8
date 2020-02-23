Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43586C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 04:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D93208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 04:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgBWEv0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 23:51:26 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44952 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726650AbgBWEvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 23:51:25 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1596171|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.33074-0.00835149-0.660908;DS=CONTINUE|ham_news_journal|0.00902463-0.000304198-0.990671;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03305;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Gr9GyVW_1582433479;
Received: from it-c02z45m7lvcf.lan(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Gr9GyVW_1582433479)
          by smtp.aliyun-inc.com(10.147.41.137);
          Sun, 23 Feb 2020 12:51:19 +0800
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: linux-next: Signed-off-by missing for commit in the csky tree
From:   Guo Ren <ren_guo@c-sky.com>
In-Reply-To: <20200223133451.0c8c0f09@canb.auug.org.au>
Date:   Sun, 23 Feb 2020 12:51:18 +0800
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <CDEFD0D4-96C0-4D08-A357-96EA68F2DB64@c-sky.com>
References: <20200223133451.0c8c0f09@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx, fixed with add:
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>

Best Regards
  Guo Ren



> 在 2020年2月23日，上午10:34，Stephen Rothwell <sfr@canb.auug.org.au> 写道：
> 
> Hi all,
> 
> Commit
> 
>  24cfce6b33f2 ("csky: Replace <linux/clk-provider.h> by <linux/of_clk.h>")
> 
> is missing a Signed-off-by from their committer.
> 
> -- 
> Cheers,
> Stephen Rothwell

