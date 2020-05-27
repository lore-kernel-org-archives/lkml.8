Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BABDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC28208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590567317;
	bh=IeNNmPjcTgw7gsx+2CfxhulT1t+d85+ymfBAlrXmt2M=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=glgrXSvs3WDGzgJU8T95UtU7u69aNt3OksiiNXcTZMuuI5amlSGbdC/6Feoz2Zbfa
	 BiWmbS1dP1RNMocE6p6VEJToFPF+hEafHyyBY7uwAkOo8Umq+Z6bozdvwFCqDzHK/y
	 3HblJjjoMEVy0N3ykm4Ew1cP4MXfOHV2kSikBHIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbgE0IPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387552AbgE0IPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:15:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7DAA21531;
        Wed, 27 May 2020 08:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590567313;
        bh=IeNNmPjcTgw7gsx+2CfxhulT1t+d85+ymfBAlrXmt2M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZYY6vnEV9kajxAkUARYha4A5QVEJ+Bth2Nr/ZyVfWBsCPJUstx2JO2wDFIbHBOKU6
         PfiItLUs2FJWoTrCqcLqIqugLsoZkkgVxIR5H/W7LeIjGa7B/LReGAiKRFd7LIhCDM
         DbYOfpppu4aS9seOltHF4HnvG19LMYaDbFV5FfAQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200408203616.4031-1-eajames@linux.ibm.com>
References: <20200408203616.4031-1-eajames@linux.ibm.com>
Subject: Re: [PATCH] clk: ast2600: Fix AHB clock divider for A1
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        joel@jms.id.au, Eddie James <eajames@linux.ibm.com>
To:     Eddie James <eajames@linux.ibm.com>, linux-clk@vger.kernel.org
Date:   Wed, 27 May 2020 01:15:13 -0700
Message-ID: <159056731319.88029.1548166710007070918@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eddie James (2020-04-08 13:36:16)
> The latest specs for the AST2600 A1 chip include some different bit
> definitions for calculating the AHB clock divider. Implement these in
> order to get the correct AHB clock value in Linux.
>=20
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Any Fixes tag for this patch? Seems like it is fixing something.
