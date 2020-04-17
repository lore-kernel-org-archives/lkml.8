Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9368C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B75362087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587130973;
	bh=T1p9Uk3WaNGzlZuBtf7fcgnHYymoY+qJ/M247pblZ2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qNkD00depXlLCu68QawwPrCKor3ZzWX94zirbtErz0q1SjL6l4zwsu8+xzRqyUQ1l
	 t+hCRaIn9hcDsk47wn+q5aiy8mD4QW541SbwMvQ6LMvKq+Gt70HDP5oWHfyxWKQKlE
	 tZ1nM68bFlrvNyWrgNcDhAj/b0OOvXeNoDkKHI/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbgDQNmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:42:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52164 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730597AbgDQNmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:42:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id x4so2977885wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 06:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tOZKi29bbKZWeRD8Sxlu38LfstaUnzJU2Zc3Cur0xnM=;
        b=h+rlvybaJA+VNkmjptoomKUxP4BPxlgyEUvYZwOwrwyBET9clm/ym6zvfkHRT8GuEN
         vOS/VhOpeHgeml1mlk6/I+PKAG2rv7l2HGRLe1rSJH3PjWYJcI9tuzr+Y33hw/V58oOH
         TqJVvat0qghEx+K6sczI64YObTVN50t5tex0H8V/XYqZhmCRALmjjjjtGFJlLYeWxbDW
         tVzKvL1I4V6h1Ue9hhDHzE57QQs+E1xHqMRwnJHUNwBT+S+rcs7oB1ct3LQ/0y1qkFFT
         J+mgY4C36wZr14t56SXF2M7yPaD7iKbGMWKOgAwUxH4LYj7S0C0LB5RggIcQc5i3hLsl
         HOTg==
X-Gm-Message-State: AGi0PuYWQtcPbjLJihPF8t7F6uiSmX68diubox0l0VuH1gpx+hDp73wE
        DsAe7quXe8kmYJFsjwPjwv8=
X-Google-Smtp-Source: APiQypL3To0jq9+BZlaEy4EWLTmoEt3k92oo47UA2OKQRS/y6NtiVXIiTcRAXi9JoY0vmRUQEOUeOg==
X-Received: by 2002:a1c:808c:: with SMTP id b134mr3636797wmd.131.1587130969654;
        Fri, 17 Apr 2020 06:42:49 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id i97sm33878249wri.1.2020.04.17.06.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 06:42:48 -0700 (PDT)
Date:   Fri, 17 Apr 2020 15:42:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     =?utf-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: Re: Re: [PATCH] kmalloc_index optimization(add kmalloc max size
 check)
Message-ID: <20200417134247.GN26707@dhcp22.suse.cz>
References: <20200417113928.GL26707@dhcp22.suse.cz>
 <AOsA0QC2CNKuIHXhFI2eG4oJ.3.1587125839812.Hmail.bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AOsA0QC2CNKuIHXhFI2eG4oJ.3.1587125839812.Hmail.bernard@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-04-20 20:17:19, 赵军奎 wrote:
> 
> 
> From: Michal Hocko <mhocko@kernel.org>
> Date: 2020-04-17 19:39:28
> To:  Bernard Zhao <bernard@vivo.com>
> Cc:  Christoph Lameter <cl@linux.com>,Pekka Enberg <penberg@kernel.org>,David Rientjes <rientjes@google.com>,Joonsoo Kim <iamjoonsoo.kim@lge.com>,Andrew Morton <akpm@linux-foundation.org>,linux-mm@kvack.org,linux-kernel@vger.kernel.org,kernel@vivo.com
> Subject: Re: [PATCH] kmalloc_index optimization(add kmalloc max size check)>On Fri 17-04-20 00:09:35, Bernard Zhao wrote:
> >> kmalloc size should never exceed KMALLOC_MAX_SIZE.
> >> kmalloc_index realise if size is exceed KMALLOC_MAX_SIZE, e.g 64M,
> >> kmalloc_index just return index 26, but never check with OS`s max
> >> kmalloc config KMALLOC_MAX_SIZE. This index`s kmalloc caches maybe
> >> not create in function create_kmalloc_caches.
> >> We can throw an warninginfo in kmalloc at the beginning, instead of
> >> being guaranteed by the buddy alloc behind.
> >
> >I am sorry but I do not follow. What does this patch optimizes? AFAICS,
> >it adds a branch for everybody for something that is highly unlikely
> >usage. Btw. we already do handle those impossible cases. We could argue
> >that BUG() is a bit harsh reaction but a lack of reports suggests this
> >is not a real problem in fact.
> >
> >So what exactly do you want to achieve here?
> >
> 
> I'm not sure if my understanding has a gap. I think this should never happen. 

Yes. Have a look at the code and how all existing sizes map to an index
with a BUG() fallback so this is already handled. As I've said the
existing BUG() is far from optimal but a complete lack of bug reports
hitting this mark suggests this path is not really triggered.

And I do have objection to your patch. Because a) the description
doesn't state the problem which it is fixing and b) the patch adds a
test which everybody going this path has to evaluate and which should
never trigger. So despite your subject line, there is no actual
optimization but quite contrary.

-- 
Michal Hocko
SUSE Labs
