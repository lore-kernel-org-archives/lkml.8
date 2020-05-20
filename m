Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F061DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C19EA206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cNAPUipq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgETSWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 14:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgETSWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:22:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB01C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:22:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id n15so1729964pjt.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=okYI7MNZp3HlTncsex+p9q3nreaGDkCfau/xqoTDFeA=;
        b=cNAPUipqx2bFJ+Q4gvOpGJfFNx2kWk3BDsLqCvL3HRuaTXiuxE4RW3w4AaIvqXfFw2
         +9c7JD4UduZ6lUFRPrWbVyXMUvvWETcxwQT/e/iAhoe1GV4s5SqGVvGL8TJD2ainIm5H
         ox1we8X5e3lST4DMJtiRgFEA/noZqS1NS7DstM53LIMcqe6MtQYwIOIwVDldY2HpxwNq
         RRKdrM1KbniVLRdGCoqtULFnPYlMq5qOAizHIlVrNFWKze/EZl3ctrER1UeeRc/W7OrJ
         VeYnvppKfKewtw0+X727v5pTXANOo5CFB8GByEcUC3dxobcUa5dVIjCBuqkJ8HSk2jKM
         qxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=okYI7MNZp3HlTncsex+p9q3nreaGDkCfau/xqoTDFeA=;
        b=j7LlisXi+prHzSFzF2m8r0w3s7Y0Bdxl8pciPNH/GaBW5Wkf/ky+P9paL03zr68Q+6
         7ENIN5uLGpWU9I4asb/TS8eeOCI09Btx5BV4NzqxEkiQXPjBuAY6L6MzXkAkv0EfmEU5
         o9KBTMPfkg79q4/SJtkCBmziwRINTxDOqa9tquhCd0MlxCz2bZHGpq9t+XUjYPau3Oig
         WjMTP1QtN8kymGD7X9PO2Ombx00Y6rOeMbK+ridGM9CupYvqmXCbgLBzvtapk/FyVWz7
         9Qm9tmNuflrIsVS7aorFhRan7LHmI9hcKcGb6bRTFIAFMuFsqIVOksMrsRAgHX/Wo0Bc
         od3w==
X-Gm-Message-State: AOAM531ziKYMVa248wfIHHveRnkHIeMFjJjl7qYywDxp7upC+3M5StkD
        WnMjcS0wrQjVDrgbJv0fpg4m4+zdKAvBq6YjLFzDYQ==
X-Google-Smtp-Source: ABdhPJwysKltK1Uu8MOEm5u657a607JdnUfCn095w7uIkCArhvl8hh8nF0iBMFJlYSsdZLUp/Ghxni9M4iiLobISq0Q=
X-Received: by 2002:a17:90a:a62:: with SMTP id o89mr6889682pjo.217.1589998920813;
 Wed, 20 May 2020 11:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200228000001.240428-1-brendanhiggins@google.com>
 <20200520150227.GA8397@linux-b0ei> <20200520164156.GA1634618@smile.fi.intel.com>
In-Reply-To: <20200520164156.GA1634618@smile.fi.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 20 May 2020 11:21:49 -0700
Message-ID: <CAFd5g47Xj6pR=CqXMtYxL6iacqxoZ9PvHxsiG8dfUML24yN1gQ@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "software node: Simplify software_node_release()
 function"
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>,
        Heidi Fahim <heidifahim@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 9:42 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, May 20, 2020 at 05:02:27PM +0200, Petr Mladek wrote:
> > On Thu 2020-02-27 16:00:01, Brendan Higgins wrote:
>
> > I have found similar report from a test robot, see
> > https://lore.kernel.org/lkml/20200303002816.GW6548@shao2-debian/
> >
> >
> > I was staring into it for a while and do not understand it. The revert
> > makes sense. I wonder if it somehow changes the order in which
> > the release methods are called.
> >
> > Anyway, reverting the revert makes test_printf working.
>
> There is a proper fix IIRC from Heikki in driver core (no link at hand, sorry).

The fix for this patch can be found here: https://lkml.org/lkml/2020/5/13/1070

Cheers
