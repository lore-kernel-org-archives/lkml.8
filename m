Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7E4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8946320679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="SwKnoN2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgFOGVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgFOGVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:21:23 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1177AC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:21:22 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id p20so16519909iop.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6UexJ591yY/0sBQwidfRyePuoEU/goCNRqDs0Bqn1P0=;
        b=SwKnoN2LBJMXiwPZLzjvgItvTNq5+bLqGvbDhWTsULRJeUMDolVhfaTo0DIqZ4UZ/r
         s8LNecQlyc4a/QhHY5SnWte0Mpo7QpV+jwOinyZHu9Fnm3Gy+3fEkIfPgUNqoay9puVC
         A9ftYAROGf4nyQpww/PevBIJJpBqiZ0w/5AqfXcDRZFveUv/Xm3ubxezEJzYcOXmTtjH
         UE01dgXoMSF+8fxTSN7cYllase901fFmRKat7AaWvHgbZCF9fQ24RxZ51WWbBwvftRqm
         CigC27toyhTGjXiTw0aWIHbUePGP4GBkBoQzwg4I3hWP39pJzRYNF4e1Tx2q/UjyNDGU
         lgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6UexJ591yY/0sBQwidfRyePuoEU/goCNRqDs0Bqn1P0=;
        b=PbkTfaIuS5NxjJNtA2reB6be5QpO4KmY7t5RPIER4MzZUSbA3YfEq+/ldMXgC+bwRM
         +rCvuKh9PjHDzO366cM7EMWQ5FlgbVEOS484KX9deMC3enRH4Swt5nxLd7Q6uBQXAUxW
         m9oRRql27NuKGppN9PQCrY3N2BVXG1z1EuKNfDrXDJJL//1KFuj/0xNEz/i6CPOH4BN3
         B1E8vHJBy3zEQFdeUyZGLSRHClYhYAjSEGtpvqjoW7OD+nwZk+TNMvYpCIj+DnPLKH5o
         6vUuSWtr5d6DwvjkXHnPg2BWuTMep2c7qJLE+MUR7hXPYdKIMcFitCOx9FQ9d1PPuV5C
         xb4Q==
X-Gm-Message-State: AOAM531xpXqyaadyRiRWqYt1bNI8T8JB0xiNvG/zAhGDaoFaetWpx0NG
        hmOs7t1bTrDErbkJ/Lth3VqhsYaFfZFlLGhwQh+/iA==
X-Google-Smtp-Source: ABdhPJz0qbxo88JZGJbwCkq5eq49FEpObhjkgWYBnJ3nngjmkA+GvLULUmZduP7VTteF5jmI93hTGQE13PkFgWQajks=
X-Received: by 2002:a6b:1745:: with SMTP id 66mr26322154iox.151.1592202081507;
 Sun, 14 Jun 2020 23:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200614123923.99189-1-songmuchun@bytedance.com>
 <20200614123923.99189-3-songmuchun@bytedance.com> <CAAmzW4N6ycsp+W_hGA03W-QVCxE6Jqo0mvjajK9ZuY1M596wSg@mail.gmail.com>
In-Reply-To: <CAAmzW4N6ycsp+W_hGA03W-QVCxE6Jqo0mvjajK9ZuY1M596wSg@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 15 Jun 2020 14:20:45 +0800
Message-ID: <CAMZfGtWFNnSLa6KQwG3CK9xjWkqE9OKfVZpaZurQArRSzG+FTg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/3] mm/slub: Use node_nr_slabs() instead
 of slabs_node()
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 2:15 PM Joonsoo Kim <js1304@gmail.com> wrote:
>
> 2020=EB=85=84 6=EC=9B=94 14=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 9:39,=
 Muchun Song <songmuchun@bytedance.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> >
> > In the some code, we already get the kmem_cache_node, so we can
> > use node_nr_slabs() directly instead of slabs_node(). Check the
> > condition of n->nr_partial can also be removed because we can get
> > the correct result via node_nr_slabs().
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> If appying this patch, there is no reference to slabs_node(). Please remo=
ve it.
>
> Thanks.

OK, Thanks. I will remove it in the next version.

--=20
Yours,
Muchun
