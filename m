Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D5AC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24F220738
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598098902;
	bh=iOZfGBE0h3jxelwCCPCwiQUT0Y4ul5c/EvwS0sBHGtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nb4INOMn4XE1bzwUF3qMR6/l88Z6wlKOSPlDonP2kQhOLofO372+eMmEm9BbBUW3S
	 ARJaThVKt9tLsj2k2kwXqeViWklDv5RjPAlOm2SNjNcd9FwdjKnbwwvz6SmThynQEr
	 a6EHeqP3PECv68/qcPF1MO3rGrN1Zb24170lmzxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHVMVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 08:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgHVMVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 08:21:39 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 602BC20738;
        Sat, 22 Aug 2020 12:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598098899;
        bh=iOZfGBE0h3jxelwCCPCwiQUT0Y4ul5c/EvwS0sBHGtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cXyGyKKEX6nOHAhVSqDWT8vBxp2LWLe9nmyg4chMKAkIzSMXdlq6HmIK+mJ4d0J+U
         nJP+7Ym/asL12B2rH0drC9wdlCaOMo33KMedtnh3ZHtreTGEM4hCJjfnwDOIjl7CQo
         edL2nJ94x1JwCqmeaZ+VJA/8HuPrzj59Fj+mInHg=
Date:   Sat, 22 Aug 2020 20:21:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] =?iso-8859-1?Q?dt-bindings?=
 =?iso-8859-1?Q?=3A_arm=3A_fsl=3A_Add_Y_Soft_IOTA=A0Orion?= board
Message-ID: <20200822122118.GH27575@dragon>
References: <1596196808-5067-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1596196808-5067-1-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 02:00:06PM +0200, Michal Vokáč wrote:
> Add devicetree binding for Orion - new board variant in the Y Soft
> IOTA family.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Applied all, thanks.
