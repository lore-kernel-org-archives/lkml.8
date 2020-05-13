Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5838DC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE04206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="J9qIkN4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgEMHH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgEMHH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:07:56 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5037C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:07:55 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x73so12695978lfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mW8RDOfapkDaoa0Hb9EShwMwCn8vakzjoyWs3SU+BGc=;
        b=J9qIkN4GOdr3b0TDdPyfF5iwQMxySZVVwyEt4C2nQgvCPYow2lWfeAh6Hp3j2u3g+0
         CpAXZ6pgAlgu0Ac73YY7tSAw8K/WpZwe+TL3PY2N7q4H3UgoHoR4E6LAZb8BH8Uz5BA9
         CxtS+rvDyaC4WK604GPAD+E7pJgAu0if/r4q3rMZ3gPPEPNWMJSBVkCxXcTwQEl/+Yp9
         nFBEKSpOH3hes9GiSy/N6Wuq+8s6+uIG3u9MDIxDbNkwklUr38268FXRPsFgWahImOOK
         8sbQIU05WISkLCPgzq+D6VBy9LU2GtYEyPW9tSD+GlaCyHxbY5VsYmBhcZuLsS+9bE7Z
         tHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mW8RDOfapkDaoa0Hb9EShwMwCn8vakzjoyWs3SU+BGc=;
        b=HN1Y6JEzshULK/t4ePw3H7g45vsmsvXEWKikQwlhs48FjDaPPIeR7o9n1BC05DSnxr
         N+VFHGYxZzWuRD/pCMQAmDzEFS+h4DzFwV+sHnpZHUHtHvQB9SyjS7EGUursopXvfVLF
         4DF5jfSYz9mbm4rgbnyC/kmSkuxc0A9vDbjr3P+RJNEW0g0VmUqRNk2FvusFphRBa2Xd
         NNKo4Zup6nuQS3IPjwQ8+I4dwlV5MmIg2TUA4peWAlQPGYOMcqrz/qmYER3wVP+crszd
         SRZdaZaYSPvp4Jgu3v4dh9pBrTEEsOubB5EliQ92bzpnQIAR1c9H19mx9t9B25KyEhdg
         WqiA==
X-Gm-Message-State: AOAM530oYPHWyTxxlJ1siZLYAb4j87tiWkp9HQHqreiECUIf9xhJ18H1
        GO/JY4yWNHNxIypFCPL5YQCufffJ+nq9FHGAsM3WUg==
X-Google-Smtp-Source: ABdhPJzDwBLW0Ng55ay6pVZ/lv4nKFNfw9bBAXMfoDctZFD/KSd0XtGRMmmuj+JMpqtM15bEUnfuAGGNF+u0G5wmXU4=
X-Received: by 2002:a19:ec7:: with SMTP id 190mr17595542lfo.203.1589353674058;
 Wed, 13 May 2020 00:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-11-maco@android.com>
 <CAB0TPYHwor85-fWKu+OMT-1ys2L7OSqVoReJRzNOMAE0xK+yzg@mail.gmail.com>
 <1f3064a9-105f-02bb-6a1a-eb9875d292e3@kernel.dk> <4416f60a-6050-5067-6881-0ee9ef944669@kernel.dk>
In-Reply-To: <4416f60a-6050-5067-6881-0ee9ef944669@kernel.dk>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 13 May 2020 09:07:43 +0200
Message-ID: <CAB0TPYHikHc3tTTQcUOOZsYZmqNxGtthpkPX_z6dKgy+V8kovg@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] loop: Add LOOP_CONFIGURE ioctl
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 4:30 AM Jens Axboe <axboe@kernel.dk> wrote:
> > Looks acceptable to me, but I'm getting a failure applying it to
> > for-5.8/drivers on this patch:
> >
> > Applying: loop: Refactor loop_set_status() size calculation
> >
> > So you'll probably want to respin on the right branch.

This series depends on a separate bugfix I sent to LKML earlier - see
https://lkml.org/lkml/2020/3/31/755 . I mentioned it in [00/10] of
this series, but perhaps I should have just included that patch.

I just verified that patch + this series still applies cleanly on your
for-5.8/drivers tree, but if you prefer I send a v5 with that patch
going first let me know.

Thanks,
Martijn



>
> Then you can also drop patch #1.
>
> --
> Jens Axboe
>
