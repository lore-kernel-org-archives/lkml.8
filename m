Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3897C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B890020838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596125116;
	bh=MHtJqtDF1W7U4ka9bGX0G01s5lGqfJbho1plbT8mKIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZrB9XRLLUkiqLbASC8ynDx/2IwzUNbjDBmLjGRkz++Cm0kRkEdtg+zSzTvEL2kDhy
	 uTHQ/dFxtjlFxr2KqAYtwjfzNsbyb6QIte4ROIJtBOXqJBk8HdTaSXSwNayaPx1SMS
	 2qToQtChTIk/NbumALchMCPin1P+XboRHNB/ViRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgG3QFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3QFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:05:15 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1319520829;
        Thu, 30 Jul 2020 16:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596125115;
        bh=MHtJqtDF1W7U4ka9bGX0G01s5lGqfJbho1plbT8mKIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dqqV3hw8tRT3kg/w0z6FolLJ4qWjcKOuHsPt0zps88MxuXvB2yJVdl9qk90ljJoWF
         rZ1zVMxcYomhfKaPHtFiMvELW5yU/yrS7mBsx9ytffQR9+n5N5sWT+GLBEhsyt0PxC
         zMhaKU0fw/9OL7fTpIh2sgsWwibDHlrQWH5KF62A=
Date:   Thu, 30 Jul 2020 17:05:11 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     mark.rutland@arm.com, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Include drivers subdirs for ARM PMU
 PROFILING AND DEBUGGING entry
Message-ID: <20200730160510.GC24716@willie-the-truck>
References: <1592392648-128331-1-git-send-email-john.garry@huawei.com>
 <20a647e7-a6ab-7cf1-743d-a3173cafe45f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20a647e7-a6ab-7cf1-743d-a3173cafe45f@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 09:03:02AM +0100, John Garry wrote:
> On 17/06/2020 12:17, John Garry wrote:
> > Ensure that the ARM PMU PROFILING AND DEBUGGING maintainers are included
> > for the HiSilicon PMU driver.
> 
> Just a reminder in case this minor patch was missed...

Sorry, yes, somehow this had slipped through the cracks. I'll grab it now
(and thanks for the ping).

Will
