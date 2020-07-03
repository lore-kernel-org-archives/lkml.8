Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D268C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E110208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tojfi2X6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgGCT2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgGCT2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:28:11 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E84EC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 12:28:11 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b25so34611958ljp.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 12:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PEF99zxMAINi9xQriRe0t74AkdAmX7z1CxtTg07Rsp8=;
        b=tojfi2X6LHGVMCGpVIbKBtZTXgJCr7+bdUVsuWaIC0On9kdDd/OIYCvZnYmTJtKbiV
         fUrEx+RJuN6HA1aAd77VNI4FZhqYNs+b10aQMIHX/JxeTtrEcIBSqI8zQBnWvEaSB7CK
         deeQDKWZNFC4olaE/xeRGGAWxafij8AIDFwjREuGFPBGEw7PuzZ4cMT0S2BjUUKDCSYy
         +ccVtVURhU1PO2DRLGa7LAxquqS5QyWV0l2fGZ2l+Dh+BmWMk8McZL0KK4bArAXq5uRA
         dhf0kfZj1p+ZpGQlBpjimL2MuY0XxeThHtXOyppyMe6BEoyGa37QMt/L1Q3mKc1j7oNv
         ucUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PEF99zxMAINi9xQriRe0t74AkdAmX7z1CxtTg07Rsp8=;
        b=Zgu+gwolFvP9ziF1+u8U7XmJC/SD7ZSxwdjZJ0aa/v5pbzCZyTaVK4RZRYk930GjlM
         AINX827fhslz5oJ9bh8poHa6MqJcprqh+DM5OVss4Q3Ayqo72dozIPJTBCxtYMjypZ3s
         ao2Qq1Zb+lntzSeVa+DKR/zczjF9H+6rKLwycI3tK43ZDPazjV7GCq4Sc528Vd0Ggfxw
         EWvOSK0KBFsk25Wu8FugxDASkQkag+29Ct5pQY+rBeM+L2nDisXZs9VThrXoe1C5ryrV
         fatP2YNK4ZEBRYU/tpwa5NfOFW+xhDSpAie5MFoaEkkQ5D0FRC5KADn16QHp8JDxCr3V
         uupw==
X-Gm-Message-State: AOAM532pJQxKmaHgetZL0927MWfHnteJ6trt7nfEpP5876vFzRrsMxwH
        0Ck3P2cVC4l/AOWQUqa2p6A=
X-Google-Smtp-Source: ABdhPJwsa80/vonouEsd+ECk1BVC6sf1tmA4+AZy6w/4aIQ/dFr/tP6UdT72WYiZTf2ZteCu6C6SOA==
X-Received: by 2002:a2e:91c7:: with SMTP id u7mr15052145ljg.184.1593804489890;
        Fri, 03 Jul 2020 12:28:09 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id 193sm5823877lfa.90.2020.07.03.12.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 12:28:09 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 3 Jul 2020 21:28:07 +0200
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        GregKroah-Hartmangregkh@linuxfoundation.org, peterz@infradead.org
Subject: Re: nr_cpu_ids vs AMD 3970x(32 physical CPUs)
Message-ID: <20200703192807.GB5207@pc636>
References: <20200703155749.GA6255@pc636>
 <8a2a55e6-6087-e4bf-3d35-ed4b4c216369@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a2a55e6-6087-e4bf-3d35-ed4b4c216369@sony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hello, folk.
> >
> > I have a system based on AMD 3970x CPUs. It has 32 physical cores
> > and 64 threads. It seems that "nr_cpu_ids" variable is not correctly
> > set on latest 5.8-rc3 kernel. Please have a look below on dmesg output:
> >
> > <snip>
> > urezki@pc638:~$ sudo dmesg | grep 128
> > [    0.000000] IOAPIC[0]: apic_id 128, version 33, address 0xfec00000, GSI 0-23
> > [    0.000000] smpboot: Allowing 128 CPUs, 64 hotplug CPUs
> > [    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:128 nr_node_ids:1
> 
> My 3950 do
> 
> 
> [    0.005271] ACPI: SSDT 0x00000000CA1F5000 0003F1 (v02 ALASKA CPUSSDT  01072009 AMI  01072009)
> [    0.108266] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
> [    0.111384] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:1
> 
> (Fedora F32  5.6.18-300) What motherboard and BIOs do you use?
> 
I have MSI TRX40 with latest BIOS.

--
Vlad Rezki
