Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1B3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB79B20767
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBYtwHmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgFZECy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFZECx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:02:53 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E48C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 21:02:53 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id a14so3933591qvq.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 21:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tZ10wzKAlun9ezjnRJ6vAT4r5GZ70Nwas5NbwCUvzuo=;
        b=EBYtwHmORFxtCoCvv7YQq+Qs5V4daAv5+kVh3p/R+NpJlM6vO9JhKGny298bG/WkTc
         EXD25rwUZd7ArQD/PK0WUbwXdB1Aaf8R+CjkI+X3LzsjilJrZ7K2pfH725FpvDbN8RY3
         NWbH7Gbsh5aRDUGlNp7+iO6iQfCpIq+UBpQ1V4/x8at4cvHpYcBRHSsvQ/9qiIEAxSGn
         JRtp/iFsbb+YVA6PcrTkNLf/OHF9I2SEksiOpns8x5Bu+heDBLlqt6Yj4CkSDZjb72fx
         LBLOWc0NHD6rTcPRQSIlIuu/hkI7OxfittbAtcG5j+rV0ECIMdaiHGBNA8A20pEiPrp0
         4ilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tZ10wzKAlun9ezjnRJ6vAT4r5GZ70Nwas5NbwCUvzuo=;
        b=dyGYdjULDSdz6wwiOkYRZDqw+PgHrvgaL/2Yi/6TqXy7bP8s4U81ggsSh1z3IYTKLF
         N7DiJSD9pXUMZb/UNSOHIkuh1KXgExxW4IP9aG30d3BmOUUFwatNf2Bx6Vt4DFYSQ5+a
         kg0Ah/3DMa2ebuTUfT4mMmhB9od/MgBXjipUAVKiLYaO2wD00IQ8TgUtINsGneXvqCqT
         YK4Ai+eBsTQB38CEFt9ON5YAQoiePPPbCYgTTqTfzrmEhxZ40mTVXZDFq/VN182lSU4z
         Abpw8CIlCoa1IIeuVEcP+0dn4Ab1qYr+UFmYy71ScNLE/4W3VtFjQzZTTnqyx1FlKe7c
         M3hw==
X-Gm-Message-State: AOAM530qN19WK9hudKT4unUfxiFqnaANSiIR0+HWvUuM4KprhPm1Zhm0
        Cf6RbutBRLJgRPp6CNc+eyyHGTAEyYtAFwmuV74=
X-Google-Smtp-Source: ABdhPJykweMvMY4T5KvPqNSo3+8We/c7WLmalDrZyaVbtMocvbX085rJvJtf7OhGXD5vI/iKmGXhSEWFHIYYiTmyyH8=
X-Received: by 2002:a0c:b48e:: with SMTP id c14mr1358186qve.66.1593144172503;
 Thu, 25 Jun 2020 21:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-4-git-send-email-iamjoonsoo.kim@lge.com> <20200625112625.GD1320@dhcp22.suse.cz>
In-Reply-To: <20200625112625.GD1320@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 26 Jun 2020 13:02:41 +0900
Message-ID: <CAAmzW4N646-xYWosMwwnOgjAB+Z_eoZO4rs58ab+gYbHXmydJA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] mm/hugetlb: unify migration callbacks
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 25=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 8:26, M=
ichal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue 23-06-20 15:13:43, Joonsoo Kim wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > There is no difference between two migration callback functions,
> > alloc_huge_page_node() and alloc_huge_page_nodemask(), except
> > __GFP_THISNODE handling. This patch adds an argument, gfp_mask, on
> > alloc_huge_page_nodemask() and replace the callsite for
> > alloc_huge_page_node() with the call to
> > alloc_huge_page_nodemask(..., __GFP_THISNODE).
> >
> > It's safe to remove a node id check in alloc_huge_page_node() since
> > there is no caller passing NUMA_NO_NODE as a node id.
>
> Yes this is indeed safe. alloc_huge_page_node used to be called from
> other internal hugetlb allocation layer and that allowed NUMA_NO_NODE as
> well. Now it is called only from the mempolicy migration callback and
> that always specifies a node and want to stick with that node.
>
> But I have to say I really dislike the gfp semantic because it is
> different from any other allocation function I can think of. It
> specifies what to be added rather than what should be used.
>
> Removing the function is ok but please use the full gfp mask instead
> or if that is impractical for some reason (wich shouldn't be the case
> as htlb_alloc_mask should be trivial to make static inline) make it
> explicit that this is not a gfp_mask but a gfp modifier and explicitly
> state which modifiers are allowed.

Okay. I will try to solve your concern. Concrete solution is not yet prepar=
ed
but perhaps I will use full gfp_mask by using htlb_alloc_mask() in caller s=
ites.

Thanks.
