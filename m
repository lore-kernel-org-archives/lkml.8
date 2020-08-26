Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EB4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC5F2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598448091;
	bh=hGUTdln7l6OLSRN/oGX5pGuJYKRn/THkz/0Z1CGTGCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YSLRJbF1DCV1zn0Y4Wwxu8rylVt7W/il6cdDFdJ1coRByQRxPbJXDL/WWrGYY/aWu
	 Iq2TtR6pKE6Wyofm7jFr4REfvhLGBf1KbhIZWx4uv8vgEAyJvXozGEGph5wnbRvPfQ
	 knNmE+XLVLmT25v+U35hTdTnno2M27OfxSwzWIzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgHZNVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:21:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34326 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbgHZNVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:21:21 -0400
Received: by mail-ot1-f67.google.com with SMTP id k20so1457144otr.1;
        Wed, 26 Aug 2020 06:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGUTdln7l6OLSRN/oGX5pGuJYKRn/THkz/0Z1CGTGCE=;
        b=SNzsDPNwvcl7wtAUFh0rJbVCHgzVgv0h1sACI5h+n6JHvXmQp89UG+eDmEmpozDbZ3
         1Khbrz0trcgCONf1fC1YMWRzYvBSQ0NSwN3Amgd5rr585hrupWx0okELSY80jFuG1QIG
         m/tJJ47yW8PS6Y2Pn913q7c9N/reqVXKyZXhMKBj3shqJIdX7sDGDAk9b49XA6H8fRSn
         27FD9QZd5pIlYJQvdgGbqBGXFwXrKWpV5akD8YdDfWurN7wlCzOs4amBVTdo3Yk8FaCe
         H04KO7fQQKb3PeaEKLeIE9oVDV8+VHQDxUfbBa6SU0Qmyv57kJUe22HnMzz7rLb44FXR
         XsfQ==
X-Gm-Message-State: AOAM533m9UDLw9yD7NcSvhNebXp98FjjzEW8bHCeVoAnY3tIRyuxJdWA
        PLvRW5IrMDdQlSGxyXNrhQWlbWkxKVMQLzf/LlY=
X-Google-Smtp-Source: ABdhPJz67fBI+FnXN0Nbltt9xsmaVh/I80TmzH8bIG5g6B/MYxdoRc6colwa+z1JLpX8myV1CZbmLzZTl97jYXwSPhw=
X-Received: by 2002:a9d:5c06:: with SMTP id o6mr9985323otk.262.1598448080994;
 Wed, 26 Aug 2020 06:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200826120421.44356-1-guilhem@barpilot.io> <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
 <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com>
 <d0ca671465e6ce72c6c4d5178440ebc1e4814da8.camel@gmail.com> <e82c121057c4496238d3de7f7c919b7039d23b7c.camel@gmail.com>
In-Reply-To: <e82c121057c4496238d3de7f7c919b7039d23b7c.camel@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Aug 2020 15:21:09 +0200
Message-ID: <CAJZ5v0gT_XKToTtuBdAeDuz6Ggk8-rVxE-hSjdfQC4uCMsTcdA@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     Guilhem Lettron <guilhem@barpilot.io>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 3:18 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> On Wed, 2020-08-26 at 16:16 +0300, Artem Bityutskiy wrote:
> > Just get a reasonably new turbostat (it is part of the kernel tree, you
> > can compile it yourself) and run it for few seconds (like 'turbostat
> > sleep 10'), get the output (will be a lot of it), and we can check what
> > is actually going on with regards to C-states.
>
> Oh, and if you could do that with and without your patch, we could even
> compare things. But try to do it at least with the default (acpi_idle)
> configuration.

IMO it is way easier to get the information from sysfs.
