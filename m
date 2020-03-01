Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D69C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 04:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89212468A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 04:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583035553;
	bh=20MqpFduH4Yl09TpISx6BGkF4F/yDWcGfG8B8oZhyWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yHV2GfKW6GPdy2UFgsdQNEit1Q0nkCPuXo6qNn4BlxLu0HaHr5hwsmDtFLbbG1YiD
	 5ecsI8S3H16sdgajGa43o9PwWvuggZEUMlvnz09vutxtgTmsP99VtyXHGA4Mj2OAka
	 SdqdSs7CIvaergdWbYtcXK+FHbFFdLrTpvWb103Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgCAEEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 23:04:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbgCAEEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 23:04:51 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BBA22467B;
        Sun,  1 Mar 2020 04:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583035489;
        bh=20MqpFduH4Yl09TpISx6BGkF4F/yDWcGfG8B8oZhyWU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RQ2L3r9aUbLtxjIZmD88dbsQE5x7imWuEOkKxR/vnHkEmEzvwwMiVPMEFBgObbTAY
         ytSa88dMNKJiYl9DJEZPlFkgf4D0mU6HWAkDfOVJPmWhn5CfMhXhBGDY9cQaKN/Yw+
         eeyNXvJ8s4Ii6F3dnY0/nCEZafTk3jbwmmTb++dU=
Date:   Sat, 29 Feb 2020 20:04:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thomas =?ISO-8859-1?Q?Hellstr=F6m?= (VMware) 
        <thomas_os@shipmail.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 0/8] Huge page-table entries for TTM
Message-Id: <20200229200448.bd54259264ea12983ea3983a@linux-foundation.org>
In-Reply-To: <20191203132239.5910-1-thomas_os@shipmail.org>
References: <20191203132239.5910-1-thomas_os@shipmail.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Dec 2019 14:22:31 +0100 Thomas Hellstr=F6m (VMware) <thomas_os@s=
hipmail.org> wrote:

> In order to save TLB space and CPU usage this patchset enables huge- and =
giant
> page-table entries for TTM and TTM-enabled graphics drivers.

Have these savings been measured?  They shouild be, please.  And
documented in this changelog!
