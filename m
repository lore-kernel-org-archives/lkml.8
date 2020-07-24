Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915F9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D7E42073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0YrLs84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgGXMJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgGXMI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:08:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA332C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 05:08:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x5so7191136wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rbilDyoAGD8fHqiMG+SK9j6c/X8TIU1Eaip9AXG2aTM=;
        b=s0YrLs84fl1PmDJdDFoY0Oz6m7PkbwBWhwEOgH/gB5Fe65olAPq2wbnB846Zr7Smu9
         ZKmCvFbu4M3IjoTgeVO/wI4v8SaaDtpfyypZybREdhQip4WTcBm+Rx8GPrf37Li1kxsf
         /+4H/blRZVjNaHVBH3d/AnF4DnyvNaS4XZgkbJmK+wopwVhmaHWOUOh4AYgzbmwogjiM
         rbcLQt2pycRor1soqxpM5MFeAfsxDLC/gESoT5v6Y0aYvz+uWLZiPLXEYsNfLsgxuRkE
         UP74bilx+KRJWYIiDJr488q4/nafesBrlecnMbVXgzF3qZFwLQL73jToOU3LpfR1hNtH
         6+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rbilDyoAGD8fHqiMG+SK9j6c/X8TIU1Eaip9AXG2aTM=;
        b=BxPsW9IN8NtVUfS9LpvaUMZffRodNgTjF6TmByutH3TPM4T174vBa2vikkhv/Q5g9h
         qB6Z5Dpqa08VTMXo9t1U/pzdRpqvxw+2MyU7w+dOJb2zgSs/S9ad8lkBBIIQ70vLo8BW
         Dc0Vo6IKqijaNkFi8XYDDlV1x8xcG2JD5ga1S7Zn8xkbpA4tiDWrzMWpw+752Z3EtgSH
         5h1Uxj6kfpz3fgp1Th8WwTAkeRyWFXgZ2WvIYGr5txB4c1ZdDW2kOld+j7p0TQGRY4Nh
         w4uwxk4RZMh5UG7v2qJzbdq6MncZU7V/H25Yjjv8l0A2o6J22aHnoWvKuG5q+CGibeH1
         Dsug==
X-Gm-Message-State: AOAM532+SwqWDgbFlMruSEhOyqrzewCpE/yq598wQ5PGX6gI1wYyRB27
        Kqx0arP4jmW5WhgK6wTJxbMjhinMvGZiwkq+rR8=
X-Google-Smtp-Source: ABdhPJx3s6PKr19pNAPoRFfFWv3+9HCtcpn0Y8yvXnQhQ1rhlLBPr3umhkH66ZUbcfMIiBL9oLH/BhrjHHoSdq4f7VI=
X-Received: by 2002:a1c:28a:: with SMTP id 132mr8365570wmc.109.1595592534535;
 Fri, 24 Jul 2020 05:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <2d0e3da8c80c314048d598fb03ae3fe52d9619f3.1593530334.git.vpillai@digitalocean.com>
 <4229D3E1-8792-4B43-9AC4-F648D49CCC99@tencent.com> <20200724071458.lah33iacywx35hdi@aaronlu-desktop>
In-Reply-To: <20200724071458.lah33iacywx35hdi@aaronlu-desktop>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Fri, 24 Jul 2020 20:08:43 +0800
Message-ID: <CAPJCdBk6gWwEkPGTr3=kCZ9QXboUfPFDPCA1oRgSg1cD_kHUrQ@mail.gmail.com>
Subject: Re: [RFC PATCH 09/16] sched/fair: core wide cfs task priority
 comparison(Internet mail)
To:     Aaron Lu <aaron.lwe@gmail.com>
Cc:     =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pjt@google.com" <pjt@google.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "subhra.mazumdar@oracle.com" <subhra.mazumdar@oracle.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kerrnel@google.com" <kerrnel@google.com>,
        Phil Auld <pauld@redhat.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "vineethrp@gmail.com" <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aaron Lu <ziqian.lzq@antfin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 at 15:17, Aaron Lu <aaron.lwe@gmail.com> wrote:
>
> On Wed, Jul 22, 2020 at 12:23:44AM +0000, benbjiang(=E8=92=8B=E5=BD=AA) w=
rote:
> >
> >
> > > +/*
> > > + * This function takes care of adjusting the min_vruntime of sibling=
s of
> > > + * a core during coresched enable/disable.
> > > + * This is called in stop machine context so no need to take the rq =
lock.
> > Hi,
> >
> > IMHO, it seems that stop machine context cannot guarantee race free. Th=
e param *cpu* maybe not *this_cpu*, rq lock should be taken even in stop ma=
chine context, and irq should be disabled too, to avoid potential races wit=
h other contexts.
> >
>
> In stop machine context, all CPUs except the active ones are spinning
> with irq disabled and in this invocation of stop_machine(), only one
> CPU is active so I don't think race is possible.
You're right, stop_machine provides much more protection than stop_*_cpu.
Thanks for the explanation.

Regards,
Jiang
