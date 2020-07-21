Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57BDC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA602080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="TicxJRsO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgGUA6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGUA6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:58:49 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7929BC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 17:58:49 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dg28so14079643edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 17:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGtVdD2nEWSAU113PZhe2hv5MHlPJH23JUncqOBeJY0=;
        b=TicxJRsOh8783t529jSJMRkr8y4Zm4nuwkyuwFnsrgdDNsMVT2C7K9phpWYq4cjyWm
         CdDaairVbrtCrkrqGloXb3Kg+Hpawv0IiLCSS152OiROfES0HHSP2mMQzr/Ps8oiN3eY
         WNK2DCgi7LnWBoTFMQV1rD0fzkoJOX8CrVyh2A6N29vL10OD7biyVAHgrQr42iIrFovz
         Ggquj7bwc6RV3JqohG9ufGn2KxwFFK3DV47wsxuS/3VWMiqvDSR/Sw1DPwcNebavbySE
         k/WS+LvuJE4mzyYbkpSta8GQzN9y1whu3KyWLJRt31b6FaohPVSI7h6bHR4sYIl0E6tR
         nKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGtVdD2nEWSAU113PZhe2hv5MHlPJH23JUncqOBeJY0=;
        b=WWprW8E/k3cYhhwSx9Zqw9w1LM7QY63BRlnZMw3fI4SQatFAuKFbXeCIVYLtt7yrI5
         voc+Mzgu9vVUSW14HEO3F350Ax1EVXOQihuKmokff7F7FBzs1KQt1dnEMaTFakVUn5wu
         3LC+yjgnyXMdinBreTf5+tKuqTL3lS0ftE0c5vstYXmO7Y7g4BRzWzJowWcEfl1yu3W9
         rvb4eGmedO1JiM+fE0CsROwEatnc9s+gmbVhcaDxfrLmTSy4csHVhInqcLPfsb+Klxj/
         Wc0KoETa5XjJSjr66oGUyIoYSFmbmb3AnenKs7T8SV5+PenSEGM2qCltGk4v5b/qrj04
         ospA==
X-Gm-Message-State: AOAM533+22+TlonEQ89gOPSQ08fJaQWEZzWSFpRJq1XhDiyfRrDnU/R3
        rwshmIvXSfMV5hgiMVEX73Yw1iAYiSiN0lT3CSahjg==
X-Google-Smtp-Source: ABdhPJxgQp44bjFNJWLzBYp6Is2/AsTzZZ4zfxGj9e6W5uADSL3R+H2d1wy4qAl88PCnEMIe9kqHQ9N3Qt//tTMNVOc=
X-Received: by 2002:aa7:d043:: with SMTP id n3mr24567303edo.102.1595293128192;
 Mon, 20 Jul 2020 17:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
 <c825b5ee-ec03-7aa8-e380-6003f33fa113@infradead.org> <a6892924b53e8610753a13fa506099558f0efc6f.camel@intel.com>
In-Reply-To: <a6892924b53e8610753a13fa506099558f0efc6f.camel@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 20 Jul 2020 17:58:37 -0700
Message-ID: <CAPcyv4hSs=yQmocOVa8S=6C_8=1DRa9Ba92PK4YsXRwndf3p=g@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] PM, libnvdimm: Add runtime firmware activation support
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pavel Machek <pavel@ucw.cz>, Ira Weiny <ira.weiny@intel.com>,
        Len Brown <len.brown@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 5:14 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> On Mon, 2020-07-20 at 17:02 -0700, Randy Dunlap wrote:
> > Hi Dan,
> >
> > Documentation comments below:
>
> Dan, Randy,
>
> I'm happy to fix these up when applying.

Sounds good. Thanks Vishal.
