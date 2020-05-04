Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96849C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED4720707
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lhGUwFje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgEDUyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgEDUyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:54:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D24BC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 13:54:54 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a31so18256pje.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 13:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yjz4DcdlU0+X8wHobzYGxUIzwN2L222SUf6AaFQNc6g=;
        b=lhGUwFjeSO6HONDbjd5J6BQxpnHT+0DMIX5LQDWNS4E7njuKX93NWHTNz/7YV9BMvR
         R0WnzhviEk4jSug57Aic1fTDwJb+eZh7BGASULx2r0TOYdeN30kEujszWzNeWUyCA28O
         +gjxaUDyRWko9eHnRJDqil9AiIxyO4hwZO3L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yjz4DcdlU0+X8wHobzYGxUIzwN2L222SUf6AaFQNc6g=;
        b=fGRqRxe3Q5NeWj0cgKOD/vyjyAaqATDyQ4bh37doB5gT5ASz5xJ21u08Kvj5kZUDeb
         hs7kDFzelTE9yY0NT09m8WPHItJv8qGTfiTfmqxDnl2HFat86rn4V4gKBhprqZkro4BH
         67eeqvDLKaYeZare0xRgJV4zITQXi6xXYazwZpsQ0r8S5fV2oD4AfUlSY39kraaHOkSO
         DK36YMN809YczBxgrcNv8paEFbGU6xm++jqk5TVzmVKi2GRPQCey7tcHwdJrzQsNNHWM
         KbA22dnJ8Ebk90/o+iX2P89JcURs8GT2am29Cgaygl6g1GhIPZ9MLCIBxNnox2Zfy2Sx
         AJlw==
X-Gm-Message-State: AGi0PuaWbuk5fL4elvJZD+CrArn8W2AIlTUWVJ8Gu78MGMyzVpr3qXDX
        F49VXyGtMN1BFP3701YhUe02vw==
X-Google-Smtp-Source: APiQypI1hmwrwHNe3VgLnmdH8z2/HwQv07gA5fq03YWgXJntEeWjErr+QIeUeHzdm22/KScvxtVCIQ==
X-Received: by 2002:a17:902:aa8c:: with SMTP id d12mr1016819plr.265.1588625693534;
        Mon, 04 May 2020 13:54:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j26sm9543504pfr.215.2020.05.04.13.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 13:54:52 -0700 (PDT)
Date:   Mon, 4 May 2020 13:54:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/3] pstore/ram: allow to dump kmesg during regular
 reboot
Message-ID: <202005041332.0942613D@keescook>
References: <20200502143555.543636-1-pasha.tatashin@soleen.com>
 <20200502143555.543636-3-pasha.tatashin@soleen.com>
 <202005041222.4A870DFEC@keescook>
 <CA+CK2bDyi-vncYc0_sSZZ9Wb4O7oNUYH-6SN=-XKkeEamB8W8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDyi-vncYc0_sSZZ9Wb4O7oNUYH-6SN=-XKkeEamB8W8A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 04:30:52PM -0400, Pavel Tatashin wrote:
> > > -static void pstore_register_kmsg(void)
> > > +static void pstore_register_kmsg(int dmesg_all)
> > >  {
> > > +     if (dmesg_all)
> > > +             pstore_dumper.max_reason = KMSG_DUMP_MAX;
> >
> > So, I'd like to avoid any new arguments in the API and instead add a new
> > field to struct pstore_info, which will be valid when PSTORE_FLAGS_DMESG
> > is set, and the max kdump reason can be set there by the pstore backends.
> 
> Hi Kees,
> 
> I am trying to verify that I understand the request correctly:
> 
> 1. pstore_register_kmsg() -> remove argument.

Yes (or, from the perspective of what v2 will look like, "do not add
an argument to pstore_register_kmsg()").

> 2. pstore_info -> add a new field  max_kmsg_reason: contains the
> actual reason value

Let's just call it max_reason, but yes. And perhaps instead of adding
KMSG_DUMP_MAX, maybe just use INT_MAX or something for "all reasons".

> 3. Modify: pstore_register() to set this field in pstore_dumper prior
> to calling pstore_register_kmsg().

Correct.

> 4. remove ramoops.dump_all boolean parameter

Yes, or more specifically, "don't add ramoops.dump_all".

> 5. add a new parameter ramoops.max_reason integer variable, which will
> be set in pstore_register_kmsg

Right, though this will likely require some refactoring of the existing
handling of the dump_oops parameter, likely as a separate patch, since
we should not remove the parameter, as some systems may be expecting to
use it still. But it should be reworked in terms of the new max_reason.

> 6. Modify other users of pstore_register() to provide the correct
> max_kmsg_reason.

Yes, which should be a trivial adjustment. You can look for all the
initializers using PSTORE_FLAGS_DMESG:

arch/powerpc/kernel/nvram_64.c: .flags = PSTORE_FLAGS_DMESG,
drivers/acpi/apei/erst.c:       .flags          = PSTORE_FLAGS_DMESG,
drivers/firmware/efi/efi-pstore.c:      .flags          = PSTORE_FLAGS_DMESG,

It looks like all the other backends actually already dump all reasons,
so they should likely all be set to the INT_MAX, or whatever is chosen
for "all reasons".

> 
> Is this correct?

But, yes, your list essentially matches what I've got in my head too. :)

-- 
Kees Cook
