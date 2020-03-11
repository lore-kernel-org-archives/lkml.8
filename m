Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8FCC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAD120637
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="DgLSRBQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgCKImc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:42:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38918 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgCKImc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:42:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id j15so960583lfk.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSW/+5dQsu/FqLoyL9jf+9ZZDs2OGV9dnsgXg37rKKk=;
        b=DgLSRBQUrCDt/5nBAjCAkkyg2P+43TXZODJ95anLVv5NU++tsUo06UW3OkHWu83+g7
         nmhMf5fweE4BGTYxQQN5I6UMHRoF3TzoUrSn84LoRkhTb4Btrv2WLiS7syKdnM0QTZ2c
         viVJFORB/ckRZHyDyVluU4L012uH/Rom6oOXPav6af6abuCO1txfmQ7GRaZj2NdNQp0z
         U0JOoaiwk00j2KSoA5lfW0+r+fD9gxySNRDFWyeQXTDXMlhTOOnosBeCv66xHzkKHtEB
         jjelGy4N+XdYZsRS8YPjhzPHRECZ0SmbpwqslniF4eI+M4oozeEKpSID1jjSGusoVX0T
         rE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSW/+5dQsu/FqLoyL9jf+9ZZDs2OGV9dnsgXg37rKKk=;
        b=RlzLzimUgIm1bTp1gdePZY3tCpmJhS+94RAp9hgM3xrg5J9eb0GaoVHvIqEd/mhfuq
         AJDZ41a5HTjt52RISQTXkxOIUB6zSPALIosIL6wb75BTR9IRJyWUTHZP1kkAYUPnSkrx
         CrECE0aq1OPKH0qvVzWMjgzfihmUa7nTA7KJxdoytCwcHkYk9xpa9PHu/kKbjnqXJTXc
         N/CWf1E6d1n+CRgubDt4LXXnflMVKu0gynPxJq+g8d+u9B+pXeKonJPqJp17lEuosPO2
         kBZvG5NPSnVcmPW2wiRWU5OvpKZsIJKvMTXnNyIqpNIBFiiGK6nNB1AYT86OA7lL5GYV
         UV5Q==
X-Gm-Message-State: ANhLgQ2bqU7peOepLsUD6pwLGICi9bv1MMFS1pD18xyHiE7SFseSt8kP
        WT0sLS9mF2bpnIzEj3i7KZ3xi+1+DLdFQjbkw4DlPQ==
X-Google-Smtp-Source: ADFU+vsWmsyleV5atqo3bIBY6SuDEIEvfcD5+QWymQfMOOR21g3oLM74WmtdBbzz2ztzPfm6tEUFggv3ukELlgKYS4A=
X-Received: by 2002:a19:cbc3:: with SMTP id b186mr1524321lfg.182.1583916149757;
 Wed, 11 Mar 2020 01:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200310131230.106427-1-maco@android.com> <BYAPR04MB5749104A80045EB0BD3EB28886FF0@BYAPR04MB5749.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB5749104A80045EB0BD3EB28886FF0@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 11 Mar 2020 09:42:18 +0100
Message-ID: <CAB0TPYHZmsMMpOi709gSbCkF7F+E5XfPu0JBZiavn0v=u=26fQ@mail.gmail.com>
Subject: Re: [PATCH] loop: Only change blocksize when needed.
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chaitanya,

On Tue, Mar 10, 2020 at 9:23 PM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> Logically this is a right thing to do, but I wonder how much speedup
> you are getting with these improvements ?
> It will be great if you have some numbers so we all know the speedup.

What makes blk_mq_freeze_queue() relatively expensive is that the
implementation of that function calls synchronize_rcu() (for good
reasons); on our x86 devices, I've seen that take 15-20ms on average.
Recent Android versions configure a lot (~30) of loop devices at boot,
and so this saves us about 600ms of boot time. I strongly suspect this
benefits other usecases besides Android.

There is another call in loop_set_status() which is harder to remove;
eg, if you use loop_set_status() to change the offset of a loop
device, you shouldn't do that if there are still requests outstanding,
and blk_mq_freeze_queue() ensures that. But in our specific case, we
know that there won't be requests outstanding, because during this
phase of boot the loop device hasn't been mounted yet. But we can't
tell the kernel that. So I will follow up with a patch that tries to
address that issue, which will also have some more detailed numbers.
If you have ideas or suggestions, feel free to let me know!

Thanks,
Martijn

>
> Irrespective of that, this looks good to me.
>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>
> On 03/10/2020 06:17 AM, Martijn Coenen wrote:
> > Return early in loop_set_block_size() if the requested block size is
> > identical to the one we already have; this avoids expensive calls to
> > freeze the block queue.
> >
> > Signed-off-by: Martijn Coenen<maco@android.com>
>
