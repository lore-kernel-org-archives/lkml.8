Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC53C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A2AB20702
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594631427;
	bh=NUBsvSsCn9fRNSrZv4S6qyVdDe0CKPjxJVWKMmysE5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2uFaI/m9FuI6Vr12eNWcbTRt2XEpC6D88lg21pC2jppzHhTkKIAbCgMLaTZR5AFep
	 /rkFcEAqcpQMlF6nVDkAhXmIKsR48iPTTTpOtFLvI8GOMXmulbg9h6K7mzyTaMblTh
	 wfuGQXihdrQGghQKpIUkuW/tIrbAicAB6l0ToPKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgGMJK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgGMJKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:10:25 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C119D2067D;
        Mon, 13 Jul 2020 09:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594631425;
        bh=NUBsvSsCn9fRNSrZv4S6qyVdDe0CKPjxJVWKMmysE5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjonRwuLMPHDUndJak24CEdmLkQQSCvIVVbk+1Y92lX+4HK4WH4ehFtNqMrLLqWUo
         4NMbRw2K1uHtuvYz3orzGTkH1zg2KiCqQ8bczSyA7xadhn10pf9oJGNVcYMd36NUrV
         ju0CtxufFgX+rrdYXypU/mJE1yFVvRFVPL84hmIw=
Date:   Mon, 13 Jul 2020 17:10:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chris Healy <cphealy@gmail.com>
Cc:     s.hauer@pengutronix.de, stefan@agner.ch, festevam@gmail.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, andrew.smirnov@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: vf610-zii-spb4: Add node for switch watchdog
Message-ID: <20200713091019.GK15718@dragon>
References: <20200712080357.3586-1-cphealy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712080357.3586-1-cphealy@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 01:03:57AM -0700, Chris Healy wrote:
> Add I2C child node for switch watchdog present on SPB4
> 
> Signed-off-by: Chris Healy <cphealy@gmail.com>

Applied, thanks.
