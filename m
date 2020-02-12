Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5940DC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2188320659
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6rLVHGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgBLM6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:58:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27613 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726728AbgBLM6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581512291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WNE9XiYfIRFh5LYCvgVuz7J2bfIjYJxs9twoYqkH1vE=;
        b=B6rLVHGrult10fEy9RK0Vcx6KCvD4yIlOFG6NwJfU+QAtVTKF9HIqurSDoagx9oRuhmwAe
        oO8tDMozVSZnL28ujrjZ4aVktqrwio4jTrwTMta4kwjR9z0DkHCwjMc4c19kO2U/YMZNm5
        6+6AxMjn8XgN9v9XM/2dAgWxw+XlDxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-GUBT95-nNVi27y58GnvC5Q-1; Wed, 12 Feb 2020 07:58:03 -0500
X-MC-Unique: GUBT95-nNVi27y58GnvC5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04ABD108F25C;
        Wed, 12 Feb 2020 12:58:02 +0000 (UTC)
Received: from mail (ovpn-122-89.rdu2.redhat.com [10.10.122.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 733DC5DA7B;
        Wed, 12 Feb 2020 12:57:58 +0000 (UTC)
Date:   Wed, 12 Feb 2020 07:57:57 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Jon Masters <jcm@jonmasters.org>,
        Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: tlb: skip tlbi broadcast for single threaded
 TLB flushes
Message-ID: <20200212125757.GD3699@redhat.com>
References: <20200203201745.29986-1-aarcange@redhat.com>
 <20200203201745.29986-3-aarcange@redhat.com>
 <20200210175106.GA27215@arrakis.emea.arm.com>
 <20200210201411.GC3699@redhat.com>
 <20200211140025.GB153117@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211140025.GB153117@arrakis.emea.arm.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Feb 11, 2020 at 02:00:25PM +0000, Catalin Marinas wrote:
> I think there is another race here. IIUC, the assumption you make is
> that when mm_users <= 1 && mm_count == 1, the only active user of this
> pgd/ASID is on the CPU doing the TLBI. This is not the case for
> try_to_unmap() where the above condition may be true but the active
> thread on a different CPU won't notice the local TLBI.

The "current->mm == mm" check is what shall prevent the above.

Thanks,
Andrea

