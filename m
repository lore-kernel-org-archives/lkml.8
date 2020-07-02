Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3311C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11F2206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ae+yR2xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgGBKWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgGBKVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:21:21 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E414C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 03:21:17 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id e13so25086225qkg.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ytrORF9e9WO5GmQr4Ib8G4OdlaRfZagxt8cdDGYBh88=;
        b=ae+yR2xba3jzWsYrhjh4aWrHLc9AlRocYJ0JEmq3EQigaJ4RNW9ivnNYinskzxyPUu
         fYhYUS5ldXzWoyodZAoAGK93++Dzakve65ZcJ70Tc8BlOrTxNP+32/353MwhrRTD8XY7
         14OM44c2Npm7C5ul7Fr82mjLVW+ElBry0NGWMaQHLKRVkyOLRN1qAaFPdtnsmtm47uFo
         ZYcfcIGgoqBEHUrj2Xsw/tIlyiIxpiDS9fyCPLpNG+wktz43JazR6iN06WedgCqCZ4tv
         a5idhRvLXbAHKNmp0u9w2H2ImOyBX2+UTaIjTW9ZtgpwIr4Myn6EQljqPLWeBOkyyZqB
         hhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ytrORF9e9WO5GmQr4Ib8G4OdlaRfZagxt8cdDGYBh88=;
        b=G2cZs4Fy/1f5EaCWfsQjvJEO3HpTtcZSm4RDTuIH7FAV5nGP2TuOkDl0aHA1qH+FQZ
         xEeX2E24skVl5wV0SdAp2YIcdJXsTpGyKMO76Rez+wUtb72oy98GK+l8Bv/0hr09hqBM
         hHi8/iCi4eCm6WTFF7AJ5RmLmSa6EPZGOU+EEpUU/ElBsF23haMAvNBJh80mgN7i4BCF
         g3jdlb3A0fdHk9Ao38AkFoIxbY3m3HnMtZsrnQwNnp+ICsdY6wCJWtBff3fU4xhTecCp
         y9LRgL8Mx5CBfyfbZg9T12tCWcT+tuw5fG0wu15jEoRcx2mMJp2BzQj3FUEtURhInWaV
         fz6w==
X-Gm-Message-State: AOAM5318HwaJfoYDtgYCt7x4QyXLSYGr7BphZW+ZQsuiHIOMfkfi02Ti
        nipnm/MTLBHT4ZlVgjG+KhEELwZGR9XacD0D44Q=
X-Google-Smtp-Source: ABdhPJzM0A+BFVGHroMWch0FzJw1+MEMvaZhzVESe7m3NsLA7Dgwgjuib+pGPpBGn0JhZxxwUIx4/By0QM8fGuBONHU=
X-Received: by 2002:a37:a458:: with SMTP id n85mr30887579qke.167.1593685276664;
 Thu, 02 Jul 2020 03:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200702052039.GA2824@192.168.3.9> <20200702081418.GZ4781@hirez.programming.kicks-ass.net>
In-Reply-To: <20200702081418.GZ4781@hirez.programming.kicks-ass.net>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Thu, 2 Jul 2020 18:21:05 +0800
Message-ID: <CAA70yB4zLkizEAHSTag1VQwtuOrEaNEeCa9Er7MAzdpfZRJOeQ@mail.gmail.com>
Subject: Re: [RFC PATCH] proc: add support detach proccess's autogroup
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 4:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jul 02, 2020 at 01:20:43PM +0800, Weiping Zhang wrote:
> > Since setid will create a autogroup for that process, there is no
> > way to detach a process from that autogroup, this patch add a new interface
> > to detach a process from its autogroup. You can write anything to
> > /proc/<pid>/autogroup_detach to do that.
>
> This is indeed what the patch does; but it fails to tell me why. Why do
> we want this? Why should I care about your patch :-)
>
> Please, always explain why you want things done, that can also help us
> consider if the proposed solution is the right one.

The reason is that, there are lots of autogroup created in our system, because
I forgot to disable CONFIG_SCHED_AUTOGROUP, and it leads to a hotspot
in tg_load_down (kenrel-3.10.0-514.16.1.el7.x86_64).
When user login system by ssh and launch a background job, it will create a
new autogroup even user logout ssh.
I cannot find a way do clear these unused autogroup by current kernel,
so I write a separate module to clear those unused autogroup for my system.
I think we should provide a interface to detach a process's autogroup.

Thanks
