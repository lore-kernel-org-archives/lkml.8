Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380B0C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0671620752
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584755916;
	bh=YEVYwaejFBzGEXNFaWiuLbxaJ4BGLIC5QyGZnjM/uo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zGO7NHjtQSDtneYBJwNtwv4y4p0Ob/GXbUzxnaKVE7RwYPZ+oqwPqZmSKoDnjr5fp
	 wXn/FUnFRqYx3fntPDclbPALnnIVhC7Zl0qZWOZBZGI7KpTYsKZ0lFXLdSssG4gTvg
	 erxU2/0KtHmP+oUNJfYHoj+kD4/sSA0iL94hg5G0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgCUB6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 21:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgCUB6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:58:31 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 230C120732;
        Sat, 21 Mar 2020 01:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584755910;
        bh=YEVYwaejFBzGEXNFaWiuLbxaJ4BGLIC5QyGZnjM/uo0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RZBrwTSPlNUeboMWDgxFW9/pgAyKTv7Gm65/9TZYqo4ptZco9VEBv8l6Zy+4cM+Pz
         +uW9uwS1Fw99/2H+5V1rLO1p1+Gx2g9+vL3832F6xKwF/XI58HVnn4IrgpwkQ6CGrq
         r4Ytpzf2jx53HjebxJSlXnwiE12m7WCG5ocoakYA=
Date:   Fri, 20 Mar 2020 18:58:29 -0700
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
Message-Id: <20200320185829.2e4fc07db5610999e7b32d7e@linux-foundation.org>
In-Reply-To: <5054bb71-b5b4-11a9-1c4e-487a7adf3177@shipmail.org>
References: <20200304102840.2801-1-thomas_os@shipmail.org>
        <9eb1acd3-cded-65f0-ed75-10173dc3a41c@shipmail.org>
        <20200318162721.9b8a4d0ef7036ad93261f859@linux-foundation.org>
        <5054bb71-b5b4-11a9-1c4e-487a7adf3177@shipmail.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Mar 2020 11:20:44 +0100 Thomas Hellstr=F6m (VMware) <thomas_os@s=
hipmail.org> wrote:

> On 3/19/20 12:27 AM, Andrew Morton wrote:
> > On Mon, 16 Mar 2020 13:32:08 +0100 Thomas Hellstr=F6m (VMware) <thomas_=
os@shipmail.org> wrote:
> >
> >>> _______________________________________________
> >>> dri-devel mailing list
> >>> dri-devel@lists.freedesktop.org
> >>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >> Andrew, would it be possible to have an ack for merge using a DRM tree
> >> for the -mm patches?
> > Yes, please do.  It's all pretty straightforward addition of new
> > functionality which won't affect existing code.
>=20
> Thanks Andrew. Can I add your Acked-by: To the mm patches for Linus'=20
> reference?
>=20

Please do.
