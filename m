Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ACCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67AB20823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g7s/gYo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgESMyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 08:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgESMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 08:54:19 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEDEC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 05:54:19 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x13so6493465pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 05:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G+3IDjSQe5T10VvQiPvHkruTfhZCDaHQP43VPDmYK54=;
        b=g7s/gYo884AOa/REioKbv6xPC+XS8JEcyTOZyZEftWHVNi/AZkMMQsZCrSmVvTpnrY
         bMRpbEGj1TuqSCh8GzKZKNV2c8wazABvcuQUMy7/gne30Botlu0xqkZWtMfZnocLBrAL
         5fHnoBkjUSpCsvv4ff5Lyilg4RosPraY7un+SosIxJugMcYwUxvuShZD52/PUEA7ckre
         SDQBDX0gJ4eV4NOkL9xRDvonfqT2qH72tVBPA4oqOYpNQY7R0o72PIvznWWOmjOj/FE3
         SsXorFaRT57g8d11sap/nnAvuVo/FxRunltRAhhi5NchyGxxAMaiPu9d4zBPLyuY1kNX
         il2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G+3IDjSQe5T10VvQiPvHkruTfhZCDaHQP43VPDmYK54=;
        b=VnV5/UnBXB5w0gqPiLvc+/1UFIFqfUm1IEhvsyDKs6ERYgYpmz1MH/JEkOgchy6l1w
         nCLiM+hENnPZ/e6Gn2eOkU5yId9xA8Iy1Z9QpIGg3hJ0frsIQp4mORtnzSHv+uHz5rSs
         v3pQZaKWOEHQJeGA4PdGZmNJaJhUjegzzouZvpiqn/AocYBvRmCsRsVX+xs07MSmQVzk
         rThuj/HTlEBPhnJwiSm2BOnSVX39I1kM942jlgw6IqklTw4lHNDOy/OsGuW/lbiK85KV
         vOiEV11BqNLyQuaMuK5ewrtZIZ3ZhKK6SWvPrsERvvp5KvizOsaXaywZIomD/rFufwHV
         SQIQ==
X-Gm-Message-State: AOAM533/i6AkChKROkdsT44pbctEuZeJ/reaTFHa+l4NeeQNujy6UJWN
        aM6VZS1NP7MH26g5Kc4BXR8xMEpE3Fw=
X-Google-Smtp-Source: ABdhPJyYJx833zFOzSVWomS3acnAcS+oW34Iz3pzV1ovicQc9QYaEhKOEwmBm50Nva3RBYLIqYsPgQ==
X-Received: by 2002:a63:7d58:: with SMTP id m24mr17701283pgn.81.1589892858921;
        Tue, 19 May 2020 05:54:18 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:2523:d194:de3b:636f])
        by smtp.gmail.com with ESMTPSA id q7sm9932171pgs.13.2020.05.19.05.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 05:54:17 -0700 (PDT)
Date:   Tue, 19 May 2020 05:54:15 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v5 06/10] mmap locking API: convert nested write lock
 sites
Message-ID: <20200519125415.GA189720@google.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-7-walken@google.com>
 <6a23fcce-181b-01ad-4a83-ea24d07ac724@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a23fcce-181b-01ad-4a83-ea24d07ac724@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 12:32:03PM +0200, Vlastimil Babka wrote:
> On 4/22/20 2:14 AM, Michel Lespinasse wrote:
> > Add API for nested write locks and convert the few call sites doing that.
> > 
> > Signed-off-by: Michel Lespinasse <walken@google.com>
> > Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Perhaps we could even move SINGLE_DEPTH_NESTING into the wrapper? It's unlikely
> there will be a new user with a different subclass?

I think I'll leave it in the API for now. I don't foresee new uses
being added as long as we stick to coarse mmap locking, but if
extending the api to support range locking it'd become more likely
that we'd want to lock multiple ranges for mremap...

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
