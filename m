Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5980EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 11:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A04C21D43
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 11:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599651741;
	bh=LsZZCgcD9CKkSW0yTqr5sXk2HVFb9a1pnywslo7fZww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k55SMsN3ZAue5rninqo8iBJ3T6HQZQsZUJQjTDOsZAVhcAjTosHgoe9MQ8bOgaV1o
	 1ifoNh6ho8vmXTcfVI/r2aq/rxFp2uyuU9zNqPx8EzSogshkj5+gKgPIs9fnqViOqO
	 8vrFGDNPth/WElZH8OULzrFNUKwBjchzQNLlhdTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgIILmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 07:42:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729622AbgIILfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:35:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4F7C21D7B;
        Wed,  9 Sep 2020 11:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599650682;
        bh=LsZZCgcD9CKkSW0yTqr5sXk2HVFb9a1pnywslo7fZww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vIur60NMEckDbV+dW9IzqmRMhQRqdG47fgB2CmYQCO4frCQmILdcuxdpwkGsZk3Ut
         MS6De6rBF8MOvEMUxl1qnrdy7RKi7swqmuyJ5RTtCLEHXtSahUJ0SgRlkwtzGg3CC3
         aA8hRwkCVNcsZHlg/uAXJpPt5P+opjQ5xPXgy5RI=
Date:   Wed, 9 Sep 2020 13:24:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.8 101/186] drm/radeon: Prefer lower feedback dividers
Message-ID: <20200909112452.GA621541@kroah.com>
References: <20200908152241.646390211@linuxfoundation.org>
 <20200908152246.531365310@linuxfoundation.org>
 <77ec0338-32a1-6379-858c-359f636a0e58@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77ec0338-32a1-6379-858c-359f636a0e58@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 01:15:13PM +0200, Christian König wrote:
> Hi Greg,
> 
> please drop that patch. It turned out to break a lot of different setups and
> we are going to revert it now.

Ok, now dropped from all trees, thanks.

greg k-h
