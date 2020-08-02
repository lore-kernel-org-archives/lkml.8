Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957CFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 16:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7049E206E7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 16:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uc3Vw0xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgHBQzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 12:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHBQzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 12:55:40 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E526C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 09:55:40 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id m7so1111348qki.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 09:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BINorMwcmmozTJcln0MY/a1goJtl5nuGFZ+Nkbr2f30=;
        b=uc3Vw0xb0konWtvxSYuBa3RKAeGOwYP+qEpMumHLXgBBqNwKGhUGcWG7uDxoMh45ZL
         1xErxsxzr06rsn5IUrENPlraLUXoBa76pkMUCQsMi7Lwzv1EB3itGyqJA6HaHqwnO1CI
         FjGJcaS0q0oW0//LNoAkZHqs1tymQ7RJjzoZBmj5UXkpwwtKgI1FFp4E+FM1r1EZNKQn
         HfihTKtxxcTF5+drYqGWRtLPqemk+VFBAwOAIwG10EsJ1QfmDtpEvp86xN0QNFyKQr2f
         U34YNzRSM7g7/tyElMX5vVcrE9yljIRvyu6xRy7IJ711leLQ4HvJeZyXYv2YNSO//lTn
         nNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BINorMwcmmozTJcln0MY/a1goJtl5nuGFZ+Nkbr2f30=;
        b=IROEHaGp6GFWzJLr/DxMg21zsoujOB2xdEd1JaOcwTFj0C9vlag/VPdE+qbfLAmgxv
         K1si8B7BjHtkYpftmKoIgkqO0r5odRi6TA1m07rpzHgJevicUeQvl8U0zlrq4B2xLxNl
         5AvAezNYY8cv+Us5l6+c8ryMer8IhHI84rbTeKdxEYA6yX4Z5oCplzN5+UnDC4suJids
         U7b9aIipEFoo0v1ywMDCBHxm1DtwnDHrAMdOSABeK56XC/VOw/qEp+6fBSPrwfVHn0Cm
         weelVEhwwC8OK81arVs8cQ1uwDJc5a+euiVZiTs90eFltqXVaDTc8XfZDWPOwt2Ng9yH
         ZXQg==
X-Gm-Message-State: AOAM532k8mC5BOTZRFXPgW1GGNlSFEArYQYAfGO3qA2awsWJlp/YCSpT
        ee2sRSmZFvhEdwGnrvYpbg==
X-Google-Smtp-Source: ABdhPJymQtwYnrk15jVl8++2D8fEG4xzmBUHJ/Uqnxy77RstBFGjbX7MLuzmJspbY8K11tAGoU9acQ==
X-Received: by 2002:ae9:ef43:: with SMTP id d64mr13560246qkg.326.1596387338519;
        Sun, 02 Aug 2020 09:55:38 -0700 (PDT)
Received: from PWN (146-115-88-66.s3894.c3-0.sbo-ubr1.sbo.ma.cable.rcncustomer.com. [146.115.88.66])
        by smtp.gmail.com with ESMTPSA id l189sm17094407qke.67.2020.08.02.09.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 09:55:38 -0700 (PDT)
Date:   Sun, 2 Aug 2020 12:55:35 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-kernel-mentees] [PATCH v3] media/v4l2-core: Fix
 kernel-infoleak in video_put_user()
Message-ID: <20200802165535.GA270694@PWN>
References: <20200726220557.102300-1-yepeilin.cs@gmail.com>
 <20200726222703.102701-1-yepeilin.cs@gmail.com>
 <CAK8P3a3NB2BVo9fH-Wcinrhhs-QJ=9dK59Ds83TvgLmEkRy3qA@mail.gmail.com>
 <20200727131608.GD1913@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727131608.GD1913@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 04:16:08PM +0300, Dan Carpenter wrote:
> kernel/signal.c:3524 __do_sys_rt_sigtimedwait() warn: check that 'info' doesn't leak information (struct has a hole after 'si_code')
> kernel/signal.c:3524 __do_sys_rt_sigtimedwait() warn: check that 'info' doesn't leak information (struct has a hole after 'si_code')
> kernel/signal.c:3556 __do_sys_rt_sigtimedwait_time32() warn: check that 'info' doesn't leak information (struct has a hole after 'si_code')
> kernel/signal.c:3556 __do_sys_rt_sigtimedwait_time32() warn: check that 'info' doesn't leak information (struct has a hole after 'si_code')

I think these are safe. Before getting to copy_siginfo_to_user(), all
`info` run through:

	do_sigtimedwait()
		V
	dequeue_signal()
		V
       __dequeue_signal()
		V
	collect_signal()

Where it either gets memcpy()'d by copy_siginfo(), or memset()'d by
clear_siginfo().

The only exception is when next_signal() fails in __dequeue_signal(),
but that will cause do_sigtimedwait() to return an error, and we never
reach copy_siginfo_to_user() in such a case.

Thank you,
Peilin Ye
