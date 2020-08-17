Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B62BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 458B0206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597657972;
	bh=qLTRMIY8cVO92KvoaaKAi1t8PlSQ8ifbvEEXAie5+F0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=WH3PoIuQLcaK1yW9ABhMDQPsjdu4l6JaX/vV3cfxU8cLh2NN8C5tivW/BuCnu1GVs
	 yIsUbIwcwVNREWCMMskKTSMxQ/Pvwx85czIbxkqeQt9jQm/fh+xIBvZ1WGU5x2APoy
	 suLpofCropczPyqK0D50JvI14N8Y833j8MJ696s8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgHQJwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgHQJwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:52:46 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BC79206C0;
        Mon, 17 Aug 2020 09:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597657966;
        bh=qLTRMIY8cVO92KvoaaKAi1t8PlSQ8ifbvEEXAie5+F0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=mQa7dGs8P1Q7SF9e9hg44t/y8o5DgLBL2Ge8akv+ciHQzzPIu4Pbm0RjZOhWHGZtD
         epc4Z6cfQXP3x+lmeWiOawgeiMoL5d1HVfdJklsdXzBvCFrhypjF0pdQUxJZzVGpp+
         n9UJ/qLEy2pZROVzKBpW1BQ+qZiJqJxEibJi9JfQ=
Date:   Mon, 17 Aug 2020 11:52:43 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmlambea@gmail.com,
        alexhenrie24@gmail.com
Subject: Re: [PATCH 0/2] HID: Constify static struct hid_device_id
In-Reply-To: <20200727132200.32510-1-rikard.falkeborn@gmail.com>
Message-ID: <nycvar.YFH.7.76.2008171152360.27422@cbobk.fhfr.pm>
References: <20200727132200.32510-1-rikard.falkeborn@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020, Rikard Falkeborn wrote:

> Constify hid_device_id in two drivers (these were the only drivers that
> didn't already have it as const).
> 
> Rikard Falkeborn (2):
>   HID: cougar: Constify cougar_id_table
>   HID: macally: Constify macally_id_table
> 
>  drivers/hid/hid-cougar.c  | 2 +-
>  drivers/hid/hid-macally.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied both patches, thanks.

-- 
Jiri Kosina
SUSE Labs

