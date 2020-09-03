Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615BAC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234B120737
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmMaspQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgICHY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgICHYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:24:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48483C061244;
        Thu,  3 Sep 2020 00:24:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a9so1784934wmm.2;
        Thu, 03 Sep 2020 00:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+UYkqqtpEumqVz085ayuA3qTudGvXO9bxur0CxdrhOE=;
        b=CmMaspQTo3Cn2zy6V3m2rGY1F+44MSnUL8tL2xItFXxVgr9v5MzGrY2Ua/CxK8PGYp
         NCVfXo4iuWXTF6KWEZrnc23PSFZySNGzifMLgXEJg1lWs0j8w2icV/hnkKvZJT7R6DNh
         Rw6e8s4iJsOgSIVD2PNo7BhuaKZYEw4vpEcgDUhbeWevkOE+iuroRX1u16V54XyBA8G/
         HzMmMuglUwWfmDR8l7JFlbpXkriJ+D6kKzWMZHOE8IgIBI7ZYjqyuTx5rNq+QNnL+ttA
         RCyPnBWexPY2rg0UVa/nK9QsjT8kOhUINcTt3zm79/mQ43G8/ZoHOpraKMhqnVxZnACS
         R8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+UYkqqtpEumqVz085ayuA3qTudGvXO9bxur0CxdrhOE=;
        b=feB3bZpKr/NXJeeF5KOq+/ThITcnJH2KhbujE7pu4+XHwtF9Z+iUA0aetxTn11PMHN
         /u4SS6k6jQ7J2M5Xq6bNnvcVNul0KehNam/A/eg46KC3M6xnTswyTrCKtJNeKBYUODLM
         XEs7BCScBuxYJbri/fGp+haPNLBK/csjXY+bSylB5DS16dHe466vsyQev+8pqBXXWprc
         6rQoKdZLdksPwYG0L1gY8a9qJuJUDBtLN8/wO00NvOIECFDkX/FiBsM7HSnSr7YQ1CTL
         tHESGe/n+jqO1ujEPVyWGfp3oeirP3X9PxtM/qTwD0CU7guY/DaIKQ2dTIQWwHQNi49B
         dAZw==
X-Gm-Message-State: AOAM532h0QmLuSPIfntWmAi0s4MKleRtntc27+kXmEc0iXoJ2AF6jWD4
        s3BkxtWPLye+1DL/3IoLZwY=
X-Google-Smtp-Source: ABdhPJzgc7SpdFeDdPuwJDjdGXknN1niR+cQ05i3OotZKfqvCURf3x8iyVce/Ffv57k9aLJcQ9L7sw==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184mr1042971wmf.26.1599117893024;
        Thu, 03 Sep 2020 00:24:53 -0700 (PDT)
Received: from [192.168.8.147] ([37.165.127.159])
        by smtp.gmail.com with ESMTPSA id a127sm2893718wmh.34.2020.09.03.00.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 00:24:52 -0700 (PDT)
Subject: Re: [PATCH net-next] net: sch_generic: aviod concurrent reset and
 enqueue op for lockless qdisc
To:     Yunsheng Lin <linyunsheng@huawei.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linuxarm@huawei.com
References: <1598921718-79505-1-git-send-email-linyunsheng@huawei.com>
 <CAM_iQpVtb3Cks-LacZ865=C8r-_8ek1cy=n3SxELYGxvNgkPtw@mail.gmail.com>
 <511bcb5c-b089-ab4e-4424-a83c6e718bfa@huawei.com>
 <CAM_iQpW1c1TOKWLxm4uGvCUzK0mKKeDg1Y+3dGAC04pZXeCXcw@mail.gmail.com>
 <f81b534a-5845-ae7d-b103-434232c0f5ff@huawei.com>
 <1f7208e6-8667-e542-88dd-bd80a6c59fd2@gmail.com>
 <6984825d-1ef7-bf58-75fe-cee1bafe3c1a@huawei.com>
 <df8423fb-63ed-604d-df4d-a94be5b47b31@gmail.com>
 <041539d7-fb42-908d-5638-49ca51d758f1@huawei.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <1c01f9e0-fde4-a8ee-caa3-598738a9a98d@gmail.com>
Date:   Thu, 3 Sep 2020 09:24:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <041539d7-fb42-908d-5638-49ca51d758f1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/20 6:14 PM, Yunsheng Lin wrote:

> 
> It seems semantics for some_qdisc_is_busy() is changed, which does not only do
> the checking, but also do the reseting?

Yes, obviously, we would have to rename to a better name.

> 
> Also, qdisc_reset() could be called multi times for the same qdisc if some_qdisc_is_busy()
> return true multi times?

This should not matter, qdisc_reset() can be called multiple times,
as we also call it from qdisc_destroy() anyway.

