Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D5DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 02:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E3B206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 02:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iGUfgGuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHLCoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 22:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgHLCoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 22:44:14 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49558C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 19:44:14 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id u20so281521pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 19:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0tE7MUBsHJE0Mpx1+XVH5JlNGfMN16YjoWq2ffNV8zc=;
        b=iGUfgGuLhp5glfj9+Q0pWAZxeqRc+45tVwKSXeadF0a/5VRBYSXZvzBjI/pIVeGlaY
         r1jI++wR9oMMv/M07yVeSZEOdZVtzqAOPdYlBpG5XGo6OH0muGHWFxAVKCthjOlNRJHX
         3gx3vhWjA71m9uwrn2dkm1NM+Kssj/QgzRu1no70ml1wAF88WA6TohQ6gN+CZQ2619nx
         WK6o/OxsEA9Jet9ONq433Sq3fD5uD9HhGAIWPWZr3HaPHODpZlQOH3Serg9yTtSECxIi
         0Kxvea5B+5SHfJigBC5SznJ5QKK7G5jER/Rnuwx6So2XCjXpv/u+vIHqJgVAOFFBsloU
         o7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0tE7MUBsHJE0Mpx1+XVH5JlNGfMN16YjoWq2ffNV8zc=;
        b=PcRj+dwylpUwNxswULuKXdZ30xoMieSgZKtUgZQcUQbqtnCDkj9p7FCKxJQyCTh4At
         26PBGRsB8yfuJN2j0dDuytcV6MBs+FDvdifWZgL6JRzAYVxdrj54EJkp6/DpYT9cygnd
         sVWJrHfJtE2TJ4+q+cXlal8DsqaRJtP88raXYg+dtx4e4UMng72T4DxqQWMvvkmnv56r
         9GIpYaqsk3umYGzHFc6rx0GOXR95RxOKCdZuOq2DZMUA3S85LmjFH4gzAvzIg07mJgVM
         okMwseBtf4/CL/4afq4+eu972CYbuhPR4yDW4aNWdhDrhl1c9Yy/DVep03B/CLjwCTGS
         GFnA==
X-Gm-Message-State: AOAM5309dVaCQjGyWRHI8yJso3FiF4hMjOvJAK+XVzkhJYJgWQa9tQr0
        JJn/C93eHd4+WwXRZrLJqc717eXujjY=
X-Google-Smtp-Source: ABdhPJxIC7s/N3U1+eyQRUwRFQ1XN7DSLT80VYkwubWr1q+bYuMwnlIB4hpElOY20MAM3xaNdrea/w==
X-Received: by 2002:a65:63d4:: with SMTP id n20mr3349103pgv.213.1597200253567;
        Tue, 11 Aug 2020 19:44:13 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 196sm455852pfc.178.2020.08.11.19.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 19:44:13 -0700 (PDT)
Subject: Re: KASAN: use-after-free Read in __io_req_task_submit
To:     syzbot <syzbot+3c72ce3136524268d7af@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000e5b60405aca4c517@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e6759a68-4789-e2de-30b4-8be0d34a099d@kernel.dk>
Date:   Tue, 11 Aug 2020 20:44:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000e5b60405aca4c517@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: KASAN: use-after-free Read in io_async_task_func

-- 
Jens Axboe

