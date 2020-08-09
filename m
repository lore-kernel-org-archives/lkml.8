Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B87BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 15:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 542B0206B2
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 15:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ6dYle3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgHIPK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 11:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgHIPKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 11:10:21 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF40DC061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 08:10:19 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id n4so3047474vsl.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 08:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tk3U73URR05lkh2ICGJjJ/tKPSgnTaTWlg1TLB6sub0=;
        b=YQ6dYle3zzGv2KDt0bQ3nieuGAXW5cvBGy/K/L0sYBQFK//6nRoiHX9X32W7xDgOMF
         XzNG/T1r83a+yuQ6IkDzJhuJrHTfJQd1KSYaNN61BEzYAaQstXuPvJ8B/Pjz+M9cs4TL
         EnTgrC9Fd7BuYprSMKmYqonO4tSyKiDQeHf4UGwBrLE1/RTBrUYnZTe9qxFNqAWVLoGO
         YCgWkKTjZgA4v4VnsZufQwuWlX+G7EdDlb4JEEykjLOYBpuR96rm81Ey32/EOdIIt80G
         tH3ZfmWGeWuo2Q8ktOyNtGWC2TpBbQUTEECcKjroqCPhHUWKQ4/YOJlU7FDLwvfB82nf
         u40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tk3U73URR05lkh2ICGJjJ/tKPSgnTaTWlg1TLB6sub0=;
        b=oJ4NeeXCnbNVw+J32GyN911bRvN2NQHmzPeLaJucR1DnmUX3y7B+CuNFPH/P4P6b8H
         zbAVzHQ0/JQP2A0hthwizi3Np63AvGqf3UPg0Q+FyLcYZY9AQXRZ/JVY6c1u4JXMqYU/
         RE/yBlB/vHo45XsB0DtdQNV/o6bRG7dTUtRao+wWXlZ9w9A5cAhy2xM47NSb50TvSSga
         gzteGL/Qyc3VEKxOzErTExxz10HZxUS2RtsBgcanACu7LvurSgNgXOZ8VVCzxEvOdC9w
         GS6rZCs/LIraevzMa9PT/pxWGn8cb/IvzcA3fQAeTZT6wmheHRihaVuGsbrT5NMZ4ctx
         sg5w==
X-Gm-Message-State: AOAM531zBI2kqqbjXGPU+zzOiqfy6iKZMbESkcVxacv3qvGzQmTH3GfC
        3erwxz5fQCnOfxdPxJFfdb1P7EZxJ3VfbMNNN973RU6AmYQ=
X-Google-Smtp-Source: ABdhPJyjtziLzBoEdWKJbz3N4Ml9RM0C6QwBecCBdSh0wcenY7FbZxpAA7xFHS7wXeSNO8+9Zr3Obwzgc+qewrtr9zY=
X-Received: by 2002:a67:fe15:: with SMTP id l21mr16216028vsr.78.1596985813241;
 Sun, 09 Aug 2020 08:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200807200957.1269454-1-jim.cromie@gmail.com>
 <20200807200957.1269454-4-jim.cromie@gmail.com> <7e5c90bf-eb04-4b63-2990-7be18e22664f@infradead.org>
In-Reply-To: <7e5c90bf-eb04-4b63-2990-7be18e22664f@infradead.org>
From:   jim.cromie@gmail.com
Date:   Sun, 9 Aug 2020 09:09:46 -0600
Message-ID: <CAJfuBxzafMKtD88TmwYqQ-UuvS1Wvtn1ehz-7gtF8KtiRojFaw@mail.gmail.com>
Subject: Re: [PATCH 3/7] dyndbg: select ZPOOL in Kconfig.debug
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 8, 2020 at 11:06 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 8/7/20 1:09 PM, Jim Cromie wrote:
> > dyndbg will next need zs_malloc and friends, so add config reqs now,
> > to avoid touching make-deps late in a patch-set.
> >
> > I used select in order not to hide dyndbg inadvertently.
> > I want to say recommends, since it could be an optional feature.
> > Whats the best way ?
>
> Hi Jim,
> Can you elaborate on what/why/when it could be an optional feature?
>

hi Randy,

I dont think making it optional adds any real value.
if ZPOOL/ZRAM/ZSWAP is not included, we dont get any of
that sweet sweet compression. or the off-lining of >1/2 the memory.
I've got 46 callsites enabled atm, which is more than average, ~3100
callsites offlined.
This is the payoff for the added complexity and memory (the site pointer)

fwiw, Im not entirely clear on which of ZPOOL/ZRAM/ZSWAP
is the correct dependency/ies.   ZSWAP feels like the best destination
for the data,
especially if the data can be pushed aggressively into it.
