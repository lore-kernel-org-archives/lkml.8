Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F12C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA60420A8B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="STEUK6Xm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgDTIzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726197AbgDTIzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:55:02 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB30C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p1egcq0MGdpiSNpIgjqSfRIC1pCZlDdIc1bKZgJ999s=; b=STEUK6XmdWG7vCm1AYCYSlKCv0
        rQ14OjsjfDuZT0F6+jnTE9cnav/LdUjPbvGAlD7mi5/8Ko2jmAr2ThJllhAczEXySs3AIUZJmc6xe
        RDGGNtWNA4yzNsmSbNQsUo3rY3hMgj7nJdVSddnPAjEU2AFfaO0XIUoFEZ7tX4uEXKd+1+ZN8JP07
        c4cAB58oBUcIbF7z+3040uIVNYHamlrDLc/15bk44szMegE30LDFIsUrHe1b63rDG3X4+RvWSXE13
        ZnCgy4ypgd93DrnIUFSJMxXRYEOf9RNFaIVVNpJaP+SUs6uLVrCrwstl95G/zcYFNj+xcucjYN4tO
        uH5agNtw==;
Received: from [2a01:79c:cebf:7fb0:d967:6cf9:736f:4613] (port=46700)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1jQSCi-0004wr-20; Mon, 20 Apr 2020 10:55:00 +0200
Subject: Re: [Bisected] Oops witn 5.7.0-rc1
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
References: <41ae3b90-8e14-9db5-a804-5fdb2eebac03@skogtun.org>
 <1587372294.26844.24.camel@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <002b6490-9e4c-27d4-304e-775c07be1b61@skogtun.org>
Date:   Mon, 20 Apr 2020 10:54:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587372294.26844.24.camel@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Giovanni Gherdovich [20.04.2020 10:44]:

> On Sat, 2020-04-18 at 18:15 +0200, Harald Arnesen wrote:
>> Kernel 5.7.0-rc1 and later won't boot on my ThinkPad T510i.
>> 
>> The attached jpeg is all I can capture of the oops. Bisected to commit
>> 1567c3e3467cddeb019a7b53ec632f834b6a9239, but I cannot revert that to check.
>> 
>> A strange thing: The same commit is in 5.6.5, and that kernel boots
>> fine. 5.7.0-rc1 also boots fine on my desktop.
>> 
>> Screenshot and config attached. Please request any further info.
> 
> Hello Harald,
> 
> thanks for the report.
> 
> The problem you encountered is likely due to a bug where the code doesn't work
> on machines with less than 4 physical CPU cores. It is fixed by this patch
> series:
> 
> https://lore.kernel.org/lkml/20200416054745.740-1-ggherdovich@suse.cz/
> 
> The series has been acknowledged by the subsystem maintainers but not yet
> merged in any tree (it is expected to land in the "tip" tree and then be pulled
> by Linus).

Thanks!

I just sent a new bug report, since rc2 has the same problem. You may
disregard that one, then.
-- 
Hilsen Harald

