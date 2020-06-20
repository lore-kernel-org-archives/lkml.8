Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8374FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B4722B37
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mm4cpJ8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbgFTBUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 21:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbgFTBUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 21:20:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B87C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 18:20:03 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so13487768ljv.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 18:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SW4SOVqLcozp3h363Duo67LJ3SOZjAIsJUMWx1hfXcQ=;
        b=Mm4cpJ8XkuWZjtLeXu+YTdl+jdjnGyFFJk/MJQxsd4yBUM+TV8ALZoXLX4sX6cdmhk
         xsCjSBPCVst0LfrH00cDvhwKH8/ee+h6SeEMxBSU1yzPQLyZ93el7JIWn4xXpWlyTdto
         XAk7Yrhevadxyjs1y2iNjI718C6i6kV/gltX8iBZHN3msI37NbHTTCYpZLoOz30/6I8m
         19PfdQmPub9mOUkp4yg0gPQg63OoveXQ3um82Csqi6TJWJsmSM4yx7p5OzMp9lxuwR6/
         RyIuseLMPCQXGWhwaZ57Ciuo4Ns0Ivip49Mg5NlqG01LA8FleovCv21i+lNI7j1UEEMM
         sFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SW4SOVqLcozp3h363Duo67LJ3SOZjAIsJUMWx1hfXcQ=;
        b=ShxpZeTaRA4pEbKXh/wPum++PETlBuvEuHvMN3BwubNDppOYqN4cbK+EU5808+pDkT
         S7q64TChvagnDie1BPXAjvlmttgzS93OZT3QHjtqZP91K8hnH7/4Ewd/Ks3CZdksPC0A
         kCcHsCvZD+tBR+7HFXSD0h7li2BwqGUzMTnV2VIHey0a3f/nVtJxfJi9yOnxAwV9Pr4U
         ZJr1DahXd0938I4teVIDte8MV2MFxYo3iZlVeWBVRDLZEEt2jIDbsTyeVD1o3kFEmr+H
         OQePZjwQy0Y8B05v//1wmJoVXy6HYTSRqBYGHrQNmidRSyus6CStwGQ/JOEsJ4AC31pG
         llhQ==
X-Gm-Message-State: AOAM530ohgCI63NDJ/qgK2OTcaDNGpV2KH7jKVo5Ag9PtulitfdkK+Ab
        8WpLbBKvC3w21hIk7PxMKFb+9bPKFr14R6P43Yc1dQ==
X-Google-Smtp-Source: ABdhPJy4Iwp70mpEUIMNRDZzfWSfNohnY+hdKUwlJLlzZGf2WPeVRg0gyIFECSF6zE7/9sD9BiWv6lC/lxpXk/r6Kx4=
X-Received: by 2002:a2e:9ac4:: with SMTP id p4mr3416165ljj.446.1592616001949;
 Fri, 19 Jun 2020 18:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-12-guro@fb.com>
In-Reply-To: <20200608230654.828134-12-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Jun 2020 18:19:51 -0700
Message-ID: <CALvZod7rpQf_9s+h6VNrNfjsN6CbvnRKYt_1KBuBqo-7Fa8jhA@mail.gmail.com>
Subject: Re: [PATCH v6 11/19] mm: memcg/slab: move memcg_kmem_bypass() to memcontrol.h
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
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

On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
>
> To make the memcg_kmem_bypass() function available outside of
> the memcontrol.c, let's move it to memcontrol.h. The function
> is small and nicely fits into static inline sort of functions.
>
> It will be used from the slab code.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
