Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063DAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 01:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D72E42073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 01:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="IiDAf+dv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbgEYBwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 21:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388054AbgEYBwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 21:52:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EB8C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 18:52:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u22so6889068plq.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 18:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=WgNdEEm9CKkIv8HqkMAg2kmrZY4evhUWZB5s9CtlNLI=;
        b=IiDAf+dvMuve0czUMKQYCts2SBoBFEpkIgWQGTTd2wOSLIJaK19N0xGac9vsPJAdFz
         Z9DjMFJvgJxMsXZOq71sHrZqBcxDqCjS0HgYHu0Kxm1WtaXWZag1Hb48Q1FE+s2VMqfa
         UvH3o6pFdIreXxwQYqhya5gRTd4+kNnp5vRgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=WgNdEEm9CKkIv8HqkMAg2kmrZY4evhUWZB5s9CtlNLI=;
        b=PrKgBPG54Q9LV7+ecYfia3QsyCdepBJ8FnpngSt3NUfHYbOmwxSp1ZM5gmoxtP97ZJ
         0IRlhMy7idxLRhpUvRls08MGPKnYUnICpPGjLS3JlLI25Soq9CnEJ23MoNgU2cnkiTeB
         QFKl22wzGkwsvbvJ6Go7hwKB5dRVrseCTHEFqLzsx2GUsIXMEF2knrypoL5ss8WL1Y2z
         96+hoqNQqFDChruF/pJwJkdZSccaavk1QYFdbDKeZmfMFi6fxb5MVaotZU/2/G9M+gxH
         pjM5QJrQ73ZXSGPeWnV5KG8+gtHsG/cQWAE9FLKHXAcL7kAzkCCBhWoQRhkPYhgO/2oe
         sEjQ==
X-Gm-Message-State: AOAM531aNCZtyqWCpunN5V0hQdOfkVobiAd+ObJ5GeVd/t3PHfAQoUpx
        OLHocw0thLzlhRaRPicxBxkp2Q==
X-Google-Smtp-Source: ABdhPJzMbXmBQ7Qh18pPVQBEtsWB75q7eUQH4r1pxGBkj6Roh0fYzFLoEzjv21K/cBdToHTNpF9+bw==
X-Received: by 2002:a17:902:6b09:: with SMTP id o9mr24576526plk.100.1590371567787;
        Sun, 24 May 2020 18:52:47 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-b9bb-eae4-aa7c-e185.static.ipv6.internode.on.net. [2001:44b8:1113:6700:b9bb:eae4:aa7c:e185])
        by smtp.gmail.com with ESMTPSA id m15sm10436166pgv.45.2020.05.24.18.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 18:52:47 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Salvatore Bonaccorso <carnil@debian.org>,
        David Rientjes <rientjes@google.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ajd@linux.ibm.com, mpe@ellerman.id.au,
        syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com,
        syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com,
        syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com,
        syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] relay: handle alloc_percpu returning NULL in relay_open
In-Reply-To: <20200521152514.GA2868125@eldamar.local>
References: <20191219121256.26480-1-dja@axtens.net> <alpine.DEB.2.21.1912201100400.68407@chino.kir.corp.google.com> <20200521152514.GA2868125@eldamar.local>
Date:   Mon, 25 May 2020 11:52:43 +1000
Message-ID: <87ftbo232s.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Check if alloc_percpu returns NULL.
>> > 
>> > This was found by syzkaller both on x86 and powerpc, and the reproducer
>> > it found on powerpc is capable of hitting the issue as an unprivileged
>> > user.
>> > 
>> > Fixes: 017c59c042d0 ("relay: Use per CPU constructs for the relay channel buffer pointers")
>> > Reported-by: syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com
>> > Reported-by: syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com
>> > Reported-by: syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com
>> > Reported-by: syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com
>> > Cc: Akash Goel <akash.goel@intel.com>
>> > Cc: Andrew Donnellan <ajd@linux.ibm.com> # syzkaller-ppc64
>> > Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
>> > Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
>> > Cc: stable@vger.kernel.org # v4.10+
>> > Signed-off-by: Daniel Axtens <dja@axtens.net>
>> 
>> Acked-by: David Rientjes <rientjes@google.com>
>
> It looks this one was never applied (which relates to CVE-2019-19462,
> as pointed by Guenter in 20191223163610.GA32267@roeck-us.net).
>
> Whas this lost or are there any issues pending?

I'm not aware of any pending issues.

(But, if anyone does have any objections I'm happy to revise the patch.)

Regards,
Daniel
