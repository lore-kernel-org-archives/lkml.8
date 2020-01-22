Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C23C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95CE2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uy+ZTjJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgAVVlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 16:41:06 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40344 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgAVVlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 16:41:05 -0500
Received: by mail-ot1-f68.google.com with SMTP id w21so771290otj.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 13:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qOzfGqLG1EaX/BWFSgUwOINS0Jq9ooncgkzx4R9Fkjs=;
        b=Uy+ZTjJfUlZLEz9nBqJA+AJ5BgXd3gd9QKk3PWvXePIqFK+wVr304OtF1bJDyP2N7g
         mS7cLdycg8D73Dp03VE3E7oDA3DYW3pNzAZ1yx241PRvXI3pE3DtGl8nplDnFzl4YUFr
         LcruTZ1svCVSRyH3T74SE6O2PMp9S3dooiQq5KivdjnFqIctU1uarYLle986EgnqUzb0
         bc1JZCPNUvlyWEqBlM5Bz4eheeVNabuK8ZAELah3ChGuDRMORFJL3S52sJHiVc+HakJj
         Y0C4jtiflOEdNn84T0us+pv/W2wsUGxcuq+DH/aNBJaG4MihkgPIMUkexpaEWku4D+OP
         sPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qOzfGqLG1EaX/BWFSgUwOINS0Jq9ooncgkzx4R9Fkjs=;
        b=N3+tQTOHwqPEcEyhn/0ZlPxJ/1pfVLBWaDGhY7RAJwxOt91WLt+Rfa4rW0ohi+ixZl
         yeuKeKDLWwJhkOEpKlYC4106tvRsUrBviLyj1bjCkdI2gXdmfzbOqrkigeZvlkmO6TM/
         UhUuebtEvxO79tmALS81AT1yuxiRd0Xni+T7V5w5Je9oFfde7ySgCQhmKN+xu37GWs1x
         McStbehbusCHOXC3U/Jj//gW0gMzZyDkmw1XXjHhLXhCjm50ayXGi4kRCYv0tCGreP8Z
         BqgXMI6faSU8V4VHl73VyrY8Ta6msOANpo8TdfnDtwfRIyAb5OIthN+rJuJ7ct/bOmgk
         GPGg==
X-Gm-Message-State: APjAAAV4cbzIogqRJwNcTXDzlUBLdsUH2Ru4lMBcgjZ8/dfdcOSGqHo9
        IU+MnYM/BiFKxvs0IROK8PBo7Y61kqaEr5qvlarMBw==
X-Google-Smtp-Source: APXvYqwxp52P8zgMm37e71Q9sRyxqMixiN3l7LI9gB48YlOY70kKTaPjXcqibQ1mgc8A1BHkogOu17hYZ4cpUJn8mkc=
X-Received: by 2002:a9d:518b:: with SMTP id y11mr8491975otg.349.1579729264223;
 Wed, 22 Jan 2020 13:41:04 -0800 (PST)
MIME-Version: 1.0
References: <20191217231615.164161-1-almasrymina@google.com>
 <20191217231615.164161-3-almasrymina@google.com> <dec1ccd5-5973-c498-f2fe-390c1c51b2d0@oracle.com>
 <CAHS8izMzXpNMCmFh_SD7n+4+rj3QTqyRfeWQyXAhFo1-qV4iEQ@mail.gmail.com> <0ea993b0-af18-cee8-527e-f6df7e76b0be@oracle.com>
In-Reply-To: <0ea993b0-af18-cee8-527e-f6df7e76b0be@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 22 Jan 2020 13:40:53 -0800
Message-ID: <CAHS8izOj7s+UnMvGzFAC6ympjfxvxybQk7Z_BVRyjj3Z4a1q+Q@mail.gmail.com>
Subject: Re: [PATCH v9 3/8] hugetlb_cgroup: add reservation accounting for
 private mappings
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 2:09 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 1/14/20 2:52 PM, Mina Almasry wrote:
> > On Mon, Jan 13, 2020 at 4:55 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>> +#ifdef CONFIG_CGROUP_HUGETLB
> >>> +     /*
> >>> +      * Since we check for HPAGE_RESV_OWNER above, this must a private
> >>> +      * mapping, and these values should be none-zero, and should point to
> >>> +      * the hugetlb_cgroup counter to uncharge for this reservation.
> >>> +      */
> >>> +     WARN_ON(!resv->reservation_counter);
> >>> +     WARN_ON(!resv->pages_per_hpage);
> >>> +     WARN_ON(!resv->css);
> >>
> >> I was once again wondering if these were always non-NULL for private mappings.
> >> It seems that reservation_counter (h_gc) would be NULL in these cases from
> >> these early checks in hugetlb_cgroup_charge_cgroup().
> >>
> >
> > You are right. I'm fixing in v10 the code and comments to account for
> > h_cg potentially being NULL, but I'm having trouble testing. Looking
> > at the code, I'm a bit confused by the checks. Seems to me
> > hugetlb_cgroup_disabled() is the same as #ifdef CONFIG_CGROUP_HUGETLB;
> > I can't find a way to enable the Kconfig but have that return false
> > unless I hack the code.
>
> What about the boot options?
>
> cgroup_disable=
> cgroup_no_v1=

Thanks, cgroup_disable=hugetlb does it. I ran the the libhugetlbfs
tests with patchset v10 and it passed, so it seems the latest version
of the patch should be fine. Of course my hugetlb cgroup tests fail
outright when hugetlb cgroups are disabled so those don't say anything
useful.
