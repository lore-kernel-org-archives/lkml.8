Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB29C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE4A20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595240660;
	bh=W9TTx5jyCQo5ak9o/jP6CEx/Sr341WG69OjAm34Eqek=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=XM4jc/KJxwtxfWVYgaIYQJh+8Reh5awlP6jioFP8qlhhRoUKhNG5/+4bcbFr/K4aJ
	 AdOZSF96S/OvFz3Nlwti4UtI3KSquYrxTeAB8M6BwXt9KHR+A07RBfJ85iWuKYHwTp
	 drD16ceJf34zEeERDelgKi0RSBP9dua3T7f6YLzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgGTKYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbgGTKYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:24:18 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 533EE20773;
        Mon, 20 Jul 2020 10:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595240658;
        bh=W9TTx5jyCQo5ak9o/jP6CEx/Sr341WG69OjAm34Eqek=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=T4tSNOm0gskCRWVggXCfex1g0XU6SADjFV849ioJKi9OoLSDtZHkdljU5S3rFfdJt
         2h7jnhcXhQEuBT1vJUcdFV5HBphLs0LUZr6JqWGQP/R6IoyDMOGl5iMJbbCp5ZNkOf
         ZBoUFpYtFkqrcXdxdq0fXrkDKDG20qXO686m1Khs=
Date:   Mon, 20 Jul 2020 12:24:15 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
cc:     gupt21@gmail.com, benjamin.tissoires@redhat.com,
        linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: mcp2221: Replace HTTP links with HTTPS ones
In-Reply-To: <20200713082135.32350-1-grandmaster@al2klimov.de>
Message-ID: <nycvar.YFH.7.76.2007201224030.23768@cbobk.fhfr.pm>
References: <20200713082135.32350-1-grandmaster@al2klimov.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, thanks Alexander.

-- 
Jiri Kosina
SUSE Labs

