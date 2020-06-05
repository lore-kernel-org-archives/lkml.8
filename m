Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D30C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81687207D0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgFEU3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgFEU3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:29:00 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE5FC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 13:28:59 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 82BA23E92B;
        Fri,  5 Jun 2020 20:28:55 +0000 (UTC)
Subject: Re: linux-next: Signed-off-by missing for commit in the jc_docs tree
To:     Jonathan Corbet <corbet@lwn.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200526080122.5a91c78a@canb.auug.org.au>
 <20200526084451.69a3bd45@lwn.net>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <ba5ca7c6-bdf9-b568-b58e-d6d466dc668f@al2klimov.de>
Date:   Fri, 5 Jun 2020 22:28:54 +0200
MIME-Version: 1.0
In-Reply-To: <20200526084451.69a3bd45@lwn.net>
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

Am I completely blind or did the patch completely disappear?

$ git log v5.0..docs-5.8 |grep -Fwe 'Alexander A. Klimov'
$ git log v5.0..lwn/docs-next |grep -Fwe 'Alexander A. Klimov'
$ git log v5.0..lwn/docs-next-merge |grep -Fwe 'Alexander A. Klimov'
$ git log v5.0..torvalds/master |grep -Fwe 'Alexander A. Klimov'
$

Am 26.05.20 um 16:44 schrieb Jonathan Corbet:
> On Tue, 26 May 2020 08:01:22 +1000
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
>> Commit
>>
>>    1fe411077207 ("Replace HTTP links with HTTPS ones: documentation")
>>
>> is missing a Signed-off-by from its author.
> 
> Argh, I don't know how I missed that.  Thanks for catching it, it will be
> fixed up.
> 
> jon
> 
