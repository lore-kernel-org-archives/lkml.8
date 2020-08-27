Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109D4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEEEC2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="aFD3sXXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgH0PMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:12:48 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:19064 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728789AbgH0Lkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:40:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598528435; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=w7fCvr48yy18hQcvWfj5BBx2HYb6MogSv84HemZHdz0=; b=aFD3sXXpZgxZY6BMB54YhpU2jYccOBTAqQ7npsij2mOKxZh+FeX8e71+od5G3tXuMz9+Gcgh
 A9lS2is60pB+pBCJd5kdZkI17oBSUIxLCYssMKoSBzkNZPIVEJsNB/46AFLqcOpltIWEf8t1
 dPTu3dZCaT3+VAWJYxzcvkMHekY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f479baa630b177c47077e2d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 11:40:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2DE8BC43391; Thu, 27 Aug 2020 11:40:26 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59F14C433CA;
        Thu, 27 Aug 2020 11:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59F14C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Maya Erez <merez@codeaurora.org>, wil6210@qti.qualcomm.com
Subject: Re: [PATCH 12/30] wireless: ath: wil6210: wmi: Correct misnamed function parameter 'ptr_'
References: <20200826093401.1458456-13-lee.jones@linaro.org>
        <20200826155625.A5A88C433A1@smtp.codeaurora.org>
        <20200827063559.GP3248864@dell> <20200827074100.GX3248864@dell>
Date:   Thu, 27 Aug 2020 14:40:21 +0300
In-Reply-To: <20200827074100.GX3248864@dell> (Lee Jones's message of "Thu, 27
        Aug 2020 08:41:00 +0100")
Message-ID: <877dtkb9lm.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

> On Thu, 27 Aug 2020, Lee Jones wrote:
>
>> On Wed, 26 Aug 2020, Kalle Valo wrote:
>> 
>> > Lee Jones <lee.jones@linaro.org> wrote:
>> > 
>> > > Fixes the following W=1 kernel build warning(s):
>> > > 
>> > >  drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Function
>> > > parameter or member 'ptr_' not described in 'wmi_buffer_block'
>> > >  drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Excess
>> > > function parameter 'ptr' description in 'wmi_buffer_block'
>> > > 
>> > > Cc: Maya Erez <merez@codeaurora.org>
>> > > Cc: Kalle Valo <kvalo@codeaurora.org>
>> > > Cc: "David S. Miller" <davem@davemloft.net>
>> > > Cc: Jakub Kicinski <kuba@kernel.org>
>> > > Cc: linux-wireless@vger.kernel.org
>> > > Cc: wil6210@qti.qualcomm.com
>> > > Cc: netdev@vger.kernel.org
>> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> > 
>> > Failed to apply:
>> > 
>> > error: patch failed: drivers/net/wireless/ath/wil6210/wmi.c:266
>> > error: drivers/net/wireless/ath/wil6210/wmi.c: patch does not apply
>> > stg import: Diff does not apply cleanly
>> > 
>> > Patch set to Changes Requested.
>> 
>> Are you applying them in order?
>> 
>> It may be affected by:
>> 
>>  wireless: ath: wil6210: wmi: Fix formatting and demote
>> non-conforming function headers
>> 
>> I'll also rebase onto the latest -next and resubmit.
>
> I just rebased all 3 sets onto the latest -next (next-20200827)
> without issue.  Not sure what problem you're seeing.  Did you apply
> the first set before attempting the second?

I can't remember the order, patchwork sorts them based on the order they
have been submitted and that's what I usually use.

Do note that there's a separate tree for drivers in
drivers/net/wireless/ath:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/

And it takes a week or two before patches go to linux-next.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
