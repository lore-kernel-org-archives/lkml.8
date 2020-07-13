Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADF1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29ABE2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594613598;
	bh=sjIr7qNn8Hd9iJBnNiQpe4AvTa3VFSgoqkSuFvHUPWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hvu+yBWutd/NcV0JJd3c0aH/0ogP51jWo3lklHqKNcyQcPKLu+WmPW46IBo33DxX2
	 cM2KH3b2gbw6YLNYNlesKly7V4KuEkseQ0v/Qdymxlq71WqWlmRNZU9/r1UqO6WEmq
	 8UgG3sCe+iUNvzq+yYZgEcWPGOajwwIE4yUnxA9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgGMENR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 00:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgGMENQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 00:13:16 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EC502070B;
        Mon, 13 Jul 2020 04:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594613596;
        bh=sjIr7qNn8Hd9iJBnNiQpe4AvTa3VFSgoqkSuFvHUPWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGDzSoUXOoGe9dfOFkAifGVOW2YyxolW8dy9oeG1NiJkt6bEXeV6p+U2Nl55eC1Wg
         s6nzseWUajiviLsci4x8KVHqtVwEOJbewGg5ah7YJC0sC0DCCdNZdaYFEX+1IMW9Dk
         VE5WPD/I6ER8DWYADGDuxtVdn5zBzqkKehz0qoDw=
Date:   Mon, 13 Jul 2020 12:13:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH] arm64: defconfig: enable RTC and audio support on
 Kontron sl28 boards
Message-ID: <20200713041311.GD12113@dragon>
References: <20200703221143.31839-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703221143.31839-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 12:11:43AM +0200, Michael Walle wrote:
> Although the Kontron SMARC-sAL28 board is now supported, there is still
> missing driver support for the hardware clock, audio interface and audio
> codec. Let's enable them as modules (where possible).
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks.
