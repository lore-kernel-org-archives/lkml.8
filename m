Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EA1C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 085BC20758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599069170;
	bh=noTD0k8/MFC/yiNgU4rAPB5R6c1yPo1FfMGbVeWC3Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UsPz9jsLkyiQPLxNmQnqRdv5nTHYKU1Z2gscym5jWJ81UPBnjoRQRLlKqxPUR7WLy
	 oSkzsKzy1ArPURmDefPMJ8BZk5QPrYFABW7IkD5EKzt82ZkU0gz847iHao8KGmsIB8
	 O/xc7LpDsX9YeIvmiNG7k0GfrY3OAlxpeScQsJTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgIBRwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgIBRwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:52:45 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9354120758;
        Wed,  2 Sep 2020 17:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599069165;
        bh=noTD0k8/MFC/yiNgU4rAPB5R6c1yPo1FfMGbVeWC3Uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=exLqUnJQUTQ+VEdSwsTwYy8ckH5wg5SYZC+MzjW67CXCN9ji3dCW/Y9mSOX/1i78a
         OS83BcXaA64zRrQlXkAA722IL6n4e0s/iuzCfB8OUI1SnYvcDgIz4yuhZ3+57iaLOm
         vt0A8VilIY0VMX2BM/6EFTIgPdzh9UfYRHWYSTsE=
Date:   Wed, 2 Sep 2020 20:52:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -rc 0/4] Protect from GCC garbage input in GCOV
Message-ID: <20200902175241.GL59010@unreal>
References: <20200902085513.748149-1-leon@kernel.org>
 <CAHk-=whURzFKdBsoHCVsy4VU-cmAKBQEhkiS8Y8TQ9nRgAbP8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whURzFKdBsoHCVsy4VU-cmAKBQEhkiS8Y8TQ9nRgAbP8g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 10:42:55AM -0700, Linus Torvalds wrote:
> On Wed, Sep 2, 2020 at 1:55 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > Bottom line, GCOV is broken on GCC 10.2.
>
> The patches don't really make sense to me.
>
> How about we just disable GCOV with the known-broken compiler version
> instead? As mentioned in the replies to individual patches, it looks
> like the "fixes" are random bandaids that don't _really_ fix anything.

Right, as I wrote in RFC "solution is wrong", I knew it, just didn't
get any feedback on how to do it correctly.

Are you suggesting something like this?

diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 3110c77230c7..bc0e355f64aa 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -3,7 +3,7 @@ menu "GCOV-based kernel profiling"

 config GCOV_KERNEL
        bool "Enable gcov-based kernel profiling"
-       depends on DEBUG_FS
+       depends on DEBUG_FS && (GCC_VERSION >= XXX && GCC_VERSION < YYY)
        select CONSTRUCTORS if !UML
        default n
        help
~


Thanks

>
>                 Linus
