Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155F1C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E278E20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQRS9wEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgA0SAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 13:00:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31458 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725845AbgA0SAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 13:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580148035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LISUUc5mSbwq4OOhAuP2n+5DZiLWcPcw5gQzbhBN3r0=;
        b=RQRS9wEUxc+4pyuat24bvH+M62RR1bvIeqphh0phXj1dtjfaU1GOD0bnY/HEZYPyrfWkz8
        dwMpTTNIUDx30haOWICziJmTVjXV8SWJZsBxX3hd4rlx988PPqkueZXHYMTU9Bm/JueFHG
        jC7IkOqVBHjra3liav6s3TmwROii1Ok=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-nvOQnH2RPY-jpmcll3XMfA-1; Mon, 27 Jan 2020 13:00:33 -0500
X-MC-Unique: nvOQnH2RPY-jpmcll3XMfA-1
Received: by mail-wr1-f72.google.com with SMTP id c6so6482078wrm.18
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 10:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LISUUc5mSbwq4OOhAuP2n+5DZiLWcPcw5gQzbhBN3r0=;
        b=rKWp+5VPNho7JAeECwAuU6AZcR38dUh4UtgTtXzgZJaH5MXqWVjQFCAJv6K6F55pgc
         gJwgvU42j8qT6C3UdaTuyiCVXqWPNsLYI47RAr/6XaTlAyxHuoMbzNvZLvoLaNwgA9Ru
         gduSsZvsAF6/AcpKl9WTAnC77P1/ALlmN40YnWJU6JSar0945TLd4I4AYYlElyzmz4lK
         W1FZ3LGPLkoNV676Za2sf2nTIMnX8OLK0fWK5L5JBJHz2TnC7ykSVk/hzluRjg6nh5Mf
         3NaavpTqZLHmRRuyXBER4lJlVdMqMy42VqLTmilkSq66D6iDRR+dFA3nFChDZQmIekZS
         +1FQ==
X-Gm-Message-State: APjAAAUsg36AvELD/lAAEWNL7gc732T37/t3pHnCZ8LuheQiJSR0etEU
        KJwysK0xJ2jNWtHvq3Gj+ZfQiIxWyUZfaxX4ACk4ntuxT4AauRM8573tWKj8FZWL4Qj6bjh3Pr4
        BzGNyEjJ1NUbD0uj4wdMPS4gx
X-Received: by 2002:a05:6000:11c6:: with SMTP id i6mr24247855wrx.178.1580148032217;
        Mon, 27 Jan 2020 10:00:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqydXL8Hy6hmc2+0FfdGyYbjp+tHmBYor3OXZuBag9Hl+JQXNDQY2Irhah3wQr6DKLU4A9G9yQ==
X-Received: by 2002:a05:6000:11c6:: with SMTP id i6mr24247828wrx.178.1580148031996;
        Mon, 27 Jan 2020 10:00:31 -0800 (PST)
Received: from steredhat ([80.188.125.198])
        by smtp.gmail.com with ESMTPSA id u7sm19732499wmj.3.2020.01.27.10.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 10:00:31 -0800 (PST)
Date:   Mon, 27 Jan 2020 19:00:28 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH liburing 0/1] test: add epoll test case
Message-ID: <20200127180028.f7s5xhhizii3dsnr@steredhat>
References: <20200127161701.153625-1-sgarzare@redhat.com>
 <d409ad33-2122-9500-51f4-37e9748f1d73@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d409ad33-2122-9500-51f4-37e9748f1d73@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 09:26:41AM -0700, Jens Axboe wrote:
> On 1/27/20 9:17 AM, Stefano Garzarella wrote:
> > Hi Jens,
> > I wrote the test case for epoll.
> > 
> > Since it fails also without sqpoll (Linux 5.4.13-201.fc31.x86_64),
> > can you take a look to understand if the test is wrong?
> > 
> > Tomorrow I'll travel, but on Wednesday I'll try this test with the patch
> > that I sent and also with the upstream kernel.
> 
> I'll take a look, but your patches are coming through garbled and don't
> apply.

Weird, I'm using git-publish as usual. I tried to download the patch
received from the ML, and I tried to reapply and it seams to work here.

Which kind of issue do you have? (just to fix my setup)

Anyway I pushed my tree here:
    https://github.com/stefano-garzarella/liburing.git epoll

