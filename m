Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737C2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C7F32068F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGXICl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgGXICk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:02:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93822C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 01:02:40 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jysf5-0003SQ-IJ; Fri, 24 Jul 2020 10:02:35 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jysf5-00015q-10; Fri, 24 Jul 2020 10:02:35 +0200
Message-ID: <04a1a291886c0c659b206fa741de6977708549c3.camel@pengutronix.de>
Subject: Re: [PATCH v2 0/2] reset: reset-zynqmp: Added Versal platform
 support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        saikrishna12468@gmail.com
Date:   Fri, 24 Jul 2020 10:02:34 +0200
In-Reply-To: <1595402165-8282-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1595402165-8282-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-22 at 12:46 +0530, Sai Krishna Potthuri wrote:
> Extended the ZynqMP reset driver to support Versal platform, accordingly
> updated the dt-binding with the Versal platform specific information
> like compatible string and reset indices.
> 
> Changes in v2:
>  - Updated 1/2 patch commit description with some explanation about
> reset indices.
>  - 2/2 patch, Created SOC specific data structure and initialize the
> const data based on of_device_get_match_data.
>  - Defined driver specific of_xlate callback.
> 
> Sai Krishna Potthuri (2):
>   dt-bindings: reset: Updated binding for Versal reset driver
>   reset: reset-zynqmp: Added support for Versal platform
> 
>  .../bindings/reset/xlnx,zynqmp-reset.txt      |  11 +-
>  drivers/reset/reset-zynqmp.c                  |  50 ++++++++-
>  .../dt-bindings/reset/xlnx-versal-resets.h    | 105 ++++++++++++++++++
>  3 files changed, 156 insertions(+), 10 deletions(-)
>  create mode 100644 include/dt-bindings/reset/xlnx-versal-resets.h

Thank you, applied to reset/next.

regards
Philipp
