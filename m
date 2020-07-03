Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3266FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A39A20B80
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lQwRKFro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgGCRIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgGCRIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:08:07 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D6CC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:08:06 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k17so6106786lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGIWYGclw9/se36iCMUa3R+SNfFXJ4xJXXtTXZwYe78=;
        b=lQwRKFroLLPm5QHChkg3JAbf09EtECvI6zfs4GvXqOv6vnLW7/Wzd13wD75qKSfnz7
         W1oWm4sqRuHKPH1SdI5iJKGlkA0Xb2bvhBW7TZtX2L6BQcz3N0aW1yF8wULQzZlIztY4
         7kjf7CwY4DS9N6TgXcRNaWIPTwxbCA1zxLgfB1vgO8Xf7Au25qL7io068STZgVpzTVlj
         B2xlQGLVq9WMVnXwtAuwrqoZcn+ghylFGdG243Z7HRbA1YBhwJXVFclBTU65JPHo3c8y
         ZJHiY2rY+ftttiBN6+jSkr3vdfkeY6y2ljaNxxWUyu5GeAP4NrTT/+E6zuHuGWzPstxj
         1bIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGIWYGclw9/se36iCMUa3R+SNfFXJ4xJXXtTXZwYe78=;
        b=NOYWgJCpMm4OodNw+jVV338kHNmBSNPy/Y118zCEd1HLs2+ERcJm1vnTjXQebCK22b
         8IIYt2xehCfxpXXVfL6iYDeZGzyU38nT2DinuroqA9ct0FbtK9D0vcjQhRfY8FIL1LSk
         dh1/ESQqib4AJPR9wbCyhF/WBxQrMUByPbg5PRbOWF6MIzsrEQTpC3Jxt1B4kII4LhTH
         vqlGM3vAOaqcG9BZ8EevoOMlbf+8XORceDkmsJk3mBv6FI9VeC8IqpI7y3gWDpKZyLV1
         0oyyoaJRJlOvdNDH+SzWV51wd0wBxB4gdk5aQEPwhzxg/36xNthjQgTEJb2Vfg6yf9n0
         tA5A==
X-Gm-Message-State: AOAM532GfDPkZPfNMARya24VPJ3JoNS0k5HRmt0QpPJBPkEqutT2Klt8
        Agf4g3Yv0OkCFHssgHS2ZRSdGIYi8k5WKUw0/Q==
X-Google-Smtp-Source: ABdhPJxUWKoOZWgsUGY+b0V4Mt13R2qjCpnNvZ54FXAo55sJdwmd5hZqaFXU13je82BQtku2OjEGo0UtL9y9uo7v7s0=
X-Received: by 2002:ac2:5443:: with SMTP id d3mr22423704lfn.121.1593796085271;
 Fri, 03 Jul 2020 10:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200703155749.GA6255@pc636>
In-Reply-To: <20200703155749.GA6255@pc636>
From:   Gabriel C <nix.or.die@googlemail.com>
Date:   Fri, 3 Jul 2020 19:07:39 +0200
Message-ID: <CAEJqkgiFFh8CvXkM4ZzXxNQmOJLL7WcgDL6rM83safNgEewZ9w@mail.gmail.com>
Subject: Re: nr_cpu_ids vs AMD 3970x(32 physical CPUs)
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        GregKroah-Hartmangregkh@linuxfoundation.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr., 3. Juli 2020 um 17:58 Uhr schrieb Uladzislau Rezki <urezki@gmail.com>:
>
> Hello, folk.

Hello,

>
> I have a system based on AMD 3970x CPUs. It has 32 physical cores
> and 64 threads. It seems that "nr_cpu_ids" variable is not correctly
> set on latest 5.8-rc3 kernel. Please have a look below on dmesg output:
>
> <snip>
> urezki@pc638:~$ sudo dmesg | grep 128
> [    0.000000] IOAPIC[0]: apic_id 128, version 33, address 0xfec00000, GSI 0-23
> [    0.000000] smpboot: Allowing 128 CPUs, 64 hotplug CPUs
> [    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:128 nr_node_ids:1
> ...
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=128, Nodes=1
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=128.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=128
> urezki@pc638:~$
> <snip>
>
> For example SLUB thinks that it deals with 128 CPUs in the system what is
> wrong if i do not miss something. Since nr_cpu_ids is broken(?), thus the
> "cpu_possible_mask" does not correspond to reality as well.
>
> Any thoughts?

This is not a 5.8-rc3 problem. Almost all AMD CPUs and APUs are
looking like this.
The only CPUs I own are getting that right is a dual EPYC box,
everything else is broken
regarding the right C/T & socket(s) count, and that probably bc is
using NUAM code
to have the info.

I reported that a while back and no-one ever cared.

There is even a comment in the hotplug code saying setting the wrong CPU count
is a waste of resources.

I have a 2200G is reporting 48Cores.

AMD Ryzen 7 3750H reporting twice the cores and twice the socket.

...

[    0.040578] smpboot: Allowing 16 CPUs, 8 hotplug CPUs
...
[    0.382122] smpboot: Max logical packages: 2
..

I boot all the boxes restricting the cores to the correct count on the
command line.

Wasted resource or not, this is still a bug IMO.

Best Regards,

Gabriel C
