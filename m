Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4BBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 20:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D77206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 20:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592598065;
	bh=pcDZ+YkyZTUiGenTdOFNJoHVPS77O76i4xkreAh2DVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MAwLti2N+wt9HPRFn9VpKb3lgzm96sx3OUVu6F1Bs1m5UMIuta6p5KG7rFFqff8N/
	 7m9eCmcEBmrDxosOzSLrZ8PSXkKkCNZPe3Rk5ywjNX+PBEays0b/6RxLGFqC5Ma0/1
	 6rDGZcG+bKSJz0x7iqVO0uLfiEVItFRBjPqnPkEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391995AbgFSUVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388968AbgFSUVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:21:02 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C40B21556
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 20:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592598061;
        bh=pcDZ+YkyZTUiGenTdOFNJoHVPS77O76i4xkreAh2DVw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gNp68tG3jgpnhLhT7iWUXlLv4EySeExtj/Rne7K6OaRZwdq5H74DwYs8tjR2iPuA8
         V2I752qmxtisW+JVSDIWAABgZ2glqjW5hKn/JXm8PKUSxEuTwSiJfIO1jd8pVW18PQ
         DQAHOW97CyJJEYY8L6M4NbCoLSgLyK0aVxpUOThE=
Received: by mail-wr1-f44.google.com with SMTP id l11so10915334wru.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 13:21:01 -0700 (PDT)
X-Gm-Message-State: AOAM532l6V4UQtUeZ5H0t6Vz3cGF+XH7Ki6goA5aigO3oqTM9pP30Adz
        ICLIG2/fZgRHo1nl2C2extY9rW2EObkPmo+eWWV8qg==
X-Google-Smtp-Source: ABdhPJzs5rWNk+PHWQLTvcS8vY5aiJhThlGntbf4/ks8R/LjFYgX32VrP9Kwr+pxpUoy2V16gMdSbWgma4OG7tsI+zM=
X-Received: by 2002:adf:a111:: with SMTP id o17mr5758162wro.257.1592598059976;
 Fri, 19 Jun 2020 13:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200618220139.GH27951@zn.tnic> <CAFmMkTGMAu-huTnP1aeMb_W4NddbTD_b2jhbDVKBDrkwgB97wg@mail.gmail.com>
 <20200619074053.GA32683@zn.tnic> <CAFmMkTGV0ZR6C=EBGQAiz1vw1vrUXSLTnH5ZbBUvfhPLg_tF6g@mail.gmail.com>
 <20200619132243.GC32683@zn.tnic> <CAD2FfiEr0kRWp2ut_PVqVDEVZqwESUxv=fxM9wUgi3n=ZCzPcQ@mail.gmail.com>
 <20200619134432.GE32683@zn.tnic> <CAD2FfiFRqwYGB50KK=aA0sU6uCALYneoyD=V4EfOsk-Ex=C+xg@mail.gmail.com>
 <20200619161026.GF32683@zn.tnic> <CAD2FfiGN5kdHHEz-6Oy9S-fFT35bJH0ZOfqfn5SyCG_Y2LtE_w@mail.gmail.com>
 <20200619164056.GB2235992@kroah.com> <CAD2FfiHVyt2hWBqcgtxbBaLEuxuzz6yAe1+8sK5J0SYWVEr5qQ@mail.gmail.com>
 <CALCETrXKzmdXtHsdBTJB7+RYZX5UOD_Q4MVd9zVAVOjYgU5WRA@mail.gmail.com> <CAD2FfiGT5bsb0sd2k8NGNmShvW_q3UV9YXgn-EwxBCJjx6PSTw@mail.gmail.com>
In-Reply-To: <CAD2FfiGT5bsb0sd2k8NGNmShvW_q3UV9YXgn-EwxBCJjx6PSTw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 19 Jun 2020 13:20:48 -0700
X-Gmail-Original-Message-ID: <CALCETrVieskMnU5XHKHYm+qOfzc+o4yhsGw42pvBNhkv2zsQJA@mail.gmail.com>
Message-ID: <CALCETrVieskMnU5XHKHYm+qOfzc+o4yhsGw42pvBNhkv2zsQJA@mail.gmail.com>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Gutson <daniel@eclypsium.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 12:58 PM Richard Hughes <hughsient@gmail.com> wrote:
>
> On Fri, 19 Jun 2020 at 20:41, Andy Lutomirski <luto@kernel.org> wrote:
> > I don't object in principle to Linux giving userspace more visibility
> > into what's going on, but I'm not convinced that adding a new
> > must-support-for-a-long-time interface that only solves 5% of your
> > problem is worth it.
>
> At the moment the only visibility we have is "the CPU supports TME"
> and "the kernel printed a message in the journal". The sysfs/procfs
> file read allows us to notify the admin if the firmware is
> deliberately disabling TME for some reason, without resorting to
> `grep` on dmesg. I don't think perfect should be the enemy of the
> good.

I am unconvinced that this has hit the "good" bar, especially since
SME is completely missing here.

Boris, etc: would it be reasonable to add a list of CPU features that
are present but turned off by firmware?  SME is far from the only
thing that's frequently in this category.  x2apic, fast strings, and
virtualization come to mind.

>
> Richard.
