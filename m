Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E771DC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 21:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0ACD208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 21:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="an3bOoyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgIDVvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 17:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgIDVvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 17:51:47 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C55C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 14:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CSV8fgUCyOoK9Ra6R0elSO8AVBPoGfoCDvuZQf1//AU=; b=an3bOoyp13xtDFVZ2xDRuDlVDJ
        Fcz807ZjfcVZRxc+plgUN+sfa4P/haJfMJYhRsxbpf/ubk6Goojdr/YDs5K+j1aRa+1Ko9Cg6Kzgw
        8pbVNOyAdYTNHoiMkbBbRS1uRnrFpRVR+dzvlJy9WpdUDNG/eL6IlAYjMQ/hPr2AzkICa5zwoWVYT
        Rhc9/mRI2kwMkgA6XidX5bYmqAK/ktPfijuEoBpW2SAr68NLKYJnOFFpkrvhTHkUbXacjOlaiOvLJ
        J24jtQfrcG6CHMu8lJ8MWbWZoevNcD2woMHK1aEYXBGke36xps7uy0LKr8b8VnEBAcoJn2CZwHk3s
        CvhrQ8Pg==;
Received: from [2a01:79c:cebf:7fb0:de97:df61:fecc:46bb] (port=53844)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1kEJcN-0003Ab-LQ; Fri, 04 Sep 2020 23:51:35 +0200
Subject: Re: [git pull] drm fixes for 5.9-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAPM=9tz0whDeamM+k_8Wu8TVzz0TDr+qMNMXo8rKeeNRKxBuiQ@mail.gmail.com>
 <CAHk-=wh2EH9DKRpJQ7+X+NWjjduLPy_Ncv1GzxnXBg-3mTn0Fw@mail.gmail.com>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <cfcea1be-e02f-b391-ab1f-780888da138d@skogtun.org>
Date:   Fri, 4 Sep 2020 23:51:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh2EH9DKRpJQ7+X+NWjjduLPy_Ncv1GzxnXBg-3mTn0Fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds [04.09.2020 21:02]:

> On Thu, Sep 3, 2020 at 8:53 PM Dave Airlie <airlied@gmail.com> wrote:
>>
>> Not much going on this week, nouveau has a display hw bug workaround,
>> amdgpu has some PM fixes and CIK regression fixes, one single radeon
>> PLL fix, and a couple of i915 display fixes.
> 
> Any movement on the i915 relocation issue? I've only seen the one
> report for the 64-bit case, but clearly there was more going on than
> just the missing page table flush on 32-bit..

Still doesn't work without the three reverts
(763fedd6a216, 9e0f9464e2ab, 7ac2d2536dfa)...
-- 
Hilsen Harald
