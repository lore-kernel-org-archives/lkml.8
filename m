Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C969C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C794620758
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgIKPsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:48:40 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:41459 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgIKPnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:43:40 -0400
Subject: Re: gcc crashes with general protection faults in
 5.9.0-rc3-00091-ge28f0104343d
From:   Meelis Roos <mroos@linux.ee>
To:     LKML <linux-kernel@vger.kernel.org>
References: <9883f24e-7ea4-ffe1-e284-8583a3407c94@linux.ee>
 <70778c21-8039-5011-e885-221c2cb06220@linux.ee>
Message-ID: <95c6539f-1c32-5caa-ce0f-e4a5e9859c56@linux.ee>
Date:   Fri, 11 Sep 2020 16:44:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <70778c21-8039-5011-e885-221c2cb06220@linux.ee>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to myself:
>> This is 5.9.0-rc3-00091-ge28f0104343d on Lenovo t460s that has ran fine up to 5.8.0.
> 
> Now I reproduced the same problem with 5.9.0-rc3 on a HP desktop with Core2Quad CPU. The call trace is very similar and it's crashing gcc again while compiling 5.9-rc4.
> 
> But it seems 5.9-rc4 cures it here as well - whatever the reason might have been.
Nope, the reason was nondeterminism - it happened on the Core2Quad running 5.9-rc4 while trying to compile todays Linux from git.

-- 
Meelis Roos <mroos@linux.ee>
