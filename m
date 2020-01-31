Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC7FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 23:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628A020707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 23:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lambdal-com.20150623.gappssmtp.com header.i=@lambdal-com.20150623.gappssmtp.com header.b="hZtCWyLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgAaXBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 18:01:01 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:38691 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgAaXBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 18:01:01 -0500
Received: by mail-il1-f196.google.com with SMTP id f5so7672460ilq.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 15:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lambdal-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J1hLrezcz3jXrNRHETLPTOEFBy5be59PXuclyjBiwAo=;
        b=hZtCWyLWJws97PMujYcbMIavFe3gxy3pp5DZgGitwbPQy690tMb2V0LrzXL9wAuxTL
         azDb7a9cYDjGX8xwo/ERun3QeQRjPE1FscLD2bvnvJHeRw40G3UqElCnWc2lgRz1oi2p
         ACzEi+KFNFMHOrcPJ7s9RW3j0mGxSE0xdRMF2TR1jteebFk9VD/csUXKAK4lmL0b0WaF
         VT9Fm9yQ8JwAuGRrYgv/09dDCSAju1tcaqky7Ic39lp8IJ0TO0IyzXsNRmPaFzccB+4t
         i0/LTuV0kul6Pc60LhDUmaqD9yB1AXuKNuuvjsWwUkfvOMZCJDhPfBHMQy11itvccbIZ
         58Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1hLrezcz3jXrNRHETLPTOEFBy5be59PXuclyjBiwAo=;
        b=Mu1AU0YQ/w5IBZuYV1HxtxfEfQjOhuKQsH5oFRnFOJ42dtmnuz0xIstefwWM2ieMIT
         R/RALW5j3incvp4HdxGbliXZYorW3fB8Bq1FhmXufmaOKXJkLTcEE+gIU2hd+KWAyad8
         DXzPoQrLSMox02silCHsdPoQCyf538tgOTT7PiQBRPjLAklbGugRsIs9GrSUpUUh9Y/O
         Zly3icHNapz3o2EbUdAD3SLlqZAnaykpfiH+UzBi4Z7h7DnROzJOAmbHZEzbXe4mYnxJ
         rbxdyF3diT93lSNdrTGHE9goJKeFJxR1Vev4PeAJV2Ic+DVXC4rH41AZJt1LRhjzuhre
         O7mA==
X-Gm-Message-State: APjAAAUIaf0p9Dce/yu0NrhtZsFH8B4G0po3kKKVYvWqZpZRFGXv07ep
        deCAfzwXGhS9pHGIe7shBSPCeehPNk7YZSazFUIUxxMRBYc=
X-Google-Smtp-Source: APXvYqysTQFPKr5xqGJDpuvTI0nGS9t3mUNnEQMliHauW2XgA/X1AGcKB5iqbde5uczSC3+TfdV+qg3UW+5WQrg/up8=
X-Received: by 2002:a92:8309:: with SMTP id f9mr11916094ild.50.1580511660295;
 Fri, 31 Jan 2020 15:01:00 -0800 (PST)
MIME-Version: 1.0
References: <CAHKq8taGzj0u1E_i=poHUam60Bko5BpiJ9jn0fAupFUYexvdUQ@mail.gmail.com>
 <20200131185531.GC14851@zn.tnic>
In-Reply-To: <20200131185531.GC14851@zn.tnic>
From:   Steven Clarkson <sc@lambdal.com>
Date:   Fri, 31 Jan 2020 15:00:49 -0800
Message-ID: <CAE8Va4ftJBFpHv1kENyRhed5EGFgopNM2TpxwYC8psJCrnPBAw@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Handle malformed SRAT tables during early ACPI parsing
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 10:55 AM Borislav Petkov <bp@suse.de> wrote:
> Only in case you want to send patches in the future, see below.
> scripts/checkpatch.pl can do that checking for you before you send. I'll
> fix it up now.
>
> ERROR: code indent should use tabs where possible
> #37: FILE: arch/x86/boot/compressed/acpi.c:398:
> +               if (!sub_table->length) {$

I did that, but my mail client ate my tabs. Lesson learned. Thanks.
