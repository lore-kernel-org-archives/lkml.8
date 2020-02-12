Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A8C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C3721734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581550252;
	bh=we5n/gcqUjIvedGn0eRQwQef3T06WrtffLUf78P4t3Q=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=QwEP/DobN+ggnA56LK5LWvDweq66nPMJvbbIFhQYD4q8Cwzt/fjQpIwFLKna0/VmK
	 B6Y4EW3FOCXY9PLmc1D8sIAtCnIzPNXpXlg/g7cylRM/SORpYqSv26q0Dezy/AAdMt
	 I13ZAqNoKswVq8Bt1GPYki1xGsjvqY/J34uuRakI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgBLXaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:30:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLXav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:30:51 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4309E20848;
        Wed, 12 Feb 2020 23:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581550251;
        bh=we5n/gcqUjIvedGn0eRQwQef3T06WrtffLUf78P4t3Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=frwv+dEI1N/HfY5SRH4s9yaL236SUHB3p4gtn6gG0ZWYS2yL96CfFV8sdwhAHVuZL
         CdXTiPWZqYvzrT9dBLaSKX+iKZrW9YaZMEUCb3vzHGvhIipwSKxBmwlJKpxC3ZxAyA
         gKlRMr+91LDQdPpaGz3UYh5nU+X66gGKMHJiNtW4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1579522208-19523-5-git-send-email-claudiu.beznea@microchip.com>
References: <1579522208-19523-1-git-send-email-claudiu.beznea@microchip.com> <1579522208-19523-5-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 4/8] ARM: at91: pm: add pmc_version member to at91_pm_data
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, linux@armlinux.org.uk,
        ludovic.desroches@microchip.com, mturquette@baylibre.com,
        nicolas.ferre@microchip.com
Date:   Wed, 12 Feb 2020 15:30:50 -0800
Message-ID: <158155025048.184098.9718921656256470902@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-01-20 04:10:04)
> This will be used to differentiate b/w different PLLs settings to be
> applied in the final/first steps of the suspend/resume process by doing
> PLL specific configurations.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
