Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1D6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10178206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjvyfnVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgFVIul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgFVIul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:50:41 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB812C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:50:39 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c75so15139488ila.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBGCr/V9grcgTVKtjGPTu3uIDpYRoMlulyR+BOcCRPM=;
        b=JjvyfnVU/VrzPRA4p3VAEpiukaK7042CHJJ9Msht32f/G58yo+vV2CgRHYLgTuQGMP
         oDLiRgzQWku62N4w/CTwZhe8C2qjieyLjNWO8MMxCsE0nz5yNEUhWmkpp9BBDVZ2uxwN
         ugcRkFazsc0m30EKhzkpUe8RTAqkMxsCpn3xLWgLmqrbOmo2mu11SUl+jWgzZT+LLqyt
         p8SJC9VBNqDfcjhlFD91INM7jAcIn4M4Gl6DKSikaCi9pj83XB6Czyc8TfPGd61eKaBe
         OmTOoCnLQJuBjR5G0hbY8Kxqc4pkjZn+m5X33HJzvKE/RfNoMWF1rkJRAKqq9B5M2xgY
         VhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBGCr/V9grcgTVKtjGPTu3uIDpYRoMlulyR+BOcCRPM=;
        b=jXhKz5UykwKQu6rSVzjm8DdbpzTaQhInOkT05jTS1NNTQ4EXc23M6gCv3HGNDLzCCD
         S5w/Vz2Uf+nYO0jowF3HDeFUaarnYA+UuFayyzk0RrwmyWfQ2EKEYzJM9NsgIPfJ9KwF
         nEx5VcHDS+KLNpwr+qjWwpin26aHY2d5T6asVAfTdr6v59jTaTYDiIF8Dbv77KtEHrT3
         jPbKgg2hDGlPBXFDcA4gnnSC+fifVpMgwPn8gzbNT0w0en7rZXr3F9Yshb50chUWtKDo
         8YO35dJTD6LOOISwZmnSyD4XB2IPL06KwDHmprlUzr6u0X2WjZKK78HiNNACQgt6jZEA
         luvQ==
X-Gm-Message-State: AOAM5339XfERLDkhqWnpRXJ2oU0/dEPeXTwjKa3T1B+NIM+1K2fnfC4x
        fd/6+b3mRw3tDSnmy1CkxNQvg6R1gw8Gg28osXU=
X-Google-Smtp-Source: ABdhPJyhazzYy9KUt8Nmim0LruffHvheYvqRC85M11WITsrB/FQs3mY3YK3RVeXqv6nyZFvEG4LLL+GHWHlD4yGefFU=
X-Received: by 2002:a92:db49:: with SMTP id w9mr14874855ilq.188.1592815839182;
 Mon, 22 Jun 2020 01:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200621133704.77896-1-alexander.kapshuk@gmail.com>
 <20200621135437.GA18092@nautica> <20200622083957.lfgz4j2dop5ryiz6@wittgenstein>
In-Reply-To: <20200622083957.lfgz4j2dop5ryiz6@wittgenstein>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Mon, 22 Jun 2020 11:50:03 +0300
Message-ID: <CAJ1xhMVpJM+CSiA4PgHNbksp1F9MHsKsQO0iBXr4_m7oShj6-A@mail.gmail.com>
Subject: Re: [PATCH] kernel/signal.c: Export symbol __lock_task_sighand
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, oleg@redhat.com,
        ebiederm@xmission.com, Andrew Morton <akpm@linux-foundation.org>,
        liuzhiqiang26@huawei.com, joel@joelfernandes.org,
        paulmck@linux.vnet.ibm.com, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:40 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Sun, Jun 21, 2020 at 03:54:37PM +0200, Dominique Martinet wrote:
> > Alexander Kapshuk wrote on Sun, Jun 21, 2020:
> > > Export symbol __lock_task_sighand, so it is accessible from code compiled
> > > as modules.
> > > This fixes the following modpost error:
> > > ERROR: modpost: "__lock_task_sighand" [net/9p/9pnet.ko] undefined!
> >
> > This can't fix something that's not broken (yet)! :)
> >
> > I think it'd make more sense to describe why you think we should export
> > it, rather than describe a precise usecase e.g. justify why this would
> > be interesting to use from modules (e.g. it would help modules like 9p
> > take a lock on the current signal handler safely and cleanly through
> > lock_task_sighand())
> >
> >
> >
> > Christian, Andrew - assuming this passes reviews from someone else I'm
> > not sure how to go forward with this; it'd be simpler for me if I could
> > take it in the 9p tree as I need it for the patch Alexander pointed at,
> > but I'm not normally touching any file outside of the 9p tree.
> > Is it better to let either of you take it normally (I think it'd be
> > you?) and wait for that to land, or can I take it in my tree for the
> > next merge window?
>
> Hm, I don't think the patch is really needed though; see my other mail. :)
>
> Christian

Thanks Oleg and Christian for your feedback.
Based on what you both expressed, my patch that exported
__lock_task_sighand as well as the original patch to address a sparse
warning in net/9p/client.c
should be dropped and the warning considered a false positive.

I'll let Dominique have the final say on this.
Thanks.
