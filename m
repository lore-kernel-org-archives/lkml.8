Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDE1C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4599120CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588852803;
	bh=502Ul+a2/6OmlVb0BNU7TBluq6gsIGbxeAbFD6GE7rI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=h9PXv+5gh5DI8TvyUPM1zPgOePfROMhULhXAsRNM392uWPp76gP2LC9N2HlMLp1zX
	 cVEpNq4/GE1nadOT5ZehrSP2Eyt0mKae71Ou/8DRBRomC3pOlDut+QTwyO1c0PgWbZ
	 +eg9jaDMLlYSaKJjk0Blg90WZ6fYz3u21ImoSVN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgEGMAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:00:02 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:59303 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgEGMAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:00:01 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 047BxZnW010264
        for <linux-kernel@vger.kernel.org>; Thu, 7 May 2020 20:59:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 047BxZnW010264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588852776;
        bh=j4LkJg3zKDbaOFanIYOCN8uuF9BCJkHkX+OsK2l2XCA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R6FOOqjvXOsQYhZ8gtX+NLCSBXg0SHK/NAYiESCKRB4zwboLy5N4pkaRYOH0s7AJh
         HeUgAmNJqegNdHYrD0lFj1Nz1aS+jjkQeCWOrLQ3qzuwel7lYvgW2f6f2BLaxbih5O
         Zp+BZyxlWdRuU/R6N/OzkiPPQua3I8WT1TVDIHqayVIKRxlKaQ7CoGkAxrchoGMd6i
         hXmRPEeztWSo+6s0OPtQA9slMeM47EPLbsdAMNQ1onkv2DPDri0KxOW31Jbp4KPk8l
         TK38tkcOKGGhoHvuat2Ad5FjlUg8RwXkYQmt/OZK98ctiTdZESVz5TN9dpI1sH2vA2
         FwoO4cHnpFSYA==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id t8so1742196uap.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 04:59:36 -0700 (PDT)
X-Gm-Message-State: AGi0PuY8iKFSQPpUObmTlR+Bw8dYK7PdR8AkmqRYtRjBTCvH5ss+nPbN
        Oqanvb7IRK1db9e2HXj3rCwR9/1Gy8mDPx+/Uhs=
X-Google-Smtp-Source: APiQypKRsRsnVT72sxg4UnhV0a253ssOTjtRUOfZJ91/QLO6o71hIL0zLqtgGpDxMTYevcWC5JpstADh+lZ4NPZyLnQ=
X-Received: by 2002:ab0:69c9:: with SMTP id u9mr11294872uaq.121.1588852774837;
 Thu, 07 May 2020 04:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <1588250972-8507-1-git-send-email-maninder1.s@samsung.com>
 <1588250972-8507-4-git-send-email-maninder1.s@samsung.com>
 <CGME20200430125001epcas5p2a6f02e9888481cef96f32ba14450bc63@epcms5p5>
 <CAK7LNASf687MLf1oWqrUiOHtw=p9Ug02bi1r-KevsxnFtQni2g@mail.gmail.com> <20200507105122epcms5p543853209caaec4c3b031d64f916f9ccc@epcms5p5>
In-Reply-To: <20200507105122epcms5p543853209caaec4c3b031d64f916f9ccc@epcms5p5>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 7 May 2020 20:58:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNATkW08MPhiZ4c1ScdZwQ1bu5TnLsj+Tcu1QP7KdmXgNsQ@mail.gmail.com>
Message-ID: <CAK7LNATkW08MPhiZ4c1ScdZwQ1bu5TnLsj+Tcu1QP7KdmXgNsQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] scripts/checkstack.pl: fix arm sp regex
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     "George G. Davis" <george_davis@mentor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 8:43 PM Maninder Singh <maninder1.s@samsung.com> wrote:
>
> Hi Masahiro,
>
> Thanks for review.
> We will integrate your review comements and send v2.
>
> >>
>
> >> so making regex $re for ARM similar to aarch64
> >>
> >> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> >> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> >
> >
> >This looks good to me, and it is a bug fix.
> >
> >Just a question about the SOB.
> >
> >
> >Maninder Singh is the author and also the submitter, right?
> >
> >What does "Signed-off-by: Vaneet Narang <v.narang@samsung.com>" mean?
> >
> >Co-developed-by or something else?
>
> Yes All 4 patches are co-developed by Vaneet and me.
> we were checking stack usage for arm and AARCH64 and found
> some changes in scrips which can help others also.
>

OK. Then,

Co-developed-by: Vaneet Narang <v.narang@samsung.com>

is the correct tag.


Signed-off-by is added when the patch is forwarded by
somebody else. This is not the case.







-- 
Best Regards
Masahiro Yamada
