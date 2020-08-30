Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AEBC433E7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 00:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51AF32076D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 00:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="v39DJi1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgH3AeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 20:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbgH3AeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 20:34:15 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80877C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 17:34:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id l191so2301451pgd.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 17:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wRsdXQOoZs4yYt+Nf5Gy2Ldf3swM1iC++OefVgYyX0s=;
        b=v39DJi1E/yraMAnVunh60K3sIDnBghmBrGk8y6BbCaeJer1nZdesStPc7IKrUDiMix
         jOrokI7kcjuCKdDtgEE8A7AvLmw41vgtFIrZKBKluFy5EW7RspscQT488RbRqnBCRTVN
         2eiNPQPUfffhonzWylRKNdFxE59QCYAu5u52Rs8ThvDRJmbEtkOhC33MrHWf64QMKuNf
         aLeeZYFzo9mzzFe1Kf1Hc2q7Dsy6EW+1eRc7mdH21fWk20yaa22q2tvqw5I1C2cN7Orc
         dTgXqxnggcZ2hgrovkX7cPw+Hz3Gm0PlbaK/AfG8SGV+OfCM5u2Do1GG7gIjwHzwyXEL
         DpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wRsdXQOoZs4yYt+Nf5Gy2Ldf3swM1iC++OefVgYyX0s=;
        b=EXsPEFNieO+hQqHpm50aa51DiqIigQ7zJYXSjodoBzZgqiPcr2atOMT4OuSz0sE0Xw
         rOntY7/Z4JDs/8bemYCXfyloQidRzeBpUj5UfPDqyU3Pk+/c6Y37rZQQhDbpO4kn0NJ/
         aE+kHgf+zHBZCas05NJO39WIS6BlvPNEuq9RSML8pygophWHqVmUT0az4Gvfhc5DkOiP
         IgeoGP5E82Eyt6OrMqBx2fFcJ1U5OC3yRTe9ksi2NsMK7/mY9JMoxAfY1ZwNMErgF3Xh
         zUCmv8ypG5Qehh0n+w+MlRSy+OER+W9yOv7uw6llLAFoopzngReckapyoMx6ZWdBVjpG
         /BXg==
X-Gm-Message-State: AOAM533l5V0JfsJa6G6apxM5BoQihAf8AAy629O3sQqPITSUv2B5s9ig
        8fig9bZgcQP4o+stb4ZJtQzSSg==
X-Google-Smtp-Source: ABdhPJy5HsE91zNZgLLhC/SB0NnDxFkJRhtbqIjkRErPweW605gkmrMve/CveVLIfKZ2hdp3MwZu4A==
X-Received: by 2002:a63:62c7:: with SMTP id w190mr3917110pgb.25.1598747654101;
        Sat, 29 Aug 2020 17:34:14 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d8sm3460750pgt.19.2020.08.29.17.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 17:34:13 -0700 (PDT)
Subject: Re: possible deadlock in __lock_task_sighand
To:     syzbot <syzbot+6e8f5b555cce8fac0423@syzkaller.appspotmail.com>,
        christian@brauner.io, ebiederm@xmission.com,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        oleg@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <0000000000001bdf9705ae0d151b@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d104d06a-393e-0d47-ef6d-2f1010c9c2b3@kernel.dk>
Date:   Sat, 29 Aug 2020 18:34:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0000000000001bdf9705ae0d151b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is already fixed, and it went upstream yesterday.

#syz fix: io_uring: don't recurse on tsk->sighand->siglock with signalfd

-- 
Jens Axboe

