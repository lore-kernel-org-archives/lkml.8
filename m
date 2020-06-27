Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5AAC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 21:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8614F2071A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 21:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593291844;
	bh=8yz1U4Hg/HTi6bS5D15L7PS/HkeMso5sGCCKE1yJF5E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LcJ2G8Sc6m2RUST6OOhwNZJ732yS+Zy/YAUxSLL8BZzjpJ8ubyVqbKvfomHZg0FF2
	 mS7LWSJeD/m5AKcIg2nX6tzdeiDlvsQZ4K9NkzklC1glaBfMzAN475BFThi33z/nTD
	 AINkVHUPdBH9EQV1w3aIrZn0ndv+lbxBU+gS42ZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgF0VED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 17:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgF0VEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 17:04:02 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFEE720739
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 21:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593291842;
        bh=8yz1U4Hg/HTi6bS5D15L7PS/HkeMso5sGCCKE1yJF5E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I9wLi6Vzlro0cukoNDE+lbHWVHLL1vKXvTJrhoAiPHrRSQqe/fQvq8JSldFkiXXKS
         wsKn/qYQy7wegGXlboiJrcEU88FaiuYeW6vFfdcRhSDAnLLatAn+npu/4+wLDyII0x
         2zRNaKpyRRoJESLz/mfyYLqXKww1elpWNkREsD80=
Received: by mail-wr1-f44.google.com with SMTP id z13so12743309wrw.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 14:04:01 -0700 (PDT)
X-Gm-Message-State: AOAM530WQQmsjFK+D4FMTfnrApbnFyaqrGQsPvZi0hkhmOrp74HNuY28
        4e+zn4uYSoNwBjGXjc14z18LfuI6EddE/cseS3t4Fw==
X-Google-Smtp-Source: ABdhPJxZ6F7drITwC1Z8zrbro7np9bRzl/PhypTnIfLU2xC0Y3hHMA3NN35621FQmG8Xa9hB1iyccqTmM0X8aVqL7hI=
X-Received: by 2002:adf:8104:: with SMTP id 4mr10199365wrm.18.1593291840650;
 Sat, 27 Jun 2020 14:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <87mu5roov6.fsf@nanos.tec.linutronix.de> <20200529082618.1697-1-laijs@linux.alibaba.com>
 <CALCETrXKdh=nBWz96pow5roLmh0ez2YeQ9P+H5gxdor5TfrqUQ@mail.gmail.com>
 <CAJhGHyBSzhm7h5dROAKSzdSD3czmUNG+80rS9tpaau_U23p4Ug@mail.gmail.com>
 <CAJhGHyC+LswHw+=Ymo92CX-ffFB=PJRP0bSLOWEN42KLPfvJ6w@mail.gmail.com> <877dw4cvng.fsf@nanos.tec.linutronix.de>
In-Reply-To: <877dw4cvng.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 27 Jun 2020 14:03:49 -0700
X-Gmail-Original-Message-ID: <CALCETrWx66qLc-NiwKS_Zu=BP8JDTzfeUO7A2vDd01kXNmiNiA@mail.gmail.com>
Message-ID: <CALCETrWx66qLc-NiwKS_Zu=BP8JDTzfeUO7A2vDd01kXNmiNiA@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] x86/entry: simply stack switching when exception
 on userspace
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 7:10 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Lai,
>
> Lai Jiangshan <jiangshanlai+lkml@gmail.com> writes:
>
> > Hello and Ping
>
> you have poked on that on Tuesday, i.e. 2 days ago. It's on the todo
> list, but not the must urgent problem on the planet.
>

Just as a heads up, I'd be surprised if I can get to this in time for
5.9.  I'm still dealing with the fallout from 5.8-rc1, and there's no
shortage of fallout...

-Andy
