Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8172C47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6501208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588265519;
	bh=Qh9yGfu7EKu8YBjyZn57LidMIeIdE9hqIfI7Nfz5zto=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0OQBmCY1G/7LW2bDHONsj9I0k0JCBLWnj/JU2tyQNeQ2th5O74Ktk7tdHGlT+RXHR
	 nUosbkWFm2J2rdGfPpE3ZAPJty/PIMrgrumdsUVatG4N53bfbp511BTbUsrqj60Uf0
	 THHKVgBU1PnJI16t99X81CMQsG1cwHiZXhe5w+NA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgD3Qv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgD3Qv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:51:58 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EE8724954
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588265517;
        bh=Qh9yGfu7EKu8YBjyZn57LidMIeIdE9hqIfI7Nfz5zto=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QQERtHd2tvFSzKdIw7cibcdVNaSdmyG20LzUeHLE/Rd8Ra4MIYEURm5Tv//rSLTV3
         Ek6VFKay/KjG3PAgO0ceXHc5n3oywEIqZ8rPWxNojM3LY+jscNuyhwVbvMuYomubRe
         4UlthhnQYnlVlPE86wP9+rVbZLbym61P7wrGwo7c=
Received: by mail-wm1-f50.google.com with SMTP id r26so2770667wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:51:57 -0700 (PDT)
X-Gm-Message-State: AGi0PubUm9UnXic1pn1cW6RNQ9zWoDfcQqbPSrwTNDyrsjyvJW9nzvHl
        EDW08NvTLIvEBh9WmZpUMNvWZbCqMfnImf7tk2kRUg==
X-Google-Smtp-Source: APiQypIwzIih6qzG1E5/i+OpsglU4R3LqlrtKcQTjqR7B2k+mg5tCDSXpdynOS/JVqaM9P2DnRTopkyMsvqVuCFJ0bE=
X-Received: by 2002:a1c:23d4:: with SMTP id j203mr4175179wmj.49.1588265515945;
 Thu, 30 Apr 2020 09:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
In-Reply-To: <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 30 Apr 2020 09:51:44 -0700
X-Gmail-Original-Message-ID: <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
Message-ID: <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        stable <stable@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Erwin Tsaur <erwin.tsaur@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 7:03 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Apr 30, 2020 at 1:41 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > With the above realizations the name "mcsafe" is no longer accurate and
> > copy_safe() is proposed as its replacement. x86 grows a copy_safe_fast()
> > implementation as a default implementation that is independent of
> > detecting the presence of x86-MCA.
>
> How is this then different from "probe_kernel_read()" and
> "probe_kernel_write()"? Other than the obvious "it does it for both
> reads and writes"?
>
> IOW, wouldn't it be sensible to try to match the naming and try to
> find some unified model for all these things?
>
> "probe_kernel_copy()"?

I don't like this whole concept.

If I'm going to copy from memory that might be bad but is at least a
valid pointer, I want a function to do this.  If I'm going to copy
from memory that might be entirely bogus, that's a different
operation.  In other words, if I'm writing e.g. filesystem that is
touching get_user_pages()'d persistent memory, I don't want to panic
if the memory fails, but I do want at least a very loud warning if I
follow a wild pointer.

So I think that probe_kernel_copy() is not a valid replacement for
memcpy_mcsafe().

--Andy
