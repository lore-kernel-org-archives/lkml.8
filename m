Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112BFC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5632067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbgGMQgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:36:17 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38024 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbgGMQgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:36:16 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 601A8CECCA;
        Mon, 13 Jul 2020 18:46:12 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] Bluetooth: btusb: add Realtek 8822CE to usb_device_id
 table
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200713154512.v2.1.I63705bf6abab9cb79c14f7959a59b201af2b8827@changeid>
Date:   Mon, 13 Jul 2020 18:36:14 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        josephsih@google.com, Alain Michaud <alainm@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F403AF9E-FBC1-4DBB-801A-24DBF59097C6@holtmann.org>
References: <20200713154512.v2.1.I63705bf6abab9cb79c14f7959a59b201af2b8827@changeid>
To:     Joseph Hwang <josephsih@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joseph,

> This patch adds the Realtek 8822CE controller to the usb_device_id
> table to support the wideband speech capability.
> 
> Reviewed-by: alainm@chromium.org
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> ---
> 
> Changes in v2:
> - Fixed the commit subject and message body.
> 
> drivers/bluetooth/btusb.c | 4 ++++
> 1 file changed, 4 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

