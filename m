Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F07C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE0220787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585728667;
	bh=echul4ZpeLSO1wDA6PEQDmeER38mQ9xHhNHK3mPtYmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Em/jwa+XxHnku7GZozI/Zo+Y5TomyjQfM26ewR9F3kJPGvUxP/oogF7h5nlOlJNGj
	 PNVQ3sjLI686uX1XzX745RBsBAaWeZPsKtnR/nDTYoNyj8Da1FfTZ2B6YrCXhNeV7J
	 1w64759VmEskMk8sxzSrI7vUw1/fjV7nBlX55FCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbgDAILG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:11:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731680AbgDAILG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:11:06 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C241D20772;
        Wed,  1 Apr 2020 08:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585728665;
        bh=echul4ZpeLSO1wDA6PEQDmeER38mQ9xHhNHK3mPtYmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tpgJstkdcTa8o/dqhGiIxpztnW65cbVsfDgyC5aqvIbXgG2TrT6Oqhwwv+2jidGgA
         wB7KTVZogjFaEjw66WjEAToGax12hMpVXwhHtZiFH8xdTOJZt39yYg4hOHFLuKzuqy
         ygZs30jkuw1kStuH5zDFlrNa7DsHerRORGpJbH18=
Date:   Wed, 1 Apr 2020 09:11:01 +0100
From:   Will Deacon <will@kernel.org>
To:     Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Tuan Phan <tuanphan@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] driver/perf: Add PMU driver for the ARM DMC-620 memory
 controller.
Message-ID: <20200401081100.GC15950@willie-the-truck>
References: <1584491381-31492-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200319151646.GC4876@lakrids.cambridge.arm.com>
 <23AD5E45-15E3-4487-9B0D-0D9554DD9DE8@amperemail.onmicrosoft.com>
 <20200320105315.GA35932@C02TD0UTHF1T.local>
 <A50AA800-3F65-4761-9BCF-F86A028E107D@amperemail.onmicrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A50AA800-3F65-4761-9BCF-F86A028E107D@amperemail.onmicrosoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 03:14:59PM -0700, Tuan Phan wrote:
>    Hi Mark,
> 
>      On Mar 20, 2020, at 4:25 AM, Mark Rutland <[1]mark.rutland@arm.com>
>      wrote:
>      On Thu, Mar 19, 2020 at 12:03:43PM -0700, Tuan Phan wrote:
> 
>        Hi Mark,
>        Please find my comments below.
> 
>      Hi Tuan,
> 
>      As Will said, *please* set up a more usual mail clinet configuration if
>      you can. The reply style (with lines starting with '=>') is unusual and
>      very painful to spot.

Seriously, this is unreadable now. *Please* fix your mail client.

Will
