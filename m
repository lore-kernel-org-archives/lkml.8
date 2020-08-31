Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93AAC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE5A208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598864509;
	bh=V1Kdqp3MpKk7bBynwA3RtEMJuXa5+xTQus1ipqhPoSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fFT9IHq7CTOeIHcrih7kXHBjTdx2irPIKNoffiHElBQsm7SQ0fQ2241Tpw56JiFvk
	 AYCZvwdJLKEUxzS1RqiRXIfBHVuzECpd+/fXix29D8KoUKUx+4YYG2ow/fh7mUj1Go
	 ghN5OK5V/st4BxXmvkY0dtXyKdhW4ClgNWG/hRlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgHaJBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:32960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgHaJBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:01:47 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BC29208CA;
        Mon, 31 Aug 2020 09:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598864507;
        bh=V1Kdqp3MpKk7bBynwA3RtEMJuXa5+xTQus1ipqhPoSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OaIMR658zsshmyKulJQyWNx9Mh0wDURnx4zzh7O387ZirDRF4I9i1LWdmgk0VdPWj
         urCCWeXhhPn98Hfyi+edpmF2PTQqcKvnYtSDwXP9Jb1zr/mTWTnjGVXwhcpM4wozbQ
         ierAPM9gnDejouvYdvBOO3f+fKUbc5a+o7OcaYLE=
Date:   Mon, 31 Aug 2020 14:31:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     kishon@ti.com, nsekhar@ti.com, vigneshr@ti.com,
        jan.kiszka@siemens.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] phy: omap-usb2-phy: Errata and coding style fix
Message-ID: <20200831090142.GI2639@vkoul-mobl>
References: <20200824075127.14902-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824075127.14902-1-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-08-20, 10:51, Roger Quadros wrote:
> Hi,
> 
> This series addresses silicon errata
> i2075 - "USB2PHY: USB2PHY Charger Detect is Enabled by Default
> Without VBUS Presence"
> 
> It also fixes coding style issues.

Applied, thanks

-- 
~Vinod
