Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64086C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325E12074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhYAievL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgFOGPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgFOGPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:15:40 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39740C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:15:40 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q8so14683838qkm.12
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pq8wSoIwYToPYyYMgXetLZRme7ou0tgoOwDcqdnlKHE=;
        b=YhYAievLTb+s1aYwoEae3p1JzZ8ET8WqfcyarhCMhIGjmFW2VuSv56qtK0iTXYAOJK
         FxW7ggnTNvKInUW/vfv9UtPmG7tFHvy2paKRofuftyaDFLjAyrCMSJ3Occs4TzSmNiL1
         +PLfC8COBKhE03g2EZeGMzANYHNxIgo4U3/pYEDsusGE3TZzIb9S+/N/euRHah/dUSoD
         NkXs3wEDD/qErfLaT1UUhe6OyD/uUVWe6U0GBAunp9czEivTVXw0CTOxd/JDr1k5fQyC
         1OQUVn+/VpGR8XOY4P6eiKzicVZ2zF5UM7xL/lHifQegmlu0ThYcdOsWYeqsjxQk3GJU
         UPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pq8wSoIwYToPYyYMgXetLZRme7ou0tgoOwDcqdnlKHE=;
        b=WA7rCiFRxRhtoIWZUl/PfVlF4PN+N3qg756OAIyAGnZA2WY+ycl8/B0p2PjUFoaC7P
         CnlGOOM2L6NEpuhqffxLs+nJ2D+RcI6rfBQ1ZREXRmXPIQUoNC4+yG8cMIDktVFfaCRM
         LG9YXAh8m1JU5+ar44QHDpk1doW7IkiYN1Mh9SYcMlsgfjsynvh/kL+74HKJt5dfJZPL
         V/zfGbZZS4bk32KL3GhurSkblDs2UZGUkesLTc1TUCgLlcbew0xcuth9L6JgLK0B3ddj
         iOESXib9751Oh8gfyM8DsNL46iHyN42izDv9wJfm3BnY9eo6Nbpp8XaVLPA6xBDuCTQL
         dE+A==
X-Gm-Message-State: AOAM530T3MSKc789+eiY9omfsQR3F6LbuSXPehG7g8x4bvImhrFBt0+Z
        qiylYcBSHx8KcrqUIoqrUL9DfekptbJb0ceFuIk=
X-Google-Smtp-Source: ABdhPJwE9J+eJGLQhM9cvcRVG6bRyMsop11pz6QRuQPdJvXk05CFa//kxOLWGMIJPV9VNYj91tLpzDE60uTUbAk0KG0=
X-Received: by 2002:a05:620a:a4a:: with SMTP id j10mr13337550qka.272.1592201739302;
 Sun, 14 Jun 2020 23:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200614123923.99189-1-songmuchun@bytedance.com> <20200614123923.99189-3-songmuchun@bytedance.com>
In-Reply-To: <20200614123923.99189-3-songmuchun@bytedance.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 15 Jun 2020 15:15:28 +0900
Message-ID: <CAAmzW4N6ycsp+W_hGA03W-QVCxE6Jqo0mvjajK9ZuY1M596wSg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/slub: Use node_nr_slabs() instead of slabs_node()
To:     Muchun Song <songmuchun@bytedance.com>
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

2020=EB=85=84 6=EC=9B=94 14=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 9:39, M=
uchun Song <songmuchun@bytedance.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> In the some code, we already get the kmem_cache_node, so we can
> use node_nr_slabs() directly instead of slabs_node(). Check the
> condition of n->nr_partial can also be removed because we can get
> the correct result via node_nr_slabs().
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

If appying this patch, there is no reference to slabs_node(). Please remove=
 it.

Thanks.
