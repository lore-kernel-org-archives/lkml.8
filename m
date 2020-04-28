Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02086C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB5B206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="RRskRblw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgD1LfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgD1LfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:35:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E21C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 04:34:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k13so24264184wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 04:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ta9b/8gauzmTI1gIbmZerg7kvPJYi178ogRC123bJng=;
        b=RRskRblw7O421JDMKdFMipZxdX5l49wk9LmGVv7DG2WqI92bmAxAf07k8jzdM/nwXR
         h95QKhZkGtM21cvhr8D6wOrDDjDIrEY1cL7ekNokImsPllbcXbfOxj2m6AvR6xMBUkrI
         8IN0Ms7BtuAaq5VA0a5wl9c9u1MD0O6i12UFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ta9b/8gauzmTI1gIbmZerg7kvPJYi178ogRC123bJng=;
        b=fNlMNodcBEHEDGB4ZLSkCev8n6nULfzNoXMPW4G1/pW5lZCfeCCld+ipw744+lKOpG
         MajAOmgSL8wfw80lef1wxsLn02E3BSsgZra2KTXe7GIpaCDKXTZRn5qUq6zpQi2dlv7p
         PxZuEpoRoQnZs4jSq3Ld+g7BY8TXD1LWniQ0JrWh1km3K7pJD7glZnx8kEU3DyCARgjv
         Cu17V4RrUswYsQ7fTh3y0/DW/ClmBF23BhjXYMCvbTCDBXHGtw15W9npuL3Q1N0vVMEA
         rXuC/Ggx/DgUOkUAa3uegElOnDfDrlzQIFSAlIHho4oidrOVEM/VsvmX5ugSA+CVmdBM
         +asA==
X-Gm-Message-State: AGi0Pua6L9am16T42PPAvR+Ug3AfuRbwb81wQQWKHRqpoPQCV08SuHl8
        cVJ0hJfTGEe/VEkHqrm1kHAb3A==
X-Google-Smtp-Source: APiQypJ4KyDDnBwcz6hpw/89Oxe5qXytwq5XOI8oPR+V6xK0/Ckt19RXYl/6gv5+eaX6TOoO1VQ8Cw==
X-Received: by 2002:adf:82a6:: with SMTP id 35mr31359798wrc.378.1588073697690;
        Tue, 28 Apr 2020 04:34:57 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:13ec])
        by smtp.gmail.com with ESMTPSA id f2sm26392729wro.59.2020.04.28.04.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 04:34:57 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:34:56 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: PSI poll() support for unprivileged users
Message-ID: <20200428113456.GA2170292@chrisdown.name>
References: <20200424153859.GA1481119@chrisdown.name>
 <CAJuCfpGnJBEvQTUeJ_U6+rHmPcMjw_pPL+QFj7Sec5fHZPH67w@mail.gmail.com>
 <CAJuCfpFhsN1=kDK0tU8aWeNt5Dj6U_1rC_dVT-27a4TL_hF0gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJuCfpFhsN1=kDK0tU8aWeNt5Dj6U_1rC_dVT-27a4TL_hF0gA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Suren,

Suren Baghdasaryan writes:
>> > I'm building a userspace daemon for desktop users which notifies based on
>> > pressure events, and it's particularly janky to ask people to run such a
>> > notifier as root: the notification mechanism is usually tied to the user's
>> > display server auth, and the surrounding environment is generally pretty
>> > important to maintain. In addition to this, just in general this doesn't feel
>> > like the kind of feature that by its nature needs to be restricted to root --
>> > it seems reasonable that there would be unprivileged users which want to use
>> > this, and that not using RT threads would be acceptable in that scenario.
>>
>> For these cases you can provide a userspace privileged daemon that
>> will relay pressure notifications to its unprivileged clients. This is
>> what we do on Android - Android Management Server registers its PSI
>> triggers and then relays low memory notifications to unprivileged
>> apps.
>> Another approach is taken by Android Low Memory Killer Daemon (lmkd)
>> which is an unprivileged process but registers its PSI triggers. The
>> trick is that the init process executes "chmod 0664
>> /proc/pressure/memory" from its init script and further restrictions
>> are enforced by selinux policy granting only LMKD write access to this
>> file.
>>
>> Would any of these options work for you?

Hmm, I think these are reasonable options when you have control over the 
system, but not so great if you don't. For example, I want to get pressure 
notifications for my logind seat, but that doesn't necessarily imply that I 
have administrative access to the machine.

>> > Have you considered making the per-cgroup RT threads optional? If the
>> > processing isn't done in the FIFO kthread for unprivileged users, I think it
>> > should be safe to allow them to write to pressure files (perhaps with some
>> > additional limits or restrictions on things like the interval, as needed).
>>
>> I didn't consider that as I viewed memory condition tracking that
>> consumes kernel resources as being potentially exploitable. RT threads
>> did make that more of an issue but even without them I'm not sure we
>> should allow unprivileged processes to create unlimited numbers of
>> triggers each of which is not really free.

There's precedent for other similar issues like this in the kernel, eg. rates 
for some ICMP packets, where we enforce a static limit in the kernel for 
unprivileged users. I'd imagine we can do something similar here, too.

>Thinking some more about this. LMKD in the above-mentioned usecase is
>not a privileged process but it is granted access to PSI triggers by a
>privileged init process+sepolicy and it needs RT threads to react to
>memory pressure promptly without being preempted. If we allow only the
>privileged users to have RT threads for PSI triggers then that
>requirement would break this scenario and LMKD won't be able to use RT
>threads.

Well, fiddlesticks :-)

If we needed to have both, I don't know what the interface would look like, but 
yes, it sounds overcomplicated. I'll think about it some more.

Thanks,

Chris
