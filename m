Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BB2C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 18:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E3320768
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 18:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Aai15vFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgIISau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIISar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 14:30:47 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906A9C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 11:30:47 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id z13so4238234iom.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 11:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=98xyvtYgbwa5J67c7RkI6GnQwliGFXe74W0JhOQBOmc=;
        b=Aai15vFl3dYqGw9K5b3xK4POAF5zorYpaKKRyIxIZqV4MkjapQJdc5WoBCxIdDvoQe
         7FdlRAedwzY1qpqwlJ5d+oVkEoZFtbyilOo5PeMvP4vfl//XjFD28AIWbmbRXihnb49x
         JbVoj7qo0eWkzJVqnZ3EfR9rqCRwG9dCMJoxkLi4ToOLHhfZC3SzjOM+82YB9SjmG1R5
         a33hxHQK4Io4do/ldHL0Nwp+Us6ESgUxv94eNJDwEE8kOAIZj98CWh42I5BQfrPOtm/D
         GfnSrPywZHKaSWgiqluDNEtHluhP8WGr1YnzmI21OdCOYBTano9T1NdzUMKvE3YznXEE
         +6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=98xyvtYgbwa5J67c7RkI6GnQwliGFXe74W0JhOQBOmc=;
        b=QAOtj/4J6Gt+ULM+QO7Ccggujti5QCKGsobs5739Ch/RNn+FNsTG2XNgqHvLoiP36E
         9zVxTeoIvn5YxAQ6ff7TpkB8ytE+YudhkfZl5l5t4lADN+wCSSBVd510rrd4PLyXEl11
         wAuEQwrEHavHN6VBCWrfv79IT39NekNlklfeOK0INK1HX5lWpXM/K0NxkPILG0hN9l/+
         9l5Qn4ThRDEgzpFV1MfX0mBVZJvg1RVkzHEMb7PdLolcvGw1a10Z2wzVeBgkqj2A/sE2
         eBAFjuQJCIYuEpZ873J8wE27yjjGGu1f8x05SfpdWCVQS/jzKb3N2S5a+QolSy++AlMU
         ZH7A==
X-Gm-Message-State: AOAM533W8HBTV2aaPswQk94yYNYqBYmf2/2Kengn5Nx9co0Vf7hMyhTR
        /Rxnt4gzHWDjlklhCsO2Uf5+4A==
X-Google-Smtp-Source: ABdhPJzDQCDM7qsjK2rY35N17lqTgsC2hAs5QECTlf9biMd54YdHkaHJRtjNBTH3FQACUVf86OCMNw==
X-Received: by 2002:a05:6602:2f88:: with SMTP id u8mr4410307iow.175.1599676246841;
        Wed, 09 Sep 2020 11:30:46 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u9sm1501725iow.26.2020.09.09.11.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 11:30:46 -0700 (PDT)
Subject: Re: [PATCH for-next] io_uring: fix ctx refcounting in
 io_uring_enter()
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200909151900.60321-1-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9080c3fa-a726-b664-f634-0ea7dfda80e0@kernel.dk>
Date:   Wed, 9 Sep 2020 12:30:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909151900.60321-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/20 9:19 AM, Stefano Garzarella wrote:
> If the ring is disabled we don't decrease the 'ctx' refcount since
> we wrongly jump to 'out_fput' label.
> 
> Instead let's jump to 'out' label where we decrease the 'ctx' refcount.

Applied, thanks.

-- 
Jens Axboe

