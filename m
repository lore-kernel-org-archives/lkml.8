Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7302EC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E7B20708
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="H5Qr1CGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgA2JwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:52:01 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:42827 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgA2JwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:52:00 -0500
Received: by mail-qt1-f175.google.com with SMTP id j5so12721217qtq.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 01:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Ym4AsXsnOm1g4rxq3gDMG1juxmP2n0x5mzZ9uOtHw8w=;
        b=H5Qr1CGEPYBqZIPOZNAv2K0TfRrrCPZLI5nSuJRWbCArLgB78GulQEWMEFvlOVsfeb
         F0YmeKRN6Mtf0ZntcG6PiSVwSKs/YT+myPW5RF7Dg+nskvmU5zL0azX0EsM+NTNAg3R8
         fijqhZuRPm0ullEvB2MHyRhJHIO6RntjxTN6GmRk4k5wPNLs+nrIbh5ypCQYcC0kwMsd
         GzyDVFzTAqWWYZV7P9jh18zamTIhYJa2wiriehGIo5eNPqmZKEJzhtmZnmjomSGb47D0
         J5NtW7UvwKiVz688IcF6KxPsSl0BcNewczbu+ZYB2P9q7k4mPnGJ1Sw4veQ/0cr7QbEz
         HL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Ym4AsXsnOm1g4rxq3gDMG1juxmP2n0x5mzZ9uOtHw8w=;
        b=USCpm3vQhjmbyVW872hjlk2sbNf+IQjSF+k/gGVhD1g6an6Tppi+UtLq8J9b16U572
         NIe2drKW8xQ1OApRP84Q+CrTyHCj82kyUbeoO6//aDb9WDpC6rENNqy9IPGug+SXaFDD
         uJ18LU0U9FeFzOhOoMXpz+JHXsPpvQ6ZxKsk86wAYeZDoi1hdKnR9dJwIMbDwAyLJXng
         2rtZJGID0hWymdIKZjTlDzNh1gj38hCksufjzqblbI+JJhEqWzyRZGWp1Hgj6NbGud6M
         p6mk7O5hUtJQ9R4NQu8xE7pz6nD5dFGhO5cYOjnknRsJ8TfrbvO8rLcyFIYpBO1Kx5gl
         ywYQ==
X-Gm-Message-State: APjAAAXrHY8ExLrieAcd/H7PRmVh+HAqaF4kIaR2pjUF+tAmXMpuuINu
        Anlk93oFg8SmXQNeNOuLmR4iI1Vr4c1YIA==
X-Google-Smtp-Source: APXvYqzEtL1Ao4cDO3pN1cdXP8qNShLpXfkdsVCfJzlIky0LOT6cMCWye4UD3R1LMz+H8E4yu8h9Qw==
X-Received: by 2002:ac8:47c1:: with SMTP id d1mr25092530qtr.84.1580291519529;
        Wed, 29 Jan 2020 01:51:59 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m16sm700391qka.8.2020.01.29.01.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 01:51:59 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] mm/page_counter: mark intentional data races
Date:   Wed, 29 Jan 2020 04:51:58 -0500
Message-Id: <9507ADF5-1040-495E-9A39-C0C23412AD64@lca.pw>
References: <CANpmjNNaCtL+vqpPKug9_DoFUue=PdoTyQFXLOx5H_BYCyDMzA@mail.gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CANpmjNNaCtL+vqpPKug9_DoFUue=PdoTyQFXLOx5H_BYCyDMzA@mail.gmail.com>
To:     Marco Elver <elver@google.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 29, 2020, at 4:06 AM, Marco Elver <elver@google.com> wrote:
>=20
> These should be using 'READ_ONCE' and 'WRITE_ONCE' for c->watermark.
> Store or load tearing would change the logic here, since the
> comparison might see garbage.

I originally thought that it probably does not matter because it is racy the=
re by doing lockless access anyway. Another thread could change the value at=
 anytime.

Now, I agree set it to a garbage due to a data race could be quite unpleasan=
t there.=
