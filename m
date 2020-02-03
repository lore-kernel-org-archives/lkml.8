Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1985C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2CE20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PuWaEsvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBCXQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 18:16:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37622 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgBCXQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 18:16:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id d3so15375203otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 15:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gsc+LSdKFmfEHsLu/PX4b/f2W5uTYqD7V4ZzUh0Ir80=;
        b=PuWaEsvTmioKz64Q7uPVIOp/N9rPTq6akD7fqQtuRHWmOto7GXFjEFiiaZpfiF2Oxm
         iiczLvMdxA7gX9/mjBZ8ZtnwN2sHqrC4OBRhqMuKo/g8CFJUF+GRekmD2R+YG1Iv8ntP
         fvondbVEOz76kPzh9Un/lXTwJbkoWs/H0ReXrgjISGWRnNPuEoN9WDxUbtR5u29xfZkT
         oAskXk7P2RCKYytwQ3FeJKx5ywr9hbBBXemLv/eTKuTK7Wqc8IrNS1TLr78w9ZSqkxGE
         M2MJ58f6NMmbvet66LP8q6Ze6KZ4eCoAqPGksDNrj2NLgtH1atGYQqMO7zviLvsOv0oa
         pnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gsc+LSdKFmfEHsLu/PX4b/f2W5uTYqD7V4ZzUh0Ir80=;
        b=ifG6SA9BsdfQA1YK7T8ZChpx9sSrYHHM+EP+lKUFxPmIovRhQioFgbjv2Xxiv1gF2F
         0qM4Y5SyeSFHrMR6jrLbsdJ0R1FRdaPTJd2xOk9AORDPd35G8kZEg8pvkLxTy7QLyBTO
         Rv0+C4TFckcm8xmO2R87AOMKP5LYGjHqv8Vx9EKiRHPGBokKEtEEvSbQ8IL/Xw7EWdBH
         ROGdiP41rAfBwDW+nTYTmKvSqnWI6R0g8aairGh3cVhwGOwpB8bTMHux22WqRjKVzEJ5
         yiPlgo9Jvp3VceI/vPaLHXbGrN8sodrSsdW58GrcIDKGYbBWGyDMEqDfHZ9TuY2kxabL
         or4A==
X-Gm-Message-State: APjAAAW5QKChKT37Zj71ieAzgDoYlVHyCV7cBC1+N4pJsSr6sMDgVumO
        n0ncck50bAtIgShNCxBRhla/xT8pdXoK4Mr/M+svXQ==
X-Google-Smtp-Source: APXvYqxks0BGaZknNqKFAhn+gbM4R5qvozx7t1UrbqkSMA2wJouCmnamEYFBah6ouIgs/03HiorFYLE+SdLRPuvskdA=
X-Received: by 2002:a9d:518b:: with SMTP id y11mr18610845otg.349.1580771791890;
 Mon, 03 Feb 2020 15:16:31 -0800 (PST)
MIME-Version: 1.0
References: <20200115012651.228058-1-almasrymina@google.com> <alpine.DEB.2.21.2001291303230.175731@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.2001291303230.175731@chino.kir.corp.google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 3 Feb 2020 15:16:21 -0800
Message-ID: <CAHS8izNq17U6i-RzHZ6tCOVQza_CGngJc0X2ZmqPHTH7y4kfdg@mail.gmail.com>
Subject: Re: [PATCH v10 1/8] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     David Rientjes <rientjes@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>, shuah <shuah@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Proposed Solution:
> > A new page counter named
> > 'hugetlb.xMB.reservation_[limit|usage|max_usage]_in_bytes'. This counter has
> > slightly different semantics than
> > 'hugetlb.xMB.[limit|usage|max_usage]_in_bytes':
> >
>
> Changelog looks like it needs to be updated with the new resv naming.
>

I updated to the rsvd naming, which you suggested earlier and Mike
agreed was better.

> > +
> >  static inline
> >  struct hugetlb_cgroup *hugetlb_cgroup_from_css(struct cgroup_subsys_state *s)
> >  {
>
> Small nit: hugetlb_cgroup_get_counter(), to me, implies incrementing a
> reference count, perhaps a better name would be in order.  No strong
> preference.
>

Changed
> >       /* Add the events file */
> > -     cft = &h->cgroup_files_dfl[2];
> > +     cft = &h->cgroup_files_dfl[4];
> >       snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events", buf);
> >       cft->private = MEMFILE_PRIVATE(idx, 0);
> >       cft->seq_show = hugetlb_events_show;
>
> Any cleanup to __hugetlb_cgroup_file_dfl_init() and
> __hugetlb_cgroup_file_legacy_init() that is possible would be great in a
> follow-up patch :)
>

Will do!

> Other than that, this looks very straight forward.
>
> Acked-by: David Rientjes <rientjes@google.com>
