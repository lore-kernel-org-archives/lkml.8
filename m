Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEE8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54949207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QAExVmYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgFQMFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFQMFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:05:08 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F4BC061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 05:05:06 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id s1so1144590ybo.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 05:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ce5ijYOF0B5Aqlf57GOv1H78E2Rpwmzo3WdEJEFGYSE=;
        b=QAExVmYqjdDJlSzYO0zRvYtLurMgwAeu8aVFVB8OL8VsADCePe+QaZgfl9OkXCKMAQ
         VKuabSPfs5so+ExviNS0jK0/pg8P+SUO6EisqEr5iBs8D8GfHdHzEXPMQyrTW/GvPWaU
         S/rpxTYOoPblTuhGcsXkbxUjMFdffWjZaJAH2Yf+MrKACpx9oUwzd7a6Iv6gA4XIx3Ky
         EP5jCZdtRVa34VO/VJ6okmLDOWuzJ1+ygmLdjT9hXqVNFsvAHysGhxo8YQ4tMhkd7Lkr
         wrif3VT2UfRTXX5dSLWVZ1RRUUPVoYECIfDkG5oeJD/zmqgSnw5qI33u0VsoZflYnWiZ
         wFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ce5ijYOF0B5Aqlf57GOv1H78E2Rpwmzo3WdEJEFGYSE=;
        b=YWz0AA2c3sfvw02brwLDdL0onCDzh+cKc8jxK+ms86BIVfVZ/9n9LF7SC8ODjOXgLL
         /8vf+JK9cIifyHcxUu8bRro5s5cW1lq34H6VbYLKGXew4Z3aCu1aciJIbnZviPqB93cC
         OzdbhtK43FvAziqRmL9x7L9P1s8bc8+qARfn91ht6w6WvLu8Kt+nn+ph7IqFU6NuQbEh
         UV+P7y7EuIzYWpxB2mFwy6VD6qZUaFflWzxVr04Pn3eHstAx2Vd0GOn4mcvNEO8EeIkn
         ABZWvek0GScVcDBYG6bXxq1JSKkTt6BBYj8PVZq4ngtjLZJN+sSrg1MqLp0cJFXK1PNL
         3l5A==
X-Gm-Message-State: AOAM533x/bbSHhcHUnireQ479XM5YT4hYXRazpy9bgC6TCS2flKXb+dk
        zPop1Ff0aBxfVTK30ou0adLfybFp+E9i+MmB0paF/g==
X-Google-Smtp-Source: ABdhPJwVwzsytVeAA15ADKunV37yJHXmL+R8PoOsnbw37rc75bwoSG0DAvnfoh+gLdkshu8DPeRsyLit2wi1veXDijQ=
X-Received: by 2002:a25:7b82:: with SMTP id w124mr11825940ybc.320.1592395505465;
 Wed, 17 Jun 2020 05:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200617090247.1680188-1-shorne@gmail.com>
In-Reply-To: <20200617090247.1680188-1-shorne@gmail.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Wed, 17 Jun 2020 05:04:52 -0700
Message-ID: <CANN689E_oP3T6J3Rw2rWv1KG3GO3JOJtCdCb3yMLz+u8hFN=Qw@mail.gmail.com>
Subject: Re: [PATCH] openrisc: Fix boot oops when DEBUG_VM is enabled
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Steven Price <steven.price@arm.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        openrisc@lists.librecores.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 2:03 AM Stafford Horne <shorne@gmail.com> wrote:
> Since v5.8-rc1 OpenRISC Linux fails to boot when DEBUG_VM is enabled.
> This has been bisected to commit 42fc541404f2 ("mmap locking API: add
> mmap_assert_locked() and mmap_assert_write_locked()").
>
> The added locking checks exposed the issue that OpenRISC was not taking
> this mmap lock when during page walks for DMA operations.  This patch
> locks and unlocks the mmap lock for page walking.
>
> Fixes: 42fc541404f2 ("mmap locking API: add mmap_assert_locked() and mmap_assert_write_locked()"
> Cc: Michel Lespinasse <walken@google.com>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Thanks for the fix.

Reviewed-by: Michel Lespinasse <walken@google.com>
