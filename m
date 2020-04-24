Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DF0C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972F8206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YOpBtwOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgDXQli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgDXQli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:41:38 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24BCC09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:41:36 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p13so4946618qvt.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LO0jH7vd93rBwmid0ByKq3myZgKzrPDn68z/12qXZxQ=;
        b=YOpBtwOx+Koq95Zm/Y4e4xnLHU8ppj1HeeDN/8tt+uOx1D+aPJZ+EpTI9+caN77RKD
         e2Mbjzv8tRVhAv2g2zNslAESwFghWb0ZxqXD74EUtbttZ8ypZElUJn0dLzcP+z3OFk1o
         ZxPsRZ1Z9YPbvFognx9hmhFuWKetAAyrpdfAG5rr70s7hGmX5uMlIrsfwMBlVGfl7nYN
         MCyRvaEZFAfIJOB8G4y2G+Uo1iH/0k1vuf46iW2G6eyeCWgDZk0BV1kUcpW68awFkTnu
         Ie4GJ8vWM2fR/OBRDWHhCcDOlN8WeKOzhhi57HSEDxXn3JUI2J2K2PH+M6nmyknXicJq
         47rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LO0jH7vd93rBwmid0ByKq3myZgKzrPDn68z/12qXZxQ=;
        b=X4eALWpCa/9xYaUXC7OgmFkLTlqBxpf9mYxAf6ZO/hmsNjkxv1a64gc3C6FQF9HX7F
         /PI0l2ZaGxqD+Oe33rq4u5zbSkgf1ffUL4U8T9QSU8+//0xa8uwXVHYUYi3HjAn/bQX5
         Jom2TygRa/AN7XUp5YXlTVDxzZTQ1p6wewBbEscz5bA/3rxPRpxThqV06ig9YGD1/+K8
         ay0Pwi1cEZ69SuPHjx15g7IahEgiL1AhcOhs33LNsUkxwkVdxlNpPPdWhrb32C6bKaBX
         3YEC5+nK5UiHQRkDa3x+nDS/hnIbGTPnB45SILcKZGGreAeYMeKehlghZ5fw2YAydOGI
         J4BA==
X-Gm-Message-State: AGi0PubA80IgXmlYewZPfpztCsDBDY3So82rvtZX+d751bXYlNzsoXIj
        OfH2MhuMu6UxJ5/9AGowOxtzQg==
X-Google-Smtp-Source: APiQypKFLaGrRxdkVHj0FWYqdzE8CBXdMAk1d593LTm3IOKBHE5GBObc5A3ugtNe5/lwPMpAfkwzhw==
X-Received: by 2002:a0c:facb:: with SMTP id p11mr10331029qvo.17.1587746495801;
        Fri, 24 Apr 2020 09:41:35 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id w79sm4071443qkb.97.2020.04.24.09.41.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 09:41:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 1/2] mm, slab: Revert "extend slab/shrink to shrink all
 memcg caches"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200424151225.10966-1-longman@redhat.com>
Date:   Fri, 24 Apr 2020 12:41:34 -0400
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <23B286D4-831B-4788-95BA-438C88BB4EB0@lca.pw>
References: <20200424151225.10966-1-longman@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 24, 2020, at 11:12 AM, Waiman Long <longman@redhat.com> wrote:
>=20
> When the slub shrink sysfs file is written into, the function call
> sequence is as follows:
>=20
>  kernfs_fop_write
>    =3D> slab_attr_store
>      =3D> shrink_store
>        =3D> kmem_cache_shrink_all
>=20
> It turns out that doing a memcg cache scan in kmem_cache_shrink_all()
> is redundant as the same memcg cache scan is being done in
> slab_attr_store(). So revert the commit 04f768a39d55 ("mm, slab: =
extend
> slab/shrink to shrink all memcg caches") except the documentation =
change
> which is still valid.

BTW, currently, do,

# echo 1 > /sys/kernel/slab/fs_cache/shrink

would crash the kernel stack probably due to large amount of memcg =
caches.

 I am still figuring out if the above commit 04f768a39d55 is the =
culprit.

[ 7938.979589][T106403] Kernel panic - not syncing: stack-protector: =
Kernel stack is corrupted in: __kmem_cache_create+0x7f8/0x800
[ 7938.979640][T106403] CPU: 80 PID: 106403 Comm: kworker/80:2 Not =
tainted 5.7.0-rc2-next-20200424 #5
[ 7938.979670][T106403] Workqueue: memcg_kmem_cache =
memcg_kmem_cache_create_func
[ 7938.979708][T106403] Call Trace:
[ 7938.979745][T106403] [c000200012e0f880] [c000000000716498] =
dump_stack+0xfc/0x174 (unreliable)
[ 7938.979789][T106403] [c000200012e0f8d0] [c00000000010d7d0] =
panic+0x224/0x4d4
[ 7938.979816][T106403] [c000200012e0f970] [c00000000010d05c] =
__stack_chk_fail+0x2c/0x30
[ 7938.979865][T106403] [c000200012e0f9d0] [c0000000004b1fb8] =
__kmem_cache_create+0x7f8/0x800
[ 7938.979914][T106403] [c000200012e0faf0] [4320383d35334320] =
0x4320383d35334320

>=20
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
> mm/slab.h        |  1 -
> mm/slab_common.c | 37 -------------------------------------
> mm/slub.c        |  2 +-
> 3 files changed, 1 insertion(+), 39 deletions(-)
>=20
> diff --git a/mm/slab.h b/mm/slab.h
> index 207c83ef6e06..0937cb2ae8aa 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -237,7 +237,6 @@ int __kmem_cache_shrink(struct kmem_cache *);
> void __kmemcg_cache_deactivate(struct kmem_cache *s);
> void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s);
> void slab_kmem_cache_release(struct kmem_cache *);
> -void kmem_cache_shrink_all(struct kmem_cache *s);
>=20
> struct seq_file;
> struct file;
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 23c7500eea7d..2e367ab8c15c 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -995,43 +995,6 @@ int kmem_cache_shrink(struct kmem_cache *cachep)
> }
> EXPORT_SYMBOL(kmem_cache_shrink);
>=20
> -/**
> - * kmem_cache_shrink_all - shrink a cache and all memcg caches for =
root cache
> - * @s: The cache pointer
> - */
> -void kmem_cache_shrink_all(struct kmem_cache *s)
> -{
> -	struct kmem_cache *c;
> -
> -	if (!IS_ENABLED(CONFIG_MEMCG_KMEM) || !is_root_cache(s)) {
> -		kmem_cache_shrink(s);
> -		return;
> -	}
> -
> -	get_online_cpus();
> -	get_online_mems();
> -	kasan_cache_shrink(s);
> -	__kmem_cache_shrink(s);
> -
> -	/*
> -	 * We have to take the slab_mutex to protect from the memcg list
> -	 * modification.
> -	 */
> -	mutex_lock(&slab_mutex);
> -	for_each_memcg_cache(c, s) {
> -		/*
> -		 * Don't need to shrink deactivated memcg caches.
> -		 */
> -		if (s->flags & SLAB_DEACTIVATED)
> -			continue;
> -		kasan_cache_shrink(c);
> -		__kmem_cache_shrink(c);
> -	}
> -	mutex_unlock(&slab_mutex);
> -	put_online_mems();
> -	put_online_cpus();
> -}
> -
> bool slab_is_available(void)
> {
> 	return slab_state >=3D UP;
> diff --git a/mm/slub.c b/mm/slub.c
> index 9bf44955c4f1..183ccc364ccf 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5343,7 +5343,7 @@ static ssize_t shrink_store(struct kmem_cache =
*s,
> 			const char *buf, size_t length)
> {
> 	if (buf[0] =3D=3D '1')
> -		kmem_cache_shrink_all(s);
> +		kmem_cache_shrink(s);
> 	else
> 		return -EINVAL;
> 	return length;
> --=20
> 2.18.1
>=20
>=20

