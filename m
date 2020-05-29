Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9174DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74368207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgE2OmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:42:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40048 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgE2OmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:42:19 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C252C2A466D;
        Fri, 29 May 2020 15:42:17 +0100 (BST)
Date:   Fri, 29 May 2020 16:42:14 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Parshuram Thombare <pthombar@cadence.com>, <bbrezillon@kernel.org>,
        <vitor.soares@synopsys.com>, <pgaj@cadence.com>,
        <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <praneeth@ti.com>
Subject: Re: [PATCH v2 1/2] i3c: master add i3c_master_attach_boardinfo to
 preserve boardinfo
Message-ID: <20200529164214.49ba670c@collabora.com>
In-Reply-To: <1590053542-389-1-git-send-email-pthombar@cadence.com>
References: <1590053467-32079-1-git-send-email-pthombar@cadence.com>
        <1590053542-389-1-git-send-email-pthombar@cadence.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 11:32:22 +0200
Parshuram Thombare <pthombar@cadence.com> wrote:

> Boardinfo was lost if I3C object for devices with boardinfo
> available are not created or not added to the I3C device list
> because of some failure e.g. SETDASA failed, retrieve info failed etc
> This patch adds i3c_master_attach_boardinfo which scan boardinfo list
> in the master object and 'attach' it to the I3C device object.
> 
> Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>

This patch looks good to me. I'll apply it just after the merge window.

> ---
>  drivers/i3c/master.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 5f4bd52121fe..3d995f247cb7 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1776,6 +1776,21 @@ static void i3c_master_bus_cleanup(struct i3c_master_controller *master)
>  	i3c_master_detach_free_devs(master);
>  }
>  
> +static void i3c_master_attach_boardinfo(struct i3c_dev_desc *i3cdev)
> +{
> +	struct i3c_master_controller *master = i3cdev->common.master;
> +	struct i3c_dev_boardinfo *i3cboardinfo;
> +
> +	list_for_each_entry(i3cboardinfo, &master->boardinfo.i3c, node) {
> +		if (i3cdev->info.pid != i3cboardinfo->pid)
> +			continue;
> +
> +		i3cdev->boardinfo = i3cboardinfo;
> +		i3cdev->info.static_addr = i3cboardinfo->static_addr;
> +		return;
> +	}
> +}
> +
>  static struct i3c_dev_desc *
>  i3c_master_search_i3c_dev_duplicate(struct i3c_dev_desc *refdev)
>  {
> @@ -1831,10 +1846,10 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
>  	if (ret)
>  		goto err_detach_dev;
>  
> +	i3c_master_attach_boardinfo(newdev);
> +
>  	olddev = i3c_master_search_i3c_dev_duplicate(newdev);
>  	if (olddev) {
> -		newdev->boardinfo = olddev->boardinfo;
> -		newdev->info.static_addr = olddev->info.static_addr;
>  		newdev->dev = olddev->dev;
>  		if (newdev->dev)
>  			newdev->dev->desc = newdev;

