Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B5BC34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED8224654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipHlH/Al"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgBSB62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:58:28 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37512 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgBSB62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:58:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id z12so11914390pgl.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 17:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q/nY1Mf51kH8KT0v62tDiqkFUg4146cYnGwpmJwHyYo=;
        b=ipHlH/AlxVQ/IulE7p5AjzOFHiVR1RBrVYYtMyUoV1UQoG/6dZkSxq2PGqL2fniBgm
         p2Y3huDQAm29/M/8lvlIqo28KOk7mjIsnca2skalBXejbHNR1Lrgos+j48iiEPvhqLDw
         N6lchqBHGjjVN/a0DsS4yGeBI/RdwNASQm1aspA3tBfW0yDxxMFQxIwSs8xp7NcmY1D/
         lCOit0ez4+qPD2E7FNkgD5GxN4hi4xESTM/cOe6e6LQV233A0JernCGhcyycJGO0ApCc
         c7wG+rJ1X+e7UIgAO7ZZ+RZZExBkp5m2WFgdAws1sbupJEUXH/dcteNZKPo27wy5uELj
         Mwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q/nY1Mf51kH8KT0v62tDiqkFUg4146cYnGwpmJwHyYo=;
        b=UU1n/HKofy7l3OeOFEZPZ5SftLshorFB174oAnuGvTQyhLTChkZN8BkRzipDdbonp8
         wc8KLK5e6tbA9tWcPpdVIaYI2u2gxtTALedNgSMcAx+7t1bIlWJeTy4mIOLdUhy4yXLl
         /AxnqeNSS1Dk0Ov9CJ21wJRL+bP3J5mQmSYbwX6YR0fMv39w78IuCAAeczhsatBX4Iiv
         mh4hbt06uegmd/HLE3Gh9UTRklweCalnyeiwP/wDhyhXGdI2RCdKm3tEW77PoemR17sk
         N712pZO+9bbQ4SO7ACxFJUWmlFOnpXL/sKAy3zdL4R0X/ukwU6/f+FXNkT9FOit1FgAW
         V04g==
X-Gm-Message-State: APjAAAXm27/wpinLsuB21Jp3Xc3D4RaN0a385uJe4MVwnvCemQgtIRlP
        PqrTSW1MtvSEld133LpXHGE=
X-Google-Smtp-Source: APXvYqzFJQ7t+g8cJNhe0uBXgIH3F++H+a+3qLANXSylYjhWNApUO0k8Gw5fe0DVzEJDNArl3M7gpg==
X-Received: by 2002:aa7:9629:: with SMTP id r9mr24801465pfg.51.1582077507872;
        Tue, 18 Feb 2020 17:58:27 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e2sm206430pjs.25.2020.02.18.17.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 17:58:27 -0800 (PST)
Date:   Wed, 19 Feb 2020 09:58:19 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Jia He <justin.he@arm.com>, Linux MM <linux-mm@kvack.org>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: get rid of WARN if failed to cow user pages
Message-ID: <20200219015819.otdnknxpyo52txy7@xzhoux.usersys.redhat.com>
References: <20191225054227.gii6ctjkuddjnprs@xzhoux.usersys.redhat.com>
 <CAPcyv4hMPh0C+_OV+vuiYQikb8ZvRanna4vXfKN=10yrAyCjDA@mail.gmail.com>
 <x49imk3bo1h.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49imk3bo1h.fsf@segfault.boston.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:09:30PM -0500, Jeff Moyer wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > [ drop Ross, add Kirill, linux-mm, and lkml ]
> >
> > On Tue, Dec 24, 2019 at 9:42 PM Murphy Zhou <jencce.kernel@gmail.com> wrote:
> >>
> >> By running xfstests with fsdax enabled, generic/437 always hits this
> >> warning[1] since this commit:
> >>
> >> commit 83d116c53058d505ddef051e90ab27f57015b025
> >> Author: Jia He <justin.he@arm.com>
> >> Date:   Fri Oct 11 22:09:39 2019 +0800
> >>
> >>     mm: fix double page fault on arm64 if PTE_AF is cleared
> >>
> >> Looking at the test program[2] generic/437 uses, it's pretty easy
> >> to hit this warning. Remove this WARN as it seems not necessary.
> >
> > This is not sufficient justification. Does this same test fail without
> > DAX? If not, why not? At a minimum you need to explain why this is not
> > indicating a problem.
> 
> I ran into this, too, and Kirill has posted a patch[1] to fix the issue.
> Note that it's a potential data corrupter, so just removing the warning
> is NOT the right approach.  :)

Agree :) Thanks!

> 
> -Jeff
> 
> [1] https://lore.kernel.org/linux-mm/20200218154151.13349-1-kirill.shutemov@linux.intel.com/T/#u
> 
