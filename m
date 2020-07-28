Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474ECC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED64206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoQ7Bq3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgG1Olj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbgG1Olj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:41:39 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D14C061794;
        Tue, 28 Jul 2020 07:41:39 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o1so10005376plk.1;
        Tue, 28 Jul 2020 07:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GF8ZjMhiyVomxf9/l0IfId/LIV7LteGzaaDxWYsxaIU=;
        b=VoQ7Bq3KPeISrwjwSkLoprGtG+k2Fb7MUT7AlyPhSWF0Rj9fuUds8Wcwl/5SeiiSWn
         j1GKLVuH4umjRwNSVPjCrQ7gcSyeFxRwwhxCIEBtjp90Na3KaTC0rUHYYy8TrOAgcd1V
         fMwls5Y4GUZdWaYHlgp1mJmXd/61BUCwxu25UjIWqJos1T7HDB83AfVFh861m8KzEEl7
         99xmGXtYlrHL71aglulvPMt1wMCUNjdDiImW/ioWlxbyh1yUVs5zk9FUWt9ZW0RFvDD1
         X/XzvbepYJqrCNjASn7nZE+NOG2b2ahTvCe1w41tXu6EQegWQfKnYtSWGfRhLaN2u1K1
         XBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GF8ZjMhiyVomxf9/l0IfId/LIV7LteGzaaDxWYsxaIU=;
        b=Ah3+4XtS2Cm+VVA7edhAGsKPDUfjNOUNDEVTBogGk3GXEPNfaatpLO7hLBt/hK6X5Y
         QC9jku+XezpLCSTJeaXelJaX0fWmqebJmpTCB85o06of2Arov2RP06OLyfdEPREV8bKS
         H4mkeci9evuYkRHlamqnqzEiU9zCZlp5CYAOBHzyLCUwpPlmsJaAuyhSXTBCufH644SA
         BKO4NBo2x00QPvbHGd9gIcmdXdG8FCwsgyELaJtjhg9Rh6EYgeXzouayXKfjifvcceug
         4AjbwaN+Q2kAVYX5dxdQpzshyAp6/cu/XTuGxS451udfecf3YAzrZHxiAaAHYjG5/T0R
         +E2A==
X-Gm-Message-State: AOAM531it19HgdP7zOrQA/acF16MiF7l179LZqDnDF5Y7VtM8sdtOKvU
        nH0YJVu9rmM7xQeb5Mq/6AUUrLBB
X-Google-Smtp-Source: ABdhPJxPnbqNFx2R/aZMT//M0oZGvl560sm+VxS32xxVHehpQkXBH7TQA2aiTJIBbOPhRQfIh4eMdw==
X-Received: by 2002:a17:902:a3c2:: with SMTP id q2mr10268577plb.212.1595947298539;
        Tue, 28 Jul 2020 07:41:38 -0700 (PDT)
Received: from [10.1.10.11] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id d65sm18735992pfc.97.2020.07.28.07.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 07:41:37 -0700 (PDT)
Subject: Re: [PATCH] [net/ipv6] ip6_output: Add ipv6_pinfo null check
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        Gaurav Singh <gaurav1086@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200727033810.28883-1-gaurav1086@gmail.com>
 <20200728021348.4116-1-gaurav1086@gmail.com>
 <CAM_iQpWbT18cRfDc2f1wVUrS6QpOmPrZwBqaitD7545-itijfg@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <4c4d94e2-e2b4-ee77-6942-f5d747a288e4@gmail.com>
Date:   Tue, 28 Jul 2020 07:41:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAM_iQpWbT18cRfDc2f1wVUrS6QpOmPrZwBqaitD7545-itijfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/20 8:12 PM, Cong Wang wrote:
> On Mon, Jul 27, 2020 at 7:14 PM Gaurav Singh <gaurav1086@gmail.com> wrote:
>>
>> Add return to fix build issue. Haven't reproduced this issue at
>> my end.
>>
>> My hypothesis is this: In function: ip6_xmit(), we have
>> const struct ipv6_pinfo *np = inet6_sk(sk); which returns NULL.
>>
>> Further down the function, there's a check:
>> if (np) hlimit = hp->htop_limit
> 
> This check exists before git history, at that time 'sk' could be NULL,
> hence 'np', so it does not mean it is still necessary now.
> 
> I looked at all callers of ip6_xmit(), I don't see how it is called with
> a non-full socket, neither 'sk' could be NULL after
> commit b30bd282cbf5c46247a279a2e8d2aae027d9f1bf
> ("[IPV6]: ip6_xmit: remove unnecessary NULL ptr check").
> 
> Thanks.
> 


Agreed.

And again, fact that this patch lacks a Fixes:  tag speaks for itself.

This means the author expects all reviewers to make a deep analysis.

Please bear with us, and add a Fixes: tag so that we can fully understand what was
the bug origin and why a fix is valid.
