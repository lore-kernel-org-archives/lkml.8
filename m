Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5245C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE59A204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589384824;
	bh=nzgdwqBNsrP+73eJCjx0UH7nQXREgSbxf60tXOz/1mA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Fvfzqy1rcZrFoeCAWOKarEW6c/V9lzJOGixheF8kX0Erq96AiWAMf1DBPOExwp/U0
	 2/3cTdPNVXslKcb3hdlOQ9OxjaWIj99FN3CCfstaDubG0RQAsN/nrnyhW7xLTo2l9B
	 yFbrFCLT4j8xqRwGkH2QFE1UbTBL/9YshFJ1BX6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389206AbgEMPrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:47:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbgEMPrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:47:00 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A718B20659
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 15:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589384820;
        bh=nzgdwqBNsrP+73eJCjx0UH7nQXREgSbxf60tXOz/1mA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uTYkcqcoqoyksVZUKhSa9PcQZ7U0QNWOs1Pb5AAKeEs6RhzLiVRCQ3Qpw8+nTE929
         dcX1cFwFqWckgbCKSoP/FhIojh8qUM1IBjDwUFkLg5JvwihgMuOsf/OjJ3hVXx56J1
         SC7asO2sZ0gMpAwWAQ2cRb6o8vQIppMko+5EBOf8=
Received: by mail-wm1-f46.google.com with SMTP id w19so14302103wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:47:00 -0700 (PDT)
X-Gm-Message-State: AGi0PuavGKMsvOXnZabloNZCMytXFNNx/0n4NdcTGsNKs/NLVqbAlZcY
        NEulQOGHlF+5lI8L0PNIuf8D+5wd+M8XqGt6aBg+iw==
X-Google-Smtp-Source: APiQypKuUOoHroqVE1Q2xSEZ5CJAKVmZYRRug6GQ131e/OlvUQIzVUtZ4lvV/wUI+iagtz1aPdU6tH9xKFo/pnQ17qg=
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr22837779wmf.138.1589384818895;
 Wed, 13 May 2020 08:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200513152137.32426-1-joro@8bytes.org> <20200513152137.32426-8-joro@8bytes.org>
In-Reply-To: <20200513152137.32426-8-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 08:46:47 -0700
X-Gmail-Original-Message-ID: <CALCETrUq=-huvWXJpVLvPRNwTiniQg8DP6R__J33gE8iSoEGAg@mail.gmail.com>
Message-ID: <CALCETrUq=-huvWXJpVLvPRNwTiniQg8DP6R__J33gE8iSoEGAg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] x86/mm: Remove vmalloc faulting
To:     Joerg Roedel <joro@8bytes.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 8:21 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Remove fault handling on vmalloc areas, as the vmalloc code now takes
> care of synchronizing changes to all page-tables in the system.

You should also remove sync_current_stack_to_mm().
