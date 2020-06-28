Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D05FC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 13:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3993A20760
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 13:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qbBv1+mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgF1Nit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 09:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgF1Nis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 09:38:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268FCC03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 06:38:48 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u9so2461503pls.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zZdrGGRNVEUyYpyE4XpRtKEKUsPRvdzWcXaxhLTH4S0=;
        b=qbBv1+mz3Hgv6YC6Zsc3njlYD4hxw++5rZYcJXU5wWzCdFrKHf6WsZQarA0hj2YuG9
         PozKqSXUxd/GHGY5d+McnfWxFjkRkUyxbPVr7H9h49Ocb0QKQDcXd+pnZN7sFEvOFqUt
         ganJ0mp5NOYjvp68c2D37QVGKgsLRgWFFgV9tW92wUdKEQE8hBhTPW4MfVOMHvhybhrZ
         /++Mqh5kZfAsGY91o3M55SOW0fKLgeBp6c67jtbG138kqHfI+EJF8g7fjcgu3ajZq7H3
         MbSxDqG8kR5v0seQxMiTQeGmULvhXxRIb2VmDyP7dKeg2Lzmw1RkewEmkarh1m7qDZJk
         0SWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zZdrGGRNVEUyYpyE4XpRtKEKUsPRvdzWcXaxhLTH4S0=;
        b=BWyixlkgTB0AUjv+nmUAK3QBOOTx0RolO/tG4L9kacSYrldxyRxZk+QcckhgAGo7ef
         kG9LZ2hUGnOWrzkUisDVpLXlT111u1xGCY0Dd+dpUN00B1+Lb5XR4Y/HEfQNOBL/tS2r
         aHaIxFHdiPHjzgtXFb0AwvqMBLi9ed7oQ37NTjqOIcQkoSX4EUNU9HLvA97s42872XQn
         tV5iNX3rqcYYYoR2WkGD8vQ2ZpnXDDALG4PErschZWcefbVuqwQPRrQ2TS432L5I8ikA
         UdWlA+s0iSk1Nf2Gmz8Bt/9DKlvPgY3EjlL6Gpw+gmA5/CWIo2bG5hO4+7SftVkLNIyP
         BSZg==
X-Gm-Message-State: AOAM531bMe/NOxKW2LTSBC1iOwIAZKKIAkdaEP//hDpRHBXkSRgxWT7F
        YZ1Ab2R/WNHp1dCtfW0uhyj2fg==
X-Google-Smtp-Source: ABdhPJy17YzsoxEm0RSV+7ui4Hr5W5kyqP1uAIoSfg/NrL6etyCSe8XD2tq/Q6etV8glm4iwEPu6qQ==
X-Received: by 2002:a17:902:a606:: with SMTP id u6mr9735698plq.94.1593351527599;
        Sun, 28 Jun 2020 06:38:47 -0700 (PDT)
Received: from [192.168.86.197] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id o23sm1050905pfd.126.2020.06.28.06.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2020 06:38:47 -0700 (PDT)
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <20200627090740.683308fd@canb.auug.org.au>
 <6920f023-5909-6ebf-606c-dbf467a31c7c@kernel.dk>
 <20200627015605.goc2btyq6z3wwb5z@chatter.i7.local>
 <425cdd05-4123-c1ec-ad82-990eceae0b5a@kernel.dk>
 <20200627151237.72b68e8b@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ae1dc26-dd5d-5f9d-ca81-8fb3550a0faf@kernel.dk>
Date:   Sun, 28 Jun 2020 07:38:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200627151237.72b68e8b@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/20 11:12 PM, Stephen Rothwell wrote:
> Hi Jens,
> 
> On Fri, 26 Jun 2020 20:25:31 -0600 Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Right, but that's what git format-patch does when the line is long.
> 
> I just tested, and "git format-patch" (for me) does *not* split those lines.

Huh, I could have sworn it's done that for me in the past, just like it
splits the Subject: line into multiple lines as well (that I just did
verify that it still does).

-- 
Jens Axboe

