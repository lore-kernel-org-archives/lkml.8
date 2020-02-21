Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB47C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED434206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgBUWcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 17:32:21 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34104 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBUWcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 17:32:21 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D6056295BD2;
        Fri, 21 Feb 2020 22:32:19 +0000 (GMT)
Date:   Fri, 21 Feb 2020 23:32:16 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
        Jose.Abreu@synopsys.com, corbet@lwn.net, Joao.Pinto@synopsys.com,
        arnd@arndb.de, wsa@the-dreams.de, gregkh@linuxfoundation.org,
        bbrezillon@kernel.org, broonie@kernel.org
Subject: Re: [PATCH v3 4/5] i3c: add i3cdev module to expose i3c dev in /dev
Message-ID: <20200221233216.3b2038f8@collabora.com>
In-Reply-To: <e093ae9da81e7702c188a20d1e8b9d7f8024bfeb.1582069402.git.vitor.soares@synopsys.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
        <e093ae9da81e7702c188a20d1e8b9d7f8024bfeb.1582069402.git.vitor.soares@synopsys.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 01:20:42 +0100
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> +static int i3cdev_detach(struct device *dev, void *dummy)
> +{
> +	struct i3cdev_data *i3cdev;
> +	struct i3c_device *i3c;
> +
> +	if (dev->type == &i3c_masterdev_type)
> +		return 0;
> +
> +	i3c = dev_to_i3cdev(dev);
> +
> +	i3cdev = i3cdev_get_drvdata(i3c);
> +	if (!i3cdev)
> +		return 0;
> +
> +	/* Prevent transfers while cdev removal */
> +	mutex_lock(&i3cdev->xfer_lock);
> +	cdev_del(&i3cdev->cdev);

When cdev_del() returns there might be opened FDs pointing to your
i3cdev [1] ...

> +	device_destroy(i3cdev_class, MKDEV(MAJOR(i3cdev_number), i3cdev->id));
> +	mutex_unlock(&i3cdev->xfer_lock);
> +
> +	ida_simple_remove(&i3cdev_ida, i3cdev->id);
> +	put_i3cdev(i3cdev);

... and you call put_i3cdev() here which frees the i3cdev object,
leading to potential use-after-free if any of the fops (ioctl, read,
write) are called on those dangling FDs. That's exactly the kind of
nightmare I'd like to avoid.

> +
> +	pr_debug("i3cdev: device [%s] unregistered\n", dev_name(&i3c->dev));
> +
> +	return 0;
> +}
> +

[1]https://elixir.bootlin.com/linux/latest/source/fs/char_dev.c#L587
