Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3078C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18422082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgBCOpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:45:33 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:44675 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgBCOpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:45:32 -0500
Received: from [172.20.10.2] (x59cc8b15.dyn.telefonica.de [89.204.139.21])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9041BCED19;
        Mon,  3 Feb 2020 15:54:51 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v3 1/2] Bluetooth: hci_qca: Enable clocks required for BT
 SOC
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1580726441-1100-1-git-send-email-gubbaven@codeaurora.org>
Date:   Mon, 3 Feb 2020 15:45:29 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        robh@kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        tientzu@chromium.org, seanpaul@chromium.org, rjliao@codeaurora.org,
        yshavit@google.com, devicetree@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <FA485B40-588D-4C3F-814A-1B22ECB24853@holtmann.org>
References: <1580726441-1100-1-git-send-email-gubbaven@codeaurora.org>
To:     Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Venkata,

> Instead of relying on other subsytem to turn ON clocks
> required for BT SoC to operate, voting them from the driver.
> 
> Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
> ---
> v3:
>  *Removed the function qca_setup_clock() 
>  *For enabling and disabling clocks, directly called the functions 
>   clk_prepare_enable and clk_disable_unprepare respectively. 
> 
> ---
> drivers/bluetooth/hci_qca.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

