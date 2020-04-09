Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEC6C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1ECD2072F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ybcida/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgDIWey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 18:34:54 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:36956 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgDIWex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 18:34:53 -0400
Received: by mail-vk1-f194.google.com with SMTP id f195so145141vka.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 15:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O43YyhQbXypQigpDb5W4AE3UQtabqP/VhiwIcpxo7xc=;
        b=Ybcida/ULL37SrbJl0X9LND3HIWNowHd90FVrfpoIESXi9gBfCinQFPtjR7fDGGafM
         xYJul2Mf6wDPOW66l9ruMU7ZvW6o8D7d3MLX/jGBET8Jv30UkSJsO1g1j0qGi7petyOD
         0CzmdZB9xAZ3U2vFLzY+bWff+YXGGG3gFGJ6pKeU8vGJo0FMJoU9VHVJtMJPXgwKl5gA
         HuSHJsb/ye4t1cER276kI/KwumuOvPouPwQUHBt1vlnesbDLUB6rodoaOuc3tcYdUGKm
         Zex0Vzd8U8ouO3B47jH/59hKFuGDYgyX+n5iCaHS6gBdBut/87BWkRS2Dta0qiR/mMGw
         2i8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O43YyhQbXypQigpDb5W4AE3UQtabqP/VhiwIcpxo7xc=;
        b=Dqxsn9LTORsuffAciGRG4vPf8uqqb4v4xWrGqCnU7NPacJ0XrV71T6AWXQxrV+vUXZ
         yRGvX89wV8S8lienlen/zwezjxbC5Tt8jyen1Pjm1iv02Uegf3YPW6A5ijdi4cd5mLCg
         n2Y5UmQsD3Hu81e/CbIvZ/pe1qvhlEUKbgX7WPauDU2HqOgZwTRSFfAFISYA8rgs6aDQ
         A6MVpM1Pj0O+Vd7E15R0fkHIEUuWxTvVDUaEu218pc+ABiKbYrIWEPiau60oKtdvDlgw
         3iR/769t3bA7RQ4vOYm4r/7bVk5+SgVrglRqTNvMVNnIWF8D+lVy8hjADxOE53bbBObZ
         ROxA==
X-Gm-Message-State: AGi0PuawOxEakokkmP+NXE3Lr5lh/Jf+nGRfhIRrJBEKWedYjm/+S/3z
        LlsMRH0M/BmzXOatnNiZp6VlYAUfVhePMf/HO+nULg==
X-Google-Smtp-Source: APiQypJYyEmRQ3L852FLGq6kYriYYTWzejlxWdd/TgxoFOIAYYRioXQN+b5ufHFx4QzoDIychhUzl3z78Lr7elgOhFw=
X-Received: by 2002:a1f:5003:: with SMTP id e3mr1537385vkb.59.1586471693332;
 Thu, 09 Apr 2020 15:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200407065340epcas1p13e6e5ad6131f0a94d3ed1e8360353a82@epcas1p1.samsung.com>
 <317e0073-a6f7-4232-3b95-a4bc3ddbcdec@samsung.com> <CABCJKudWRmdyJAxjnTs+NiRJVnhDUQfzGO3sVKZNJoQ5Qi-aew@mail.gmail.com>
 <4a4a914c-c020-4b45-7cba-5aed816f0545@samsung.com>
In-Reply-To: <4a4a914c-c020-4b45-7cba-5aed816f0545@samsung.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 9 Apr 2020 15:34:41 -0700
Message-ID: <CABCJKueXaqJz2n9sfAOWsHGD8qgL8VzD5qWcqsK7cA6zrM_Yrw@mail.gmail.com>
Subject: Re: [PATCH] dm verity fec: Don't add data_blocks to block
To:     Sunwook Eom <speed.eom@samsung.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sunwook5492@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 11:40 PM Sunwook Eom <speed.eom@samsung.com> wrote:
> If you don't mind, I'll send a new version of this patch.

Sounds good, thanks! Please also add a Fixes tag to the next version:

Fixes: a739ff3f543af ("dm verity: add support for forward error correction")

Sami
