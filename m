Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37FEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2828206F0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="BXGx739N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgFEQj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgFEQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:39:55 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A34C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 09:39:55 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a25so10805782ejg.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MiHJvWvFUN4W4TOaBTTRVwH9Kbcz3EtLSrutNpEo/8=;
        b=BXGx739NHMzDG5jF4pX2SjGcZdBMtypWsjdXc+T5TXcMRY3QFLn1zVYTB10ArVqHfw
         bS2lJVfCpuTD82oSoAPn3j92VWPnGK3U9NUDm8MQimf3XMKwYy5kLcX07pC1YGpVXB2O
         3gP+9IYgz88+xJpYfAzaurF+CZ8yPzls/rjK0WfZtXiZKUXRZsqhDHr4qc11YmqpXt9e
         r86XRpvXT+Cy7gLPk8Rype/AN669h2aux8SKpgTvrVFDhanzHQcIcspCONHUC6/YyZs1
         5ZPK/WfUFfhDs5cz5AFCES84sqyqXKNvoU5i+bNAsSbPuv0mImc46an+0ZEFKox19Ymn
         uSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MiHJvWvFUN4W4TOaBTTRVwH9Kbcz3EtLSrutNpEo/8=;
        b=kxM94sVbMCD4n3FQSSi0qj09ifIJwHl4LOZmSdgow+Q2beaiAg5YHAr17ISszMrXCl
         MByYaGMaz99zOjn3MWr5EDlPjRi+be8xb+tO2j1cAh3oFvrNhh5fIZ25zsaXVsR+ui59
         ipESXeZsHgRBalzqm/xwfM5MDOfsrvUwUD9PM9J68j4yC0fR8JRGiLR+QcGbubIVdXGC
         T2p97EVdKAL9ea+3faQCRqOha3B3toDoJ/eVBouFcVAYU2xBiIt4hefeF/S6oLaUS0E4
         jQejOHllPFjUiZTtH4beLUTH/lBbqAqN1EPrptBntjmv77LjRg/nIrw3xEVztkV4SHDx
         rJMg==
X-Gm-Message-State: AOAM532PBck6tZ8HTHDJeHHdUqG2Jinw+6/1AmMweCgivOgWXlLgmBsn
        xAbdcQ9vTB5XRy+jNSyqYquvlN4uAJVHeZQ3rslWIw==
X-Google-Smtp-Source: ABdhPJz9NOYy2yZ6H8XGWcEzcmqj7Uj80HxfYALJr2J1pSWlpcP4qVMIo7RE/ZyxbXyEIMN2Y5wxAGBnr9c0Vhr3t/s=
X-Received: by 2002:a17:906:bcfc:: with SMTP id op28mr4137917ejb.237.1591375193798;
 Fri, 05 Jun 2020 09:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0gq55A7880dOJD7skwx7mnjsqbCqEGFvEo552U9W2zH3Q@mail.gmail.com>
 <CAPcyv4gQNPNOmSVrp7epS5_10qLUuGbutQ2xz7LXnpEhkWeA_w@mail.gmail.com> <CAJZ5v0g-TSk+7d-b0j5THeNtuSDeSJmKZHcG3mBesVZgkCyJOg@mail.gmail.com>
In-Reply-To: <CAJZ5v0g-TSk+7d-b0j5THeNtuSDeSJmKZHcG3mBesVZgkCyJOg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 5 Jun 2020 09:39:42 -0700
Message-ID: <CAPcyv4iECAzRjAUJ1hymOzZRjBYQ_baFrSz=2ah=2pfehn9S_g@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Drop rcu usage for MMIO mappings
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 9:22 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
[..]
> > The fix we are looking at now is to pre-map operation regions in a
> > similar manner as the way APEI resources are pre-mapped. The
> > pre-mapping would arrange for synchronize_rcu_expedited() to be elided
> > on each dynamic mapping attempt. The other piece is to arrange for
> > operation-regions to be mapped at their full size at once rather than
> > a page at a time.
>
> However, if the RCU usage in ACPI OSL can be replaced with an rwlock,
> some of the ACPICA changes above may not be necessary anymore (even
> though some of them may still be worth making).

I don't think you can replace the RCU usage in ACPI OSL and still
maintain NMI lookups in a dynamic list.

However, there are 3 solutions I see:

- Prevent acpi_os_map_cleanup() from triggering at high frequency by
pre-mapping and never unmapping operation-regions resources (internal
discussion in progress)

- Prevent walks of the 'acpi_ioremaps' list (acpi_map_lookup_virt())
from NMI context by re-writing the physical addresses in the APEI
tables with pre-mapped virtual address, i.e. remove rcu_read_lock()
and list_for_each_entry_rcu() from NMI context.

- Split operation-region resources into a separate mapping mechanism
than APEI resources so that typical locking can be used for the
sleepable resources and let the NMI accessible resources be managed
separately.

That last one is one we have not discussed internally, but it occurred
to me when you mentioned replacing RCU.
