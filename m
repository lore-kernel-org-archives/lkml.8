Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B711DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3C82053B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgENSWC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:22:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36167 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgENSWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:22:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id w19so19337584wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 11:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=IC3XDAaXwRIF534HLzVFyxJuQdymZeHXyo2fYM9SygA=;
        b=DdUR+1pLAj3x93jDf8OkYUjedrzGRZkU5gTIUoeUjPu9wedzt82feHqDyQl1/QsAFp
         m6xrvXe2sBKmqHMxQqH3N2icEkCW++czIQ+qfa5UAQE/qkZZxXhesOIhAx3L/K3F3QOI
         S3QjabdlgpBjJELN0uc4NJ/FIJhPO3NHygeVZ8CyndP8aRjTT45pFmYoTa21HzkHbyZG
         3LFZ7LLM4O/loSF3Q78WHx+m5rCRkQfAGU9JEVc5NMjUDy8uQsFTIY296OSEUcC5G4uE
         jxZ6S+S4KCAZdy6ujpQVKketJvuZPdbP6yV/2Pj+I/aJKF8c6dxjIsOG/ssdFEEm+48N
         9R3Q==
X-Gm-Message-State: AOAM533b6K8mlnXg44kTYq5smRtrUhiqcSV5eXxAfyPy/zPyZ3RjRZV9
        pPdC7jmVVT73W8Ok3VBH+3rxnHHu7es=
X-Google-Smtp-Source: ABdhPJw+boPryPkzkMQnYp4TNVvqlRiyqRg0ebKNi901yuRPu3ewuRWeIUW+/wRAAVXw+T/1Lj2qvQ==
X-Received: by 2002:a1c:9694:: with SMTP id y142mr13856371wmd.52.1589480520347;
        Thu, 14 May 2020 11:22:00 -0700 (PDT)
Received: from ?IPv6:2a00:20:401e:4388:1d59:5442:feba:f46c? ([2a00:20:401e:4388:1d59:5442:feba:f46c])
        by smtp.gmail.com with ESMTPSA id v205sm23921663wmg.11.2020.05.14.11.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 11:21:59 -0700 (PDT)
Date:   Thu, 14 May 2020 20:21:57 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wjpb-h9Z6O6o_7GkqCV1N-qQhagVJxpYZurYQR+eLkuEg@mail.gmail.com>
References: <20200514170451.1821723-1-christian.brauner@ubuntu.com> <CAHk-=wjpb-h9Z6O6o_7GkqCV1N-qQhagVJxpYZurYQR+eLkuEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [GIT PULL] thread fixes v5.7-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <1C5DBE84-3E8F-4478-8188-8A09A527B195@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 14, 2020 8:07:59 PM GMT+02:00, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Thu, May 14, 2020 at 10:05 AM Christian Brauner
><christian.brauner@ubuntu.com> wrote:
>>
>> This contains a single fix for all exported legacy fork helpers to
>block
>> accidental access to clone3() features in the upper 32 bits of their
>> respective flags arguments.
>
>I've taken this pull, but I really think the minimal and more
>straightforward fix would have been to just make do_fork(),
>kernel_thread() and clone() change the flags field from "unsigned
>long" to "unsigned int".
>
>I don't see why that wouldn't have fixed things, and it would have
>been simpler and more obvious, I think.
>
>Doesn't matter, I guess.
>
>                   Linus

Seemed weird to me to change something that's been exposed to userspace for that long.

Christian
