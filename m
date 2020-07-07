Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63859C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 455C020720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkpo7TAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgGGRvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgGGRvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:51:49 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41880C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 10:51:49 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z24so26074555ljn.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 10:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f8v3cihLb8QiYI+J7AvaB4CTyWDaUVAO7Iv9Hi1QHe4=;
        b=rkpo7TANGfYaf/vUlpMrEhPBVlyPR+6aGEwlZKfWQQpG0KMVCXwsNjcTFyG9GxKIm5
         OW6A8LMLGR5zBTemvohQt00saLvbvr87BZGQir8UL7aOjA2lE1x7CvhKF+ERzqaLgovs
         jAWvxVoHOOLitql/iKoM/lSlOopQtwFZ5k0VWbxfcMKesburO0/9k+pdi6jSCYLU8ymO
         o+Cm+7NDR3EMNMeecJBJFzcwectWqAnZ71zEoFbcXo3uND8DfO91YEQ/eD1KPXEBsIXS
         2PS0/VR4/kazbbMi2Jlxe5qHgnW2m/okbiC7OULjKzs4tiPcypSmMoqcjm/HpZn6vIbG
         XqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8v3cihLb8QiYI+J7AvaB4CTyWDaUVAO7Iv9Hi1QHe4=;
        b=ISwKT/p7TRXvKK2X4Gn5mGDPkyc+13EnQac4lxqucFD8Cl1IRnpXqDTtk4DN1uJOPt
         ZmCwBErD7xC/J/P569LuvsAqBW4TRmaNelaRhQFs239ioK2nXT8Ul4KqQsL/wJUbTy3e
         1fDzahBZWFguyuAMABFIVWZgFAckwnqXpkJIhsTDf07ACnTfUyRAyJpYDhC0R5lQih0Q
         4x03x1UbRziaBsVPmPBApCmOS+N8YOFQNXANucKDAuXz2cGfX9w+Lim3V7g0xhphbTE1
         qpfHjrxpXATb0NqoHLiTvpvXx79pIsNVeLz/7cqSDt2ssJeLGaDZ+7Q2BqW9udvW4lYl
         g/Hg==
X-Gm-Message-State: AOAM530wT4ARBmadmaFDuMBHblj1QM5KLfu6aHpuaHaN65b7pzvaS2jV
        5BRstPpTF8Re1ypgf9UK/4CuvlWJOWQDy8CNKZ3CJg==
X-Google-Smtp-Source: ABdhPJz3z4N/tz9QUCm3/uMGyMCbcOzLsEG1LY30yg5vIopZm4tUsj84eGDkYNA1hPKp8gSOam8WReaW+Zo1AOeZkHk=
X-Received: by 2002:a2e:b4d0:: with SMTP id r16mr10305827ljm.332.1594144307499;
 Tue, 07 Jul 2020 10:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200707173612.124425-1-guro@fb.com> <20200707173612.124425-2-guro@fb.com>
In-Reply-To: <20200707173612.124425-2-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 7 Jul 2020 10:51:36 -0700
Message-ID: <CALvZod6KXkJKBZ4y6AUTFnPHTQhEceqVNZkyNg4JtMvk40iOBA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: slab: rename (un)charge_slab_page() to (un)account_slab_page()
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 10:36 AM Roman Gushchin <guro@fb.com> wrote:
>
> charge_slab_page() and uncharge_slab_page() are not related anymore
> to memcg charging and uncharging. In order to make their names
> less confusing, let's rename them to account_slab_page() and
> unaccount_slab_page() respectively.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
