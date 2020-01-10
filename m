Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EF1C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B1220838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="pDxzWr7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgAJRdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:33:47 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46834 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgAJRdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:33:46 -0500
Received: by mail-oi1-f196.google.com with SMTP id 13so2487542oij.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ksl+vJ81uwWzx8tmYMkSddxoxlD6SBF31Vqw/Cm4F+4=;
        b=pDxzWr7JwNvVuHmgOkjXvIPc55f0Lxat/iHEV3kBknVGkWuYT//7MLvF/rGm1UEw13
         xgDXvajUgFSkVn/Mowb0vgHH2bwIAwKnEETTxzK1eXw7e84VJbxaQcyW4S5wirg+EJxh
         H6xgxHjXMbk/cX6gJ0jpb3sUmn3n47ozfND3hrv3kd4iGvakcCkAdAC4c8X2NAxPcxWM
         vu+CPR26ON3H+Y2xutoAt1P1ZqvPtWYDDXfH3/sJMxDa0JrFdbXujOl0sL3cFN/9T3wS
         u0YArVRLEqfFQG7ig9QV4Bp1mClj87MvFdBC14326lSfQKSOZJERsfaU5JA3e3JgzIOA
         j8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ksl+vJ81uwWzx8tmYMkSddxoxlD6SBF31Vqw/Cm4F+4=;
        b=WRsc+0MoEd8uujYaF0bB5Sti7MH3BzFhdAPlB2soSXnvjFxU+ZkUvTz1h4ETd2CHoA
         ddLci9xXODdjcahe7gWp0tCShoK53HDuPLOpo5ARphbtXy2twtyeuXE8MrmSypE7+We2
         yeXueNfRGu9L5HRUnOAk9jG7UnqxDTygawz1SKDoZy2bbQRAbADlpEbWyh1DdgrckiOn
         4o6lY6casA8fgrf+K5zicPAF3qavD5YYNTthZ8jvDO+vYr8dd8L9Yvkf6nD1sHt9CdRW
         wOokdB0ZPfUg2uUPMkSC4Egu83BTdqjHV51sqekkV9APEGVQEOgSeYSryot1Dfs3xUbs
         b2vA==
X-Gm-Message-State: APjAAAViMWZWkb4WiOrY2Ym2S7G5oiACKXYJuURckNCFoxtexCCBtc1b
        AhcrTCOHzlGi+an5APTKVeiOSrhqmwTeATEQsPCv7Q==
X-Google-Smtp-Source: APXvYqzhq0ZmPdm2FvbVqqhxRBWJSuPUXMhdMbWwgHAHxrtLp0P4UgLsD45jDwlWNkJLZu30q0SN2uRTJVQPKboYUDo=
X-Received: by 2002:aca:4c9:: with SMTP id 192mr3272786oie.105.1578677626092;
 Fri, 10 Jan 2020 09:33:46 -0800 (PST)
MIME-Version: 1.0
References: <157863061737.2230556.3959730620803366776.stgit@dwillia2-desk3.amr.corp.intel.com>
 <e60e64f9-894b-4121-d97b-fb61459cbbe5@redhat.com> <CAPcyv4jm=fmP=-5vbo2jxzMe2qXqZP=zDYF8G_rs3X6_Om0wPg@mail.gmail.com>
 <4d0334e2-c4e7-6d3f-99ba-2ca0495e1549@redhat.com> <CAPcyv4jixmv8fJ5FiYE=97Jud3Mc+6QzRX1txceSYU+WY_0rQA@mail.gmail.com>
 <fc0cfb97-5a60-7e73-4f85-d8e6947c5e28@redhat.com>
In-Reply-To: <fc0cfb97-5a60-7e73-4f85-d8e6947c5e28@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Jan 2020 09:33:35 -0800
Message-ID: <CAPcyv4jVpN26RGQLRn4BewYtzHDoQfvh37DEdEBq1dd4-BP0kw@mail.gmail.com>
Subject: Re: [PATCH] mm/memory_hotplug: Fix remove_memory() lockdep splat
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 9:29 AM David Hildenbrand <david@redhat.com> wrote:
[..]
> > So then the comment is actively misleading for that case. I would
> > expect an explicit _unlocked path for that case with a comment about
> > why it's special. Is there already a comment to that effect somewhere?
> >
>
> __add_memory() - the locked variant - is called from the same ACPI location
> either locked or unlocked. I added a comment back then after a longe
> discussion with Michal:
>
> drivers/acpi/scan.c:
>         /*
>          * Although we call __add_memory() that is documented to require the
>          * device_hotplug_lock, it is not necessary here because this is an
>          * early code when userspace or any other code path cannot trigger
>          * hotplug/hotunplug operations.
>          */
>
>
> It really is a special case, though.

That's a large comment block when we could have just taken the lock.
There's probably many other code paths in the kernel where some locks
are not necessary before userspace is up, but the code takes the lock
anyway to minimize the code maintenance burden. Is there really a
compelling reason to be clever here?
