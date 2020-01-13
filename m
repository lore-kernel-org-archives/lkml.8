Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFE6C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536C92081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d8i7XTNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgAMSi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:38:58 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40259 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgAMSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:38:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id c77so9237773oib.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 10:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cGW0Khst53+VyBuFsjl4dOwNiUvK/2GW3tg88oBHadY=;
        b=d8i7XTNWkg4Lcja5cQM/ZeAXWJtULssp/GxEbRAb21HJFYTJsuU9CH9fG1w4dy9LYq
         ROJh4sTI1Wfl9dCF/Sf96ukTS4L2H6vQZ6aI0xjM/zUhz2EQXM52TTZsoe0jwqlxUdRj
         zi4VnGwztAfYw1eG97WDypmdrM8xeLiU4jctcbo/GqiKiRAAQIds7B2If5zgPfOdVzDD
         6vP3owEKYV881z+qbBmxo8EjocHlEVEb4ntwHkUs9Bn+3E86YMVc/U75j+qdfVHkiRWl
         8ghwEe0mue9wLH4jSDISd90OVBlg/qOs7bWvYKYBeVwx4zDuTNTs3v92wiQ1w+qGHTCz
         Xy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGW0Khst53+VyBuFsjl4dOwNiUvK/2GW3tg88oBHadY=;
        b=ILysw/Iw81yXZhOggfdG4knunineyQgI25xOzoa8vJr5IL121YeHTTVWN6+lwqcQFU
         jm95O35qNzseyJd7UKbxCw+tVXohMa4jaO4KndWJ4OXiM+CWNbGcGq4qCzFK5u3vtsJ+
         +x1k5b9e1LUOQfgZQjDX1vbumdSXFIN0jBXx5HuX73En6vXYk7zfY/qz4d3ccFFHL0G6
         YyarLseQMsm9VTBXsBtI1za3YJdqoaVSNMMbL1nxPKc/8wGkjBD8h4hmp6p7hnOFt/SC
         jwymU3xpgoSq90NVrbjz/zYfaYCUUFNe+xhzIKI8A2sYAcL6BgH5OIC8VEzvt0VeX+No
         ixfA==
X-Gm-Message-State: APjAAAXtpDr84F2u9otOBS+Xf4qZssIHhGuhS4FphMzZnhrVVG1ecgtM
        HuZ0ePPr5mbhnkJ7NdcuoGrmX8dhp4LwKjD+WK63Vw==
X-Google-Smtp-Source: APXvYqz8ssCJPRbaLZ7FLBwTvLiPXDiN1s5LzcWP4+UO3GTzT361QVHJlv68dIWWiEeENtI6FCDqE1/uVeq9U5UsC2c=
X-Received: by 2002:aca:4183:: with SMTP id o125mr13027850oia.125.1578940736791;
 Mon, 13 Jan 2020 10:38:56 -0800 (PST)
MIME-Version: 1.0
References: <CALvZod7E9zzHwenzf7objzGKsdBmVwTgEJ0nPgs0LUFU3SN5Pw@mail.gmail.com>
 <20200108202311.GA40461@romley-ivt3.sc.intel.com> <bbc27400-68d9-13fd-7402-d158a6754122@intel.com>
 <20200108214250.GB40461@romley-ivt3.sc.intel.com> <c1c19ba6-4113-fa4d-4313-4d1d551a95f2@intel.com>
In-Reply-To: <c1c19ba6-4113-fa4d-4313-4d1d551a95f2@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 13 Jan 2020 10:38:45 -0800
Message-ID: <CALvZod7-FkBf0JcCHe5M5HM7s1Pt3c0d0VaVE0MQ3yWpa7bSdA@mail.gmail.com>
Subject: Re: [bug report] resctrl high memory comsumption
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 1:54 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Fenghua,
>
> On 1/8/2020 1:42 PM, Fenghua Yu wrote:
> > On Wed, Jan 08, 2020 at 12:42:17PM -0800, Reinette Chatre wrote:
> >> Hi Fenghua,
> >> On 1/8/2020 12:23 PM, Fenghua Yu wrote:
> >>> On Wed, Jan 08, 2020 at 09:07:41AM -0800, Shakeel Butt wrote:
> >>>> Recently we had a bug in the system software writing the same pids to
> >>>> the tasks file of resctrl group multiple times. The resctrl code
> >>> Subject: [RFC PATCH] x86/resctrl: Fix redundant task movements
> >> I think your fix would address this specific use case but a slightly
> >> different use case will still encounter the problem of high memory
> >> consumption. If for example, sleeping tasks are moved (many times)
> >> between resource or monitoring groups then their task_works queue would
> >> just keep growing. It seems that a call to task_work_cancel() before
> >> adding a new work item should address all these cases?
> >
> > The checking code in this patch is also helpful to avoid redundant
> > task move preparation (kzalloc(), task_work_add(), etc) in the same
> > rdtgroup.
>
> Indeed.
>
> >
> > How about adding both the checking code and task_work_cancel()?
>
> That does sound good to me.
>

Hi Fenghua, any updates here?

> There is something in the current implementation that I would appreciate
> your feedback on: Currently the task's closid and rmid are initialized
> _after_ the call to task_work_add() succeeds. Should these not be
> initialized before the call to task_work_add()?
>

This seems like a potential race.

thanks,
Shakeel
