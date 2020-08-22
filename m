Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0D5C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 14:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6452072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 14:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="Wbkz2zA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgHVOWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 10:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbgHVOWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 10:22:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4115C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 07:22:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a5so4481034wrm.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 07:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5HFVo2zL2bsI/Q9rxIrK2pe3dbH+0GlhbWJVp1cCskk=;
        b=Wbkz2zA+bdCvXZ3rsLg7F0NkvvbKjFGx0Fwa3Zu06+1hpw2dEm/jvRid8vhtlSNfB+
         aPl3Pdn9/iqjpCH7R5fz7LUKdSff29/ZZ8IO7KLS9eYLANNWtwOapGpYfZCcxcOqhyDn
         jE/LbyZE93/5JI/BDmGC4H+QaqEu4NudgYpbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5HFVo2zL2bsI/Q9rxIrK2pe3dbH+0GlhbWJVp1cCskk=;
        b=PieRhOjav8LiwSJSC5/1g1WoWtILE1DZiDmm64AGCxV44l3NaViLrAeHti8EYk8HS4
         O/01gA/NDbycUwc0kYGDBG4EYUm+P1UNzkMuFWqY+BcDSqNq6KZYqtn6CTVQPF9U/NFj
         1HkqFle0cutVOrqgThvzEzFMROFG5m2AB6EeyseQgGRSfAtCfZ+PktBKdXuZO4cmkedL
         KJrTcsyYdu+E1coIEybl2GTss7PfdAn3Bd2PnX/b7+KKqsRj4KOrJ2MuFs5ZZpp3RCpx
         RyobVzBV6e0VC1XdksOmdxTSHapJ3P+3EvyYZ60TBL2dEDn645Sq/oQf1pXNQGxj2Z2x
         zIEw==
X-Gm-Message-State: AOAM530kc6IkFUrUiwxjhLRW0kxq2+7cauL4Mbhx1JbjPjVVnAUtQ0qt
        eOGRx2AhyPgeEbmOjpDpYPecQA==
X-Google-Smtp-Source: ABdhPJzJZyqNjdHMGQ/nkBrB4dh3Vqvf0CzIf2KNRQ9WTeuU0RPG+NzYRmOQyJdoAUhibiQ2J5s+Rw==
X-Received: by 2002:adf:e60a:: with SMTP id p10mr5303146wrm.295.1598106149913;
        Sat, 22 Aug 2020 07:22:29 -0700 (PDT)
Received: from [192.168.0.101] ([79.134.173.43])
        by smtp.googlemail.com with ESMTPSA id p17sm13328547wra.81.2020.08.22.07.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 07:22:28 -0700 (PDT)
Subject: Re: general protection fault in fib_check_nexthop
To:     syzbot <syzbot+55a3e617aaf04b962a3e@syzkaller.appspotmail.com>,
        davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
References: <00000000000086e96005ad5d17a7@google.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <6d82801a-8704-9198-67d6-12927e21f0fd@cumulusnetworks.com>
Date:   Sat, 22 Aug 2020 17:22:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <00000000000086e96005ad5d17a7@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/20 9:10 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    18445bf4 Merge tag 'spi-fix-v5.9-rc1' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=162cbd7a900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a0437fdd630bee11
> dashboard link: https://syzkaller.appspot.com/bug?extid=55a3e617aaf04b962a3e
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> userspace arch: i386
> 

#syz dup: general protection fault in fib_dump_info (2)

