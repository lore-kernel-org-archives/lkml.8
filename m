Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF6FC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74826206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584426959;
	bh=D4MtuvsjHkebm/CoE5MTz+RywaOPJ+VFWURFwbwhTbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t9CBNBu1zI0SbBWbZqvi03vudlUbnZQiP2Kaqao4T73XkE7RU5hLRpfn6EpO7gNLJ
	 u/7DJksMTAKq6JVacCdXGaEHP1YAO0ggTxDtiWiabXULS6VLrADsoiBVMhoYZ/Xqa6
	 KTUjpFKMA28AR3AiTk/4+slUJ40Lmpi2UJBxssXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgCQGf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQGf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:35:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 387F220674;
        Tue, 17 Mar 2020 06:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584426957;
        bh=D4MtuvsjHkebm/CoE5MTz+RywaOPJ+VFWURFwbwhTbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f65z0SLRVn5xIg/QuAxS209aLQ3pvoig5aPPmNQehJeDJbqie0dEmd5qgETxQygvQ
         Ekh+VjNOETTU/YlghtYfFV/3YzcHD4mCvZDKcJXcDQdvhwNS1OnFdKLqLLX86bVdTK
         0S0/fy+USH4k5PuJlnwEVVNgMHD6zY8gyni6zTkM=
Date:   Tue, 17 Mar 2020 07:35:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jeffy Chen <jeffy.chen@rock-chips.com>
Cc:     linux-kernel@vger.kernel.org, anders.roxell@linaro.org,
        arnd@arndb.de, sboyd@kernel.org, naresh.kamboju@linaro.org,
        daniel.lezcano@linaro.org, Basil.Eljuse@arm.com,
        mturquette@baylibre.com, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] arch_topology: Fix putting invalid cpu clk
Message-ID: <20200317063546.GA1052866@kroah.com>
References: <20200317001829.29516-1-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200317001829.29516-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 08:18:29AM +0800, Jeffy Chen wrote:
> Add a sanity check before putting the cpu clk.
> 
> Fixes: 2a6d1c6bcd1f (“arch_topology: Adjust initial CPU capacities with current freq")

Don't you mean:
	Fixes: b8fe128dad8f ("arch_topology: Adjust initial CPU capacities with current freq")

