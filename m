Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9FBC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0362072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="JPa2uVHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391203AbgAXSFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:05:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40584 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389886AbgAXSFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:05:03 -0500
Received: by mail-ot1-f66.google.com with SMTP id w21so2458416otj.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 10:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jRTNXnXM7oz5Drw0JUEzLHf8Tl/lM2SK6ojzvbVm3Do=;
        b=JPa2uVHTQnO/DXnNRVd8XmoPi8VpJuIDhI+MwREr6Mb8Ij5HVUDpA6TxomyZ+Lff6W
         Y0DI9Cm0csX4gVNf0fT2szWUMfB8PaOM+JHgiQ6lHgp2HYGhZ1FLuEQr0mFTp/UHZGEJ
         4+wmRzEAsVw/5tyikkUBaJSaYwn1dj9gvK9c5x/AxAQpvh0podrIffNwzqKp0EkArmJ1
         oMwVvXtqQAlFZUlPokk+ed89Py3Hp2N12VOLnaJO0t5fYarr08YbsRzuILrxgeCojT/8
         rcUiO4nPjlpm1y4ofxPB9A4MFUjfm6TIH4pRlXvUZhWjjbyJWGoW4+7jNw2e/p4KVf8Q
         t5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRTNXnXM7oz5Drw0JUEzLHf8Tl/lM2SK6ojzvbVm3Do=;
        b=hE7M51HD278fQ77kDjyEkaDXtll8ITd44Mku7rAJ90vDxQ4nm7OG2t60bh7MmErh5a
         Ee3WODqKnUyXMlHjmsVpD5DF4SJpXeTQP+ugaYqknFQLv9WSAgMI1DLpbHu6Wo6Z7Tib
         CKk8DKURFXnWJlzYFizGNsqA0zZ1H2AwlAeX5o40JjlCtPyVubTwDL1oD2h1aJPd7C5c
         nhFhq5Wn/qggKe5jUM8UcKhu7tuS1bclBJ/BNJ6S3XpTcs+Q0n67KULNFiNq02QMXw8b
         coslbNcnWilYMqirCyiHfOxIOS7FfwCEf5tTOFWvdJP3hJ1/q7mcc/DC3ZuFDSic1M66
         wnVg==
X-Gm-Message-State: APjAAAX3Yy/yBYOeNAPqatVImFNFDgH8ryVX/Oj3K3ibj1RqDejjBqr6
        QRlsvLL8/RlHNDiHhfbxiUkPChf9/bCjvNkDg/YkGw==
X-Google-Smtp-Source: APXvYqzFJoNGdvBkNazI2Gmjmm0Jg7CrgLUOGYJxHStstoF4GHQEZ08I0ffdQ1SOyeaigHkZmgGXPCfxHkNpYgjxS48=
X-Received: by 2002:a9d:68d3:: with SMTP id i19mr3393231oto.71.1579889102817;
 Fri, 24 Jan 2020 10:05:02 -0800 (PST)
MIME-Version: 1.0
References: <e60e64f9-894b-4121-d97b-fb61459cbbe5@redhat.com>
 <CAPcyv4jm=fmP=-5vbo2jxzMe2qXqZP=zDYF8G_rs3X6_Om0wPg@mail.gmail.com>
 <4d0334e2-c4e7-6d3f-99ba-2ca0495e1549@redhat.com> <CAPcyv4jixmv8fJ5FiYE=97Jud3Mc+6QzRX1txceSYU+WY_0rQA@mail.gmail.com>
 <fc0cfb97-5a60-7e73-4f85-d8e6947c5e28@redhat.com> <CAPcyv4jVpN26RGQLRn4BewYtzHDoQfvh37DEdEBq1dd4-BP0kw@mail.gmail.com>
 <64902066-51dd-9693-53fc-4a5975c58409@redhat.com> <CAPcyv4hcDNeQO3CfnqTRou+6R5gZwyi4pVUMxp1DadAOp7kJGQ@mail.gmail.com>
 <516aa930-9b64-b377-557c-5413ed9fe336@redhat.com> <CAPcyv4iiYtN6iGt=rVuNR=O=H9YcY1b1yWp+5TuDhu0QoVqT_A@mail.gmail.com>
 <20200124124512.GT29276@dhcp22.suse.cz>
In-Reply-To: <20200124124512.GT29276@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 24 Jan 2020 10:04:52 -0800
Message-ID: <CAPcyv4jcCnfGy5HcYimxcyF6v_Anw4nMdaNHQt4tMrqUaN70Rg@mail.gmail.com>
Subject: Re: [PATCH] mm/memory_hotplug: Fix remove_memory() lockdep splat
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 4:56 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 10-01-20 13:27:24, Dan Williams wrote:
> > On Fri, Jan 10, 2020 at 9:42 AM David Hildenbrand <david@redhat.com> wrote:
> [...]
> > > For your reference (roughly 5 months ago, so not that old)
> > >
> > > https://lkml.kernel.org/r/20190724143017.12841-1-david@redhat.com
> >
> > Oh, now I see the problem. You need to add that lock so far away from
> > the __add_memory() to avoid lock inversion problems with the
> > acpi_scan_lock. The organization I was envisioning would not work
> > without deeper refactoring.
>
> Sorry to come back to this late. Has this been resolved?

The mem_hotplug_lock lockdep splat fix in this patch has not landed.
David and I have not quite come to consensus on how to resolve online
racing removal. IIUC David wants that invalidation to be
pages_correctly_probed(), I would prefer it to be directly tied to the
object, struct memory_block, that remove_memory_block_devices() has
modified, mem->section_count = 0.

...or are you referring to the discussion about acpi_scan_lock()? I
came around to agreeing with your position that documenting was better
than adding superfluous locking especially because the
acpi_scan_lock() is take so far away from where the device_hotplug
lock is needed.
