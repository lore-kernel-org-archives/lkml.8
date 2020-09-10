Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6389C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 531A7207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHXmm+NX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgIJTPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731265AbgIJQAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:00:43 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2570CC061795
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 09:00:10 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id h8so1556736ooc.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idAeA9NPrviZ9cr7wYnG5dNkEQPMk1g4dXWXMAeWeZw=;
        b=bHXmm+NXe2hxUUFxQHd/9gJEqNC/Up/xUvXvedGdisFsrmQgfPogURwk+T30eMMnk1
         jRzNoTlpBWooKXhpOvofPIT1BDrGSy1I8g6C388YxoIrp19SOv2baGvPXqUnQZS4a5bT
         Z9DfL3ajxxE0iQXSTrihOF9mhrGwhovWoGorZ9Rw/GXQSWCbhnOhRhcgUelhZli5Jzee
         m26AOmC6rX64dmNs64GlUrxKFGOVSUz8AsVUV7GivzzLcLQsCd5Ed7LVhQMt97KvrjUw
         MfW/dU+kiJlG6MzWSnQY1xzuUwv/INn91DU7W63JVIU2knmi8FMRAAZu5QW7zXwZCH6H
         CMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idAeA9NPrviZ9cr7wYnG5dNkEQPMk1g4dXWXMAeWeZw=;
        b=tU9/sg/4Wso1TYcM5J/u1QlbulkJQJDbEjR6sTkFuzdme63nPu8K/q1CuPjvpMJhmW
         eSHDFxgPRq+SDVs5kFO3fUbhHbdxqJZ4tT5AMU2oMy/Wda/2wkW/zDGskLJQ2V/tCmlV
         YA1tMcik1XCdhXmcengdU14SPafPfYH+UgouX4NmJWireqJH8i5nFpxRhfXlGVl2cG6W
         tc6+y99/dXCjNjGPotx2xLmI9hG3zFcYzzg3P7J7+V5zTWvsTwuf8HSVTHS51Qmm9/Zt
         vY03ghEn7gn2ieALhuOtPW/y2wBHqx9aDGY1LZ0noWyvVeTdFDpvoQ/roN/2Ake/XLlG
         KZqw==
X-Gm-Message-State: AOAM531PHcT+NHECyuTQ/KlmFbJNqD7DvWucP3A/OM3/aUtOnnLOky1g
        Ft2NncNPRtErgGHJUkJ4S4eNAez+7JkvLaxsW/lJduQYQiO1BQ==
X-Google-Smtp-Source: ABdhPJzbuAw6tV4jnzgCZ9l/O5vRNrAFGMw3y60rNky/LhuNDqBW2oold/quuNlzYyzwNPXrd8cTy6vXWEni8eUlgMY=
X-Received: by 2002:a4a:a648:: with SMTP id j8mr4972141oom.44.1599753609477;
 Thu, 10 Sep 2020 09:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200910150328.20545-1-oded.gabbay@gmail.com> <20200910155440.GC1151284@kroah.com>
In-Reply-To: <20200910155440.GC1151284@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 10 Sep 2020 18:59:41 +0300
Message-ID: <CAFCwf132vzvEQ2Jrzme8SuK8OCSB8-QTXiwr5Rj96_hwi91TKQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] Adding GAUDI NIC code to habanalabs driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 6:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Sep 10, 2020 at 06:03:13PM +0300, Oded Gabbay wrote:
> > This patch-set adds support for initializing and using the GAUDI NIC ports,
> > functioning as scale-out interconnect when doing distributed Deep Learning
> > training. The training can be performed over tens of thousands of GAUDIs
> > and it is done using the RDMA-over-converged-Ethernet (RoCE) v2 protocol.
> >
> > Each GAUDI exposes 10x100GbE ports that are designed to scale-out the
> > inter-GAUDI communication by integrating a complete communication engine
> > on-die. This native integration allows users to use the same scaling
> > technology, both inside the server and rack (termed as scale-up), as well
> > as for scaling across racks (scale-out). The racks can be connected
> > directly between GAUDI processors, or through any number of standard
> > Ethernet switches.
> >
> > The driver exposes the NIC ports to the user as standard Ethernet ports by
> > registering each port to the networking subsystem. This allows the user to
> > manage the ports with standard tools such as ifconfig, ethtool, etc. It
> > also enables us to connect to the Linux networking stack and thus support
> > standard networking protocols, such as IPv4, IPv6, TCP, etc. In addition,
> > we can also leverage protocols such as DCB for dynamically configuring
> > priorities to avoid congestion.
> >
> > For each NIC port there is a matching QMAN entity. For RoCE, the user
> > submits workloads to the NIC through the QMAN, same as he does for the
> > compute engines. For regular Ethernet, the user sends and receives packets
> > through the standard Ethernet sockets. Those sockets are used only as a
> > control path. The data path that is used for AI training goes through the
> > RoCE interface.
> >
> > It is important to note that there are some limitations and uniqueness
> > in GAUDI's NIC H/W, compared to other networking adapters that enforced us
> > to use a less-than-common driver design:
> >
> > 1. The NIC functionality is NOT exposed as different PCI Physical
> >    Functions. There is a single PF which is used for compute and
> >    networking, as the main goal of the NIC ports is to be used as
> >    intra-communication and not as standard network interfaces. This
> >    implies we can't connect different drivers to handle the networking
> >    ports because it is the same device, from the kernel POV, as the
> >    compute. Therefore, we must integrate the networking code into the
> >    main habanalabs driver.
>
> That's kind of common, see the long threads on the netdev and IB mailing
> lists about this type of issue on other networking cards today.  The
> whole "virtual bus" code should help solve this, if Intel ever gets
> around to posting a new version of that patch series one day...
>
> But, because you are writing networking driver code here, you really
> should run all of this by the netdev@vger.kernel.org maintainers and
> developers, as they know how to review this interaction with the network
> stack better than anyone else.
>
> Care to resend it and cc: them too?
>
> thanks,
>
> greg k-h

Sure, np.
Do you have someone specific or should I just send it to that mailing list ?
I don't know anyone there.
Oded
