Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B951C55197
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA702098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iB1jjpAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgDXTnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgDXTnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:43:40 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13BAC09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 12:43:40 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id c24so10683013uap.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYIyO0FM6OKLTtdidib4kMcRxKmjnuqRDI/kUo72TPs=;
        b=iB1jjpAPyu5N+Ty0NvIhETMALoLw3CWs1vsmNe2SNdO3f2nhQ/G117vxfSTMqpjmp3
         kWTI4UFRErUQddDTVOeyXh3p/aBKbAiVEbsOTjsoopA9/inmwJ0b22h9QQthrtyJhe5f
         aEWQ9wzmaYdHFzXlIn4rMfCyLFLx0p9W+O6uPflycOwPNAXikNYhRwd23PlWaUdh5o19
         +p56EjWuBxrskFZiFuReT57UOngHnfrUzIgPQdCRfhGL12cWrIjK3ZfkIGx7aTxvS1bK
         bjqcOSNHvYE4Se4z0d8UOpQ7EUOw/gormYfm5EAbxC5xxNMvlTaXfdv3D2kzbzmjKtDu
         bOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYIyO0FM6OKLTtdidib4kMcRxKmjnuqRDI/kUo72TPs=;
        b=pxmrJeYaSBGFU4O+YbC323OfGGrhEzAVk7jZ4MPPa9pB2F2eN5XyQjomJjnYXBpvdM
         z+1oEviJoueLyRXt7V9AEPCyADdmrFN+4Nsvj3gyVlF6Uge6kUDq7iHCFbolKkJFWnOv
         D/ELu9CcZ6ekGmyLz87hIbGn8Myy0nFByCEktUG1bVin9tie59Xid7ITmRl3l9iMsLkC
         WdY3sH4prFX+F0cbLK+vZ6lu37IBPabi/0/YbM7T+5T5U32pre3yAdmHhzlJtXQW56HW
         WxGcMQYkbL+RhfXcJLCLh2d1ibP8w1LjUSaKmbrWbgXW/u7MrHOJ3H/yjgOOSDHT9vrD
         hUPw==
X-Gm-Message-State: AGi0PubiKO8E62c0rWrUp1mSwMk6xifb1xoDdD9B8/l6zLT3zQYtvFXb
        +G0fREY2Aemz2LoE+283ayn2vFb3JnyzR6gk+zZf+A==
X-Google-Smtp-Source: APiQypLbCAPlZZDSVGcMwx906oxRyln6GauufX0aC9cwnkiQn/QK/qcy4q5D1KHXLNqyNSNn+GZ2PeLwEhU2CmLECH4=
X-Received: by 2002:ab0:485:: with SMTP id 5mr8980818uaw.86.1587757419335;
 Fri, 24 Apr 2020 12:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200424153859.GA1481119@chrisdown.name>
In-Reply-To: <20200424153859.GA1481119@chrisdown.name>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 24 Apr 2020 12:43:28 -0700
Message-ID: <CAJuCfpGnJBEvQTUeJ_U6+rHmPcMjw_pPL+QFj7Sec5fHZPH67w@mail.gmail.com>
Subject: Re: PSI poll() support for unprivileged users
To:     Chris Down <chris@chrisdown.name>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 8:39 AM Chris Down <chris@chrisdown.name> wrote:
>
> Hi Suren,

Hi Chris,

>
> I noticed that one restriction of the PSI poll() interface is that currently
> only root can set up new triggers. Talking to Johannes, it seems the reason for
> this was that you end up with a realtime kernel thread for every cgroup where a
> trigger is set, and this could be used by unprivileged users to sap resources.
>

This reasoning is correct and IIRC the enforcement of this is just the
way /proc/pressure files are created:

proc_create("pressure/io", 0, NULL, &psi_io_fops);
proc_create("pressure/memory", 0, NULL, &psi_memory_fops);
proc_create("pressure/cpu", 0, NULL, &psi_cpu_fops);

IOW there are no additional capability checks performed on the PSI
trigger users.

> I'm building a userspace daemon for desktop users which notifies based on
> pressure events, and it's particularly janky to ask people to run such a
> notifier as root: the notification mechanism is usually tied to the user's
> display server auth, and the surrounding environment is generally pretty
> important to maintain. In addition to this, just in general this doesn't feel
> like the kind of feature that by its nature needs to be restricted to root --
> it seems reasonable that there would be unprivileged users which want to use
> this, and that not using RT threads would be acceptable in that scenario.

For these cases you can provide a userspace privileged daemon that
will relay pressure notifications to its unprivileged clients. This is
what we do on Android - Android Management Server registers its PSI
triggers and then relays low memory notifications to unprivileged
apps.
Another approach is taken by Android Low Memory Killer Daemon (lmkd)
which is an unprivileged process but registers its PSI triggers. The
trick is that the init process executes "chmod 0664
/proc/pressure/memory" from its init script and further restrictions
are enforced by selinux policy granting only LMKD write access to this
file.

Would any of these options work for you?

> Have you considered making the per-cgroup RT threads optional? If the
> processing isn't done in the FIFO kthread for unprivileged users, I think it
> should be safe to allow them to write to pressure files (perhaps with some
> additional limits or restrictions on things like the interval, as needed).

I didn't consider that as I viewed memory condition tracking that
consumes kernel resources as being potentially exploitable. RT threads
did make that more of an issue but even without them I'm not sure we
should allow unprivileged processes to create unlimited numbers of
triggers each of which is not really free.

>
> Thanks!
>
> Chris

Thanks,
Suren.
