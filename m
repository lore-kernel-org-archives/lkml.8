Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984E9C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B412072E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="mrXN+dy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGOVNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOVNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:13:14 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF57C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:13:13 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id e4so4339997ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=40EEju4zhqJNrLfahZyvepUCR8xy5Lu2ucbT1r8p0F0=;
        b=mrXN+dy1yUMmabC3DbDw1XiQjq2v4RTo4FewptRgSRsKZaezXTLKzGQsdD2IK2Lw4o
         ylOOtZ9Wku93bV570PsOKqjeYOQyiBgg2w9hC6iZALlL8Oz3scyc3iSz2QJDTU7drBQX
         nN44CCsIqw7tc9YR/DGGT/hQ7jDupBu42eszm91Mo9plmbHtq9/v8ZtkKb4r+TGVZK/s
         9qTUQ1K9texzP7W8vFwC+tbJfkMpl0Rl+QBhHahf9RnHxtN3jATVi3rH//8aL73Pa7pZ
         my87Wq2fK5ApE2hvH7buO2uLfaGZ7xlEukhxstbwuCCM/6kwsmdpzh5Dk0GXNqtn3Vxw
         30PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=40EEju4zhqJNrLfahZyvepUCR8xy5Lu2ucbT1r8p0F0=;
        b=fI3CWD6NF//yBfyWBoNF+7pDeVsZvE0Y4CJ87crdZBDVEpXweKsWHDg/Aea1/X1Of8
         ExwPNNF/wI1io5InPQ8Kq5j5Jew365lLq7VEWVYXQ7l3s3hqrgUtBG4O3M7pBhSBswYV
         yTGgWEH/xCzE7LwM7Z1QSVjIL3WdxI5mYxmX5kaWtqivAhMzjQeyHB/pBM/J7CQwd/M1
         ZJjvPSh30CIalAtzP6T4GCC2PtiezFa5TAa2EFmmD4xfJoxl9g7P+m5yHhlCLxZgjxtQ
         LPFF6hbph0F+Z2eP6B8DStWlAbEpt8CFlUP2+nM2XkOiUb2d5p2lHtyeniJeB+PzmhKG
         4RuA==
X-Gm-Message-State: AOAM531DAVc5ZeG5TQHdQROHjRvg9vbNR8oi69bbazlawFvMSg+uDjUA
        AShhHA34/0nJMNj5Dmez8hsnCB/9EEY=
X-Google-Smtp-Source: ABdhPJxUsPALjvyqqoh3klOIbksCl3fNYezR8nEYz/TKInS5zb4Btyj6cdvMN2tAyk/SnqE3Qd7sEQ==
X-Received: by 2002:a2e:9dc6:: with SMTP id x6mr441174ljj.94.1594847592248;
        Wed, 15 Jul 2020 14:13:12 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u25sm791726lju.54.2020.07.15.14.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 14:13:11 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E10BE102143; Thu, 16 Jul 2020 00:13:17 +0300 (+03)
Date:   Thu, 16 Jul 2020 00:13:17 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
Message-ID: <20200715211317.hxw724qajn7ksioo@box>
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
 <20200715205428.GA201569@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715205428.GA201569@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 04:54:28PM -0400, Joel Fernandes wrote:
> Hi Linus,
> 
> On Wed, Jul 15, 2020 at 11:36:59AM -0700, Linus Torvalds wrote:
> Regarding the ADDR_AFTER_NEXT checks, shouldn't you check for:
> 
> 	if (ADDR_AFTER_NEXT(ALIGN(*old_addr + *len, PMD_SIZE), old))
> 		return;

See comment to ADDR_AFTER_NEXT().

-- 
 Kirill A. Shutemov
