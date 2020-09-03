Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDABC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0430620716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599144804;
	bh=jcI1wB3uEmJxhTvzRxmimv0PrE1TOxCdeThQ+yqZv1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1TVQsOcpGcTNzqo8t8IsrQj102E4/wtbL/jqQbQ6F1a/K11HNyvfHuCjRLSC5B+iB
	 JrXzqaHjwZ2TCQ3UiJ8lcNOGZTh2SL1qCfsfZjZU2sJGJ59S3UX/dgeILOX/xnIga2
	 z+lY3zZAO10c7e/UyQOeDtEYEJIsVzKtF5c6qft4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgICOxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729196AbgICOw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:52:57 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 317BE2145D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599144768;
        bh=jcI1wB3uEmJxhTvzRxmimv0PrE1TOxCdeThQ+yqZv1U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eY/nd+MMiPngAnCXlXF0YoRMhSv0LYKp0VauSpqAAY27HPu/zlGPBlgUxAh9AtDJM
         TeHhjkpq03iNW2yj8d/81P0amZDHMr9VV23PkBK4uEjxNQjEubJ58uYwzY9umP/XKo
         cwoYuxZZsgm7Al2wF0p9/KriRKc2SeRUkr2G8Fr4=
Received: by mail-wr1-f41.google.com with SMTP id g4so3570339wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 07:52:48 -0700 (PDT)
X-Gm-Message-State: AOAM531au71/3LMFSx4CzFuw6PmOZCCuKnbkFfTyG7qs0FHnFHW3pDt+
        KorlJaDubv2HX4qD+aN4LBDYD2wzRRp62DNqxmtTVw==
X-Google-Smtp-Source: ABdhPJx3YyX1cRpc56KwXkACUYF87VTzQngvZGkcWK/fNLMxQ/No8ECF13MUK2M5YiZsCco+ja/S+ONnOgSZ+wP+L3A=
X-Received: by 2002:a05:6000:11c5:: with SMTP id i5mr2968557wrx.18.1599144766547;
 Thu, 03 Sep 2020 07:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200902155904.17544-1-joro@8bytes.org>
In-Reply-To: <20200902155904.17544-1-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 3 Sep 2020 07:52:35 -0700
X-Gmail-Original-Message-ID: <CALCETrWAk-zVKKjvrq+fRAX5HKhdHF36h+jY+91_tQOa67xozA@mail.gmail.com>
Message-ID: <CALCETrWAk-zVKKjvrq+fRAX5HKhdHF36h+jY+91_tQOa67xozA@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/32: Bring back vmalloc faulting on x86_32
To:     Joerg Roedel <joro@8bytes.org>
Cc:     X86 ML <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 8:59 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> One can not simply remove vmalloc faulting on x86-32. Upstream
>
>         commit: 7f0a002b5a21 ("x86/mm: remove vmalloc faulting")
>
> removed it on x86 alltogether because previously the
> arch_sync_kernel_mappings() interface was introduced. This interface
> added synchronization of vmalloc/ioremap page-table updates to all
> page-tables in the system at creation time and was thought to make
> vmalloc faulting obsolete.
>
> But that assumption was incredibly naive.

Does this mean we can get rid of arch_sync_kernel_mappings()?  Or
should we consider adding some locking to make it non-racy again?

-Andy
