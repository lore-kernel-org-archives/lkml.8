Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895D2C4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 23:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483DF2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 23:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584574044;
	bh=i6pGPorqV2nYmFtmC9QBp81f8cK8ZobRK54WOdgCcSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gnxHv/mWrK5Gy9t4mjTGqy6exL1jgzMCSfMpN2YafDmk9tp3G6DaZ13WA/YtQMcdf
	 LGQFfPuvObs3kL3sGrspavz6dfB2GhXNnE4FJWHVHtj/cE4XATSmKB3ezrLQ8XKA7x
	 RAw42WKAjCACjfPSLPHGWpJflJk9ljO3thTxPBbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCRX1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 19:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCRX1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 19:27:22 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 056EC20754;
        Wed, 18 Mar 2020 23:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584574042;
        bh=i6pGPorqV2nYmFtmC9QBp81f8cK8ZobRK54WOdgCcSs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P3bagWAUq1nf/cM2NTMdjQUYEkquTlKMy/F7QBP858wkJyKnm+o0apJRBJ1Py4foS
         4pjeYFgXkcseFBcOYkjnYvJYqkiBbqYlYhE/LTo9ffrdt7EgiVbtOyBm+5xzQp0uFt
         C0WYInv4ZBWDCnDzFSiWjFhDVDBgPEiJHdYzHyGA=
Date:   Wed, 18 Mar 2020 16:27:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thomas =?ISO-8859-1?Q?Hellstr=F6m?= (VMware) 
        <thomas_os@shipmail.org>
Cc:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, pv-drivers@vmware.com,
        Dan Williams <dan.j.williams@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        linux-graphics-maintainer@vmware.com,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: Ack to merge through DRM? WAS [PATCH v6 0/9] Huge page-table
 entries for TTM
Message-Id: <20200318162721.9b8a4d0ef7036ad93261f859@linux-foundation.org>
In-Reply-To: <9eb1acd3-cded-65f0-ed75-10173dc3a41c@shipmail.org>
References: <20200304102840.2801-1-thomas_os@shipmail.org>
        <9eb1acd3-cded-65f0-ed75-10173dc3a41c@shipmail.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Mar 2020 13:32:08 +0100 Thomas Hellstr=F6m (VMware) <thomas_os@s=
hipmail.org> wrote:

> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20
> Andrew, would it be possible to have an ack for merge using a DRM tree=20
> for the -mm patches?

Yes, please do.  It's all pretty straightforward addition of new
functionality which won't affect existing code.

