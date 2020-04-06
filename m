Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A5FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FED206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586165982;
	bh=PikeJ5lzCSAMVRBCATXOBgcLG2zweYuCpVoiEok4wEk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=wXz7epJYbYip5TnaS3L57ZwBWoXsFlETchoEQXMn94nQGWyx3BRu9x7uQ60LyXW36
	 jBD0u4kkdalfQz6ujzluxZoB98yfuDG0EzkV5L7Lk4R6dbripoGJJbbW/O59L+a/q8
	 LmmRz5GpH2GgBaE8zIubab9/0vlVnf/uGQ8KkFU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgDFJjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbgDFJjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:39:41 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AD1E2051A;
        Mon,  6 Apr 2020 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586165981;
        bh=PikeJ5lzCSAMVRBCATXOBgcLG2zweYuCpVoiEok4wEk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Q79fDb9816pwefVgZqGCzkVSc3UEqEcUrZqBkY/n4WIQoXXPJWqZAjRb9nHHAvupZ
         EOd1cVS0qOZaJuA9PWki3eJvwzhTgMeOv9z5xI+7wCFeuKiDN0Dt64FBZjroZkdSZk
         NraJfMRq7MkYo4ACQronwDlz45t180DPSMdDBS6c=
Date:   Mon, 6 Apr 2020 11:39:38 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@archlinux.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: logitech: drop outdated references to unifying
 receivers
In-Reply-To: <20200112235009.4074405-1-lains@archlinux.org>
Message-ID: <nycvar.YFH.7.76.2004061139270.19713@cbobk.fhfr.pm>
References: <20200112235009.4074405-1-lains@archlinux.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2020, Filipe Laíns wrote:

> The hid-logitech-{dj,hidpp} were originally developed for unifying
> receivers but since then they have evolved and now support other types
> of receivers and devices. This patch adjusts the original descriptions
> with this in mind.
> 
> Signed-off-by: Filipe Laíns <lains@archlinux.org>

Applied, thanks Filipe.

-- 
Jiri Kosina
SUSE Labs

