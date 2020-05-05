Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3025DC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08BF4206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgK6KdCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgEENE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgEENE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:04:27 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CD5C061A0F;
        Tue,  5 May 2020 06:04:27 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 18so845724pfv.8;
        Tue, 05 May 2020 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tY2Tzay3CtpKrgEwP5AMH50BGKklVo94Ad6zROIjzd4=;
        b=hgK6KdCe1MUlx2uapDcoAkSv8U6euhMHtQyQLqeUl+c5XDoAzf6gXknvLILCI25g16
         iK4YR89e3F4MKtdDHWeY6tcQR28GzqMMOX6fn7Mbq9FYgojY+XNJuB0N2262dx+Url70
         4PAwzESvGxgPCQfytGGsrQv8Lt+j0roH+KFc1LdCQLLmCG0Vp6UDNpd/UP+YRp3nXVwv
         QUp0bJos+4P5PMicYhfEXhqmZWyn9UT9cGGgFnT9O5TFYX0uZgEzh2yRJX5D9dGkdeRj
         rLrwHViuhzyGZhrMEkqwNZlUHYnZ68ulDJX7DwkDwmTQ+zWxA0rRyzueNon/WjoO3ePP
         Hbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tY2Tzay3CtpKrgEwP5AMH50BGKklVo94Ad6zROIjzd4=;
        b=jSYAkqrlkW18NNr+w/FfPRUxgD0itR4rPNGlmgwEBRrvzuherK1SO5UVoJ+aWblz+F
         hYdUDbmVQ6v7TYP96mRn49FSEeSGFH1D789BM4pm3ihnAbDNRAsIGYQEBnXR2h7ndzY0
         0cXQzNFqNahSpgU0NzBZLj720r6FXzlNiJ+E1V61M1uSQnPuW9ZIpGB9sSN5GbSrfqUc
         VhnBs/7uLTS6wCsD8+HnD3gTbLDM548BE/58yhi6xTq4rBDUmBglCmSR4YU5DuvhfY5a
         1PjpJSpHjVyx8bK0MNeTYY8J2wKGnfa2eAWN9KnHWb24NZ3ulWzBsCnh4qMH9dqIyQND
         yGfA==
X-Gm-Message-State: AGi0PuYBnkiOOug/p8xrQiiv+8wsyFd34Kf7qnYjB0+3JasjyJW2qJc4
        CR3dj8ZFMY9FsStU+xXJYB8=
X-Google-Smtp-Source: APiQypIkmjaLT9hLhrdtgGzDP78a4P++lfdDp873GTeMiiFe/EbuahrP7N0IemUKzf2G7LGjNZu+4w==
X-Received: by 2002:a62:1c89:: with SMTP id c131mr2903107pfc.164.1588683866499;
        Tue, 05 May 2020 06:04:26 -0700 (PDT)
Received: from [192.168.1.7] ([120.244.110.63])
        by smtp.gmail.com with ESMTPSA id b12sm1953307pfd.165.2020.05.05.06.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 06:04:25 -0700 (PDT)
Subject: Re: fs: jfs: fix a possible data race in txBegin()
To:     Markus Elfring <Markus.Elfring@web.de>,
        jfs-discussion@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>
References: <5ef374a5-0e2e-5c74-a827-0148c384f6e3@web.de>
 <abbb03ec-7ce3-08b6-7d08-420743067f19@gmail.com>
 <fa6fabec-8cc5-fc62-657f-3794e9405fac@web.de>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <e6ec72e5-e1d8-cf15-ddfd-2e335c5de962@gmail.com>
Date:   Tue, 5 May 2020 21:04:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fa6fabec-8cc5-fc62-657f-3794e9405fac@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/5/5 13:12, Markus Elfring wrote:
>> I am not sure how to add the tag "Fixes"...
> How helpful do you find the available software documentation?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=47cf1b422e6093aee2a3e55d5e162112a2c69870#n183
>
>
>> I need to find which previous commit add the code about txBegin()?
> I suggest to take another look at corresponding source code places
> by a command like “git blame”.
> https://git-scm.com/book/en/v2/Git-Tools-Debugging-with-Gits

Thanks a lot, Markus.
I have used "git blame" to find the last change on the related source code.
I will send V2 patches, thanks again :)


Best wishes,
Jia-Ju Bai
