Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF4BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98652084C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uzhSIRMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgH0VKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 17:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0VKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 17:10:14 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E192AC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 14:10:13 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id k10so3688442lfm.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 14:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ixjZmO1t9Slh8e49hGHeOLGuoW3qUdXzY3TFmyOpR7s=;
        b=uzhSIRMq/VC2gbpPuCOatXfLJeVSPdb5yV/E64ymQ5pYPDpJJtQ4zCb/1W/sfERMIl
         kzlL1rSMnRziF1YC+2bKB6i4NHgXR5FNTA6vSuqmcPswBbgdpVw2tYnXhHGV+RTET2My
         WUPCv15Tz3Aybd4Hx0tktedPqyf0HP/P9OtJF6RaZAI0+h62aZjGfkgd28CQQofFkdBA
         m2f4JQ2NNKw6rDk/M5ZwaoZ110/dpcq9eO1li4OZNmXb2rZ6xkfBnTpPxbV6sXl4KkRI
         XpAB/GB4k5oGvdYqyq92v/M/jJ9kXQLWoalsRcYM+07sj/2KTrJqxYjmICMosdl1b4H5
         k4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ixjZmO1t9Slh8e49hGHeOLGuoW3qUdXzY3TFmyOpR7s=;
        b=GkwtXEKJwNB6cR9R1KcalGqrUCztbSy2qQ5rg8W/cssfA9U2X2TII14EZVdm7bi/xE
         WORBZIJlrJwAc+LmqTr+EyG1clso/U1s+CGYDz80+a7T2hcStVh8g7oHP5hmM2E4uovs
         HfL4dGbiwlo3efFTyYlGwkLHIQtAS3xkvTG5Bibf0VWJpEjw/C3FM19ncwQR1V6xZi6j
         krE61+LQIiMH5rncSFPwl/FY366my+bTgbP5jttPC3K7bGvuMx6jDItes3sRuX0yyvzl
         KhCkI4i1K6Jqe1EPwgZbVYSLRcsUzI0zOWJo20qClL1YQxnlzVXAMH/Mx8PphrZrysM6
         3KSw==
X-Gm-Message-State: AOAM532DOQ6mpyjFMwkHXKDzui8T+0Ht0stJKP9gGnKFpLfGqA5ZbWjg
        Uc1/fVqVIBAR6/J8+xBXurrTtKI/6WMCAeb+d7kHJQ==
X-Google-Smtp-Source: ABdhPJzkpv4//qcpr1zupRZJ4DuLu3ynt0GPhuT7sptf5s54q5j5U7AyndYJ/Aq24BNUSvJe5975xRqPddvMgoNSGLM=
X-Received: by 2002:a19:c714:: with SMTP id x20mr1157875lff.3.1598562611999;
 Thu, 27 Aug 2020 14:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200827175215.319780-1-guro@fb.com> <20200827175215.319780-2-guro@fb.com>
In-Reply-To: <20200827175215.319780-2-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 27 Aug 2020 14:10:00 -0700
Message-ID: <CALvZod43dAjwpJqJ_pO_rn9_QagYezR-NdE0eSv_MQMLsCZQ_g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] mm: kmem: move memcg_kmem_bypass() calls to get_mem/obj_cgroup_from_current()
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:52 AM Roman Gushchin <guro@fb.com> wrote:
>
> Currently memcg_kmem_bypass() is called before obtaining the current
> memory/obj cgroup using get_mem/obj_cgroup_from_current(). Moving
> memcg_kmem_bypass() into get_mem/obj_cgroup_from_current() reduces
> the number of call sites and allows further code simplifications.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
