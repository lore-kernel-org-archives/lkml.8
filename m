Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA4AC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3673F22522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="oW3qFX6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgAUDJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 22:09:40 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37639 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgAUDJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 22:09:40 -0500
Received: by mail-ot1-f66.google.com with SMTP id k14so1682649otn.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 19:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zzgAN7AcFUKo31VzGca5wqU7jl5yRWzRRc+tIT8IsdI=;
        b=oW3qFX6l83ZPQ5G+hzzgXNelFpIMqlQxZNmoDJwHEETifAbTlPlyCkKOG/yDY6znYu
         eq+wXWMOKkn3fK14gRz7UFjvSx4GuJk+LPCb1DrJune8B8chnaQ553KHRGJaT9T21cE6
         jBkp5CXNJjdaDhDB7fqCe/e5O3HuPplIhnB9gL2iRSn/l1VOhSAPY4LJ/YeJI35pajl4
         5P3P6lxIGDRCxpHvJrssmgEZQJUqCQkdHOC4tDTEyZeQaSoRb11zEfDqjyRkkaZhYs+W
         Q/3mvi/8xpCiv3ZHgRNo7CFBberN8G34sdZnmz0QKqXZI0N0CzmeRyE8geQxIKMxVcYP
         JbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zzgAN7AcFUKo31VzGca5wqU7jl5yRWzRRc+tIT8IsdI=;
        b=TX5ldrv781xzfHuo0+yvgyqJT47Z77exUSxbvmj5PMkIQ1IZrqxhizUbf7G7k+Xuqo
         A46kX3y0BaciryxB/DM1MWQUo8swbZDl4gSA9FIsQmpmHaGXnqKnSgoXyRWtHzeI9d8J
         2S3R4MI8+UQjHZQJh/GjD2YBVakUsFwicxSNGAAdXMVQcqIHCqlMonnwV2R6ROm+s1Wt
         QWSkc5ZIG14teDvH8yzJ7PbrCJEwlGWBg/avPdvRa08TdSOeanxfHP8DGpwN+P/8zXgh
         oJQsRIDp+ji2f/leVek0POcUmTpLv+oEAWwaRunHaFL3MiSI3hyQkv59DGrdi2z/Vcg1
         wdAQ==
X-Gm-Message-State: APjAAAUzbLHrGdr9xnwMgLrcCVNJ8y+icyuMY7iKYs9G6LEm7XnYORl2
        d/SGMs2QS9cJfwAjrPn2joFcEskW83OI3HXl3xhEJzXg
X-Google-Smtp-Source: APXvYqyWPPBlFl8k77ykQtRhabA6jR2wpAyFXUn7yE9w3Z0qz05h9scPEucgncq36HL8MGc82zVafvBeR8O9Z99ZFJ8=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr1984867oto.207.1579576179419;
 Mon, 20 Jan 2020 19:09:39 -0800 (PST)
MIME-Version: 1.0
References: <157954696789.2239526.17707265517154476652.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157954697957.2239526.17206272633668977957.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87pnfdd20d.fsf@linux.ibm.com>
In-Reply-To: <87pnfdd20d.fsf@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 20 Jan 2020 19:09:26 -0800
Message-ID: <CAPcyv4gjuk1OOnT2oobXXKS-d5DMFqrwbb-LCbG+0aexh_83sw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] mm/numa: Skip NUMA_NO_NODE and online nodes in numa_map_to_online_node()
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 5:36 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > Update numa_map_to_online_node() to stop falling back to numa node 0
> > when the input is NUMA_NO_NODE. Also, skip the lookup if @node is
> > online. This makes the routine compatible with other arch node mapping
> > routines.
> >
> > Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Link: https://lore.kernel.org/r/157401275716.43284.13185549705765009174.stgit@dwillia2-desk3.amr.corp.intel.com
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  mm/mempolicy.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 4cff069279f6..30d76db718bf 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -137,8 +137,8 @@ int numa_map_to_online_node(int node)
> >  {
> >       int min_node;
> >
> > -     if (node == NUMA_NO_NODE)
> > -             node = 0;
> > +     if (node == NUMA_NO_NODE || node_online(node))
> > +             return node;
> >
> >       min_node = node;
> >       if (!node_online(node)) {
>
>
> The above if condition will always be true?

No, not for the node_offline case, and that's typically what callers
are passing.
>
> -aneesh
