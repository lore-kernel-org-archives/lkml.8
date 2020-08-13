Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65BBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 933CD20885
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af27m4tR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHMLb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgHMLb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:31:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADBAC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 04:31:59 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kr4so2644489pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 04:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TdxvYAjwHYBqX28RZ+WzNUpjs3QbINtn5/MRyyS8TLo=;
        b=Af27m4tRbZiKQS9zEInh/cKxpGWSJD1wgUrpOo5G0oLOElEFVrOLsUX9sVA5J2UGOH
         4LyRrSz+9a63Niw44hGv8m7iRFZScwB381gbrBzxwMcvHFBkfM+49Rfvshvkzit9+wz5
         Lpv9KC6Eg/WWEV42aS2o5jtEJiE2GBX85cnLWSIadobWwJJjvkES9NatQ2T/GoMjiUlf
         lv+20AvFvJP7qsv19Ma5hYDm2G7GgaiK9eddERpGH3lGiZMyPJt84FInkqG1d/YKh1+M
         UkW47z5HuZnPZDTPomajhatqxwFGwML9BU55CHkScLu3W/oeuXKVnaG2OZStAhyTtGN9
         3k+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TdxvYAjwHYBqX28RZ+WzNUpjs3QbINtn5/MRyyS8TLo=;
        b=mQDrN3JeCNLH8gNtVIsdvBLiyS9rIeEaYBfqO9aW/8AaoNiFwCFTkrXzSdm25bIE7r
         0EYB9EvlvuqJzWjSPd/8O4ip8gCqsx6mf4JpTk9BSy5vs8cAVItesb31+lu+HPZuemNH
         CZFtElz7B+6R8+fLyQPdyFTHPXQVsj1tspUBbrvlXkXKfjgw+e0vKeNifxo4MiOTVljE
         DMxMGD7EkLoP9PkwZJ93zXhOaOGCbDVQlF6R/h682Xb5R6KQiLuqnTjGnEZubrKAleZV
         fCTMKlcdNZWy125YNIunX6XJPtio4iPKPCFI531PoICOomMesTcMFjICjgzIfzW2OezS
         Xlgg==
X-Gm-Message-State: AOAM531WoBOG0yunmTggPEvZgixDxsv6H351B3qcNWh7UYuv4YiZh/SA
        rjCHm6SJbKlU443iad1+Z9U=
X-Google-Smtp-Source: ABdhPJxa5aZAJ/Gekwq4D8YGUYdMsa4IUsup7BXdrpnf/npn/T7/PejRDXRAWvZ+Jl5PU+BSK2nCVQ==
X-Received: by 2002:a17:90a:9b88:: with SMTP id g8mr4586084pjp.143.1597318318744;
        Thu, 13 Aug 2020 04:31:58 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id a24sm5611736pfg.113.2020.08.13.04.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 04:31:57 -0700 (PDT)
Date:   Thu, 13 Aug 2020 20:31:55 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhang.lyra@gmail.com,
        ruifeng.zhang1@unisoc.com, cixi.geng1@unisoc.com,
        Orson Zhai <orson.zhai@unisoc.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jon DeVree <nuxi@vault24.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH] printk: Change timestamp to triplet as mono, boot
 and real
Message-ID: <20200813113155.GA483@jagdpanzerIV.localdomain>
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
 <20200811094413.GA12903@alley>
 <87zh7175hj.fsf@nanos.tec.linutronix.de>
 <20200811130218.GI6215@alley>
 <20200813015500.GC2020879@jagdpanzerIV.localdomain>
 <20200813102258.GL12903@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813102258.GL12903@alley>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/08/13 12:22), Petr Mladek wrote:
>
>   + would take more space (prefix + text vs. binary representation)

Dict buffer is allocated regardless of how we use it, and only printks
from drivers/* (dev_printk*) add dict payload. It might be the case
that on some (if not most) systems dict pages are not used 90% of times
(if not 99%).

>   + not reliable because dict is currently dropped when no space

Well, in the perfect world this is a problem, but "maybe not having
alternative timestamps sometimes" can be OK approach for people who
wants to use those triplet timestamps.

But, in general, how real this problem is? What I sae so far (on my boxes)
was that printk messages are longer than dict payload.

Example:

6,223,93298,-,caller=T1;acpi PNP0A08:00: _OSC: OS supports [Segments MSI HPX-Type3]
 SUBSYSTEM=acpi
 DEVICE=+acpi:PNP0A08:00
6,224,93413,-,caller=T1;acpi PNP0A08:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
 SUBSYSTEM=acpi
 DEVICE=+acpi:PNP0A08:00
6,225,93540,-,caller=T1;PCI host bridge to bus 0000:00
6,226,93541,-,caller=T1;pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
 SUBSYSTEM=pci_bus
 DEVICE=+pci_bus:0000:00

It might be the case, that overflowing dict buffer, without first overflowing
printk buffer, can be rather challenging.

>   + it would make the controversial dictionary feature more important

Yes. But, for the time being, this controversial dict feature allocates
pages for dict buffer anyway.

	-ss
