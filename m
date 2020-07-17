Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838CEC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B482067D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgGQR4T convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:56:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42742 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGQR4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:56:18 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jwUal-0003bm-Od
        for linux-kernel@vger.kernel.org; Fri, 17 Jul 2020 17:56:15 +0000
Received: by mail-pg1-f198.google.com with SMTP id j9so8411358pgm.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DJeYw43KCdF1n+mtxqHrWGu9uDmkgMx6dDVvN1r/iUI=;
        b=BMjaUd5kHGrXmTxoOFW8pUVh8aIDk2P50XGhMdCOMcgN6ACjU+9JvCGImvWh2qsgwv
         F3fhVs1dj5uZUCnRg9eGORD5sCz9KQG/jhinu+X6YKnnG71D6LGLMAuciKacRtotuXZn
         +t4S3xQ8l2t3jnzR2VLO/hs6287QN7mvQWqZrLBCjt0q5AeNEMS2bPdL+AsyBxjT2ck3
         8KGAf7dKLbR7y1HUiN7W8+uxFmDdPoRoQsWCt0ou5H4/Zw+x+Ru+pIV9u4Hf9jYm2+im
         SPRaxb8UG8IBv0L5yy8nPlvPj0tYfXlTV+ClpQ7gxjj6Dj6Bmk1T9H5BrpRxDXgNfCP8
         Wgtw==
X-Gm-Message-State: AOAM531lZsGt0TqDbyKwY53KZd2ZYdK02TAbie99qUQEVggAzYMQz2nk
        Hg2ax8PLKLktTm0nCnCb1X04XD487V8V9mHZTBbsg+UHTITJD8S67J3skhC6uZNpErlTbiJkqWD
        Z5KC4BXo1Hns43c27RIHlw1OCSjs1Blj6CcT8gg6Jzw==
X-Received: by 2002:a17:902:a412:: with SMTP id p18mr8397696plq.283.1595008574082;
        Fri, 17 Jul 2020 10:56:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfTo9D7lyFkDMei5LDbgFf/qwVM6msV/kFw7ZA8SiHACyAuV9cXxTJL0fSYj34hSeq6uLdww==
X-Received: by 2002:a17:902:a412:: with SMTP id p18mr8397678plq.283.1595008573667;
        Fri, 17 Jul 2020 10:56:13 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id b18sm3514062pju.10.2020.07.17.10.56.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 10:56:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [Regression] "SUNRPC: Add "@len" parameter to gss_unwrap()"
 breaks NFS Kerberos on upstream stable 5.4.y
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <650B6279-9550-4844-9375-280F11C3DC4B@oracle.com>
Date:   Sat, 18 Jul 2020 01:56:09 +0800
Cc:     Pierre Sauter <pierre.sauter@stwm.de>,
        matthew.ruffell@canonical.com,
        linux-stable <stable@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-kernel-owner@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CCF13E29-7B8B-47B3-A8D0-1A6E0E626BA6@canonical.com>
References: <309E203B-8818-4E33-87F0-017E127788E2@canonical.com>
 <5619613.lOV4Wx5bFT@keks.as.studentenwerk.mhn.de>
 <0885F62B-F9D2-4248-9313-70DAA1A1DE71@oracle.com>
 <4546230.GXAFRqVoOG@keks.as.studentenwerk.mhn.de>
 <650B6279-9550-4844-9375-280F11C3DC4B@oracle.com>
To:     Chuck Lever <chuck.lever@oracle.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 18, 2020, at 01:34, Chuck Lever <chuck.lever@oracle.com> wrote:
> 
> 
> 
>> On Jul 17, 2020, at 1:29 PM, Pierre Sauter <pierre.sauter@stwm.de> wrote:
>> 
>> Hi Chuck,
>> 
>> Am Donnerstag, 16. Juli 2020, 21:25:40 CEST schrieb Chuck Lever:
>>> So this makes me think there's a possibility you are not using upstream
>>> stable kernels. I can't help if I don't know what source code and commit
>>> stream you are using. It also makes me question the bisect result.
>> 
>> Yes you are right, I was referring to Ubuntu kernels 5.4.0-XX. From the
>> discussion in the Ubuntu bugtracker I got the impression that Ubuntu kernels
>> 5.4.0-XX and upstream 5.4.XX are closely related, obviously they are not. The
>> bisection was done by the original bug reporter and also refers to the Ubuntu
>> kernel.
>> 
>> In the meantime I tested v5.4.51 upstream, which shows no problems. Sorry for
>> the bother.
> 
> Pierre, thanks for confirming!
> 
> Kai-Heng suspected an upstream stable commit that is missing in 5.4.0-40,
> but I don't have any good suggestions.

Well, Ubuntu's 5.4 kernel is based on upstream stable v5.4, so I asked users to test stable v5.4.51, however the feedback was negative, and that's the reason why I raised the issue here.

Anyway, good to know that it's fixed in upstream stable, everything's good now!
Thanks for your effort Chuck.

Kai-Heng


> 
> 
>>>> My krb5 etype is aes256-cts-hmac-sha1-96.
>>> 
>>> Thanks! And what is your NFS server and filesystem? It's possible that the
>>> client is not estimating the size of the reply correctly. Variables include
>>> the size of file handles, MIC verifiers, and wrap tokens.
>> 
>> The server is Debian with v4.19.130 upstream, filesystem ext4.
>> 
>>> You might try:
>>> 
>>> e8d70b321ecc ("SUNRPC: Fix another issue with MIC buffer space")
>> 
>> That one is actually in Ubuntus 5.4.0-40, from looking at the code.
> 
> --
> Chuck Lever

