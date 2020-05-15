Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD45C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3619420657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jJ5NV32v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgEOSRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEOSRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:17:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D2CC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:17:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b190so1354847pfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MQ4wGQK4HJGpPKqcajR0zrY/G28luDq8Vm3rkva5Veo=;
        b=jJ5NV32vjYnf+3B7EVOMNSKt9CGk8/ztEwZ2/IVShnsOnn/YWf8Cq8Fj4XyjEETFIb
         Nx0qznk0qoM/d4NCwVziqX4rjqqObXVtOvuhBD7hlzlT1rU/XBWwF2ge7dygEptfG3v6
         9DoSyk6Zbfu8dnH9RRSpyj4JrZs1S6oXxslawre6YaO7PRsps8TPeCTiy2mya5G2c4JD
         j9ov85cQkfzEqMl6XYLQCdl+pXPwBPtfEFMntvPKMWpY6Nzehs82l5OIiteXt+U0dT5I
         x8i51CIRAdxut7syKCkQ56RqDnHRoBkWDmVm3e2/ku8fJPNdo/XepaiMr9nUG+GvvK46
         oGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MQ4wGQK4HJGpPKqcajR0zrY/G28luDq8Vm3rkva5Veo=;
        b=r9ur+03W7MQs/fqSr6WOI+KdhZiGuOTRD6kM3CcIwuSrFr3p5sW9GYq2RJaU/zo4lW
         x8aYq4UCRoV+M/CwZyNZAHVHizB42MHeEdI/oCL0M6dsnPCrdl1SqU+IwHncxtX8GzB4
         /eeVsAPYGQ8mPaoiER9soYMkIEXsfAJlHVCUx8AKlmGtCkowk9bo8HL47c/MxMfOljfI
         ecpMnjgGyZbcHbKBYgtXkcrMbUPx4aG7ApFl5exfXWI7U3mDuApcnTuw2LMAl3q8h0OS
         w6MKojnlyBGONOKrWXtpEOkzkaNijzEws1d4IIlxQMUh+d2F/bnv79k2rXyTwxvVA3Oh
         BIqg==
X-Gm-Message-State: AOAM5313aT1uiKmioOKX5EfvghGe2OTJbMZufh8ZFYE2LrBrpfTdUGz2
        YWq3X2ZnrEAPEVrAa+gJRBNiCmxqI8A=
X-Google-Smtp-Source: ABdhPJybZEgEYF7mYlhjvAx8IHoZRB9VyNA3vi8oa52PVgAXc4IbNdmrC5fX4dmuFbgJ0HHW5lppsg==
X-Received: by 2002:a63:381:: with SMTP id 123mr4273198pgd.240.1589566663443;
        Fri, 15 May 2020 11:17:43 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:adf1:7e34:eff4:95bb? ([2605:e000:100e:8c61:adf1:7e34:eff4:95bb])
        by smtp.gmail.com with ESMTPSA id w126sm2516181pfb.117.2020.05.15.11.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 11:17:42 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] io_uring: add a CQ ring flag to enable/disable
 eventfd notification
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200515163805.235098-1-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5795fd28-ee65-e610-5472-d1493902f2cd@kernel.dk>
Date:   Fri, 15 May 2020 12:17:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515163805.235098-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/20 10:38 AM, Stefano Garzarella wrote:
> v1 -> v2:
>  - changed the flag name and behaviour from IORING_CQ_NEED_EVENT to
>    IORING_CQ_EVENTFD_DISABLED [Jens]
> 
> The first patch adds the new 'cq_flags' field for the CQ ring. It
> should be written by the application and read by the kernel.
> 
> The second patch adds a new IORING_CQ_EVENTFD_DISABLED flag that can be
> used by the application to disable/enable eventfd notifications.
> 
> This feature can be useful if the application are using eventfd to be
> notified when requests are completed, but they don't want a notification
> for every request.
> Of course the application can already remove the eventfd from the event
> loop, but as soon as it adds the eventfd again, it will be notified,
> even if it has already handled all the completed requests.
> 
> The most important use case is when the registered eventfd is used to
> notify a KVM guest through irqfd and we want a mechanism to
> enable/disable interrupts.

Thanks, applied.

-- 
Jens Axboe

