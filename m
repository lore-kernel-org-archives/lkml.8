Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67957C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3DC21739
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9hPJ8Rt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgA0LdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:33:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33738 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730109AbgA0LdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580124782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PlXx4GCmusHDyEhr1tc9UGO1kB0k8P75h0J2Af90Eb0=;
        b=A9hPJ8RtIVEC8gjkpIoWwyV7FkbDcO9J57D5P1KR1dL8vCv79pwW8bSNsT1zp5CK4VbY/Q
        H4eR15Ow2t54M1vOkJKRPL8cUGMbE0mA2NDljAhxZ4kBDLR6bCsD8bm1YMbJDNpbgMVsRg
        c4Os02fKk4XsMcgke5iJPFnLy1Whzao=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-3_4QDrRxNJeYRh_Sehvrvw-1; Mon, 27 Jan 2020 06:33:01 -0500
X-MC-Unique: 3_4QDrRxNJeYRh_Sehvrvw-1
Received: by mail-oi1-f199.google.com with SMTP id o5so1629933oif.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 03:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlXx4GCmusHDyEhr1tc9UGO1kB0k8P75h0J2Af90Eb0=;
        b=nk5u3dVFqWnrVTipl0cZy92jMxEkmkaiKt4LEgUX29ImGZKVljLjmycABYT4SYwWX1
         q0GvyhvMN+td0U6G9lSj8m79qb2YMMAedrPOGR+IGe8YpvUtpfm/SspMlWSh9mBwnxjY
         87iXVcMVSXM88pSZPLJLEZr/D9Qy73eaWkasZSD3Fqu9Qa/JosGUKU/qcl20x35NiKJu
         SeDo+JCf86+otLs+7N+UC1Qx997rzvWlOJXRdurb+Fg2LgxcatvqMERwWZxoAQpLHmOG
         mIjM+1C8Fg3Wi80yw03cmQRSfBNgvW8iBW7LZ9EQgTq61RKEjYNZyGZT4oeEz9I61czy
         OQGQ==
X-Gm-Message-State: APjAAAWk1OF+mmzFgVa6oDbcOPkTWidypBBboposFe9EV/PM9NWwrlpy
        EGuy2JXMW1d8Yi4sIs1IOVa4omQr51zJvgv/Vtqe4hFomYAw1q9PiJjpowO07Pu6RwgcHrfaKMT
        nGhsO7gcKXjQNRtv84OpMAoiGyXeaYC2rrhpNWK74
X-Received: by 2002:a9d:53c4:: with SMTP id i4mr12833307oth.48.1580124780170;
        Mon, 27 Jan 2020 03:33:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqy2WCKL3TcEQWLEGBx1bgWgRFFUvo6KJVLgtkrNqpfuMHkeNAswCT3gA+Mrw2sEoru3XQgdgZuxdIpa/3I3A0I=
X-Received: by 2002:a9d:53c4:: with SMTP id i4mr12833293oth.48.1580124779964;
 Mon, 27 Jan 2020 03:32:59 -0800 (PST)
MIME-Version: 1.0
References: <20200127101100.92588-1-ghalat@redhat.com> <063e702f-dc5f-b0ca-fe26-508a9f1e8e9a@I-love.SAKURA.ne.jp>
In-Reply-To: <063e702f-dc5f-b0ca-fe26-508a9f1e8e9a@I-love.SAKURA.ne.jp>
From:   Grzegorz Halat <ghalat@redhat.com>
Date:   Mon, 27 Jan 2020 12:32:48 +0100
Message-ID: <CAKbGCsfyiLfvwi1iYuTu2Gg5=TXQwUQ3iv73PdNvY8o_NZJ7aQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: sysctl: add panic_on_mm_error sysctl
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Stan Saner <ssaner@redhat.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Vratislav Bendel <vbendel@redhat.com>, kirill@shutemov.name,
        khlebnikov@yandex-team.ru, borntraeger@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2020 at 11:43, Tetsuo Handa wrote:
>
> Maybe panic_on_inconsistent_mm is better, for an MM error sounds too generic
> (e.g. is page allocation failure an error, is OOM killer an error,
> is NULL pointer dereference an error, is use-after-free access an error) ?
>
yes, panic_on_inconsistent_mm is better

> Also, should this be in /proc/sys/vm/ than /proc/sys/kernel/ ?
Agreed

I will wait a day or two for more feedback and send V2 with sysctl
named as 'vm.panic_on_inconsistent_mm'.

Thanks,
--
Grzegorz Halat

