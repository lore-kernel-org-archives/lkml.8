Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DE3C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CEA120656
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgGMV6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgGMV6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 17:58:36 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE41C061755;
        Mon, 13 Jul 2020 14:58:36 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id E0809BC0FD;
        Mon, 13 Jul 2020 21:58:32 +0000 (UTC)
Subject: Re: [PATCH] kprobes: Replace HTTP links with HTTPS ones
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200708184201.611d929ae6017c87ea98b114@kernel.org>
 <20200709191636.26252-1-grandmaster@al2klimov.de>
 <20200713094025.180fa813@lwn.net>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <d4441d4a-61cb-f84b-d751-b5b2e9b0544c@al2klimov.de>
Date:   Mon, 13 Jul 2020 23:58:31 +0200
MIME-Version: 1.0
In-Reply-To: <20200713094025.180fa813@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 13.07.20 um 17:40 schrieb Jonathan Corbet:
> On Thu,  9 Jul 2020 21:16:36 +0200
> "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
> 
>>   Documentation/kprobes.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This file no longer exists in docs-next or linux-next (it's been converted
OK, forget this patch.

> to RST and moved).  What tree are you making your patches against?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/

> 
> jon
> 
