Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B68C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B20206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583534933;
	bh=LWpHu1r84HlOjvwG3ioOylpqLJocbQRWsXQw7XgIK0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ipGjAKzjsgs0JYefO+Lt34/GiB3YkfLaSNQlFHvPeb7dJAx5XoETQ+Cw4R5BaRGZy
	 zSwdPteGkU0Np9eKecQLjePXL1x0Wsij2F5sC7fppwwcf3jiVJo2EchYaTfP7/92F9
	 krv+rhTavwqmL4EgD6ZoElhNXpLl6c7CUQpevf34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCFWsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:48:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46490 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFWsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:48:52 -0500
Received: by mail-lj1-f193.google.com with SMTP id h18so3854380ljl.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 14:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4+hg26NRO9oToP0fK/zLY8Uu7C+0oO/4HrjLui3AwqI=;
        b=SCWAY/NTkr7D0TyKU1ZdmrjUWU/TXc/sJGIzi8nKRo6pLPzoXL4lN9kNM4AFizNloC
         apWBNk+7L+MMWPV7j8eyraj7m74+ytyyvYKKmBMvAbw+rVrBa4AKbooBvexoTiU6WsiW
         bL/i1VKBUUl9G6Gm72kdmJBIe1k2GEtTh5WF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4+hg26NRO9oToP0fK/zLY8Uu7C+0oO/4HrjLui3AwqI=;
        b=duE8h8pivXJbx/snywyheB2IfTFCtO7aXp6LvWt5JMnPLLSqISEKBC0ylQKoenrLCq
         wpN+icZDAtPBqyt4ZNmMuFQKMVYph3DRnD/9TM8cJTOhPy9UexvR2CYH0emAozKWRkN2
         CN/chATQ5Mt8bUnzMtSQVpGwhbzxb1Tn2fZIzTQLVZshuUWh+cDOo40T+Q0z3EAWblFG
         yz28K2QXwc2YbWoU0tZxyteMFq22zX82fISEAQI7nv8f3TMi0V+5RMJscesYQUFDe7B0
         0pUX7DEVpadFtoBUYRtT/+l9GTDhpDjcPSkrp1IvGr/+B4l3IkdFmZDoysJPGQJO9R3/
         jtRA==
X-Gm-Message-State: ANhLgQ2/xSo0Qt6m6x6WnigTeJiIbjEuhy4Zl2DC18EgppHGTM2dsgYL
        GOvu2tyfgWc3JW56DLE1UzGYRYn6qwsbMg==
X-Google-Smtp-Source: ADFU+vsYBIHcaitTV0N8xWGtUdgiJ4qEZVH44WVMCzGofAb98n61Os2vQ/iiFW387BkETrpuZag4Kg==
X-Received: by 2002:a2e:554:: with SMTP id 81mr3233164ljf.92.1583534929731;
        Fri, 06 Mar 2020 14:48:49 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id n200sm1299443lfa.50.2020.03.06.14.48.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 14:48:48 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id z9so3200351lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 14:48:48 -0800 (PST)
X-Received: by 2002:ac2:5203:: with SMTP id a3mr3217720lfl.152.1583534928332;
 Fri, 06 Mar 2020 14:48:48 -0800 (PST)
MIME-Version: 1.0
References: <20200306221312.11199-1-j.neuschaefer@gmx.net>
In-Reply-To: <20200306221312.11199-1-j.neuschaefer@gmx.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Mar 2020 16:48:31 -0600
X-Gmail-Original-Message-ID: <CAHk-=wg9yNnh-0yuM1wif_8iSRyCNVTMxwJvf58PS=S=r4Ax+g@mail.gmail.com>
Message-ID: <CAHk-=wg9yNnh-0yuM1wif_8iSRyCNVTMxwJvf58PS=S=r4Ax+g@mail.gmail.com>
Subject: Re: [PATCH] parse-maintainers: Mark as executable
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 4:13 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> This makes the script more convenient to run.

Applied directly to my tree as I was busy merging stuff anyway..

               Linus
