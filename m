Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D42C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 17:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C05D20786
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 17:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594487652;
	bh=tFm00tYvn7vhjhKrCpNUrSPBZx/gcRTVNWRie6+SKEo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=npl21f0tpU10Yjg05lGBOhmitWuS7xcwpdr0UrnECStshhRJYheRWSZoRUZAvKeZf
	 iBZ3KRqRw5OYaFtzVFCjTA0EdU0PSIZdHVtBuzn3gruigAziqcPgM5M+waz7dO1d/M
	 0NQLPGZWZOwHL1VqW5i3DGxz+jIollbb9YyQO0ww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgGKROF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 13:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728674AbgGKROF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 13:14:05 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96F492084C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 17:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594487644;
        bh=tFm00tYvn7vhjhKrCpNUrSPBZx/gcRTVNWRie6+SKEo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WicGKo/yazUFc3Y5sF4bpw33UAMasXR8qJdo+xdl92gcFmf/d45lFAjoIjU++1tP+
         aGw+3o1AytpfprwyjLlL9IXJRnevuU054lx5VCKHOWpo0mYTcN15c5Kc8mpODIUZYN
         Gg9y4XeCycGs3oK3CINOj1BGxUyOMM67mmPd5pdc=
Received: by mail-wr1-f47.google.com with SMTP id f7so9010375wrw.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 10:14:04 -0700 (PDT)
X-Gm-Message-State: AOAM532UZ0fo19tt8EIVbpSZBj7jl+b+xMSbKgSNA6FJX+C+gf94hA3y
        ce3rSESP0luGTnMN1KEHvO7eKlbd2OIQHJPceZ1vRg==
X-Google-Smtp-Source: ABdhPJxMh8vjF84E3/DntWMxXWeZPTgDvsTCHvRQyIrYebZSo08BFeR11MAYOMoWyO7UY+SzvZ1k4gm1HX+vVNrPrMQ=
X-Received: by 2002:adf:f888:: with SMTP id u8mr31368677wrp.18.1594487643227;
 Sat, 11 Jul 2020 10:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200710224525.21966-1-bshanks@codeweavers.com>
In-Reply-To: <20200710224525.21966-1-bshanks@codeweavers.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 11 Jul 2020 10:13:51 -0700
X-Gmail-Original-Message-ID: <CALCETrU8==gUPD7TygK_dVZZnzirpLUCWQCgYmEDn2s2Y5U_gg@mail.gmail.com>
Message-ID: <CALCETrU8==gUPD7TygK_dVZZnzirpLUCWQCgYmEDn2s2Y5U_gg@mail.gmail.com>
Subject: Re: [PATCH v5] x86/umip: Add emulation/spoofing for SLDT and STR instructions
To:     Brendan Shanks <bshanks@codeweavers.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Rammhold <andi@notmuch.email>,
        "Moger, Babu" <Babu.Moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 3:45 PM Brendan Shanks <bshanks@codeweavers.com> wrote:
>
> Add emulation/spoofing of SLDT and STR for both 32- and 64-bit
> processes.
>
> Wine users have found a small number of Windows apps using SLDT that
> were crashing when run on UMIP-enabled systems.
>

Acked-by: Andy Lutomirski <luto@kernel.org>

I tested this under KVM-emulated UMIP.  I don't have a real UMIP
system handle to test STR.

--Andy
