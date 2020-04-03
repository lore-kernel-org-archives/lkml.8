Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD07AC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44C4206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR20vyTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbgDCEe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:34:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40211 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgDCEe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:34:58 -0400
Received: by mail-qk1-f195.google.com with SMTP id z15so558570qki.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 21:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WjLB9th1Eu1d/RS4/4J3ZU+AKzJ958RwVN86+I3SOag=;
        b=bR20vyToiPAzSf2jF9AhhO/6hGq/n+mG1eHn4mk/Tqu+THl8K4OpLx/MBTkuEly0jF
         YxWZ9TvV0z1BiGIWFgjy11Wu2uzo87tQLxmuGxglBJwCaSwUyvcz3FT1rhTq4u+IZsfN
         mrfX5kAOzuZt3XDxYzqYf0CAbAgWxVlvBghhx04g2/rrEz4peAnlosK6DP796JKQMpBJ
         0YchIvSyBW+a0Zc7C6FMntGZfL/+H4Lw8okjCko/XLBflZ7RYuxbO/hq7LNbS1Xyx3kF
         Tm5Bka6++z9dh5Ul30yg5zDUPpHKP9DgjwAg92OUUS6VsVwpRqSi65TUvhlKbiJhagbl
         +3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WjLB9th1Eu1d/RS4/4J3ZU+AKzJ958RwVN86+I3SOag=;
        b=JhDXAWZGSYWGlZG8MkOSJqfIYM7LHX2GDYP8uyX3u48cSqrejKaZoxy5UINuQDmFQM
         2EyGxGbz6rwMysuwt8jjKE97u6JQM9rnbWZ3ld8JJQSVWGVARcdHNhlT4qHAED13dMPR
         PL8Fqrcex+Cahm1scF88dEow47TJKmr5EpSpVt+rYctxFbUQhOKyJXQZEVvnhkk6j63q
         RcQ6asOAoyKS08GEVXMYqDIqqTa2l1djh9XLadItBfSs+pDk1NQoHdQJceoAjnPF3ENO
         vRHAxiLKkoRvDwX7S8ETLY8vSnDtzM3zX1rXxMBjw2i7BPVAlqcZokE81rjKeC78/x14
         uIlQ==
X-Gm-Message-State: AGi0PuZ+iCnljgyxS0NG1//lyP1zNPtnOSlPI2c+hekU3DnY0D8Mm2qw
        VV0GbGBGBzOsoJLD9zfvbyrLLOgOOEt8nxWHh6umiwTb
X-Google-Smtp-Source: APiQypJX5PLqIEm2aSweoKUvuu6FkMfa73c7b+xeL/CPPAx4nzkjE8uhxV9AM30sADCWD9BfLLp/BqAUGtVHRpdLcWQ=
X-Received: by 2002:a05:620a:1311:: with SMTP id o17mr1804275qkj.343.1585888496570;
 Thu, 02 Apr 2020 21:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200306150102.3e77354b@imladris.surriel.com> <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
 <20200311173526.GH96999@carbon.dhcp.thefacebook.com> <CAAmzW4PRCGdZXGceSCfzpesUXNd8GU-zLt-m+t762=WH-BjmoA@mail.gmail.com>
 <20200401191322.a5c99b408aa8601f999a794a@linux-foundation.org>
 <20200402025335.GB69473@carbon.DHCP.thefacebook.com> <CAAmzW4PF1AXcZnQpWmqWgTShu+5v7B=nv8waRv+vk-0Bd78cZw@mail.gmail.com>
 <20200402194233.GA171919@carbon.DHCP.thefacebook.com>
In-Reply-To: <20200402194233.GA171919@carbon.DHCP.thefacebook.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 3 Apr 2020 13:34:45 +0900
Message-ID: <CAAmzW4M7cGmvssfmT5kmeZNOiQfbZP6N71TRHBq0BDtWqi78=g@mail.gmail.com>
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 4=EC=9B=94 3=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 4:42, Ro=
man Gushchin <guro@fb.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > In fact, I've tested this patch and your fixes for migration problem
> > and found that there is
> > still migration problem and failure rate is increased by this patch.
>
> Do you mind sharing any details? What kind of pages are those?

I don't investigate more since I had not enough time to do. If I
remember correctly,
it's the page used by journaling. I attach my test script below to
help you reproduce it.
My test setup is:
- virtual machine, 8 cpus and 1024 MB mem (256 MB cma mem)
- ubuntu 16.04 with custom kernel
- filesystem is ext4

> I'm using the following patch to dump failed pages:
>
> @@ -1455,6 +1455,9 @@ int migrate_pages(struct list_head *from, new_page_=
t get_new_page,
>                                                 private, page, pass > 2, =
mode,
>                                                 reason);
>
> +                       if (rc && reason =3D=3D MR_CONTIG_RANGE)
> +                               dump_page(page, "unmap_and_move");
> +
>                         switch(rc) {
>                         case -ENOMEM:
>                                 /*
>
>
> > However, given that
> > there is no progress on this area for a long time, I think that
> > applying the change aggressively
> > is required to break the current situation.
>
> I totally agree!
>
> Btw, I've found that cma_release() grabs the cma->lock mutex,
> so it can't be called from the atomic context (I've got a lockdep warning=
).
>
> Of course, I can change the calling side, but I think it's better to chan=
ge
> the cma code to make cma_release() more accepting. What do you think
> about the following patch?

For 2GB CMA area, we need to check 8192(?) bytes in worst case scenario and
I don't think it's small enough for spinlock. Even, there is no limit
on the size of
the cma area. If cma area is bigger, it takes more. So, I think that
spinlock() isn't
good here.

Anyway, below is the test script that I used.

Thanks.

-------------------------->8------------------------------------
RUNS=3D1
MAKE_CPUS=3D10
KERNEL_DIR=3D~~~~~~~~~~~~~~~
WORKING_DIR=3D`pwd`
RESULT_OUTPUT=3D$WORKING_DIR/log-cma-alloc.txt
BUILD_KERNEL=3D1
BUILD_KERNEL_PID=3D0
SHOW_CONSOLE=3D1
SHOW_LATENCY=3D1

CMA_AREA_NAME=3Dcma_reserve
CMA_DEBUGFS_ROOT_DIR=3D/sys/kernel/debug/cma
CMA_DEBUGFS_AREA_DIR=3D$CMA_DEBUGFS_ROOT_DIR/cma-$CMA_AREA_NAME

CMA_AREA_COUNT=3D`sudo cat $CMA_DEBUGFS_AREA_DIR/count`
CMA_AREA_ORDERPERBIT=3D`sudo cat $CMA_DEBUGFS_AREA_DIR/order_per_bit`
CMA_AREA_PAGES=3D$(($CMA_AREA_COUNT * 2 ** $CMA_AREA_ORDERPERBIT))

CMA_ALLOC_DELAY=3D5
CMA_ALLOC_SPLIT=3D32
CMA_ALLOC_PAGES=3D$(($CMA_AREA_PAGES / $CMA_ALLOC_SPLIT))

function show_cma_info()
{
cat /proc/meminfo | grep -i cma
sudo cat $CMA_DEBUGFS_AREA_DIR/{count,used}
}

function time_begin()
{
echo $(date +%s.%N)
}

function time_elapsed()
{
tmp=3D$(date +%s.%N)
echo $tmp - $1 | bc -l
}

function time_sum()
{
echo $1 + $2 | bc -l
}

function time_avg()
{
echo $1 / $2 | bc -l
}

if [ "$1" =3D=3D "show" ]; then
show_cma_info
exit 0
fi

if [ "$SHOW_CONSOLE" !=3D "1" ]; then
exec 3>&1 4>&2 >$RESULT_OUTPUT 2>&1
fi

if [ "$BUILD_KERNEL" =3D=3D "1" ]; then
pushd -
cd $KERNEL_DIR
make clean &> /dev/null;
make -j$MAKE_CPUS &> /dev/null &
BUILD_KERNEL_PID=3D$!
popd
echo "waiting until build kernel runs actively"
sleep 10
fi

echo "BUILD_KERNEL: $BUILD_KERNEL"
echo "BUILD_KERNEL_PID: $BUILD_KERNEL_PID"
echo "CMA_AREA_NAME: $CMA_AREA_NAME"
echo "CMA_AREA_PAGES: $CMA_AREA_PAGES"
echo "CMA_ALLOC_SPLIT: $CMA_ALLOC_SPLIT"
echo "CMA_ALLOC_PAGES: $CMA_ALLOC_PAGES"

for i in `seq $RUNS`;
do
echo "begin: $i"

show_cma_info

CMA_ALLOC_SUCC=3D0
T_BEGIN=3D`time_begin`
for j in `seq $CMA_ALLOC_SPLIT`;
do
sudo bash -c "echo $CMA_ALLOC_PAGES > $CMA_DEBUGFS_AREA_DIR/alloc" &> /dev/=
null
if [ "$?" =3D=3D "0" ]; then
CMA_ALLOC_SUCC=3D$(($CMA_ALLOC_SUCC+1))
fi
done
T_ELAPSED=3D`time_elapsed $T_BEGIN`

sleep 5
echo "alloced: $CMA_ALLOC_SUCC"
show_cma_info

for j in `seq $CMA_ALLOC_SUCC`;
do
sudo bash -c "echo $CMA_ALLOC_PAGES > $CMA_DEBUGFS_AREA_DIR/free"
done

if [ "$SHOW_LATENCY" =3D=3D "1" ]; then
T_AVG=3D`time_avg $T_ELAPSED $CMA_ALLOC_SPLIT`
echo "T_AVG: $T_AVG"
fi

sleep $CMA_ALLOC_DELAY
done

if [ "$BUILD_KERNEL_PID" !=3D "0" ]; then
kill $BUILD_KERNEL_PID
fi

if [ "$SHOW_CONSOLE" !=3D "1" ]; then
exec 1>&3 2>&4
fi
