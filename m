Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2A0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6839E208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgFRTJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:09:52 -0400
Received: from nautica.notk.org ([91.121.71.147]:34209 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgFRTJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:09:51 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 8B12CC01F; Thu, 18 Jun 2020 21:09:49 +0200 (CEST)
Date:   Thu, 18 Jun 2020 21:09:34 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net, davem@davemloft.net,
        kuba@kernel.org, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/9p: Fix sparse endian warning in trans_fd.c
Message-ID: <20200618190934.GB20699@nautica>
References: <20200618183417.5423-1-alexander.kapshuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200618183417.5423-1-alexander.kapshuk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Kapshuk wrote on Thu, Jun 18, 2020:
> Address sparse endian warning:
> net/9p/trans_fd.c:932:28: warning: incorrect type in assignment (different base types)
> net/9p/trans_fd.c:932:28:    expected restricted __be32 [addressable] [assigned] [usertype] s_addr
> net/9p/trans_fd.c:932:28:    got unsigned long
> 
> Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>

INADDR_ANY is 0 so this really is noop but sure, less warnings is always
good. I'll take this one for 5.9.
Thanks!
-- 
Dominique
