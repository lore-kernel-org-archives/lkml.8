Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9756C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923B1206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgDUQdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:33:00 -0400
Received: from muru.com ([72.249.23.125]:50614 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDUQc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:32:59 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6DF388081;
        Tue, 21 Apr 2020 16:33:46 +0000 (UTC)
Date:   Tue, 21 Apr 2020 09:32:55 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, bcousson@baylibre.com
Subject: Re: [PATCH] ARM: dts: am574x-idk: Disable m_can node
Message-ID: <20200421163255.GV37466@atomide.com>
References: <20200401090858.18523-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401090858.18523-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [200401 02:09]:
> Since commit bcbb63b80284 ("ARM: dts: dra7: Separate AM57 dtsi files"),
> the m_can node was inherited from dra76x.dtsi but the IP is not
> connected on the idk board. Disable the node to reflect this.

Applying into fixes thanks.

Tony
