Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F481C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B3620899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590580264;
	bh=O1IhXKvulbbaTb2S/qFZhvTkhhxiyeByusPSy3+8X+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ia1bkvEz7ULsvHwKQtFpu33S58kxBYSCA0kPG0KBwReExOO1Uhig2EqhU/2h7/e/j
	 H+abfUmXVGbft3co/2r+21TcqZWbiTIju9QKrMarY7/g5SjTDCpg7vWYJ7x7AJanJy
	 pJMKxXBpKn54Mm6jVsbuf98zImkZLylMkh7nhVbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgE0LvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgE0LvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:51:02 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8844D207CB;
        Wed, 27 May 2020 11:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590580262;
        bh=O1IhXKvulbbaTb2S/qFZhvTkhhxiyeByusPSy3+8X+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E1buh6nfWyw2le+sjPSU+ott8HqQvdvVr4k55F/24YH+2Mg3djenF6k1RWcxZRdu2
         iaZCV9jtLzNmgZlVa35PVbmIgBeGQo2IYJQEnE4ZkwZMbuvxl66+NhiVnuj2PRFhkr
         JWVKJWksIVBkUn2TYQYr8NFTrB38H+2fYJfcpHwk=
Date:   Wed, 27 May 2020 12:50:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] driver/perf: Add PMU driver for the ARM DMC-620
 memory controller.
Message-ID: <20200527115057.GB13795@willie-the-truck>
References: <1589229894-18863-1-git-send-email-tuanphan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589229894-18863-1-git-send-email-tuanphan@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 01:44:52PM -0700, Tuan Phan wrote:
> DMC-620 PMU supports 10 total counters that are independently
> programmable for different events and can be individually started and
> stopped.
> 
> ACPI is only supported; device tree support is welcomed to be added and
> tested for other platforms.
> 
> Usage example:
>   #perf stat -e arm_dmc620_10008c000/clk_cycle_count/ -C 0
>   Get perf event for clk_cycle_count counter.
> 
>   #perf stat -e arm_dmc620_10008c000/clkdiv2_allocate,mask=0x1f,match=0x2f,
>   incr=2,invert=1/ -C 0
>   The above example shows how to specify mask, match, incr,
>   invert parameters for clkdiv2_allocate event.
> 
> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
> ---
> Changes in v2:
> - Removed IRQF_SHARED flag and added support for multiple 
> PMUs sharing the same interrupt.
> - Fixed an interrupt handler race condition.
> 
> The ACPI binding spec for PMU DMC620 is under beta and located
> in ARM server group under project "ACPI on ARM". 
> 
>  drivers/perf/Kconfig          |   8 +
>  drivers/perf/Makefile         |   1 +
>  drivers/perf/arm_dmc620_pmu.c | 869 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 878 insertions(+)
>  create mode 100644 drivers/perf/arm_dmc620_pmu.c

Given that this is Arm IP, it would be nice to have a review from somebody
at Arm. I have vague recollections of an internal DMC PMU driver too, but I
don't remember the details.

Will
