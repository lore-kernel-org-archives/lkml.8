Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1162C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB2820733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="l9UrcbgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgC3TzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:55:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39032 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgC3TzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:55:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id a43so22282280edf.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 12:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0m2AnfIRcCHRpZW6PDeIax9gdSThqigcANOhQSHQQRM=;
        b=l9UrcbgGyZHpzzpXZ0ao5T6qmamT4bwpPo9Q1ZImIf8A7LLg6hVilR0KrN4O3gamsX
         TTDYIQCaPyZJm/VklimIRgeNaVSOlkAPYBcWC6u4lLFVoKVG3GvRC4sgvM5WwLN230cR
         NqacKnMDiHYRg5NxBw2W+fdR/djzIb+BwQuL5HGUnGcaGsEKVpBQA6Ibaza1SI8dNSo4
         1wCRpauHNIBwEuVetbcLpEdV1LxzYnn6SincBoe4V3EhF3iBRM/JOpP5Gm6ettn+PyeR
         kd8ucX/kUEddGzeLrJ8AcsMIcaAHlPDS+29wJSZpBltd4kvSmndVWXZiizq1H4clGtmK
         Zjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0m2AnfIRcCHRpZW6PDeIax9gdSThqigcANOhQSHQQRM=;
        b=LYMdnKwudgazPNxKsr/X9y7FaGG7xipfJ8YOEcB5MTv7AZfQwtlGiSlQ9BmrhBUOSb
         xEpqv0GuvYON1n9hZ6GluXxO5VMp8HdsohNmBoRzG+Ne7+FL6TxigmU7Nf1ACFJgLRvD
         zmNXde0DQTDEoH5Mzw1TOY/P1OeflH48WNC0TUkcBiTuLdX7D1AYFN8mlqKvynOPsOEy
         nneTO0fqt+Es4tq5geFJzNptu/JRHKTIlv5h1Z4gjMMYuJb7eACa9QMhmcPQMH8ZcwUg
         dQx4RWZrERxbNFISdH9AJXIEu55kTGmVnzK7Irwfz/goB0TX3y4VO+LEH/RhuZSI7nIG
         Q34w==
X-Gm-Message-State: ANhLgQ3sMvY+KabbXNQ3x7cQGyuZ/0tGz8p5FXqOqvNw+QW+3U/TFTif
        IkFK4ZegjHzJtKzUhYr56EfDiplNKBkMmRy6e0bIeQ==
X-Google-Smtp-Source: ADFU+vuRYf2PNGMfKGMR9APzvmfg1zGeVpB4kVz6LrQE2pYYEguvqYB2rhx1GF+WePdck7GQUX3jq1SI88VCcV1b6Hc=
X-Received: by 2002:a17:906:1697:: with SMTP id s23mr12715702ejd.211.1585598108932;
 Mon, 30 Mar 2020 12:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200319195046.GA452@embeddedor.com> <CAJZ5v0iDVL1WWTmmQX+2JDmyAfu2e8nSdLSmCqA-WZV+7pBHvw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iDVL1WWTmmQX+2JDmyAfu2e8nSdLSmCqA-WZV+7pBHvw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 30 Mar 2020 12:54:57 -0700
Message-ID: <CAPcyv4icgZEn9r9-+-R+rBQKebq+QcpYGQ-dvCiqhkO8XmDmEA@mail.gmail.com>
Subject: Re: [PATCH][next] acpi: nfit.h: Replace zero-length array with
 flexible-array member
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 3:06 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Mar 19, 2020 at 9:15 PM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
> >
> > The current codebase makes use of the zero-length array language
> > extension to the C90 standard, but the preferred mechanism to declare
> > variable-length types such as these ones is a flexible array member[1][2],
> > introduced in C99:
> >
> > struct foo {
> >         int stuff;
> >         struct boo array[];
> > };
> >
> > By making use of the mechanism above, we will get a compiler warning
> > in case the flexible array does not occur last in the structure, which
> > will help us prevent some kind of undefined behavior bugs from being
> > inadvertently introduced[3] to the codebase from now on.
> >
> > Also, notice that, dynamic memory allocations won't be affected by
> > this change:
> >
> > "Flexible array members have incomplete type, and so the sizeof operator
> > may not be applied. As a quirk of the original implementation of
> > zero-length arrays, sizeof evaluates to zero."[1]
> >
> > This issue was found with the help of Coccinelle.
> >
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > [2] https://github.com/KSPP/linux/issues/21
> > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>
> Dan,
>
> I'm assuming that you will take care of this one or please let me know
> otherwise.

Yes, this one and the other 2 related libnvdimm fixups are in my queue.
