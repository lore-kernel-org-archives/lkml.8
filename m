Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FB7C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C538206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q17v1xD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgCLRMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:12:19 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40029 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgCLRMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:12:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id n5so4977065qtv.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dMVelJrz8fF3lspFFmR9UFxMP7yEL5SRbojWYJwpleE=;
        b=q17v1xD7+lA8wXe7vp0z0myc3y32AN/wsOmHR05q+5Z46xQJ2Zg7PkozNiXWt+Y9Zi
         bS3nVvMKIxhlhK1Go1qCj5Y8G4UJrS676cdjbPnc8TnKWbf9C0IH4EycUr3TPrJQtR9G
         ymiKbuctcMhwaXAqWXsBxEZsjVQT+aCIUK7rEmZ6F4M9XE4mF8xvk2pLeODoEFmNPE38
         aK5r3HQ2WIcHHVbdydQGDA9UIbnajywgrcgE6QMXMNBQnz+H0aHpJB+n0BcHV63/Xbsc
         rBoLePORPfIFLp7KPQxvmLWTdIUEwPQApQyLDruUnrFnSdD3D933COtX+mub5XvtjCaf
         eZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dMVelJrz8fF3lspFFmR9UFxMP7yEL5SRbojWYJwpleE=;
        b=AFWdT5stSBtVnv8Pj2PaHO2HuH8i+pb2fqDPj2fiS0Ix22/K7/wUdaFatrSnKhIF6c
         BWpUxf4ceDtMODNAouunVxC+/V8SepnLl/48Gc9UsWKCSHwnYRSe+JbSUU95nWcgOMwu
         MWo3p6u/Vury+vXzyo2gWfY2vCXguC9IbeCPT6QLEOWseLGC2Tasat/+ICOb/XR+ZION
         mJiw+iNzz21WIUDnFgwavIPSqCyuXJ4/yHyzE26GQ7Ml1to2xjDq9nTHNL6GTQujuIYe
         SUS2ijJIWQPK4pTvmZRA1KVl+4eL7jW8X6vWEcSrutv4iphyziDIaNyrXSTWI2aZ8PY7
         Ck7w==
X-Gm-Message-State: ANhLgQ0eyTC2LrXOejlv4q2KH3unBePiN9B+xs0Yk4GJ8oYOKcBRtLNZ
        5UDQd8kW9lhvQ3trt/W91xU=
X-Google-Smtp-Source: ADFU+vtXpKcQPnH10nXjPcSeZkbkwE8Fn6TN9er5R901MoXFbwsd+Zi4gu+EcVfOcjjbM8T8Qsebrw==
X-Received: by 2002:ac8:b42:: with SMTP id m2mr8390030qti.67.1584033138091;
        Thu, 12 Mar 2020 10:12:18 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.214.213])
        by smtp.gmail.com with ESMTPSA id j193sm9475302qke.22.2020.03.12.10.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:12:17 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3023740009; Thu, 12 Mar 2020 14:12:14 -0300 (-03)
Date:   Thu, 12 Mar 2020 14:12:14 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf record: fix binding of AIO user space buffers to
 nodes
Message-ID: <20200312171214.GD12036@kernel.org>
References: <c7ea8ffe-1357-bf9e-3a89-1da1d8e9b75b@linux.intel.com>
 <20200312143152.GA28601@kernel.org>
 <2e01e17a-962d-571b-4407-70aa270cec6a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e01e17a-962d-571b-4407-70aa270cec6a@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 12, 2020 at 07:09:56PM +0300, Alexey Budankov escreveu:
> 
> On 12.03.2020 17:31, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Mar 12, 2020 at 03:21:45PM +0300, Alexey Budankov escreveu:
> >>
> >> Correct maxnode parameter value passed to mbind() syscall to be
> >> the amount of node mask bits to analyze plus 1. Dynamically allocate
> >> node mask memory depending on the index of node of cpu being profiled.
> >> Fixes: c44a8b44ca9f ("perf record: Bind the AIO user space buffers to nodes")
> >> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >> ---
> >>  tools/perf/util/mmap.c | 21 +++++++++++++++------
> >>  1 file changed, 15 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> >> index 3b664fa673a6..6d604cd67a95 100644
> >> --- a/tools/perf/util/mmap.c
> >> +++ b/tools/perf/util/mmap.c
> >> @@ -98,20 +98,29 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, int cpu, int affinity)
> >>  {
> >>  	void *data;
> >>  	size_t mmap_len;
> >> -	unsigned long node_mask;
> >> +	unsigned long *node_mask;
> >> +	unsigned long node_index;
> >> +	int err = 0;
> >>  
> >>  	if (affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
> >>  		data = map->aio.data[idx];
> >>  		mmap_len = mmap__mmap_len(map);
> >> -		node_mask = 1UL << cpu__get_node(cpu);
> >> -		if (mbind(data, mmap_len, MPOL_BIND, &node_mask, 1, 0)) {
> >> -			pr_err("Failed to bind [%p-%p] AIO buffer to node %d: error %m\n",
> >> -				data, data + mmap_len, cpu__get_node(cpu));
> >> +		node_index = cpu__get_node(cpu);
> >> +		node_mask = bitmap_alloc(node_index + 1);
> >> +		if (!node_mask) {
> >> +			pr_err("Failed to allocate node mask for mbind: error %m\n");
> >>  			return -1;
> >>  		}
> >> +		set_bit(node_index, node_mask);
> >> +		if (mbind(data, mmap_len, MPOL_BIND, node_mask, node_index + 1 + 1/*nr_bits + 1*/, 0)) {
> > 
> >                                                                                   ^^^^^^^^^^^^^^
> > 										  Leftover?
> 
> Intentionally put it here to document kernel behavior for mbind() syscall
> because currently it is different from the man page [1] documented:
> 
> "nodemask points to a bit mask of nodes containing up to maxnode bits.
>  The bit mask size is rounded to the next multiple of sizeof(unsigned
>  long), but the kernel will use bits only up to maxnode.  A NULL value
>  of nodemask or a maxnode value of zero specifies the empty set of
>  nodes.  If the value of maxnode is zero, the nodemask argument is
>  ignored.  Where a nodemask is required, it must contain at least one
>  node that is on-line, allowed by the thread's current cpuset context
>  (unless the MPOL_F_STATIC_NODES mode flag is specified), and contains
>  memory."

Ok, will add the above as a comment above the line with that comment.
 
> ~Alexey
> 
> [1] http://man7.org/linux/man-pages/man2/mbind.2.html

-- 

- Arnaldo
