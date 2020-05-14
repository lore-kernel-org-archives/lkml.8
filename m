Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60256C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466B620727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgENOtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:49:55 -0400
Received: from 8bytes.org ([81.169.241.247]:42964 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgENOtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:49:55 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8480D1D3; Thu, 14 May 2020 16:49:53 +0200 (CEST)
Date:   Thu, 14 May 2020 16:49:51 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: Re: [PATCH v2 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Message-ID: <20200514144951.GL18353@8bytes.org>
References: <20200513152137.32426-1-joro@8bytes.org>
 <CALCETrW1Y2Q7dWwv4X7PHf3yxOGMcDaBG0NK7BWPAR=FiqsoPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrW1Y2Q7dWwv4X7PHf3yxOGMcDaBG0NK7BWPAR=FiqsoPQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 09:01:04AM -0700, Andy Lutomirski wrote:
> Assuming the missing cleanup at the end gets done:
> 
> Acked-by: Andy Lutomirski <luto@kernel.org>
> 
> grumpily acked, anyway.

Thanks, I updated patch 7 and added your acks, will send a v3 probably
tomorrow.


	Joerg

