Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3889AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 156DC207DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="HPhBTxMU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uPmw7Isx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgHROgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:36:13 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:38043 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727782AbgHROgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:36:12 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 52DCFFC5;
        Tue, 18 Aug 2020 10:36:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 18 Aug 2020 10:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=5
        TdnmIs67JzoUO77MgRwZ9vTwpz13W5GGUJXcewViJs=; b=HPhBTxMUoeE0g+wHy
        i7VlPgVyLeE/N5FhgpYbqOwJ4oYtmowcOpiSg0m9MsJ95x9rR0MMF2DxOkYMa131
        VjI8alZNnJ2wej6wpaRv3fc0NpmZEi1Zl0OkZ8O0ZNuW0CDcLret5QTCmisoMWb9
        hF8ouE+xk3/nYo7x6iMm2bGtUNoKrvbOnJw47Ji3DMDWS4lOGtoVGIzCyBQdjm5l
        yorOwUKDqsTNJXt1ak+UTht9KcwaT902rD0nLIpVqW2AVRCgxElG1BkXlU4JhkT4
        J2pPwvPoFRcjQlhRvmmDinRkOWlW4m3a9DAtXWv9TKu9TfLKjoXcKEDbApNRlgft
        UcxRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=5TdnmIs67JzoUO77MgRwZ9vTwpz13W5GGUJXcewVi
        Js=; b=uPmw7IsxLGcFxk4Mh9WKHeImfCPK2ESrm9PrjLoivh6pf7OXTNhwHVjsb
        PNCVdH40asSmnoOTphbxZhdXodBw4/1D0Nj4uJytd5ZNYxJamNfnqDW3AkyLfxpf
        fy8v4cl2ey/znQswsE42CBWn0rY5XpL3akodsUizEJfmgdwjyOOdITx4CjhS63SU
        l/LJmphBY+H9jIWQvNM/StW+TDvSJQitdcvesHkzCM9ycctsZ95BX+A+2ABxwGbk
        FSTWbJSXkhXWN7eL1gsT5moANMcwByLkBmfzBPqERY/WyRCX1VTwbiUkP+ejezXa
        mkZbV/khhKstf6XMdnMKGobeM3Jng==
X-ME-Sender: <xms:Wuc7X2RdwOXWazn-tlOvWJzPsXx5Z_s0FjSlRbexHdY_EeuyJLxnHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddtiedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggugfgjsehtke
    ertddttdejnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeeuheekheelffefieduteefkeejffdvueehjeejffehle
    dugfetkedvleekudduvdenucfkphepkeefrdekiedrkeelrddutdejnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhm
X-ME-Proxy: <xmx:Wuc7X7y39b788q95La5JXfTLIf1XE3I-IvIG3sELXBI8EcDqdPUIHA>
    <xmx:Wuc7Xz17YnIaidxJM9_5-0V9xPbI8Nt86mN5kLLa4ZLlciZt0ggS2w>
    <xmx:Wuc7XyCzxvV6nIq0nJg3Aga9mMEyYrM9GPHeti47iloVyoId_xuxOg>
    <xmx:Wuc7X_LiWsTthhIL3mV_sU5mJdMlb_N7CoUB0KmrOuawjXpjAzN0Yg>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 46AA9328005D;
        Tue, 18 Aug 2020 10:36:10 -0400 (EDT)
Date:   Tue, 18 Aug 2020 16:36:33 +0200
From:   Greg KH <greg@kroah.com>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: Scheduler benchmarks
Message-ID: <20200818143633.GA628293@kroah.com>
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 08:00:11PM +0530, Muni Sekhar wrote:
> Hi all,
> 
> I’ve two identical Linux systems with only kernel differences.

What are the differences in the kernels?

> While doing kernel profiling with perf, I got the below mentioned
> metrics for Scheduler benchmarks.
> 
> 1st system (older kernel version compared to the other system) benchmark result:
> 
> $ perf bench sched messaging -g 64
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 64 groups == 2560 processes run
> 
>      Total time: 2.936 [sec]
> 
> 
> 2nd system benchmark result:
> 
> $ perf bench sched messaging -g 64
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 64 groups == 2560 processes run
> 
>      Total time: 10.074 [sec]
> 
> 
> So as per scheduler benchmark results, clearly a huge difference
> between two systems.
> Can anyone suggest to me how to dive deeper to know the root cause for
> it.

Look a the differences between your different kernels, that would be a
great start :)

good luck!

greg k-h
