Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6132DC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B06020724
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFrhlA2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgDXIVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgDXIVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:21:50 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82F9C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:21:49 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id c17so8599360uae.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Odi1ziVK1CcSvxbtWVKLHGTvitokOWski09WlRklulg=;
        b=XFrhlA2D4r6LyWN/vMKM5EZss4qMC2FKOueM0iCNZPF0PmlTgVe2q0aD3BRkQctr30
         /RXoOhK7B4w98jrF3gwlGwtMxa2y559IHNrgfg25YtFHMN2MRrsoPEHeHcmyHeSOUJnH
         t77IuyWOrVaA5pP1FYEiRuPCJmZ2wqgWcREYXjc9LgCQg0kY/UFG0IFxkJLQDMtvUDlr
         jdnIySQHip5OJ/DZPD7V1erXlx/LVqSKTKmD117kKWpmgdXncqKHcyYcxXDGmPgIIK3c
         hAuEq3Qff7L0+HpW91AvuKUuodfD0TwWwmkiot7C+93sYzY8iteacJjs5s3o6tBFcpbF
         82OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Odi1ziVK1CcSvxbtWVKLHGTvitokOWski09WlRklulg=;
        b=SnR53+xbK5Cua2hnonv89/GEC8Du0AKAY9H+TnJGhtQXERBnFLCRd84OMHPSMZpvIZ
         lAVIQtxtHQfFO5H15mhc11qJem41TBEf0fcB8vldvDJIFt5gH0FM6WX57sNtthWBQiEw
         6AMS04StlH5H6TMRxjtVaoKQlY5noPp6+jcubZiw+D2RlKVBEqS7y3tGjF8gKfSb5ddy
         G6+H2AA2YsZt+BwYeuGUSGW8s/CQ82sNc1nGEjm4lpBKVvMcZDnrD4vFrJgKvPrxG4I1
         1tTGSALClWA3xL/GGgplKQPE28uhz2V6YxawAPogf3hlzxQQnq8fKWMEZUI7XEL+dMmF
         afBA==
X-Gm-Message-State: AGi0Pub9WNi2Zp7cxzo2z5ADCdbtNBM1bI/vhdOyRF32gCnDPEDIqQ+r
        t9rTlEvtUkWt5HYzoCCUvozB/El9BtJ5JSURQ/wukHA=
X-Google-Smtp-Source: APiQypISzy34zpElN5spEfyfFWgrLoB2FrRXG/mlFt7B4sc3eXIkkiMykN6eJVLLlza8iSIzq7mCmza6bazPxvHo4Z4=
X-Received: by 2002:ab0:238f:: with SMTP id b15mr6531756uan.32.1587716509046;
 Fri, 24 Apr 2020 01:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvaiCzPQT6Jrx4pFW6KuZj2WLSQQpCbU-sg1jEgscQAKFQ@mail.gmail.com>
 <1587715859.28179.17.camel@suse.cz>
In-Reply-To: <1587715859.28179.17.camel@suse.cz>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Fri, 24 Apr 2020 09:21:37 +0100
Message-ID: <CALjTZvZ2B3X1F=tVOvC4h0yGAfEvfu6HUZERmydMrVRsXdOtuQ@mail.gmail.com>
Subject: Re: [BISECTED] bug/regression, x86-64: completely unbootable machine
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 at 09:11, Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> Hello Rui,
>
> thanks for the report.
>
> The problem you encountered is due to a bug where the code doesn't work on
> machines with less than 4 physical CPU cores. It is fixed by this patch
> series:
>
> https://lore.kernel.org/lkml/20200416054745.740-1-ggherdovich@suse.cz/
>
> The series has been merged in the branch sched/urgent of the "tip" tree
> (https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git), the commit
> fixing the bug you observed is 23ccee22e834 (x86, sched: Account for CPUs
> with less than 4 cores in freq. invariance), and will be merged in Linus'
> tree at some point.
>
>
> Thanks,
> Giovanni Gherdovich

Hi, Giovanni,

Great, thanks for the quick turnaround. I wager it will have hit
Linus' tree by 5.7-rc3.

Best regards,
Rui
