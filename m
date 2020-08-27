Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64572C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B6C22B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qxwcVn5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgH0OJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgH0ODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:03:45 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA68C061235
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:50:47 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j9so4893789ilc.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iAwILKXaGwE32BKWKaWMGVaA1oh3sBt+J35AZWjjyZY=;
        b=qxwcVn5JQ9XYTQbP2HLcOTAwz30rF8EQCFatdqtquebkoj614HXR5RCCZn47g/sFms
         b1B9FEawJrQ0st6va0eVKzrouTvhxlfCKY5lceQ5M0mEFmP87mCM1WfcXMY0rTnFfVWm
         ySrewvO/AFV5vFAEV6VVxXDaIpQGU8hvL4BcPZuxNtv5wV6r5lx2MWlDm6fmA38V1ah8
         r1c5ALWfnWIYR9RXi08rgC36D4UJkyd3fxxLQOp2nslXWKm67FvJLiKHgCs5NPTS1n7/
         7nibAib6cK52NRtC/4y31vn1506yvBpqn+dx3MKZwQuMTZ4yMdm+HHMTG3w2Tel1aVZ1
         ytUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iAwILKXaGwE32BKWKaWMGVaA1oh3sBt+J35AZWjjyZY=;
        b=OC83gUMiywHoQqPHMzvmOyaaGEs34Jp1rB1lkW+lwddGiXswcCI7s16SdDbdmeFHdi
         av0n6HbBlrZOd8uq/7+HGTx2+3sJIsflptW9GCYC6+U5rV/3vRy/EgFzZkv4WvlFFX3Q
         W5m8HYPYSEKX8o4IEmw9QM0StEEreY5Lho0Hbw3d83cagxp2KtiC+gUbuPmczaFC6gco
         NlO9rBDQVSRA30xk260uzOX0WLJNk43rE0oWd4XH/80vdh1QCjDg+uN0UDStFkYnAw/q
         +BJalOYOYJkmi1oHMsX/D26X1+98/If8n1scU9sAPkuyI8KRp2LhJy+gPCT+RTEWjV2+
         hl0Q==
X-Gm-Message-State: AOAM531a1TUxL0duq5Iu0oOJCT/Z7rYIaESSpP97q0Ou7lOVlMI20uX2
        HbAki8B26jNtcSGXBp4P/P27kg==
X-Google-Smtp-Source: ABdhPJzOPDGdpeaugrph99pH0rYwmDwtHxNDF8nsNnio4tgus2HsTtEiJ9SU9c3mUcm6yO9cBck+8w==
X-Received: by 2002:a05:6e02:1066:: with SMTP id q6mr17103230ilj.29.1598536245882;
        Thu, 27 Aug 2020 06:50:45 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 79sm1247128ilc.9.2020.08.27.06.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 06:50:45 -0700 (PDT)
Subject: Re: [PATCH v5 0/3] io_uring: add restrictions to support untrusted
 applications and guests
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Aleksa Sarai <asarai@suse.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jannh@google.com>, io-uring@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Jeff Moyer <jmoyer@redhat.com>
References: <20200827134044.82821-1-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2ded8df7-6dcb-ee8a-c1fd-e0c420b7b95d@kernel.dk>
Date:   Thu, 27 Aug 2020 07:50:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827134044.82821-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 7:40 AM, Stefano Garzarella wrote:
> v5:
>  - explicitly assigned enum values [Kees]
>  - replaced kmalloc/copy_from_user with memdup_user [kernel test robot]
>  - added Kees' R-b tags
> 
> v4: https://lore.kernel.org/io-uring/20200813153254.93731-1-sgarzare@redhat.com/
> v3: https://lore.kernel.org/io-uring/20200728160101.48554-1-sgarzare@redhat.com/
> RFC v2: https://lore.kernel.org/io-uring/20200716124833.93667-1-sgarzare@redhat.com
> RFC v1: https://lore.kernel.org/io-uring/20200710141945.129329-1-sgarzare@redhat.com
> 
> Following the proposal that I send about restrictions [1], I wrote this series
> to add restrictions in io_uring.
> 
> I also wrote helpers in liburing and a test case (test/register-restrictions.c)
> available in this repository:
> https://github.com/stefano-garzarella/liburing (branch: io_uring_restrictions)
> 
> Just to recap the proposal, the idea is to add some restrictions to the
> operations (sqe opcode and flags, register opcode) to safely allow untrusted
> applications or guests to use io_uring queues.
> 
> The first patch changes io_uring_register(2) opcodes into an enumeration to
> keep track of the last opcode available.
> 
> The second patch adds IOURING_REGISTER_RESTRICTIONS opcode and the code to
> handle restrictions.
> 
> The third patch adds IORING_SETUP_R_DISABLED flag to start the rings disabled,
> allowing the user to register restrictions, buffers, files, before to start
> processing SQEs.
> 
> Comments and suggestions are very welcome.

Looks good to me, just a few very minor comments in patch 2. If you
could fix those up, let's get this queued for 5.10.

-- 
Jens Axboe

