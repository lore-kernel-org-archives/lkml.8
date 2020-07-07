Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8F0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAAD12065F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnoeNSsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGGJej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGGJej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:34:39 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114F1C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 02:34:39 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id e3so12197515qvo.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 02:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3l+HlT4Oglz91X+kY631+QAP/vqvhKsDTErd5bEL8g=;
        b=DnoeNSspsQ3loogNN01mAoLhjErJ9aj+PYz62kuCWUGZTi4kTG/UxJYx/3uReXYk+U
         EZQdQBbMYWIE/gHch8YUGRdcHrAjcDtjOkz2VgxR+HbqZ2UHtHYKFn6lGY/x/lL1/4AU
         FusMMQ0qZjaj7/XZo7v6pNdyzSOW7BwncA0img8bSQrAgrlGrgZpyZIA1Cg8SWQtWBx5
         V/IbZ0/hkoNp3ANulWI3jdjOiAFH/h9ODLGp3XXDmu1+K4B/G/bA30S92pvKr7sAMKaP
         6QL9mZvF6hBLqORTpmX/3lyMTCmL0JN1gRbanmyrGv/m6jw8o+IA0yOtFcM1e22TyIGP
         40fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3l+HlT4Oglz91X+kY631+QAP/vqvhKsDTErd5bEL8g=;
        b=CUbl6o1Z9WJsFZtrSvusiKc8KSelZb/eRWOvqYpaeHvO6i3bMS/AthRUIIIz08HzBD
         +MjSj1k86X9v+pmvwiFkhvv6dlrq1GMKdT/uyKqrpL5EV5XNJMZcOBTJ52U0g2jtv6MD
         6NQvItKVYc5IyIU1AiQYjcSQwhAaB5/3LwbJYpF4bOoCWj/QHCHTEpl8QvpvalHGuDeM
         bBnXcDElJ3l0LZWT0WGQ45aBdDY+2lvtglQpIwR4BLEc/NrY+4Cx/SLsVLXE1XBZeUFw
         PWYPKQJYwekGDQ3kmHFRFpinZXI6R5UbmdS64aQNTM2/QcqA8+/J0jj1ezYxsQT1VpgR
         Mhgg==
X-Gm-Message-State: AOAM532qG9AtqxcysK+OXVvKEmExWe0fzz7KqMbOGJ/DKFgrysQ6R7Qm
        WaVn1bzJQD6Yl64x19sJz1+6fJqduNdINDJ1bw0=
X-Google-Smtp-Source: ABdhPJyHKpGqf+M2LCoEOyJDQ5ztTQ90tyZifZWC7OMyMuWrjtpbwr20FKQpQ3Yb/bDQjdve5HSClltTNdcEp0d/d7A=
X-Received: by 2002:ad4:5148:: with SMTP id g8mr12081760qvq.173.1594114478212;
 Tue, 07 Jul 2020 02:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200702052039.GA2824@192.168.3.9> <20200702081418.GZ4781@hirez.programming.kicks-ass.net>
 <CAA70yB4zLkizEAHSTag1VQwtuOrEaNEeCa9Er7MAzdpfZRJOeQ@mail.gmail.com>
In-Reply-To: <CAA70yB4zLkizEAHSTag1VQwtuOrEaNEeCa9Er7MAzdpfZRJOeQ@mail.gmail.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 7 Jul 2020 17:34:26 +0800
Message-ID: <CAA70yB6A11ogu_f_sV+n9erZqsFX9TyZYvYJ6yr+cxsMoGFkcg@mail.gmail.com>
Subject: Re: [RFC PATCH] proc: add support detach proccess's autogroup
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 6:21 PM Weiping Zhang <zwp10758@gmail.com> wrote:
>
> On Thu, Jul 2, 2020 at 4:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jul 02, 2020 at 01:20:43PM +0800, Weiping Zhang wrote:
> > > Since setid will create a autogroup for that process, there is no
> > > way to detach a process from that autogroup, this patch add a new interface
> > > to detach a process from its autogroup. You can write anything to
> > > /proc/<pid>/autogroup_detach to do that.
> >
> > This is indeed what the patch does; but it fails to tell me why. Why do
> > we want this? Why should I care about your patch :-)
> >
> > Please, always explain why you want things done, that can also help us
> > consider if the proposed solution is the right one.
>
> The reason is that, there are lots of autogroup created in our system, because
> I forgot to disable CONFIG_SCHED_AUTOGROUP, and it leads to a hotspot
> in tg_load_down (kenrel-3.10.0-514.16.1.el7.x86_64).
> When user login system by ssh and launch a background job, it will create a
> new autogroup even user logout ssh.
> I cannot find a way do clear these unused autogroup by current kernel,
> so I write a separate module to clear those unused autogroup for my system.
> I think we should provide a interface to detach a process's autogroup.
>
ping
