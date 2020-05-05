Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF51C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08187206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/qxArlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgEEKvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 06:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728180AbgEEKvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 06:51:07 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BB5C061A0F;
        Tue,  5 May 2020 03:51:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z1so721094pfn.3;
        Tue, 05 May 2020 03:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Q3LtCeqVYvw1HA6KD0HdwxRUXQ/eiBuEX+basoeT+8=;
        b=O/qxArlz1Hi5XKXUboKARA8vW1G5e5Yil8P+6TamjnOf57gihrqNXyrGZ4Pje5y0GL
         8C7+rtUTrH4EFaoE3VQgtxN6i/jan/0WZBwXHjiT1cdQsoFyiQnYXPBm58oBCXBawFzS
         ciy8HaZfOv8cARner/6xw8S+w6HqHYUkbsowhHaMtuZrDPfzzRQ50aKjJdXZY5GG3ooz
         /l2HET8DAXd/N/cH1EjdLqKv8EFfGxDjfYOAfE+ZFu8T1sVLXWqg5DEgFbMz7QikNZsm
         grjlUWskhTZxH/SS17+glpSLFeYjqnGBOrU68Nnc7sNG0rwDEylFrKjPzW3jYyPbh5aN
         iRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Q3LtCeqVYvw1HA6KD0HdwxRUXQ/eiBuEX+basoeT+8=;
        b=Y2yCvSj6YOBBEWMuFbTGomVywARb2M3ufUqudnhBPbZ4jn7vfBW9fAllQLSQhCVrs7
         6fSeYC3yMfKSemJo+pCjc+LH4sV2+10tDvfiSbD+Tg7KdTK577YYUtqIaNWRH+I+gFtb
         AdY7K+ZBiq8iCesF82RwHO3dHeEkbhCkz6sxtH2wXXNkH02QLXF19IRR9OYFyx2Puu89
         fulEvch7TWPmsmAsmtaH86KACygWTRCfSitimifEpUQ2AYzN3x4H1ImyHarlyOGLkoKc
         JmHgRJ5trHJDIsARbmdLxDNKYppeH5FmeLxy6ikV+GU+8mGVHWUKBdtTnF43I/LWwm2T
         UVTg==
X-Gm-Message-State: AGi0PuZK6SpSJAwDUlpO1Y9IISXt+rE1++J5tLpU/ROS2bFGMaiTtuOF
        cHjYHuG1Amel3J25UCH1SXE=
X-Google-Smtp-Source: APiQypLtQ27lSFkU6FxaM2UO+TnBdLHkBhE2satL+IEi+vD2EaYsUsA3ZP3nywqHd92h18Mnd5cfJw==
X-Received: by 2002:aa7:9891:: with SMTP id r17mr2552355pfl.5.1588675866063;
        Tue, 05 May 2020 03:51:06 -0700 (PDT)
Received: from localhost (146.85.30.125.dy.iij4u.or.jp. [125.30.85.146])
        by smtp.gmail.com with ESMTPSA id b20sm1835580pff.8.2020.05.05.03.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:51:05 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 5 May 2020 19:50:59 +0900
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/3] printk: honor the max_reason field in kmsg_dumper
Message-ID: <20200505105059.GA2353374@jagdpanzerIV.localdomain>
References: <20200502143555.543636-1-pasha.tatashin@soleen.com>
 <20200502143555.543636-2-pasha.tatashin@soleen.com>
 <20200505010219.GA2282345@jagdpanzerIV.localdomain>
 <CA+CK2bASiWe=w07gsc-_fFZxPY0SSECSYh6femUCA8yugEpuRg@mail.gmail.com>
 <CA+CK2bAZAAzAK7G3bJ5dOHR__5+a8LgWPVBzwM+TnbHdVKDUgQ@mail.gmail.com>
 <CA+CK2bAPhXL_p2WkDaLshw2U13KbdU5NMH6qJsy8YTq3rwZwBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAPhXL_p2WkDaLshw2U13KbdU5NMH6qJsy8YTq3rwZwBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/05 00:21), Pavel Tatashin wrote:
> > > I changed it to make code cleaner:  for such basic operation there are
> > > too many conditions if we will keep it inside the kmsg_dump().
> > > However, if being able to set always_kmsg_dump dynamically during
> > > runtime is deemed important, I can change it back to be checked in
> > > kmsg_dump.
> >
> > If you agree that we do not have to modify this variable dynamically,
> > I will also change the permission here:
> > module_param_named(always_kmsg_dump, always_kmsg_dump, bool, S_IRUGO | S_IWUSR);
> 
> Hi Sergey,

Hi Pavel,

> After thinking about this. I will move this logic back to kmsg_dump(),
> to keep the current behavior where kmsg_dump can be modified during
> runtime.

Agreed. I think that sysfs knobs and user-visible API need to preserve
their behaviour. There is a deprecation protocol, but usually it takes
many years of WARN_ON() and pr_err("this knob will be removed") before
we can change anything. E.g. sysctl has been deprecated for about a
decade IIRC before it was actually removed.

	-ss
