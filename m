Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0891BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62B72065C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="mx3aJiDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgHOWf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbgHOWf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:35:57 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02654C061786
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 15:35:56 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id kq25so13615558ejb.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 15:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dTQO2UGS6IbiCmBPjV1qZIfUiVzOZUUnWY06F94c99c=;
        b=mx3aJiDKzbnOxFKDF2RwZ9IauJ0zs+LzdbJHW+c57kA/ofwiUeISFOtdotyEnSyoqp
         0+qfs3A/JE9vcLyzGR9jCsBraOODgNTw+KDUF2JHy1UWRhMXA/Pt+zatTWoZLdHxNhij
         ISBzAEezjt+AAVgfrEqQO0a+jOdS/Toz9C/kqd0jtaPoP1QZ+MCW2xdY0qsmu0UH8x6g
         kCvkSS1w0mq1WPfdNOfhHCxCngq/axQiSYA9OwYj2UVMBPcyyKQmWjnxJdnY7vWey+DM
         7/JUTk8Ka8QPCBx5bQUHW7dfao6a5PqNmNOkEJIfiPcturLuJ2V4uuxN6OpwVtOoXifU
         1HHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dTQO2UGS6IbiCmBPjV1qZIfUiVzOZUUnWY06F94c99c=;
        b=LUkNevX2n2+Q08hlU4TNmZYx9RvqbhjSHSBpqOsy/5nUqhx2a/CAxRxf3yJQl5+eK3
         1yNgTaQXYih7pEl6uDIqpFkaVIiqZd66kv8GIKNXYKc1By87nthBDH8/t/3CUlTnBPqp
         8OrcQG0qoLiHbQq96sW0/HKQRtGpbh7zKSh2HrXf7wLsZqLag904Wtvq0eiKMZkz38lD
         sUv6yTmPjYb6t+v0aOFFNoOvZfTo9DKkuUY0EsU16w4naUphaynYy9ZP4WO6mQ5tOu/O
         mFoLgmi6zzMnC5bie4YALPYvvdKbkhaOtLwMsGsnpSRR2zG2t7SYuS8W/kWUeho95I4n
         msdQ==
X-Gm-Message-State: AOAM533PTWnLG8tfkRO7v/SqKmoS4CFsyvWN6LhvS/WTn8o8vKTcn2Lx
        6am6QQjPzNPgzvIZKkhMxAdpPDPj+/yAVyWzZbJJ1MRmkfDw
X-Google-Smtp-Source: ABdhPJwajHLy4Cpu9WC5K51l5XAs5s1YBGBAGWUzquqWkkmQK36cRloxe0v45CqP0jbqneMTpEefGiKzcZkmjxRpt3A=
X-Received: by 2002:a17:907:20e1:: with SMTP id rh1mr8294271ejb.106.1597530954556;
 Sat, 15 Aug 2020 15:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200809063600.GC1538@shao2-debian> <20200814230851.sn4oiddwcaoqhvso@madcap2.tricolour.ca>
In-Reply-To: <20200814230851.sn4oiddwcaoqhvso@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 15 Aug 2020 18:35:43 -0400
Message-ID: <CAHC9VhRUoM1j7rqOvtzHcSUq9C6x19WREMfpQF1cWC6B-um-zg@mail.gmail.com>
Subject: Re: [audit] c4dad0aab3: canonical_address#:#[##]
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 7:09 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-08-09 14:36, kernel test robot wrote:
> > Greeting,
> >
> > FYI, we noticed the following commit (built with clang-12):
> >
> > commit: c4dad0aab3fca0c1f0baa4cc84b6ec91b7ebf426 ("audit: tidy and extend netfilter_cfg x_tables")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> >
> > in testcase: trinity
> > with following parameters:
> >
> >       runtime: 300s
> >
> > test-description: Trinity is a linux system call fuzz tester.
> > test-url: http://codemonkey.org.uk/projects/trinity/
> >
> >
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
> This looks odd to me.  I don't see any audit involved in this and I've
> heard other complaints that this bot has appeared to mis-attribute other
> errors.  I had a quick look before I went on vacation a week ago and was
> back today briefly.  I'll be away until the 24th and won't be able to
> look before then.

I am just getting back to normal network access myself, but I did have
a brief exchange with Richard about this and I agree it looks a bit
odd.

--
paul moore
www.paul-moore.com
