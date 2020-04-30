Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C703CC83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E1E21974
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgD3IHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgD3IHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:07:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A6EC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 01:07:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AD6532A0221;
        Thu, 30 Apr 2020 09:07:35 +0100 (BST)
Date:   Thu, 30 Apr 2020 10:07:33 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>,
        <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>
Subject: Re: [PATCH v6 3/8] i3c: master: i3c mastership request and handover
Message-ID: <20200430100733.4e0dc578@collabora.com>
In-Reply-To: <1587140462-30209-1-git-send-email-pthombar@cadence.com>
References: <1587140398-29473-1-git-send-email-pthombar@cadence.com>
        <1587140462-30209-1-git-send-email-pthombar@cadence.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020 18:21:02 +0200
Parshuram Thombare <pthombar@cadence.com> wrote:

> +
> +/* This function is expected to be called with normaluse_lock */
> +int i3c_master_acquire_bus(struct i3c_master_controller *master)
> +{
> +	int ret = 0;
> +
> +	if (!master->this || master->this != master->bus.cur_master) {

Let's limit the number of indentations by doing

	if (master->this == master->bus.cur_master)
		return 0;


> +		if (master->mr_state == I3C_MR_IDLE) {
> +			master->mr_state = I3C_MR_WAIT_DA;
> +			init_completion(&master->mr_comp);
> +			queue_work(master->wq, &master->sec_mst_work);
> +			/*
> +			 * Bus acquire procedure may need write lock
> +			 * so release read lock before yielding
> +			 * to bus acquire state machine
> +			 */
> +			i3c_bus_normaluse_unlock(&master->bus);
> +			wait_for_completion(&master->mr_comp);
> +			i3c_bus_normaluse_lock(&master->bus);

Is that really enough? I remember we had something a bit more complex
to handle the case where bus is acquired to send a message to a device,
and another master on the bus re-acquires it before we have a chance to
send this message message. i3c_master_acquire_bus_ownership() was
dealing with that in Przemek series. It seems you've rewritten a lot of
these things. Would you mind explaining why, and how that works?

> +			if (master->mr_state != I3C_MR_DONE)
> +				ret = -EAGAIN;
> +			master->mr_state = I3C_MR_IDLE;
> +		} else {
> +			/*
> +			 * MR request is already in process for
> +			 * this master
> +			 */
> +			ret = -EAGAIN;
> +		}
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(i3c_master_acquire_bus);


