Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA71C54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EA920714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kgtAL3A/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCWB2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 21:28:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37394 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgCWB2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 21:28:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id h72so4474806pfe.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 18:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AiAyav6BwFSr29hdXCFnFBhxNCa7Q5OcMKiajqm24bE=;
        b=kgtAL3A/6q6jkcurZgQ/kVVXu6f85IzCnxR0nwV9strvNuVnOnmy4sxdJ0k0ru7kJc
         aI4BvhATkLGVtBTW1/B4/RhGO5LO3n1BjpiwKCiTn2PGnbmxFfUtuONEoPBmWdaPvBAo
         +Oxb3JMtGWXYsuNKG2e4JYF7e+htB9ANmvl1zYsE7Z6L5romyFG/jag1HvVFx6j+hyOo
         xH3shSVK3thQEQweHvwtBf83/3468I/gEP1ARm9iQv1+Hb9F6s/5K3dSd7raIRur0I7L
         esl7ic6dt83E9FuT0apPYzZDSViZlff2zT552qXxcSeCESDxns4hTRYwm4+xRJnfhikr
         1Biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AiAyav6BwFSr29hdXCFnFBhxNCa7Q5OcMKiajqm24bE=;
        b=bLKnVIuQDJIVpv8VJw6xyEQkxQOsXab1dy9XvTTQBiWbnuwdEIt+JeaCe8MBgtvO6y
         CVyQkeVSjVw0ngNU/L5ENsOLTpdHARvAJnfQM0jxIhYouzvXW3Px9YNdF/HIAK3uXU3s
         qArubbEz9Bv5DrYuA/LoHx/PF7BGhB6T5gY36UkFb4UGOZzwwNdOfO+gG5fL4k1PU6Ru
         zk7qw4ULSpnO0Vg2LsUeZ1RfwECRdfhLwHcNAgu1MG2jikkGfkQgPUoTn9niICbGKE6Y
         uY6MhfOO4N4IK9wyzhoBQjB7iuqHC1b/ru5lFETqSeo9va4NZwwmvgyPHuErj4i6bLk1
         dMfA==
X-Gm-Message-State: ANhLgQ0GyDrOOaOV8CfIRxxLOa/E5np3tkkKYCDKcgn5r2ZDXcC92dFe
        CuSWZwSPEq8QKSj/yvKAH+sLoeP8UyYAKg==
X-Google-Smtp-Source: ADFU+vsBiyW0sX3RAY4WyAPXLoLQgRCGZpgI/fXucknlS62yFbmqVtt4Y5o8sFEPdrgT4rTI7yKCew==
X-Received: by 2002:a62:2a8c:: with SMTP id q134mr10146989pfq.35.1584926908504;
        Sun, 22 Mar 2020 18:28:28 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id m11sm10334604pjq.13.2020.03.22.18.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2020 18:28:28 -0700 (PDT)
Subject: Re: [PATCH 1/1] io_uring: Fix ->data corruption on re-enqueue
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <c8d9cc69995858fd8859b339f77901f93574c528.1584912194.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <be427cf7-78d4-7e19-bc16-25aeb0ab33e5@kernel.dk>
Date:   Sun, 22 Mar 2020 19:28:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c8d9cc69995858fd8859b339f77901f93574c528.1584912194.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/20 3:23 PM, Pavel Begunkov wrote:
> work->data and work->list are shared in union. io_wq_assign_next() sets
> ->data if a req having a linked_timeout, but then io-wq may want to use
> work->list, e.g. to do re-enqueue of a request, so corrupting ->data.
> 
> ->data is not necessary, just remove it and extract linked_timeout
> through @link_list.

You're missing a Fixes line again!

-- 
Jens Axboe

