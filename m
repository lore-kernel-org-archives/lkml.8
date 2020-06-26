Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05629C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 05:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21A720768
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 05:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V00pRRhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgFZFDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 01:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgFZFDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 01:03:52 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729C8C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 22:03:52 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 80so7751523qko.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 22:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MYSs5eT5+H+DDXa7SQpCZxjLH8NEqlh5crSWC+SUyko=;
        b=V00pRRhq9bxphfWep6t8lFVdEhgiJTOz5XqB5xZn39QTiYXdEcqYThHVw+1zvOsDWz
         VxIsaol4TiPYmXWlkVEfgXEbu6R2eBWBWLTpmmB3wbmvh152AATduW3CUHuCZxYGxBkv
         1XXzRDP8iETsZw6EyhkZpwxloV7m0uxDhacshNF+RBwZqyekrwUuqVCzo9ymvn/JMKUb
         a/vCLo1lm6DMTRkZ40ps+Sm6KU/7z5vBoOwFTFXBYCGJ27C4FHF6IMHs48tpv54R6JaJ
         C8GUnKhn22o+gHdMrY7wtJU4QVC6X8sdCsk4ng7/J2DLwPubI8WsAE7Opkp+b86rowKM
         1guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MYSs5eT5+H+DDXa7SQpCZxjLH8NEqlh5crSWC+SUyko=;
        b=tlw82H12g4BacMZt02XIyNS5n3/jy+nMpj/qQmRyzJyLpuTKYHc1+WuLBZetRtAC0m
         IznjrtMysQJLcsjIpe0up7p6MRGfQRiAfyMGzYQU+rTnr4wUAB8+79tFzG3yn2cNPgb/
         5SUIlDJo97A/tqr4CSALaYl3KHrE803Hj4WmD1mPsqV1lno1To7Y1aGw/aSGHwdRWIR5
         W0KAuBUSZE7hAOxA//0xgwVf1PI5KIBQqPsebmrUHmu4CTaG0so0xC3e7JDZ/T21H7/d
         GplqQwiOLmIxYPjLtXvHBj1jJUx5Vp1YVRKIlTMZZCqr+580CaT2f6Q6qSJEvLurWFsD
         n2aA==
X-Gm-Message-State: AOAM533C25xh6FSm+EDEUs9/e/RxxuP5sThDjI6CUQKXLE+uBFVwuqIh
        q/4TsdyH9jq3MWPzyf6OCkZ5304A73xM7O/0Yi/GME01
X-Google-Smtp-Source: ABdhPJyFBELjp5thhBR8rQ45kHVsWNrd2bCEMcJZVym82CgtEELCpfimj4s/5eKHhCs8TxK2jxXOgkWvhpjejIllFt4=
X-Received: by 2002:a37:6003:: with SMTP id u3mr939689qkb.343.1593147831746;
 Thu, 25 Jun 2020 22:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-7-git-send-email-iamjoonsoo.kim@lge.com> <20200625120830.GG1320@dhcp22.suse.cz>
In-Reply-To: <20200625120830.GG1320@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 26 Jun 2020 14:03:41 +0900
Message-ID: <CAAmzW4Ngrf+Krc45RK_B=o5e9AHiXnquVDOOUpRX99OWWBW0wA@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] mm/gup: use a standard migration target allocation callback
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 25=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9:08, M=
ichal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue 23-06-20 15:13:46, Joonsoo Kim wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > There is a well-defined migration target allocation callback.
> > It's mostly similar with new_non_cma_page() except considering CMA page=
s.
> >
> > This patch adds a CMA consideration to the standard migration target
> > allocation callback and use it on gup.c.
>
> We already can express that by a missing __GFP_MOVABLE so I would rather
> not introduce a duplication in form of another flag.

I replied to this question in a previous email.

Thanks.
