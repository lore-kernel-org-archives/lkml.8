Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61B8C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 16:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCE42071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 16:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="l3Bv7Oj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgDYQAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 12:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgDYQAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 12:00:43 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F4EC09B04D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 09:00:41 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id m18so18086323otq.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aJowGujbLx9YHoHGEkmT5nMHlO6tS2Ov2OkuY7Bp1BA=;
        b=l3Bv7Oj5K54EczsINK6LMtMkBrM8JRDuQVy6qvWE0aLQG+12c06xYGyLwrdCDAeG+E
         U9Qy9NYrstNZtSmyifXYYIpz8xAHeYkfQ4zi0O4HWatXLreenCK0FEV7PtkRCMnr/IDh
         fxZFHa427ONVTI49NJqhU+YImD272y/laUDW+BoWFME1R2jIa7rwctETIj1Cm8Us0vWF
         cPc7igzFkbi5PoBiwFL9toQ7XeBWW5BIUMe2+zsITtqG5dAOhnazX9nkF8H1UP5h/Q34
         O9m7hpPF8Pncm/1bFwi9lHEFdxeBnhhHc5JcNCojfk7X5jsxAkbZOYYcvMb+h3xPhqz8
         /kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aJowGujbLx9YHoHGEkmT5nMHlO6tS2Ov2OkuY7Bp1BA=;
        b=YI+ucElCJ00kW1YwsyjlHUSt96zuB/KMSYrKZzPE2KlKLe+0W2SLiSAMsAKoDYLB41
         Tf0O/HKPa3jiDIjYtkZEPglajwTpBTh8x46SoLgHP7J2To6Y2dbaE0Vjm2ftHnNjC793
         quKFaZYOb5OiPr7NKwES4AL7UX+Io3ifvOiQXI7+EBc9pdgmAiG3DY5IU9KrVA3Q7gTF
         4DE3WgGE84SfRYXSU9eA5qNtZroS9LFvVkk7LkecpTMs/vn96kQdljrRGDZx6CmrL+v1
         LxxlwqhBbiiNp5e2puO4mKCbVe+JjFvNzKay0REtbCPXXe4js/8CvSpcInSV21SOkN+J
         FSQQ==
X-Gm-Message-State: AGi0PubPkNfQ3f/iBfRWvbrCRTuUmocT6GEQO/EfoKV9tje3JAdvAl8t
        SAtatD4bKuqsV8ZNg8P38VHMCg==
X-Google-Smtp-Source: APiQypIwBOSv8g6UXUE+etBF+ux/xNwS0QmCD3XxU/Hx2+E6+6uBzYCaWzUexCqyaeUOTvlPOhElkQ==
X-Received: by 2002:aca:b2d6:: with SMTP id b205mr10968150oif.137.1587830441059;
        Sat, 25 Apr 2020 09:00:41 -0700 (PDT)
Received: from [192.168.86.21] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id k205sm2545514oih.15.2020.04.25.09.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 09:00:40 -0700 (PDT)
Subject: Re: [PATCHv3 31/50] sh: Add loglvl to printk_address()
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
References: <20200418201944.482088-1-dima@arista.com>
 <20200418201944.482088-32-dima@arista.com>
 <20200420155237.1b6532c0d0c6940fccd1b762@linux-foundation.org>
From:   Rob Landley <rob@landley.net>
Message-ID: <92cf0382-bdb4-6966-5a77-2ade50fdc451@landley.net>
Date:   Sat, 25 Apr 2020 11:06:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420155237.1b6532c0d0c6940fccd1b762@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/20 5:52 PM, Andrew Morton wrote:
> I guess it doesn't matter much, as sh seems to be rather dead.

The j-core guys are using it.

Rob
