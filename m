Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B96EC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198E420B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595319551;
	bh=TYERl2SMOVxHa6xdDVBmiIMbf9QEZlOcozrjEFlYSH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XskRgZmO5i8jwQVplntU1bEFx+W4MAlzWgq5s/49IYLHc23nFyfB9oRzU41YDajaP
	 nNhkRYiuJQtwJLkw9KVEiI+t5TuM7kajMoTKeq/iy1GuSVGEW2/+vIbYCsqBv3Iy3c
	 sM0nOMCndB1I7Vnbij1RH2Ee/oiaImXIqFESxIj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgGUITJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgGUITJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:19:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93D5D20720;
        Tue, 21 Jul 2020 08:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595319549;
        bh=TYERl2SMOVxHa6xdDVBmiIMbf9QEZlOcozrjEFlYSH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QzFSRSDFZ0Zp2iih6yelFAtd5iZJmpwXhxa/zRyQwFwTY0xsOI3VXj4xmpBizWlg8
         Jh4c9pPcpQT01+M742B21N8pyazczeegGb/is9qviuh57Yrzrhox5D0MNtP5GkJJDM
         Z12Vu8ekMweEWT3G/PiYFW6u2yUYJqmpTGjtUyS8=
Date:   Tue, 21 Jul 2020 10:19:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v5 2/4] power: supply: core: add wireless charger adapter
 type property
Message-ID: <20200721081917.GC1655283@kroah.com>
References: <cover.1595301250.git.huangqiwu@xiaomi.com>
 <8a46e20d48d34f898b26cccfee562735894b08ae.1595301250.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a46e20d48d34f898b26cccfee562735894b08ae.1595301250.git.huangqiwu@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 01:59:35PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> Reports what type of wireless adapter connection is
> currently active for the supply.
> for example it can show if ADAPTER_PD capable source is attached.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
