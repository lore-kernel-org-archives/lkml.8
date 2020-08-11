Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EC5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6037F2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597112481;
	bh=HU0RLG4moDfMRlsMhMfGS7F281kMpizylGvKs2qA890=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Y52/OBtLga74ljecf2F4MFnyM7waOuQppVWEMfyyDG1U1IQrQnwQohJ9gZTNdgQBi
	 tYdK/q9RA1uAeuS5RzUN5kJkA1n8lY6VcXNRMUR5X1s/Pv1MGAP3eNYbSN30m9qBr+
	 ax0idrEz/m4YdcV2kmzziW7eY/2jScHMQVo+tkLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgHKCVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 22:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgHKCVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:21:20 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 376E1206DC;
        Tue, 11 Aug 2020 02:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597112479;
        bh=HU0RLG4moDfMRlsMhMfGS7F281kMpizylGvKs2qA890=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gYz3tdpYES59ro1cZ97vrJAQzeLwlHDeZOhKcJ7DNekx2+kaotF2mfR5AdLR5Iu8U
         /SMS6huxJx945h2reSvWrz6XAOXSKptdBVMxWPozVO9ku7jebtUdlRH9MItxgbZsFx
         TlgbS1AMQK/dXjzlQKfK9XLoYPgiOUrN9aumVyP8=
Date:   Mon, 10 Aug 2020 19:21:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        Baoquan He <bhe@redhat.com>, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v4 0/6] mm / virtio-mem: support ZONE_MOVABLE
Message-Id: <20200810192118.34a33d64e357ce5dd6f7614d@linux-foundation.org>
In-Reply-To: <baaf5992-cf43-69c1-7257-a5aa0a470ab8@redhat.com>
References: <20200804194142.28279-1-david@redhat.com>
        <baaf5992-cf43-69c1-7257-a5aa0a470ab8@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020 09:56:32 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 04.08.20 21:41, David Hildenbrand wrote:
> > @Andrew can we give this a churn and consider it for v5.9 in case there
> > are no more comments?
> 
> @Andrew, Ping, so I assume we'll target v5.10?

Yep, sorry.  Merging a significant patch series during the merge
window(!) would be quite extraordinary and I don't think that anything
in this patchset justifies such an action?

