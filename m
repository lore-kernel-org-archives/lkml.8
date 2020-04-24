Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E76C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACD420700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qlbIQJx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgDXQQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgDXQQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:16:04 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04500C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:16:02 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 20so10672946qkl.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NpF4ebF/mYc/rJmh8e1mUhjq/ubrH1/GxyUQdknJIGg=;
        b=qlbIQJx48Hqu7w0gAnipO2M5dI+LZSShUdFRLUYQdJ2+pCW6pjcFCPv+MakyoqqUEK
         Qm3GG+bdomT1A+nZhHBhHSJLP16cts35laZ7bQ20NqnwrOfBG+48ZA7ODiHFhzcJAQhY
         wRWHv+l9wHefrjPabykyY51Cg9XQalxuVH4cIThTsW5iLoTEjJMah/I8Mg66re0StfZh
         6Comod9ZQt2LH1UEkWSNQ54hmDWF1ZJOSPtela1cbfCwcqhAYB0BSorqm0mqi8jf6RR5
         oTj0ptA4Xt9+1q3m+T0IxWlCUD/QWxQVBFovazS5BJx5w7oab/VRbC/HwwRy9SCZmMiV
         jelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NpF4ebF/mYc/rJmh8e1mUhjq/ubrH1/GxyUQdknJIGg=;
        b=O4l14gM0gPl07w9s7oZNC6OhcujnQ0Z0CJqBpTNm9fW95w2UNfdNUOBfSsHgGOPZ8W
         oJSKbJT6p53Mg9HI4wzPc4x3I3zfXEs4QLqXvLs1j7cVHI3YCPAfCJOmkRxJ9rL19frq
         8FzMIRg5WnNTAmIkuWZFNhrqexnLm9GpzAmoe6sim+LlZxVH+8bYe2u4wueV73anjpx4
         l6D3HN/kyMv3rlgrGpOeL/dC3kOX3vnzX0q1ua6cOV68MebjC7lBDYMRODzzq04je6Am
         9zkmf9u24Z0d2V/y6qjwVEFZG+iRjfoqZ/j/ZV4Io1m2my7pYr60I+4JLe88J+64Utk8
         OF8g==
X-Gm-Message-State: AGi0PuYSXxgjtkkj02XPEoJO8CGvcH7l+u5vPgwjtUGnA0MRKjVusn2Q
        q1g5f248Vz6U6Nirbgu5XWUnIg==
X-Google-Smtp-Source: APiQypIvAJav39D5U2ZXeodLcy5EzzRj0EKmLYvt7gwBvIUSBywr76ydugdStWM8PWVQDw4YSnbefg==
X-Received: by 2002:a37:61cd:: with SMTP id v196mr9602979qkb.393.1587744961999;
        Fri, 24 Apr 2020 09:16:01 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j9sm1444329qkg.88.2020.04.24.09.16.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 09:16:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/2] mm/slub: Fix slab_mutex circular locking problem in
 slab_attr_store()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200424151225.10966-2-longman@redhat.com>
Date:   Fri, 24 Apr 2020 12:16:00 -0400
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A3C34CA-F514-41C2-AC3F-E5925C7C0F9A@lca.pw>
References: <20200424151225.10966-1-longman@redhat.com>
 <20200424151225.10966-2-longman@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 24, 2020, at 11:12 AM, Waiman Long <longman@redhat.com> wrote:
>=20
> diff --git a/mm/slub.c b/mm/slub.c
> index 183ccc364ccf..255981180489 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5567,13 +5567,30 @@ static ssize_t slab_attr_store(struct kobject =
*kobj,
> 		return -EIO;
>=20
> 	err =3D attribute->store(s, buf, len);
> -#ifdef CONFIG_MEMCG
> -	if (slab_state >=3D FULL && err >=3D 0 && is_root_cache(s)) {
> -		struct kmem_cache *c;
> +#ifdef CONFIG_MEMCG_KMEM
> +	if (slab_state >=3D FULL && err >=3D 0 && is_root_cache(s) &&
> +	    !list_empty(&s->memcg_params.children)) {
> +		struct kmem_cache *c, **pcaches;
> +		int idx, max, cnt =3D 0;
> +		size_t size =3D s->max_attr_size;
> +		struct memcg_cache_array *arr;
> +
> +		/*
> +		 * Make atomic update to s->max_attr_size.
> +		 */
> +		do {
> +			if (len <=3D size)
> +				break;
> +		} while (!try_cmpxchg(&s->max_attr_size, &size, len));
>=20

try_cmpxchg() is only available on x86.

mm/slub.c: In function =E2=80=98slab_attr_store=E2=80=99:
mm/slub.c:5613:13: error: implicit declaration of function =
=E2=80=98try_cmpxchg=E2=80=99; did you mean =E2=80=98xa_cmpxchg=E2=80=99? =
[-Werror=3Dimplicit-function-declaration]
   } while (!try_cmpxchg(&s->max_attr_size, &size, len));
             ^~~~~~~~~~~
             xa_cmpxchg

