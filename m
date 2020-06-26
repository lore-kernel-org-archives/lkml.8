Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08826C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1F62067D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593181421;
	bh=9CQT8UTYivEQIj1xuOHTlm2nK2ORIGBNyAS2pgMNqps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Kr76dS373WSrHY/cnB1F9rs0HNCiqmXnJe0nH6quKT8yXnbFKcGfMUtqNR4mpNkzT
	 PXqnO3VGJp71sdda5qpgtt0i8IO8eQ6/aA9OLrCr6lA9X9N0vP7J+YYY/vch6LqRF9
	 nmd5mpahjcFuiQFOsWwdfSZB1n8EhxExVQq52/ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgFZOXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:23:40 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43041 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZOXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:23:40 -0400
Received: by mail-oi1-f194.google.com with SMTP id x83so635174oif.10;
        Fri, 26 Jun 2020 07:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1s+jOM03Ys0L0H6keRcrjY2jkiJrGLbo1O0phZPezKY=;
        b=cwzo6RwcSkka6c/FFGq5vsaAVUJHfUAc/YDqnP9Qs4aBV7OcUredvxjBp8Dm1x+OQP
         fThaUot13uNshuv9nm7ASB6u5yEhEiZeHy1g0G8rsQLeRf50FBa75QLw9lw7q9G35+jZ
         J/e4CiV73uCH1TiUP7V6fBYaKeq6vHjpl0dRd2o34ItS9FMtDIVD0psXMYfIKl6RfXwL
         DCvF2xrOLoYMX/5/TpasRahH81wAmNX3XB2+d+9zu1PdNT6Lm8HAiKHn1nJeZorajdBt
         00PPiURapENMDwEIrPKl2EUl4HAlV6ld1vCHVf1rNxxRnHBYw+MsPhz5ksRyMzDD8NcP
         zoZQ==
X-Gm-Message-State: AOAM530TvMn7+qybGa0S6TtBqV7rtOlen96zYLDEesmNkCF218TOqFYd
        Uh3Zp0mUVUSqEbxxqbq2L3Zla1c+FMWVDKIoGAQ=
X-Google-Smtp-Source: ABdhPJz6ugoc6qjOUMHZbN/qVoA9N2ilGrzO14m64yxqaMJkzKgFIoX4Uv8A4Vz758e5B/07WM2QMXgtRst2wS7uixA=
X-Received: by 2002:a05:6808:99b:: with SMTP id a27mr2542048oic.68.1593181419856;
 Fri, 26 Jun 2020 07:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159312907937.1850128.15890323251117466770.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159312907937.1850128.15890323251117466770.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Jun 2020 16:23:29 +0200
Message-ID: <CAJZ5v0gL66d7fo8nmKFUm6dSBe8bSRymcOfW9YeePUJ9U=3p-g@mail.gmail.com>
Subject: Re: [PATCH 11/12] PM, libnvdimm: Add syscore_quiesced() callback for
 firmware activation
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 2:07 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> The runtime firmware activation capability of Intel NVDIMM devices
> requires memory transactions to be disabled for 100s of microseconds.
> This timeout is large enough to cause in-flight DMA to fail and other
> application detectable timeouts. Arrange for firmware activation to be
> executed while the system is "quiesced" all suspend operations have
> completed successfully.
>
> Note that the placement of syscore_quiesced() before
> suspend_disable_secondary_cpus() and the "TEST_PLATFORM" early exit in
> suspend_enter():
>
>         if (suspend_test(TEST_PLATFORM))
>                 goto Platform_wake;
>
> ...is a deliberate tradeoff. suspend_disable_secondary_cpus() causes
> violence to drivers with many interrupts allocated (server-class network
> adapters for example). So, allow for triggering firmware-activation
> without requiring all irq vectors to be routed (oversubscribed) to a
> single CPU.

So while the other patches in the series look good to me, this is kind
of questionable for reasons described in my reply to the intro
message.

Cheers!
