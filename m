Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C4CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 22:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2856924738
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 22:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592693406;
	bh=OSard3bu9eS3++LH0j4ZVd6z2ffYcvqxtIa3zeFGYpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oYftfVAs2lvF8SjJv9p2zg89cGt0Or+C8Xl2O5rXIFXC03HlX7ZgOjwySC/uCfd/t
	 +Qaki95RJI4P7Jyflw2yc+OHhVU6/Ka9ymjFvXrV3myng1H+wyG6Ahh5t63fhsuNB9
	 3ftMw4bJ121kBEtTEOSir8aSfELgnAbCu8OodfTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgFTWuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 18:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbgFTWuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 18:50:04 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F6E824733;
        Sat, 20 Jun 2020 22:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592693403;
        bh=OSard3bu9eS3++LH0j4ZVd6z2ffYcvqxtIa3zeFGYpo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fSXzxzEJG8Ha90DRN26xtroZknh+hk10BpFT8PRjIC+3S6vPXZu7yhvC0CsVhPWnG
         QxYwIBKRyRJFfgw9nJNNFE33Cq8UJRiA+OfAWSb7AgaK8bEwlze5x4vmXzgOnohnfz
         qglC0pZ9XVGrUw95zvMXn51j+Cd630FktWRjyPBc=
Date:   Sat, 20 Jun 2020 15:50:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 06/19] mm: memcg/slab: obj_cgroup API
Message-Id: <20200620155001.49de01dc8d84379d4557f113@linux-foundation.org>
In-Reply-To: <20200619213810.GA237539@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
        <20200608230654.828134-7-guro@fb.com>
        <CALvZod4hq5moKcb6f5L6VAS+v5+jKf8Hyd0gLotD7bMK7FsKgg@mail.gmail.com>
        <20200619213810.GA237539@carbon.dhcp.thefacebook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 14:38:10 -0700 Roman Gushchin <guro@fb.com> wrote:

> Andrew, can you, please, squash the following fix based on Shakeel's suggestions?
> Thanks!

Sure.  But a changelog, a signoff and an avoidance of tabs-replaced-by-spaces
would still be preferred, please!
