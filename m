Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AF3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1502220702
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Jv+VHnVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgAZTgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 14:36:05 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:40039 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgAZTgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 14:36:05 -0500
Received: by mail-il1-f196.google.com with SMTP id i7so2604960ilr.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 11:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=syPIfmDLsV3gXR4lbQZTmU4cW2egXq/JFpL1XL5FfcY=;
        b=Jv+VHnVLkKDQs8jhmY/aC2s2Fhe5xX+/6JUdRNt1o8ij5/boMtR0MJaQORO6QX45Pj
         wEh420xwocvL6lybV9IlLrsRok+y8OnRkBSJ5dc85WgnMJlXykRvbrk+Ij/wYF1XWZW+
         vSDZo0FFhh5SaFxzXGKT3xWqG/oN+QfcfksM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=syPIfmDLsV3gXR4lbQZTmU4cW2egXq/JFpL1XL5FfcY=;
        b=V4DygM5evgIovqJZe3VeNTJDUfav+OtfyHpiOOb7+AeKOdMXkK7HLAyp/ZmLF5a6Sj
         9VIW8geT4REwre3ke80NfkCftCiRaTmb+7XmURdepuwo4/yt8dk2/nHzR7cefMUAQtUO
         b6tGd/HoPZNF8HbzTTZAD05CAIW/fX36yeMe0fzRtj4TLaynL69zCG/DVYI2G8lFE1Ru
         gE/NVTbnBnmOrXufR6u16nxHDTi4CLA/+bRA2rXCsAF6ZxjcYKiDe490Dpr0CHpQtHUs
         nh1LdUkGWILyoRmd7x/6rQ1skd/b+TtiUzcFUEwb5L+RERw6uOFJzPjP/3Vaa4fzq/46
         FKdA==
X-Gm-Message-State: APjAAAXC9n8uH5LQFAMxD+aZLKzuP/tN83YAiNK8ooEEw4PI7YdtXVt/
        vRHozGymm+m+bsF7A/TU14ykyoSJUWNX5cWH54A=
X-Google-Smtp-Source: APXvYqyGWVWp616/peAyk+7tcqPLDo0y5FoS0hoWdOsadtX+exVqbgTg5QstoaPzU/EpiU4L97u7+w3CgwIEyn4JFzk=
X-Received: by 2002:a92:8dda:: with SMTP id w87mr12135286ill.55.1580067364412;
 Sun, 26 Jan 2020 11:36:04 -0800 (PST)
MIME-Version: 1.0
References: <1571111349-5041-1-git-send-email-teawater@gmail.com>
 <1571111349-5041-2-git-send-email-teawater@gmail.com> <CALZtONA9Y9tvOJcHUyac770fSQhCoGMb7kDL1R5N9Bueqd+7_g@mail.gmail.com>
 <c67747b9-35cf-ec42-9cd3-6217e9d717b9@linux.alibaba.com>
In-Reply-To: <c67747b9-35cf-ec42-9cd3-6217e9d717b9@linux.alibaba.com>
From:   Dan Streetman <ddstreet@ieee.org>
Date:   Sun, 26 Jan 2020 14:35:28 -0500
Message-ID: <CALZtONAENzho7HrRy=+wZafsh81aYs-J9QsmTfo5ZuMFVt25Lw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm, zswap: Support THP
To:     Hui Zhu <teawaterz@linux.alibaba.com>,
        Vitaly Wool <vitalywool@gmail.com>
Cc:     Hui Zhu <teawater@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 8:48 PM Hui Zhu <teawaterz@linux.alibaba.com> wrote=
:
>
>
>
> On 2019/11/9 12:15 =E4=B8=8A=E5=8D=88, Dan Streetman wrote:
> > On Mon, Oct 14, 2019 at 11:49 PM Hui Zhu <teawater@gmail.com> wrote:
> >>
> >> This commit let zswap treats THP as continuous normal pages
> >> in zswap_frontswap_store.
> >> It will store them to a lot of "zswap_entry".  These "zswap_entry"
> >> will be inserted to "zswap_tree" together.
> >
> > why does zswap need to carry the added complexity of converting THP
> > into separate normal sized pages?  That should be done higher up in
> > the swap layer.
> >
>
> Hi Dan,

Hi, I'm really sorry for the delay, I got very distracted over the end
of year holidays.

I'm not as involved in kernel work anymore, so I'm cc'ing Vitaly as he
is maintaining zswap now (though I may jump in with opinions sometimes
:)

>
> There are 2 issues will increase the performance overhead if thp is
> handle in swap layer.
> 1, When zswap is full, it will let page go back to swap device.
> Thp swap out faster if it is not split.
> But swap layer doesn't know if zswap is full or not, so it need split
> the thp each time.  It will decrease thp swap out speed.

My main concern is the complexity added to zswap, and making sure
everything is correct.  For example, what about the load path?
Doesn't zswap need to rebuild the THP when the page is swapped back
in?  And the BUG_ON() in the load path really concerns me, what if
zswap rejected a THP because it was full, wouldn't the page still be a
THP when zswap was requested to load it?

> 2. If thp can handle the thp with itself, it can decrease the times
> of access the locks.
> For example:
>         spin_lock(&tree->lock);
>         for (i =3D 0; i < nr; i++) {
>                 do {
>                         ret =3D zswap_rb_insert(&tree->rbroot, entries[i]=
,
>                                         &dupentry);
>                         if (ret =3D=3D -EEXIST) {
>                                 zswap_duplicate_entry++;
>                                 /* remove from rbtree */
>                                 zswap_rb_erase(&tree->rbroot, dupentry);
>                                 zswap_entry_put(tree, dupentry);
>                         }
>                 } while (ret =3D=3D -EEXIST);
>         }
>         spin_unlock(&tree->lock);
>
> This is my test in a vm that has 1 CPU, 1G memory and 4G swap:
> First, I write a very small patch that let shrink_page_list split all
> thps.
> @@ -1298,8 +1298,7 @@ static unsigned long shrink_page_list(struct
> list_head *page_list,
>                                           * away. Chances are some or
> all of the
>                                           * tail pages can be freed
> without IO.
>                                           */
> -                                       if (!compound_mapcount(page) &&
> -                                           split_huge_page_to_list(page,
> +                                       if (split_huge_page_to_list(page,
>
> page_list))
>                                                  goto activate_locked;
>                                  }
> Following is my test with this kernel:
> echo lz4 > /sys/module/zswap/parameters/compressor
> echo zsmalloc > /sys/module/zswap/parameters/zpool
> echo 0 > /sys/module/zswap/parameters/same_filled_pages_enabled
> echo 50 > /sys/module/zswap/parameters/max_pool_percent
> echo 1 > /sys/module/zswap/parameters/enabled
> swapon /swapfile
> echo always > /sys/kernel/mm/transparent_hugepage/enabled
>
> / # usemem -a -n 1 $((2000 * 1024 * 1024))
> 2359296000 bytes / 3384272 usecs =3D 680796 KB/s
> 71011 usecs to free memory
> / # usemem -a -n 1 $((2000 * 1024 * 1024))
> 2359296000 bytes / 3288668 usecs =3D 700587 KB/s
> 74503 usecs to free memory
> / # usemem -a -n 1 $((2000 * 1024 * 1024))
> 2359296000 bytes / 3402337 usecs =3D 677181 KB/s
> 142834 usecs to free memory
> / # usemem -a -n 1 $((2000 * 1024 * 1024))
> 2359296000 bytes / 3299039 usecs =3D 698385 KB/s
> 130385 usecs to free memory
>
> Second, same test with zswap thp patch:
> echo lz4 > /sys/module/zswap/parameters/compressor
> echo zsmalloc > /sys/module/zswap/parameters/zpool
> echo 0 > /sys/module/zswap/parameters/same_filled_pages_enabled
> echo 50 > /sys/module/zswap/parameters/max_pool_percent
> echo 1 > /sys/module/zswap/parameters/enabled
> swapon /swapfile
> echo always > /sys/kernel/mm/transparent_hugepage/enabled
> / # usemem -a -n 1 $((2000 * 1024 * 1024))
> 2359296000 bytes / 2799385 usecs =3D 823037 KB/s
> 69978 usecs to free memory
> / # usemem -a -n 1 $((2000 * 1024 * 1024))
> 2359296000 bytes / 2794564 usecs =3D 824457 KB/s
> 69124 usecs to free memory
> / # usemem -a -n 1 $((2000 * 1024 * 1024))
> 2359296000 bytes / 3000326 usecs =3D 767916 KB/s
> 123705 usecs to free memory
>
> You can see that let zswap handle zswap is faster.
>
> Thanks,
> Hui
>
> >>
> >> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> >> ---
> >>   mm/zswap.c | 170 +++++++++++++++++++++++++++++++++++++++------------=
----------
> >>   1 file changed, 109 insertions(+), 61 deletions(-)
> >>
> >> diff --git a/mm/zswap.c b/mm/zswap.c
> >> index 46a3223..36aa10d 100644
> >> --- a/mm/zswap.c
> >> +++ b/mm/zswap.c
> >> @@ -316,11 +316,7 @@ static void zswap_rb_erase(struct rb_root *root, =
struct zswap_entry *entry)
> >>          }
> >>   }
> >>
> >> -/*
> >> - * Carries out the common pattern of freeing and entry's zpool alloca=
tion,
> >> - * freeing the entry itself, and decrementing the number of stored pa=
ges.
> >> - */
> >> -static void zswap_free_entry(struct zswap_entry *entry)
> >> +static void zswap_free_entry_1(struct zswap_entry *entry)
> >>   {
> >>          if (!entry->length)
> >>                  atomic_dec(&zswap_same_filled_pages);
> >> @@ -329,6 +325,15 @@ static void zswap_free_entry(struct zswap_entry *=
entry)
> >>                  zswap_pool_put(entry->pool);
> >>          }
> >>          zswap_entry_cache_free(entry);
> >> +}
> >> +
> >> +/*
> >> + * Carries out the common pattern of freeing and entry's zpool alloca=
tion,
> >> + * freeing the entry itself, and decrementing the number of stored pa=
ges.
> >> + */
> >> +static void zswap_free_entry(struct zswap_entry *entry)
> >> +{
> >> +       zswap_free_entry_1(entry);
> >>          atomic_dec(&zswap_stored_pages);
> >>          zswap_update_total_size();
> >>   }
> >> @@ -980,15 +985,11 @@ static void zswap_fill_page(void *ptr, unsigned =
long value)
> >>          memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
> >>   }
> >>
> >> -/*********************************
> >> -* frontswap hooks
> >> -**********************************/
> >> -/* attempts to compress and store an single page */
> >> -static int zswap_frontswap_store(unsigned type, pgoff_t offset,
> >> -                               struct page *page)
> >> +static int zswap_frontswap_store_1(unsigned type, pgoff_t offset,
> >> +                               struct page *page,
> >> +                               struct zswap_entry **entry_pointer)
> >>   {
> >> -       struct zswap_tree *tree =3D zswap_trees[type];
> >> -       struct zswap_entry *entry, *dupentry;
> >> +       struct zswap_entry *entry;
> >>          struct crypto_comp *tfm;
> >>          int ret;
> >>          unsigned int hlen, dlen =3D PAGE_SIZE;
> >> @@ -998,36 +999,6 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
> >>          struct zswap_header zhdr =3D { .swpentry =3D swp_entry(type, =
offset) };
> >>          gfp_t gfp;
> >>
> >> -       /* THP isn't supported */
> >> -       if (PageTransHuge(page)) {
> >> -               ret =3D -EINVAL;
> >> -               goto reject;
> >> -       }
> >> -
> >> -       if (!zswap_enabled || !tree) {
> >> -               ret =3D -ENODEV;
> >> -               goto reject;
> >> -       }
> >> -
> >> -       /* reclaim space if needed */
> >> -       if (zswap_is_full()) {
> >> -               zswap_pool_limit_hit++;
> >> -               if (zswap_shrink()) {
> >> -                       zswap_reject_reclaim_fail++;
> >> -                       ret =3D -ENOMEM;
> >> -                       goto reject;
> >> -               }
> >> -
> >> -               /* A second zswap_is_full() check after
> >> -                * zswap_shrink() to make sure it's now
> >> -                * under the max_pool_percent
> >> -                */
> >> -               if (zswap_is_full()) {
> >> -                       ret =3D -ENOMEM;
> >> -                       goto reject;
> >> -               }
> >> -       }
> >> -
> >>          /* allocate entry */
> >>          entry =3D zswap_entry_cache_alloc(GFP_KERNEL);
> >>          if (!entry) {
> >> @@ -1035,6 +1006,7 @@ static int zswap_frontswap_store(unsigned type, =
pgoff_t offset,
> >>                  ret =3D -ENOMEM;
> >>                  goto reject;
> >>          }
> >> +       *entry_pointer =3D entry;
> >>
> >>          if (zswap_same_filled_pages_enabled) {
> >>                  src =3D kmap_atomic(page);
> >> @@ -1044,7 +1016,7 @@ static int zswap_frontswap_store(unsigned type, =
pgoff_t offset,
> >>                          entry->length =3D 0;
> >>                          entry->value =3D value;
> >>                          atomic_inc(&zswap_same_filled_pages);
> >> -                       goto insert_entry;
> >> +                       goto out;
> >>                  }
> >>                  kunmap_atomic(src);
> >>          }
> >> @@ -1093,31 +1065,105 @@ static int zswap_frontswap_store(unsigned typ=
e, pgoff_t offset,
> >>          entry->handle =3D handle;
> >>          entry->length =3D dlen;
> >>
> >> -insert_entry:
> >> +out:
> >> +       return 0;
> >> +
> >> +put_dstmem:
> >> +       put_cpu_var(zswap_dstmem);
> >> +       zswap_pool_put(entry->pool);
> >> +freepage:
> >> +       zswap_entry_cache_free(entry);
> >> +reject:
> >> +       return ret;
> >> +}
> >> +
> >> +/*********************************
> >> +* frontswap hooks
> >> +**********************************/
> >> +/* attempts to compress and store an single page */
> >> +static int zswap_frontswap_store(unsigned type, pgoff_t offset,
> >> +                               struct page *page)
> >> +{
> >> +       struct zswap_tree *tree =3D zswap_trees[type];
> >> +       struct zswap_entry **entries =3D NULL, *dupentry;
> >> +       struct zswap_entry *single_entry[1];
> >> +       int ret;
> >> +       int i, nr;
> >> +
> >> +       if (!zswap_enabled || !tree) {
> >> +               ret =3D -ENODEV;
> >> +               goto reject;
> >> +       }
> >> +
> >> +       /* reclaim space if needed */
> >> +       if (zswap_is_full()) {
> >> +               zswap_pool_limit_hit++;
> >> +               if (zswap_shrink()) {
> >> +                       zswap_reject_reclaim_fail++;
> >> +                       ret =3D -ENOMEM;
> >> +                       goto reject;
> >> +               }
> >> +
> >> +               /* A second zswap_is_full() check after
> >> +                * zswap_shrink() to make sure it's now
> >> +                * under the max_pool_percent
> >> +                */
> >> +               if (zswap_is_full()) {
> >> +                       ret =3D -ENOMEM;
> >> +                       goto reject;
> >> +               }
> >> +       }
> >> +
> >> +       nr =3D hpage_nr_pages(page);
> >> +
> >> +       if (unlikely(nr > 1)) {
> >> +               entries =3D kvmalloc(sizeof(struct zswap_entry *) * nr=
,
> >> +                               GFP_KERNEL);
> >> +               if (!entries) {
> >> +                       ret =3D -ENOMEM;
> >> +                       goto reject;
> >> +               }
> >> +       } else
> >> +               entries =3D single_entry;
> >> +
> >> +       for (i =3D 0; i < nr; i++) {
> >> +               ret =3D zswap_frontswap_store_1(type, offset + i, page=
 + i,
> >> +                                       &entries[i]);
> >> +               if (ret)
> >> +                       goto freepage;
> >> +       }
> >> +
> >>          /* map */
> >>          spin_lock(&tree->lock);
> >> -       do {
> >> -               ret =3D zswap_rb_insert(&tree->rbroot, entry, &dupentr=
y);
> >> -               if (ret =3D=3D -EEXIST) {
> >> -                       zswap_duplicate_entry++;
> >> -                       /* remove from rbtree */
> >> -                       zswap_rb_erase(&tree->rbroot, dupentry);
> >> -                       zswap_entry_put(tree, dupentry);
> >> -               }
> >> -       } while (ret =3D=3D -EEXIST);
> >> +       for (i =3D 0; i < nr; i++) {
> >> +               do {
> >> +                       ret =3D zswap_rb_insert(&tree->rbroot, entries=
[i],
> >> +                                       &dupentry);
> >> +                       if (ret =3D=3D -EEXIST) {
> >> +                               zswap_duplicate_entry++;
> >> +                               /* remove from rbtree */
> >> +                               zswap_rb_erase(&tree->rbroot, dupentry=
);
> >> +                               zswap_entry_put(tree, dupentry);
> >> +                       }
> >> +               } while (ret =3D=3D -EEXIST);
> >> +       }
> >>          spin_unlock(&tree->lock);
> >>
> >>          /* update stats */
> >> -       atomic_inc(&zswap_stored_pages);
> >> +       atomic_add(nr, &zswap_stored_pages);
> >>          zswap_update_total_size();
> >>
> >> -       return 0;
> >> -
> >> -put_dstmem:
> >> -       put_cpu_var(zswap_dstmem);
> >> -       zswap_pool_put(entry->pool);
> >> +       ret =3D 0;
> >>   freepage:
> >> -       zswap_entry_cache_free(entry);
> >> +       if (unlikely(nr > 1)) {
> >> +               if (ret) {
> >> +                       int j;
> >> +
> >> +                       for (j =3D 0; j < i; j++)
> >> +                               zswap_free_entry_1(entries[j]);
> >> +               }
> >> +               kvfree(entries);
> >> +       }
> >>   reject:
> >>          return ret;
> >>   }
> >> @@ -1136,6 +1182,8 @@ static int zswap_frontswap_load(unsigned type, p=
goff_t offset,
> >>          unsigned int dlen;
> >>          int ret;
> >>
> >> +       BUG_ON(PageTransHuge(page));
> >> +
> >>          /* find */
> >>          spin_lock(&tree->lock);
> >>          entry =3D zswap_entry_find_get(&tree->rbroot, offset);
> >> --
> >> 2.7.4
> >>
