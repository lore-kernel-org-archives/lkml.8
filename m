Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38465C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 19:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E97620691
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 19:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VLkScLOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgGRTND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 15:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgGRTNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 15:13:02 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E96C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 12:13:02 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id w2so9405930pfn.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 12:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AF6WzDREys7pX44hC1bnRv06arMUHM4xLeS+gr1uXIw=;
        b=VLkScLOaoK0Ukpw/Jn1jBHjHkQPxv/NzGahgmzX8U0JLGmdRxN0Z5glvG35Ea0KlV7
         ccFW0AMVog87wJnx3QDFvbdWRS0xpiBN08aN8hkGBDjLElpckhcF+BzFhrA9RLinRlTn
         JoSfoaKHdvQd+4YPF+ARFjvAg3itMssIOypqgKovoyzyLzpFwKh0P9bYtktiYQQtHZ8h
         hbyFmZ7P7/6XZPpIZfBUXfGwQCvF9WTKWroTOUKeZpN0AZcCD7IKBonS4zuRJ5VlI421
         GBEH7UGDNbj4YOBi5woahrem9VtRZPXYggSIkdJIh+2+Uf0ypGfEAzyr2CV9hiTq3Nc8
         lzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AF6WzDREys7pX44hC1bnRv06arMUHM4xLeS+gr1uXIw=;
        b=udKe45MTuI31n03/iuorqLTvrwf7Mye6I+uXdjEu7gdTqmuRhKIOQY3v+RlSjWOu31
         IxwRa+v3L4rDt8rWWhVmZlpF2NZBh3dPrlIbs13jz5ZU40rb7b5ANi26glYNA7Z1MZz3
         7l2hN6dUgTPM0J0sVe6qxs4JDFXlKfjB6FpgX6uFOhBsibk5/fnH5UDDBINDXqwooIdf
         s1baXsOq5wgez2TkQcpqP9NMuZvZhaNG9aGkdPK2sbZYRjrwJY5jU3r2sSiomF6ozvD3
         r4tWVW1sTtvXcJTJmlPafnVEvlMvw90fWZKYM/xHlhqHGkOxbl8LeEB8H+7QFqOT6A13
         hKhw==
X-Gm-Message-State: AOAM531mlIhADcu2jfquz2Zhqn+B70GVR+VEWibUn1rS697vvXSRAPT8
        CRSICbAn2uqQgw8gMaqz5nLvJHj/X2HB
X-Google-Smtp-Source: ABdhPJx2fo6BNpvN/HcJneXKAp7Vtblyq6Xzc8545k3Dnwng76UGrnDP2f88KKuHDeAbqncqBVpbu0nztdy9
X-Received: by 2002:a62:be02:: with SMTP id l2mr12704136pff.163.1595099580890;
 Sat, 18 Jul 2020 12:13:00 -0700 (PDT)
Date:   Sat, 18 Jul 2020 12:12:58 -0700
In-Reply-To: <CAOSf1CHjrFb3J6t0HQXQVVM-PEgAcaCADA8mcwYVi4mpq+f3Yw@mail.gmail.com>
Message-Id: <xr93sgdo7i2t.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <37af499e-2b8b-7e78-ed4b-0aaf711fcb38@csgroup.eu>
 <20200614233235.121432-1-gthelen@google.com> <CAOSf1CHjrFb3J6t0HQXQVVM-PEgAcaCADA8mcwYVi4mpq+f3Yw@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/powernv/pci: use ifdef to avoid dead code
From:   Greg Thelen <gthelen@google.com>
To:     "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver O'Halloran <oohall@gmail.com> wrote:

> On Mon, Jun 15, 2020 at 9:33 AM Greg Thelen <gthelen@google.com> wrote:
>>
>> Commit dc3d8f85bb57 ("powerpc/powernv/pci: Re-work bus PE
>> configuration") removed a couple pnv_ioda_setup_bus_dma() calls.  The
>> only remaining calls are behind CONFIG_IOMMU_API.  Thus builds without
>> CONFIG_IOMMU_API see:
>>   arch/powerpc/platforms/powernv/pci-ioda.c:1888:13: error: 'pnv_ioda_setup_bus_dma' defined but not used
>>
>> Move pnv_ioda_setup_bus_dma() under CONFIG_IOMMU_API to avoid dead code.
>
> Doh! Thanks for the fix.
>
> Reviewed-by: Oliver O'Halloran <oohall@gmail.com>

Is there anything else needed from me on this patch?
Given that it fixes a 5.8 commit I figured it'd be 5.8 material.
