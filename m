Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB112C3F2D3
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 04:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B7821D56
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 04:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583035486;
	bh=0JNvEb3Oe9lLFf2wYJ8fkwfOXwpITMyBmYV9rpsUprQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aQTNHr1LyYJo/wlbV995+7zOP2OncNIHtG5QgsvQcQ116mKtPWEmlXg8/YDxO4tRQ
	 AM7r9aWBvfy5+RPbpla8eL/HXH64K2qm1nPLdMIlc5iBRjZbirZV14EaMjqEwJuTCB
	 QKVsrPAoil15toxyYyVe1EEGf1SfQHYDBYcQTUks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgCAEEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 23:04:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbgCAEEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 23:04:33 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C34BE20658;
        Sun,  1 Mar 2020 04:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583035473;
        bh=0JNvEb3Oe9lLFf2wYJ8fkwfOXwpITMyBmYV9rpsUprQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QPAM2InIOtf/BTM0mPFNHD4Eb/MLJlhIH6jVAWt0uUInAhIawWsbRac58Nc+GgYTi
         M9MVw6eqShud7jv5/E1kK+S0i8o9ir9g5e/3olstbMtBoHB1cmp1T7A/b/Zspds5DN
         7TwRnQgkVa5KL9fUgefgyShO2VI5HnyBh2AF2gd8=
Date:   Sat, 29 Feb 2020 20:04:32 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thomas =?ISO-8859-1?Q?Hellstr=F6m?= (VMware) 
        <thomas_os@shipmail.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>, pv-drivers@vmware.com,
        Dan Williams <dan.j.williams@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        linux-graphics-maintainer@vmware.com,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 0/9] Huge page-table entries for TTM
Message-Id: <20200229200432.55b5b64f46dc2f2f80fa7461@linux-foundation.org>
In-Reply-To: <cc469a2a-e31c-4645-503a-f225fb101899@shipmail.org>
References: <20200220122719.4302-1-thomas_os@shipmail.org>
        <cc469a2a-e31c-4645-503a-f225fb101899@shipmail.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 14:08:04 +0100 Thomas Hellstr=F6m (VMware) <thomas_os@s=
hipmail.org> wrote:

> I'm wondering what's the best way here to get the patches touching mm=20
> reviewed and accepted?
> While drm people and VMware internal people have looked at them, I think=
=20
> the huge_fault() fallback splitting and the introduction of=20
> vma_is_special_huge() needs looking at more thoroughly.
>=20
> Apart from that, if possible, I think the best way to merge this series=20
> is also through a DRM tree.

Patches 1-3 look OK to me.  I just had a few commenting/changelogging
niggles.
