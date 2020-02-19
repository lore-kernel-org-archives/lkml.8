Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77114C761A1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD8E2469A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJa9ax/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgBSW0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:26:43 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35466 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbgBSW0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:26:42 -0500
Received: by mail-io1-f68.google.com with SMTP id h8so2437882iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZA0ribeEWX8XZYNOp8V2N04XGm24eAG8ehEYb5CcW4=;
        b=VJa9ax/Yn+26wBkOB2vajcBuaN3funzj7TCXC1MTUyqxO6HmN0wth2X8WJqP5wslCE
         ICxFKrAKE/3yirjnw7ZEdeZluvzWvX7rhTfLu8bG9pxONYSYwXy6M/W0rZrWB9k9aiHK
         kwp2E7MJMyqu2iOIYJwVbRScgBFYnMyIfH+gskrnwRgFcLZxxE11hEBP2IrgroDZuuFu
         H7mWEXO+Z/RSffJk+lVFkqCeQ5wk/8hxW+Qup2B0QUNdU2HChrE3qyGPBc1LiO+YpE+4
         DoRX6fq4Sljh9y90H+tsgzytCGCMLlD+GTl493Hr0jKSH0S6RmsrlFQXLaha+mjXX+v9
         YBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZA0ribeEWX8XZYNOp8V2N04XGm24eAG8ehEYb5CcW4=;
        b=pF+2TIV6lxxiOGSTf98zZIPQjx4qYbiHCAi+/i+uZzmm8yweZ2drafbbAQMRu3R63N
         22SBAv2+kaL2DQfRwn3g3f6XQnZvUpGSoUMkoYnP8juzGI6W+/p5OjmcfaxanhygvUwZ
         nD5xR0d8ni1ZzuY0xXzSkj9WLufC5OkZ65yA6F2rIpaBx+NLp6H99XUOCngG4/pH59pW
         rGn3Q/sZu86EibAhbxcJlN7VOR1F+y5vSj3zi7vQkhBPwcixEk08iLQATDrtjkRPFGhD
         XBc1XqtmuAuuv/i3A9Lulek1eohcTqMo9NKxc/Zl1q9eVGa2lmfPzvBQNIqF+INCAC+x
         eqeQ==
X-Gm-Message-State: APjAAAX3c3TbH+GDN0MxGhWrrnX7kCWbkRy72um2PCTwBeesFSQYRs/e
        3plHrAYnFmPppref0LWQiz2Y2qqtzDt700kG1s3Gwg==
X-Google-Smtp-Source: APXvYqyNMrvd51aRqORJ2/CIK2NvfdHwqs4soxukKFFUBUxtDRo+9uPnz37KrS2gf9oum1QkW/IIRN9OYMSuHuD3rmI=
X-Received: by 2002:a02:cc59:: with SMTP id i25mr22026556jaq.78.1582151200403;
 Wed, 19 Feb 2020 14:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20200213082643.GB9144@ming.t460p> <d2c77921-fdcd-4667-d21a-60700e6a2fa5@acm.org>
 <CAKUOC8U1H8qJ+95pcF-fjeu9hag3P3Wm6XiOh26uXOkvpNngZg@mail.gmail.com>
 <de7b841c-a195-1b1e-eb60-02cbd6ba4e0a@acm.org> <CACVXFVP114+QBhw1bXqwgKRw_s4tBM_ZkuvjdXEU7nwkbJuH1Q@mail.gmail.com>
 <CAKUOC8Xss0YPefhKfwBiBar-7QQ=QrVh3d_8NBfidCCxUuxcgg@mail.gmail.com>
 <20200215034652.GA19867@ming.t460p> <CAJmaN=miqzhnZUTqaTOPp+OWY8+QYhXoE=h5apSucMkEU4nvtA@mail.gmail.com>
 <20200219025456.GD31488@ming.t460p> <CAKUOC8UceQ_cDQC8ckvUio0AZHhasi7Np-PQ09e-dQ3fechKoA@mail.gmail.com>
 <20200219222255.GB24522@ming.t460p>
In-Reply-To: <20200219222255.GB24522@ming.t460p>
From:   Salman Qazi <sqazi@google.com>
Date:   Wed, 19 Feb 2020 14:26:26 -0800
Message-ID: <CAKUOC8VGMYM1w15G-2KKZ=SEU_T_Xv9fR2Kp3JUupogBxy5x8g@mail.gmail.com>
Subject: Re: BLKSECDISCARD ioctl and hung tasks
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 2:23 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Wed, Feb 19, 2020 at 09:54:31AM -0800, Salman Qazi wrote:
> > On Tue, Feb 18, 2020 at 6:55 PM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > On Tue, Feb 18, 2020 at 08:11:53AM -0800, Jesse Barnes wrote:
> > > > On Fri, Feb 14, 2020 at 7:47 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > What are the 'other operations'? Are they block IOs?
> > > > >
> > > > > If yes, that is why I suggest to fix submit_bio_wait(), which should cover
> > > > > most of sync bio submission.
> > > > >
> > > > > Anyway, the fix is simple & generic enough, I'd plan to post a formal
> > > > > patch if no one figures out better doable approaches.
> > > >
> > > > Yeah I think any block I/O operation that occurs after the
> > > > BLKSECDISCARD is submitted will also potentially be affected by the
> > > > hung task timeouts, and I think your patch will address that.  My only
> > > > concern with it is that it might hide some other I/O "hangs" that are
> > > > due to device misbehavior instead.  Yes driver and device timeouts
> > > > should generally catch those, but with this in place we might miss a
> > > > few bugs.
> > > >
> > > > Given the nature of these types of storage devices though, I think
> > > > that's a minor issue and not worth blocking the patch on, given that
> > > > it should prevent a lot of false positive hang reports as Salman
> > > > demonstrated.
> > >
> > > Hello Jesse and Salman,
> > >
> > > One more question about this issue, do you enable BLK_WBT on your test
> > > kernel?
> >
> > It doesn't exist on the original 4.4-based kernel where we reproduced
> > this bug.  I am curious how this interacts with this bug.
>
> blk-wbt can throttle discard request and keep discard queue not too
> deep.
>
> However, given block erase is involved in BLKSECDISCARD, I guess blk-wbt
> may not avoid this task hung issue completely.

Thanks for the explanation.

As I said, it takes one 4K BLKSECDISCARD to get to 100 second delay
where the entire device is unusable for that time.  So, the
queue doesn't have to be deep at all.  It's a single tiny IOCTL.

>
>
> Thanks,
> Ming
>
