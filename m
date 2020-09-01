Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613C8C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41585205CB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glYae7st"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIAJey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:34:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20365 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgIAJex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598952892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o5Y78x1ZbIMZDcyiKJ8JiDFugDPHcPR0uo/OCjQ9IBA=;
        b=glYae7stfra9G25vJ5RMkfCakBoaJOV5z3Liy4BLsZsroT2HR8+6SuXIQ2uVzo5rCmv2eq
        1bLcwy2L8IKMIkd9zq+iyK+bLQtznIvNDp1LeJBvtvy42vwksAFm4gaLMTtxKj46pm6Esq
        DRGB0m/K2AzKkFqyVjwEsOFBVI099MY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-00ebRX0aPqi6YraJ7ZAaIA-1; Tue, 01 Sep 2020 05:34:49 -0400
X-MC-Unique: 00ebRX0aPqi6YraJ7ZAaIA-1
Received: by mail-pf1-f199.google.com with SMTP id b189so311517pfa.16
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 02:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5Y78x1ZbIMZDcyiKJ8JiDFugDPHcPR0uo/OCjQ9IBA=;
        b=N2GHrb2dZnZF73epbiv/bbosKINHAFpLWjPOO1Kx6HdDIVZ0o6ZAPVFQkRQqfVaaa4
         BaF6k1GvURU2Iks3DfnxjXNmtXqHqXJ2OCUaFGAAZ/hNPK2gtS9hUGjm64sNdxfBtmy/
         GctK7c3K1Ek3At9eyqfeErXJ+sCfJLAw6A33avreCwXam1ciWoAwzWormdceeecYXuR6
         o8IuMye5aBVhzIQ9wYJSch9HmcTQ0cRacjeOa5xx3g7Adhy6mbXtVV8fKffGB6RKM/YE
         M5wXCrJqToti/geM8s+r88b6X0sjSLEeWQ++Vi559YAQNE1w1NjUjermosH22LPKGmMI
         1QFQ==
X-Gm-Message-State: AOAM532c0QgIABquCpjVwQH6x0URrRqdAZsxNYeVt61MVdliXv+KWnzE
        1vJaSYa75zpXu9X3+evrUdn7YAkDNeyvclhCSk4PGJP6ci0jl9olk87BS6KJ/JQsvdNvFNesIOw
        KTpWz3J6ya20LjKx63WnMD4EPHaQ8G06JmBucqjUd
X-Received: by 2002:a63:6e01:: with SMTP id j1mr743708pgc.147.1598952888715;
        Tue, 01 Sep 2020 02:34:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWGx5gRzrr+E1Ah23gCssdxWPYkby9RSfbimJo07tkodnjtRxFh3BSEUXgTJbgP/qmIUT/Y2585CMTPSDc8ZE=
X-Received: by 2002:a63:6e01:: with SMTP id j1mr743688pgc.147.1598952888314;
 Tue, 01 Sep 2020 02:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200829112601.1060527-1-maz@kernel.org> <nycvar.YFH.7.76.2009011013400.4671@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2009011013400.4671@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 1 Sep 2020 11:34:37 +0200
Message-ID: <CAO-hwJKa9QWxEo7PvCEjoEG3YZLS+1EKvaC8C3pga7R9Yc5_tw@mail.gmail.com>
Subject: Re: [PATCH] HID: core: Correctly handle ReportSize being zero
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 10:14 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Sat, 29 Aug 2020, Marc Zyngier wrote:
>
> > It appears that a ReportSize value of zero is legal, even if a bit
> > non-sensical. Most of the HID code seems to handle that gracefully,
> > except when computing the total size in bytes. When fed as input to
> > memset, this leads to some funky outcomes.
> >
> > Detect the corner case and correctly compute the size.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
>
> Thanks Marc; Benjamin will be pushing this patch through his regression
> testing machinery, and if all is good, I'll push it for 5.9-rc still.

Test results were good. I have now pushed this patch to for-5.9/upstream-fixes

Cheers,
Benjamin

>
> --
> Jiri Kosina
> SUSE Labs
>

