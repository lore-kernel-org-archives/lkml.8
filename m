Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDF3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B0522201
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="E7wrQFaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGNKXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgGNKXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:23:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F318C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 03:23:17 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so4564700wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 03:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlzRJM8mhGfoCPfN5rPg0eExUr0iLTJOeJnlqNcI75s=;
        b=E7wrQFaSIQoyKACZmylXPglasydLNJIj2E3wM4S7yjBUn272tNNIyE2OM+yWYYWVRC
         SMGOSuTO1+BcfdVS14I9jd49BQWkAI08u5VbBClLQTj+n1Kq65hxzBshJjh55Gn+3CNo
         du5o9LChvhH5xVqA23X8Y1yGyV3y7bfunQEZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlzRJM8mhGfoCPfN5rPg0eExUr0iLTJOeJnlqNcI75s=;
        b=pPBh8k0yNgMm1LqF4QZ5wLCMQY8k7ETfdIa0vJakwtofsANnT2X6Zf75X+la5Ml0MM
         NkrdWhL8WrUUeUyIiQi7fRPnGXy2iTjUws0LUFnLYPYQXGNkmRc1i7VE4aAGrXTF71nG
         2oay+LXEzxZ/WbffXDsdskjT8YuYyIaEwfNCxWtxJroPvRSsNIX3C8mgDsU5hqYxsFAU
         rFHHbgtWOmSsmSa7EiPbpCet2xn3racvrAmpWoV3UbSYN26Ui+DverIoWlLdLG+A5LlK
         XciZD4Sc/SkR6K+eDGCCSd7+OC4LmVRppsU/gQcvbApX/WDeRDWX/u4FrgngWbbg+pW8
         tUDQ==
X-Gm-Message-State: AOAM532npzc7aDBZoQ2yHPZ5rPAnPpv88IFU7x2rN47kKxmvWfkRSLLC
        /gNmi1d+6gno0qotcQZHLzmWRFgRAmJGqqjOXviaTg==
X-Google-Smtp-Source: ABdhPJytQElS+DT8asCVTNhFWihhJjgYcs9+nYqA039MBrXJjfioSIvUHpnM1GyFlV3F5fxZh6rw7lo9l9cUSB+oEC0=
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr3447830wme.46.1594722195600;
 Tue, 14 Jul 2020 03:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200704085213.444645-1-ignat@cloudflare.com> <20200704085213.444645-3-ignat@cloudflare.com>
 <8b168d8c-f526-42b4-7cec-ec7c26c64122@cambridgegreys.com>
In-Reply-To: <8b168d8c-f526-42b4-7cec-ec7c26c64122@cambridgegreys.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Tue, 14 Jul 2020 11:23:04 +0100
Message-ID: <CALrw=nFaeMPH9GbMWwiT4rV32=uLKa3ZOYpmnkKTA3bvMiyXYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] um: some fixes to build UML with musl
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>, johannes.berg@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 9:40 AM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
>
> On 04/07/2020 09:52, Ignat Korchagin wrote:
> > musl toolchain and headers are a bit more strict. These fixes enable building
> > UML with musl as well as seem not to break on glibc.
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> > ---
> >   arch/um/drivers/daemon_user.c |  1 +
> >   arch/um/drivers/pcap_user.c   | 12 ++++++------
> >   arch/um/drivers/slip_user.c   |  2 +-
> >   arch/um/drivers/vector_user.c |  4 +---
> >   arch/um/os-Linux/util.c       |  2 +-
> >   arch/x86/um/user-offsets.c    |  2 +-
> >   6 files changed, 11 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/um/drivers/daemon_user.c b/arch/um/drivers/daemon_user.c
> > index 3695821d06a2..785baedc3555 100644
> > --- a/arch/um/drivers/daemon_user.c
> > +++ b/arch/um/drivers/daemon_user.c
> > @@ -7,6 +7,7 @@
> >    */
> >
> >   #include <stdint.h>
> > +#include <string.h>
> >   #include <unistd.h>
> >   #include <errno.h>
> >   #include <sys/types.h>
> > diff --git a/arch/um/drivers/pcap_user.c b/arch/um/drivers/pcap_user.c
> > index bbd20638788a..52ddda3e3b10 100644
> > --- a/arch/um/drivers/pcap_user.c
> > +++ b/arch/um/drivers/pcap_user.c
> > @@ -32,7 +32,7 @@ static int pcap_user_init(void *data, void *dev)
> >       return 0;
> >   }
> >
> > -static int pcap_open(void *data)
> > +static int pcap_user_open(void *data)
>
> This change in the function name was introduced on purpose to avoid name clash in some version of libpcap which export pcap_open

Yes

>
>
> >   {
> >       struct pcap_data *pri = data;
> >       __u32 netmask;
> > @@ -44,14 +44,14 @@ static int pcap_open(void *data)
> >       if (pri->filter != NULL) {
> >               err = dev_netmask(pri->dev, &netmask);
> >               if (err < 0) {
> > -                     printk(UM_KERN_ERR "pcap_open : dev_netmask failed\n");
> > +                     printk(UM_KERN_ERR "pcap_user_open : dev_netmask failed\n");
> >                       return -EIO;
> >               }
> >
> >               pri->compiled = uml_kmalloc(sizeof(struct bpf_program),
> >                                       UM_GFP_KERNEL);
> >               if (pri->compiled == NULL) {
> > -                     printk(UM_KERN_ERR "pcap_open : kmalloc failed\n");
> > +                     printk(UM_KERN_ERR "pcap_user_open : kmalloc failed\n");
> >                       return -ENOMEM;
> >               }
> >
> > @@ -59,14 +59,14 @@ static int pcap_open(void *data)
> >                                  (struct bpf_program *) pri->compiled,
> >                                  pri->filter, pri->optimize, netmask);
> >               if (err < 0) {
> > -                     printk(UM_KERN_ERR "pcap_open : pcap_compile failed - "
> > +                     printk(UM_KERN_ERR "pcap_user_open : pcap_compile failed - "
> >                              "'%s'\n", pcap_geterr(pri->pcap));
> >                       goto out;
> >               }
> >
> >               err = pcap_setfilter(pri->pcap, pri->compiled);
> >               if (err < 0) {
> > -                     printk(UM_KERN_ERR "pcap_open : pcap_setfilter "
> > +                     printk(UM_KERN_ERR "pcap_user_open : pcap_setfilter "
> >                              "failed - '%s'\n", pcap_geterr(pri->pcap));
> >                       goto out;
> >               }
> > @@ -127,7 +127,7 @@ int pcap_user_read(int fd, void *buffer, int len, struct pcap_data *pri)
> >
> >   const struct net_user_info pcap_user_info = {
> >       .init           = pcap_user_init,
> > -     .open           = pcap_open,
> > +     .open           = pcap_user_open,
> >       .close          = NULL,
> >       .remove         = pcap_remove,
> >       .add_address    = NULL,
> > diff --git a/arch/um/drivers/slip_user.c b/arch/um/drivers/slip_user.c
> > index 8016d32b6809..482a19c5105c 100644
> > --- a/arch/um/drivers/slip_user.c
> > +++ b/arch/um/drivers/slip_user.c
> > @@ -9,7 +9,7 @@
> >   #include <errno.h>
> >   #include <fcntl.h>
> >   #include <string.h>
> > -#include <sys/termios.h>
> > +#include <termios.h>
> >   #include <sys/wait.h>
> >   #include <net_user.h>
> >   #include <os.h>
> > diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> > index c4a0f26b2824..45d4164ad355 100644
> > --- a/arch/um/drivers/vector_user.c
> > +++ b/arch/um/drivers/vector_user.c
> > @@ -18,9 +18,7 @@
> >   #include <fcntl.h>
> >   #include <sys/socket.h>
> >   #include <sys/un.h>
> > -#include <net/ethernet.h>
> >   #include <netinet/ip.h>
> > -#include <netinet/ether.h>
> >   #include <linux/if_ether.h>
> >   #include <linux/if_packet.h>
> >   #include <sys/wait.h>
> > @@ -332,7 +330,7 @@ static struct vector_fds *user_init_unix_fds(struct arglist *ifspec, int id)
> >       }
> >       switch (id) {
> >       case ID_BESS:
> > -             if (connect(fd, remote_addr, sizeof(struct sockaddr_un)) < 0) {
> > +             if (connect(fd, (const struct sockaddr *) remote_addr, sizeof(struct sockaddr_un)) < 0) {
> >                       printk(UM_KERN_ERR "bess open:cannot connect to %s %i", remote_addr->sun_path, -errno);
> >                       goto unix_cleanup;
> >               }
> > diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
> > index ecf2f390fad2..07327425d06e 100644
> > --- a/arch/um/os-Linux/util.c
> > +++ b/arch/um/os-Linux/util.c
> > @@ -10,7 +10,7 @@
> >   #include <signal.h>
> >   #include <string.h>
> >   #include <termios.h>
> > -#include <wait.h>
> > +#include <sys/wait.h>
> >   #include <sys/mman.h>
> >   #include <sys/utsname.h>
> >   #include <init.h>
> > diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
> > index c51dd8363d25..bae61554abcc 100644
> > --- a/arch/x86/um/user-offsets.c
> > +++ b/arch/x86/um/user-offsets.c
> > @@ -2,7 +2,7 @@
> >   #include <stdio.h>
> >   #include <stddef.h>
> >   #include <signal.h>
> > -#include <sys/poll.h>
> > +#include <poll.h>
> >   #include <sys/mman.h>
> >   #include <sys/user.h>
> >   #define __FRAME_OFFSETS
> >
>
> Apologies for the delay in answering, I was buried under OVS for the last month or so.
>
> With the exception of this patch the rest of the series looks OK. Can you please resumbit and if Johannes and Richard are OK with it I will +1 it.

I didn't quite understand how I should improve this patch. Could you,
please, clarify?

> Best regards,
>
> --
> Anton R. Ivanov
> Cambridgegreys Limited. Registered in England. Company Number 10273661
> https://www.cambridgegreys.com/
