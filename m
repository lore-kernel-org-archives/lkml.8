Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D362C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6946120731
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="SuIpP+w+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgDMJtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728015AbgDMJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:49:41 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 05:49:41 EDT
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44430C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:42:05 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id v9so1494514ljk.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5EVtSWTpW2gBZAVG9ya8rnghhWuRsTFGgq4qSDI6w6g=;
        b=SuIpP+w+r+qMR9OHa1Bp4wwQC6uIAMRhhzW1Rxk6cHq3gO6nqkA/hulf5DEzztSqHj
         wJGe77kLD8NMfLQM2zJFSUm87BD9GW75pydTfyd8u5BIoeV6jtQXVV2/pHN2Ht9uU023
         y/i/hZ7v/Hf4OlnIWGwLF9DBtOGONHZQ/Cg6tUC0fKaFhcdewe1idzlJfSm6ZGvqXG0Z
         W2ZjDUDM39RS8HYJty0vc8/pmg/NR79rTnfgHGb1Eb2QCUFdazEtbTlht6CzuAdoHpyo
         XRgBuPYVHrBfi/+Yira39hWBe8qpUKC3Vx2kOh3x+YSo0wLceegv8XcUif+My7kdIy5e
         gWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5EVtSWTpW2gBZAVG9ya8rnghhWuRsTFGgq4qSDI6w6g=;
        b=Qj8vB+toSvTsIh95m8KIIED2q2uUY7mjmuGlj9OcqcbTne0sKEaVGjuyZK8byivU5d
         s9gE9WNbXso92n+5B6oXEHjbNQ6W612ubMp1zE789ut0/fVA2UvIAhQsq3atYNe96Hzy
         bw+DPR2wLyAg0ZF9isA1XIzx1oQledYgbwYgfFcgBkdIULzT7NEJoKM5UFxhqWC2+JvP
         hSl6AMPFYMN8M/GOryA9QA2B5WyQpRULGLGYPjZkntJhJbliGFzLARSPyi6PC9UFPgnl
         XOiw2W9v432JBcBEAM2iGdcoQmNgfQbK6SKOytpMVu4SL45wx6fjQaXmvaLbhPEQulRb
         TzMg==
X-Gm-Message-State: AGi0PubAks3HqZEMhIJGwIZdZCI1vKEXnOHli2Whbn+r7Jg87irBp+f9
        7/xbDuX9+3M3oNFpljicdGhv3g==
X-Google-Smtp-Source: APiQypIyIFcgHREegUey45rm8BQoRKlq4QMlIcs+yf0PgL2iZ92N/aJM6blxjp3mghWys2omt9d82w==
X-Received: by 2002:a2e:140d:: with SMTP id u13mr1384446ljd.152.1586770923586;
        Mon, 13 Apr 2020 02:42:03 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a15sm6720609ljp.44.2020.04.13.02.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 02:42:02 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7840210230F; Mon, 13 Apr 2020 12:42:04 +0300 (+03)
Date:   Mon, 13 Apr 2020 12:42:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 5/8] khugepaged: Allow to callapse a page shared across
 fork
Message-ID: <20200413094204.a2gpsjhugy5dznjy@box>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-6-kirill.shutemov@linux.intel.com>
 <5a57635b-ed75-8f09-6f0c-5623f557fc55@nvidia.com>
 <20200410155543.i66uz6pbynfvkhak@box>
 <df772934-b5e5-8578-9b47-3f17bf9b8896@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df772934-b5e5-8578-9b47-3f17bf9b8896@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 01:59:22PM -0700, John Hubbard wrote:
> I think I understood what you were saying. The problem is that was ignoring
> a couple of points, especially in an RDMA situation: 1) the page can be
> pinned by various drivers, on behalf of other processes, even if the original
> process is being torn down, and 2) it doesn't really matter which process pins
> a page--the end result is that it's pinned.

Well, no. It is critical that nobody gets new pins after this point on
behalf of *this* process as we about change what is mapped on this virtual
address range. We must avoid the situation that khugepaged screws
legitimate GUP users and make what process see differs from what GUP see.

Pins on behalf of other processes after the point are not relevant to us.

I will keep the comment as is for now. As you can see I'm struggling
communicating my point. Any better wording is welcome.

-- 
 Kirill A. Shutemov
