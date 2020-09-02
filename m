Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2933C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75FCB20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="V8U7jhgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgIBMn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 08:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgIBMnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 08:43:01 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC52C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 05:42:51 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d26so6475948ejr.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 05:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SccKNTt3YC7XbTuW2H30Zmdads/idBqIfZTM94c1dTk=;
        b=V8U7jhgODsB8A//a8e72+JnBkGzNrjWlf+cOescmbiJ3DdRRPUNnX7AH0GN4CKTzGQ
         +/DnJnNFfFFBJdJNHpWGYydROSt6ust0nCR9krxGx1RYNVxs3B9Vt6pXMrhZ8ezZilSg
         5iMLITForaLMdJBbuQ8/D4kKbKs5exxbDRNVJo9rsu4teVNsFhLVlefNJLDkf5vnWjK6
         zCRx5PQacyjnr2low+ElUA4KMRIwH64tKzzsty1u/A5yrzKTSqH1Y5b+yFxgftrNkQrZ
         nsrBzKgtGopGLoDGEl4qx5f3eYHngO7vqpj+i4F57egPLI66c960+Mpld71TPJl37vP/
         c1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SccKNTt3YC7XbTuW2H30Zmdads/idBqIfZTM94c1dTk=;
        b=oencepJrrcELnjiFuES+/Eoa1HrIalgBgFyJ3+TfOoPMmLVa1RZUJtwPwNGK01Whld
         RXQMtu6Qy7uvSrDHuQ7UvFqXjwuUJ26CmayBkkj0PlSZJiKGP7vhJFm+b9Bu7rmjG1ZQ
         QhG193lq5uU+iy6ziLPzWEVeDzm5e/ZE08arQviRT432uSfacp2fBZxuTvmcd7xJnPUV
         D6HIkNO2wTM1c3HtECobvSk+T+V5TPlKWQMJmgI3wF94XL1ktfJoQ7NxY1xpzhVTnZM3
         NpRhU3BcsrY+xtdka/hqOKkL1HClqHDdiW/DLeHTOJ5X+O9i82gLrHFC+5VhchuNg+G6
         J/iQ==
X-Gm-Message-State: AOAM530O7QiMfmFatn+ebTAyV8DC16uKDDIGfIvMVulz/OsYqULpXOlK
        tnhTh7UPMaLw09iZlFN7uc+q2hkedd+uD5WqiTXByg==
X-Google-Smtp-Source: ABdhPJx66UO5GHi9sHXGjEoebE3qu+qT1iXTpFKwiHny0D+6C+OPmtHNdkot7yilBnEj0otgEXsEp/WbFvPk7azEl3E=
X-Received: by 2002:a17:906:715b:: with SMTP id z27mr2767202ejj.166.1599050569831;
 Wed, 02 Sep 2020 05:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <6469324e-afa2-18b4-81fb-9e96466c1bf3@suse.cz> <A8A8D5FE-86C3-40B4-919C-5FF2A134F366@redhat.com>
In-Reply-To: <A8A8D5FE-86C3-40B4-919C-5FF2A134F366@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 2 Sep 2020 08:42:13 -0400
Message-ID: <CA+CK2bAebg4PALh3_-49MXGJ-FNP3hE98wHZd5uEC-q7wG6Vmg@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] The new cgroup slab memory controller
To:     David Hildenbrand <dhildenb@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        stable <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Am 02.09.2020 um 11:53 schrieb Vlastimil Babka <vbabka@suse.cz>:
> >
> > =EF=BB=BFOn 8/28/20 6:47 PM, Pavel Tatashin wrote:
> >> There appears to be another problem that is related to the
> >> cgroup_mutex -> mem_hotplug_lock deadlock described above.
> >>
> >> In the original deadlock that I described, the workaround is to
> >> replace crash dump from piping to Linux traditional save to files
> >> method. However, after trying this workaround, I still observed
> >> hardware watchdog resets during machine  shutdown.
> >>
> >> The new problem occurs for the following reason: upon shutdown systemd
> >> calls a service that hot-removes memory, and if hot-removing fails for
> >
> > Why is that hotremove even needed if we're shutting down? Are there any
> > (virtualization?) platforms where it makes some difference over plain
> > shutdown/restart?
>
> If all it=E2=80=98s doing is offlining random memory that sounds unnecess=
ary and dangerous. Any pointers to this service so we can figure out what i=
t=E2=80=98s doing and why? (Arch? Hypervisor?)

Hi David,

This is how we are using it at Microsoft: there is  a very large
number of small memory machines (8G each) with low downtime
requirements (reboot must be under a second). There is also a large
state ~2G of memory that we need to transfer during reboot, otherwise
it is very expensive to recreate the state. We have 2G of system
memory memory reserved as a pmem in the device tree, and use it to
pass information across reboots. Once the information is not needed we
hot-add that memory and use it during runtime, before shutdown we
hot-remove the 2G, save the program state on it, and do the reboot.

Pasha
