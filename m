Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26618C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 027E12077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="WiZjnsTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgFAJXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFAJXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:23:38 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F96C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 02:23:37 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id a14so8749622ilk.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqbM69/6RW5Btr+W+KHpVhDzS+R37L39EP+X3OHdumA=;
        b=WiZjnsTn7t6HATVqWNwzrCyf5T8xkwd5HR2j4Vvo5xu7w7JgxRYRSp3N+/3ZQSnoOb
         G9J2tzfRzki+NXd/XEXaSwFPmIQjAQJJwCaCdEfYlyM2w9N2XBtKo8Rk93FyrWCtAyw5
         v5q8CNwHVBzDU33yYausjqJpHWIr64asf8+CGUYhILKyPE+W6rW44HXy1MYFVCUpCicA
         fi7D19giO5H/WMBwqp57oXR0Wgm3MeQuFbuORUi97EMIZ7sIMgf+iiKMfSScH+rSiCI0
         mX2x6df2Ucdyv6UajdPE0/ybpMpfkTVgloVKE1pe9dVQeVSWYsyIi+PlHsLyckT41XYy
         fIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqbM69/6RW5Btr+W+KHpVhDzS+R37L39EP+X3OHdumA=;
        b=cQ9NK9tmnByZsktNOHFQ5xnWzzHKTSWT9BTmMM+G2c0tU1VjqZHQIsDh+SSgkZvuDK
         urQBtmUDEwsbqFv4GmnKGr5O+Z3hMY68Lll/ItsEmltp2TrBNYRcj07uNtwe+AD7hZoz
         FNK1Dy8MRkOfKRPMuCTPibGXaRTp/sCQ4t35IB7srH+6xrbKgqEUN1Xp9Nit9Rdf46No
         9uMljJQziBU7Uk4EWkUB0u9VLJKMzlDFZP+5ArlFZ2VFKLExfC57J43dcx4NR/EwmoWg
         huAtd6SrMiNlsPJeFpkmV5LIDEYhwQIh98ygbLatFuoWY2gAcBOx3K5p+FZqAK4abCMh
         89pg==
X-Gm-Message-State: AOAM531uTsOEtF/Ph2CQsSAd/veX0/yu4b2vSR5ULy6Hjr5jp4msR5KO
        +xwsn2XxcvzLVKpBinmtOa9vWh73qlBog6DD2mYdIA==
X-Google-Smtp-Source: ABdhPJzNfGfNdBgl/JJpnGyRowW9LBmQ/5RldTpIc35wpQR9xtvWpjDFGb9F6X7IvF1goJw4p1ikZSe4SvzOYC9hJ40=
X-Received: by 2002:a92:d3c2:: with SMTP id c2mr5456378ilh.181.1591003416905;
 Mon, 01 Jun 2020 02:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <CABV8kRz0mKSc=u1LeonQSLroKJLOKWOWktCoGji2nvEBc=e7=w@mail.gmail.com>
 <20200519081551.GA9980@willie-the-truck> <CABV8kRzYzBrdzC1_opmmdpW63N2htfOsAUZ+RjiSDsy=SJW6Yg@mail.gmail.com>
 <20200520174149.GB27629@willie-the-truck> <CABV8kRzjCCsjVeRsBD7U_Lo0==sBw9EKm=1z7g=60KyJvJLZBQ@mail.gmail.com>
 <CABV8kRxfet2RXXNcUoTKwfVzFWEQfxAkXUX4M5XhkP3nc-0+rQ@mail.gmail.com>
 <20200527095528.GC11111@willie-the-truck> <20200527101929.GT5031@arm.com>
 <20200531093320.GA30204@willie-the-truck> <CABV8kRyHo+EAWaMUzGA220z=HJRBCpH6UWiYGb84uSL3h8HQHw@mail.gmail.com>
 <20200601091441.GW5031@arm.com>
In-Reply-To: <20200601091441.GW5031@arm.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Mon, 1 Jun 2020 05:23:01 -0400
Message-ID: <CABV8kRz2ineTcLS29Lh=BW_kJB_X7PoqY-MaMj_pUUziOxrYCw@mail.gmail.com>
Subject: Re: arm64: Register modification during syscall entry/exit stop
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Will Deacon <will@kernel.org>, Kyle Huey <khuey@pernos.co>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 5:14 AM Dave Martin <Dave.Martin@arm.com> wrote:
> Can you explain why userspace would write a changed value for x7
> but at the same time need that new to be thrown away?

The discarding behavior is the primary reason things aren't completely
broken at the moment. If it read the wrong x7 value and didn't know about
the Aarch64 quirk, it's often just trying to write that same wrong
value back during the next stop, so if that's just ignored,
that's probably fine in 99% of cases, since the value in the
tracee will be undisturbed.

I don't think there's a sane way to change the aarch64 NT_PRSTATUS
semantics without just completely removing the x7 behavior, but of course
people may be relying on that (I think somebody said upthread that strace does?)

Keno
