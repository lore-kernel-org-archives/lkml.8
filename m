Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F82C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CBD821531
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="n+U1wbC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbgE0IO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387566AbgE0IOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:14:22 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C96C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:14:21 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z13so18132273ljn.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zzZtT7KW7sYELS+x9P5gFRYxRCfWQakAeOdFpPLtsA=;
        b=n+U1wbC11tvcVxQlHXWV9nn3KwP1+ePp9m9shXT05yfmWjfN5kBIOqCYsW86q1QDJs
         TWbnR77mQ7t5eJRdy/82kUGdgY7X9jhWMRWSHOOLt/T0raPsQDVlsThMGleAMh0yWhEr
         fZj67VmYf5a1Lp0QiHCvybHuR1S3pU51x0pOytBk9Rk3HL48i9fymYRL12nJ6rVw2o5d
         AAgwJGYPrvVdIvbuX7Z+XmxvChkhRfcaOlzLuOkzJCDh4veOjuxP/2aOOS1QanH8z2Ja
         CK12D3ZIn8CZlry1JEgxI8a1AAtlgwgy/FQtGwW44wx8VYAJMBlx2zbIIaZN54xiLlwl
         N0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zzZtT7KW7sYELS+x9P5gFRYxRCfWQakAeOdFpPLtsA=;
        b=i2pMU6ryRqwQ7mceCOupJUfWDejrJPpIBeCW7JBlXDdkNmVqNXdiC1SmxeCpdFLJak
         Td24oc4PtocoWQVvJAFhaovdtU08mBgsIDdIAdaytYcTyW4xTyXDUwAQyXykRUf0P5J3
         3o4v2naIHHityUYzcstNhOCrY5TjRc7GRcK9+KyVschd7SWEmFLFLETv97v5a6eEtvqA
         IlMDAapsAvuhP9ctHQhiwZbApaokTE4uIZvfetcEv/KeiBBr0v+tY2zAxYN+5vf+sDqW
         uAYKr3dH4N2H8vcJncvXl0RKhD3zQ//XgRWcVlzNI7vGevFfS1myfcZVjyi1sNhimrxl
         D2uw==
X-Gm-Message-State: AOAM532Qe50rDMDuS0LZraoNe9Zmdx/0cabzmkwS35CPzIBpXLPyCXLu
        69DfqsDJ8z8oOZcQx3Ul5txj5GM9FGUCC3j71HwpCw==
X-Google-Smtp-Source: ABdhPJzUJ6PUKWE4CS8AO2wzYW1rnO8yE1O6Sl9F6DxNY0ivQj69wqaQu7Xcdvo4njCx9xLdp9661fYvBnTP5lZlUAI=
X-Received: by 2002:a2e:b178:: with SMTP id a24mr2497864ljm.268.1590567260182;
 Wed, 27 May 2020 01:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAB0TPYGCOZmixbzrV80132X=V5TcyQwD6V7x-8PKg_BqCva8Og@mail.gmail.com>
 <20200522144100.GE14199@quack2.suse.cz> <CAB0TPYF+Nqd63Xf_JkuepSJV7CzndBw6_MUqcnjusy4ztX24hQ@mail.gmail.com>
 <20200522153615.GF14199@quack2.suse.cz> <CAB0TPYGJ6WkaKLoqQhsxa2FQ4s-jYKkDe1BDJ89CE_QUM_aBVw@mail.gmail.com>
 <20200525073140.GI14199@quack2.suse.cz>
In-Reply-To: <20200525073140.GI14199@quack2.suse.cz>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 27 May 2020 10:14:09 +0200
Message-ID: <CAB0TPYHVfkYyFYqp96-PfcP60PKRX6VqrfMHJPkG=UT2956EqQ@mail.gmail.com>
Subject: Re: Writeback bug causing writeback stalls
To:     Jan Kara <jack@suse.cz>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, miklos@szeredi.hu, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Mon, May 25, 2020 at 9:31 AM Jan Kara <jack@suse.cz> wrote:
> Well, most importantly filesystems like ext4, xfs, btrfs don't hold i_rwsem
> when writing back inode and that's deliberate because of performance. We
> don't want to block writes (or event reads in case of XFS) for the inode
> during writeback.

Thanks for clarifying, that makes sense. By the way, do you have an
ETA for your fix? We are under some time pressure to get this fixed in
our downstream kernels, but I'd much rather take a fix from upstream
from somebody who knows this code well. Alternatively, I can take a
stab at the idea you proposed and send a patch to LKML for review this
week.

Thanks,
Martijn


>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
