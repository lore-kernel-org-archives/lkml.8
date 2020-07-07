Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96917C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A1CF206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lX6RRZO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgGGTyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgGGTyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:54:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53668C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 12:54:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w3so391576wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 12:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=cyTfJLNquzRQmiKrpHKDnhwW/N+p/GExldJfwiteKnE=;
        b=lX6RRZO9VbhYRvz3OLKgDI91FR04aXdCWuz/PEoEdgjW59uilGbiclyrTE5tiwUfdw
         Ryr1CD6djJ3V6XzmZmT++qn0jd+gwJDzN8ZBAvv1YB2wya7a+lY118f3F8FTMth9B2ob
         gJANRjVRerxX1x0wARIUS65Ai9d9Kb+ZMWBSmWz06riDid425TYGdHZBD2hXn/e4c4+u
         tpByIr6augMy8y59sU0A+VFsLag1aW7VnaRWOiXpaHaTIOd0KmMtdGzoYSWpOFatFyBq
         CPEV/o+ehMh3upyU6DLezvHyafuIqsS9V3/LM0MW9s2A4MOiEgQyJUUQldJqd9nFw8Xd
         9Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=cyTfJLNquzRQmiKrpHKDnhwW/N+p/GExldJfwiteKnE=;
        b=RjqpK4Qc8JAVig7/nChhfD/PNz1mLZeiiPEs+eviImU9fN7btcZo6nFfAnS/ufGIY8
         rZKss8uFBSgQ52slVomr3ehnS3cr7uoFgyzQg7gL4SEpfjNePLc2e3Q4NZUjtu/d6rZv
         BZHoo2ujxnvqQj5OCJDivUpp1K4e0fO/wslhEcpZkFN1MVTmnP2cfRTRQteJAGkrfSFb
         740Zfwsoa0gAfIi50WaLVKB3fxSR7XhiC+nYZFCE+zAMQK+7v0HLFSedW6oclpLND+6I
         1YXgeeT+aDf/1R+saGmW7GAwddOrOiQxMfSYQYIBf3jk7l0LapgYYFHM+UkehhaamIED
         Jljw==
X-Gm-Message-State: AOAM5307MnMOSmAflabQLMLfDmMxa0p01oSfONqVBUT3z/Swv7P9M0ys
        fKgMu7WqusXPcSoyQG7eF6hoOJL8
X-Google-Smtp-Source: ABdhPJygGd10PaKDvRc0uzl+CkB0pIAc5gblJDnFvt2TNnq9FUjMvYap4/38CJ4xrss3WiWkcaesNA==
X-Received: by 2002:a1c:9a02:: with SMTP id c2mr6302605wme.16.1594151673806;
        Tue, 07 Jul 2020 12:54:33 -0700 (PDT)
Received: from [10.11.11.4] ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id c206sm2471459wmf.36.2020.07.07.12.54.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 12:54:32 -0700 (PDT)
From:   Martin Zaharinov <micron10@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Bug Report High CPU Usage events_power_efficient
Date:   Tue, 7 Jul 2020 22:54:31 +0300
References: <E2C5FE67-C85E-469C-9B81-10F7555F836B@gmail.com>
 <91805D0F-2D74-4EA3-A2D7-13E4FBBEAB51@gmail.com>
To:     "linux-kernel@vger kernel. org" <linux-kernel@vger.kernel.org>
In-Reply-To: <91805D0F-2D74-4EA3-A2D7-13E4FBBEAB51@gmail.com>
Message-Id: <6AD52867-83C1-4C6C-A0AE-4DE0D6C16310@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And this is log from /sys/kernel/debug/tracing/trace


# entries-in-buffer/entries-written: 32410/32410   #P:64
#
#                              _-----=3D> irqs-off
#                             / _----=3D> need-resched
#                            | / _---=3D> hardirq/softirq
#                            || / _--=3D> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
           <...>-57259 [005] .... 29619.680698: workqueue_execute_start: =
work struct 00000000ef22e4b8: function gc_worker [nf_conntrack]
           <...>-57259 [005] .... 29623.811407: workqueue_execute_end: =
work struct 00000000ef22e4b8: function gc_worker [nf_conntrack]
           <...>-57259 [005] .... 29623.811410: workqueue_execute_start: =
work struct 0000000000aeec55: function fb_flashcursor
           <...>-57259 [005] .... 29623.811421: workqueue_execute_end: =
work struct 0000000000aeec55: function fb_flashcursor
           <...>-57259 [005] .... 29623.811422: workqueue_execute_start: =
work struct 00000000a6d382bb: function vmstat_update
           <...>-57259 [005] .... 29623.811435: workqueue_execute_end: =
work struct 00000000a6d382bb: function vmstat_update

> On 7 Jul 2020, at 22:44, Martin Zaharinov <micron10@gmail.com> wrote:
>=20
> the problem is hear with kernel 5.7.7=20
>=20
> last work kernel without this problem is 5.6.7
>=20
> hear is more info:
>=20
> cat /proc/57259/stack
> root@megacableamarilis:~# cat /proc/57259/stack
> [<0>] gc_worker+0x1be/0x380 [nf_conntrack]
> [<0>] process_one_work+0x1bc/0x3b0
> [<0>] worker_thread+0x4d/0x460
> [<0>] kthread+0x10d/0x130
> [<0>] ret_from_fork+0x1f/0x30
>=20
> PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ =
COMMAND                            57259 root      28   0       0      0 =
     0 R  69.8   0.0  82:42.14 kworker/5:2+events_power_efficient        =
                                                 =20
> 32 root      21   0       0      0      0 R  31.0   0.0  87:06.33 =
ksoftirqd/4
>=20
>=20
> Please help to fix this problem
>=20
>> On 22 Apr 2020, at 15:55, Martin Zaharinov <micron10@gmail.com> =
wrote:
>>=20
>> Hello Qian and Greg=20
>> With latest 5.6.x kernel have problem with events_power_efficient =
28488 root      28   0       0      0      0 R  95.5   0.0 101:38.19 =
kworker/2:1+events_power_efficient Process start to load machine after =
3-4 hour and load not stop only reboot machine remove process . Server =
runing on AMD EPIC CPU 2x 7301 32Gb Ram Have 2 x 10G card Intel when =
machine load over 1G traffic machine locked and only restart fix problem =
to next load . After move traffic and server stop load process still =
hear and load server ?
>> And after reboot process move to other core .
>>=20
>> Best Regards,
>> Martin
>=20

