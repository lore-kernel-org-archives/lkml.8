Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E001EC3F2D0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC7C24686
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583841205;
	bh=9Dqcrvid3TzQgZ9K1Vvw91iUzAv4QQy5lINcNKCa/so=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=VOQ6m0eJkLuhl35eycCTwyQIL5izgyr2V4y2RXV0z02IawdV2HBc8h+/IywWhjAHW
	 bdAnmk3tzNiVWInSoU20DMgS51CLSKELR+MTLr+BqPv6DUe6sP9VpWtl8mrxAHKNq0
	 +aN2tbXqe98CpR8QhXtbrsD9GyQ1d940Vd+W6Ik4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgCJLxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgCJLxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:53:24 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2514524680;
        Tue, 10 Mar 2020 11:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583841204;
        bh=9Dqcrvid3TzQgZ9K1Vvw91iUzAv4QQy5lINcNKCa/so=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=sjCiWvrQsolPGGawdf8DitKDpTSHdufJ9q+aIS3KMYbySomPXkCgOtBchAWe09kWT
         paeMlaX3QMSvoon7YaHpUFg2Zm3VcIqdZGYsNh3YEdUsGv8C4dYcPyvWeOhmhmZbl4
         R1OvSiEkS5OqQly2085o8KQu/CmwGsBrKFH5wzR8=
Date:   Tue, 10 Mar 2020 12:53:21 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Tony Fischetti <tony.fischetti@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add ALWAYS_POLL quirk to lenovo pixart mouse
In-Reply-To: <20200304164700.11574-1-tony.fischetti@gmail.com>
Message-ID: <nycvar.YFH.7.76.2003101251500.19500@cbobk.fhfr.pm>
References: <20200304164700.11574-1-tony.fischetti@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020, Tony Fischetti wrote:

> A lenovo pixart mouse (17ef:608d) is afflicted common the the malfunction
> where it disconnects and reconnects every minute--each time incrementing
> the device number. This patch adds the device id of the device and
> specifies that it needs the HID_QUIRK_ALWAYS_POLL quirk in order to
> work properly.

You are missing Signed-off-by: line here (please see 
Documentation/process/5.Posting.rst and 
Documentation/process/submitting-patches.rst to read what this is about).

Also, we generally prefix all the patches to HID susbsytem with 'HID: ' in 
the subject / shortlog, so as you'll be resending with signoff, could you 
please fix that up at the same time as well?

Thanks,

-- 
Jiri Kosina
SUSE Labs

