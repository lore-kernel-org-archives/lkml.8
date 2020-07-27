Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E88C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C088208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbgG0QfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbgG0QfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:35:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FBEC061794;
        Mon, 27 Jul 2020 09:35:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 77A29261235
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.7 024/179] dm mpath: pass IO start time to path selector
Organization: Collabora
References: <20200727134932.659499757@linuxfoundation.org>
        <20200727134933.846667790@linuxfoundation.org>
Date:   Mon, 27 Jul 2020 12:35:13 -0400
In-Reply-To: <20200727134933.846667790@linuxfoundation.org> (Greg
        Kroah-Hartman's message of "Mon, 27 Jul 2020 16:03:19 +0200")
Message-ID: <87sgdcuda6.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> From: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> [ Upstream commit 087615bf3acdafd0ba7c7c9ed5286e7b7c80fe1b ]
>
> The HST path selector needs this information to perform path
> prediction. For request-based mpath, struct request's io_start_time_ns
> is used, while for bio-based, use the start_time stored in dm_io.

Hi Greg,

This patch is not -stable material.  It is only needed for a new feature
merged in 5.8.

Thanks,

-- 
Gabriel Krisman Bertazi
