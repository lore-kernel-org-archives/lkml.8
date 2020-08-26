Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BDAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B14820786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aU8siOpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHZTun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgHZTue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:50:34 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A10CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 12:50:33 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k1so1583401pfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 12:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uxqzqvKmp7TiheniHf4IhKcDFcjxbiVLlnBXpofjwMk=;
        b=aU8siOppe3gnQyuaHzROkStSBHp1R5OW7cyHZa9Qz7+3P9SoF3bduzgEtFv0LgQ6EB
         SoPfRvVMaGGz7cgLY3D80QJOfKTkdjKYwQBRF982bGuQfjWlAASB6m3+ZBBr5WHfyh2w
         9WogV6NaCd7ry+cSTti/fvS9ekjLyQoNnN7HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uxqzqvKmp7TiheniHf4IhKcDFcjxbiVLlnBXpofjwMk=;
        b=E6I+5PvmbMkzVTiY1XWB2RB60yEKw1Mpm3Z0uK6DgAaIPo4psVQMMMxO7L6L/7XsYL
         0eWcfk7o5X8K5KXHTDigGwidTOxxGjNREJVyXqO4FAe7+0npGushADnTMW7fF2Zw8JHA
         w68GrwScxu+mRiZCZmGPctmhfRox1zXI08ZNOyhLghhqM30cVUIWAAG0Iq+Qi+cBHyB6
         uPt9Z+mEp5NLKLD3KiRvw6WhCN/ulINd4hElv1tbcFGxg+6O6ngsqvQC2sX0DiykbVo9
         Ym2kOtvbfpD7Jbk1sgUUnWy9rGF/5rjraGmcrNv8Mwmvvx3+w73kaiCEN7MQwu5Zi7wc
         5IOw==
X-Gm-Message-State: AOAM532GVOJwPHeKplgj/uIwq+wIP5m8Mzasm5v9iqiDejLBpuCzT6LK
        ch86wAHbCXixuTueYOh06rP1NA==
X-Google-Smtp-Source: ABdhPJzxqVFKo5Bu6GBfBDh+chu3duJcUOhxiTiRE4q8mDWtHYdG37wKhgbCE4yKAY4sw60hABcZoA==
X-Received: by 2002:a63:df13:: with SMTP id u19mr11904336pgg.275.1598471433358;
        Wed, 26 Aug 2020 12:50:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a200sm3921461pfd.182.2020.08.26.12.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 12:50:32 -0700 (PDT)
Date:   Wed, 26 Aug 2020 12:50:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <asarai@suse.de>,
        io-uring@vger.kernel.org
Subject: Re: [PATCH v4 3/3] io_uring: allow disabling rings during the
 creation
Message-ID: <202008261248.BB37204250@keescook>
References: <20200813153254.93731-1-sgarzare@redhat.com>
 <20200813153254.93731-4-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813153254.93731-4-sgarzare@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 05:32:54PM +0200, Stefano Garzarella wrote:
> This patch adds a new IORING_SETUP_R_DISABLED flag to start the
> rings disabled, allowing the user to register restrictions,
> buffers, files, before to start processing SQEs.
> 
> When IORING_SETUP_R_DISABLED is set, SQE are not processed and
> SQPOLL kthread is not started.
> 
> The restrictions registration are allowed only when the rings
> are disable to prevent concurrency issue while processing SQEs.
> 
> The rings can be enabled using IORING_REGISTER_ENABLE_RINGS
> opcode with io_uring_register(2).
> 
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Where can I find the io_uring selftests? I'd expect an additional set of
patches to implement the selftests for this new feature.

-- 
Kees Cook
