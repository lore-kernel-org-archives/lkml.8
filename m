Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7E9C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 11:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8109D21D7B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 11:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="LOMf+n/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgIILCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 07:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgIILC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:02:29 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D754EC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 04:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=no7k1Y3k9JdhUDQ1XN9MbhKJqVbexKH3abcl8LEljAc=; b=LOMf+n/0EvE5t0zXMU5aOe370K
        BPRVe4f8DXve+0EkUHQIwq7rEdNn+dYXttY3NrZ0lkEc9oW4BDsQooky8Urt1I6sKYnB5q1lwqt3K
        ZYCOOaQHUvxCsfdQmcLa0WCSL1DGhwPWlXssdr8tYD3z5j1hDRsUwwOzbtDzoSCTlCUk1mGIGmskB
        DLCi4PGPF4az/cNZISyH/nxH/DzzYD3BK7cX03wJVC+YH7oP95lewyXhZxU8bgbYCKFSJ0ERjopNh
        iWiQFQEUEyHYiYmtR+p6mC8jN+AUPknLY7EHCfsGGDCg/4GWu1LzH9PNxXXIiKpJZoRNFKg9A0bu5
        eMdxRyKg==;
Received: from [2a01:79c:cebf:7fb0:de97:df61:fecc:46bb] (port=48632)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1kFxrq-0007p9-No; Wed, 09 Sep 2020 13:02:22 +0200
Subject: Re: [git pull] drm fixes for 5.9-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAPM=9tz0whDeamM+k_8Wu8TVzz0TDr+qMNMXo8rKeeNRKxBuiQ@mail.gmail.com>
 <CAHk-=wh2EH9DKRpJQ7+X+NWjjduLPy_Ncv1GzxnXBg-3mTn0Fw@mail.gmail.com>
 <cfcea1be-e02f-b391-ab1f-780888da138d@skogtun.org>
 <CAHk-=wjRLmayxnChONeb24pFPv=o733ptzpAyuAebrxWzhPYtw@mail.gmail.com>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <ec952f8e-52c5-6474-42a4-5e3b3091bb6f@skogtun.org>
Date:   Wed, 9 Sep 2020 13:02:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjRLmayxnChONeb24pFPv=o733ptzpAyuAebrxWzhPYtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds [08.09.2020 20:19]:

> On Fri, Sep 4, 2020 at 2:51 PM Harald Arnesen <harald@skogtun.org> wrote:
>>
>> Still doesn't work without the three reverts
>> (763fedd6a216, 9e0f9464e2ab, 7ac2d2536dfa)...
> 
> So this didn't make rc4, but it's in my tree now.
> 
> Harald, I'm assuming things work for you again now with the current
> git tree, but it is always good to double-check in case something else
> interacted with the reverts...

I can confirm that everything works as expected now.
Thanks to all!
-- 
Hilsen Harald
