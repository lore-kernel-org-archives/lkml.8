Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D667BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFDA920838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tO79DpjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgG3RqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 13:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgG3RqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 13:46:02 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F705C061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 10:46:02 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l17so12975390ilq.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Mjw46l0WiX2cgOgOB9HnUvadVnuzoTI29vrJPNcSYdE=;
        b=tO79DpjBf7dyEFJtFiuMv7DYl6NYwoM4SslJJRQr2CELhHlLvy1t0mj6zr0HNPy80a
         MEnLhW4EDL5MCV2lUcMEZBcNXPSuTL9BaA3Ix0Aoa/+ooD6lm0gVXYvW02BnmWTRKcU/
         0Plq72094GIXK6XFS14k1u1uzqAl6vhuX2vy4dsipM7KOO+rRwdlEmgiVSoL0BW0skfk
         hzHZ/QFxYz9HltfzvI6ZjG4cFQ19VCjoqyw67fIIHZk1sA5JMscy3+WEpIhM/j9Yut3j
         DYtWYatt/I/VbG/cpIjB83+29/KwM61PK8T8x2udZGQLMsAc0+aJopQ//FLWB92fd5ja
         ePtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mjw46l0WiX2cgOgOB9HnUvadVnuzoTI29vrJPNcSYdE=;
        b=Ie3LrosumCh0aXuAljsYLj5KBZptNv17RWHEXRgTi/ga/YOzFMb4XvkoB7l6Tlwcod
         f6ByriM8O6JGj69az7JFY42N30Y4JRxS7uO395rPtnb5BmxAOu7A8K1cXFoAjlDP+Qxk
         K3LR7vBRfTaAsy+FjCPbaJ6RbmK64loPyOmPtGlsaFP4OEwX/K9BYWXNPTVjFiC5Bpwr
         qtMGJNTOl09vuS4x4fYV8ZfM5ZrBJzNIcYiDreifvawlOeXUZNq5Lt8kGX2tQNqDhsIz
         GaGrW/isPv2QM+LVV9A3N0SOc9P7GdcXZve2kywp6F/DDe5L/BSs4/+qS/5/b1W1KG3w
         eXGQ==
X-Gm-Message-State: AOAM532nSAwl9o6r7fCOj5GdybQ61268kYidvCKe704kXV7IgN6Fc8Wb
        7mhYfhLjHmziSTYXut/cp+PXn8XTN3g=
X-Google-Smtp-Source: ABdhPJx36xWyE9IPUbIQe9q8bmMvshCLd0FNQ2JLoprKgzDBA8xzmDzIpKa+MAm4X6576CTI4BYjtw==
X-Received: by 2002:a92:46:: with SMTP id 67mr34706426ila.113.1596131161540;
        Thu, 30 Jul 2020 10:46:01 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r2sm3278374ilc.58.2020.07.30.10.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 10:46:01 -0700 (PDT)
Subject: Re: [PATCH] iocost: Fix check condition of iocg abs_vdebt
To:     Chengming Zhou <zhouchengming@bytedance.com>, tj@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200730090321.38781-1-zhouchengming@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a52ee19a-0d04-4085-7eca-0678bcf16311@kernel.dk>
Date:   Thu, 30 Jul 2020 11:46:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730090321.38781-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/20 3:03 AM, Chengming Zhou wrote:
> We shouldn't skip iocg when its abs_vdebt is not zero.

Applied, thanks.

> Fixes: 0b80f9866e6b ("iocost: protect iocg->abs_vdebt with
> iocg->waitq.lock")

Minor note, and I fixed this up, but these should be one line.

-- 
Jens Axboe

