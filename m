Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B227C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2732820768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPvb/NB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390712AbgFXVxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390681AbgFXVxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:53:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88B5C061573;
        Wed, 24 Jun 2020 14:53:19 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n2so1675729pld.13;
        Wed, 24 Jun 2020 14:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7FZe/ACm/TrVyy5tAbWSUYZ7NAn7pkF8YVyyAayiW4U=;
        b=FPvb/NB0oDdq9fffO18VK8cID+hgC2aUxo9xVY5gVgR58izwUCVce5KUipPFUgLLIQ
         kOx7LjmSFgWkDdzETZiiWdMAgIcif8LRMDpyq/ChlGk+Sjd77X0VbxRXV2EgsuWV6mk5
         dYffVOzZY28YKx5fgBCIW6LS2a/7JPhgtb/iPe9lFxnCzsUUsvOPX/QB1jP13hcfSEzc
         Llm/rOM9NMEZTogX//SVZsxgmwniPh8FCKxRRutd3+JOlMnZVN/Wj7b599Us73R8iNax
         cijZOKRhitHcHHdYVgEIUq5Yb++o0qbOI5fiMY/vj247yxkpA6JT47Dm/4AhwkjTX4Xb
         xrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7FZe/ACm/TrVyy5tAbWSUYZ7NAn7pkF8YVyyAayiW4U=;
        b=KOYJnfeZ5mgSOsuEQ+TvzBXyRDwTXXJk8QleGQOhHbBRnTrNu82rRSoj1B0o+sE5G6
         zhprNGyPLv3jcnxo19OiXLm9x9u3rI41UYRYVfbs/tgycOhMby/vuRzEJZzYNs+kwJuv
         p3ZQfjziHo3MGuljoYqtpVfRqJiHkJBv65tOB6r5bQmD/Zd1tzqib5nICLCsVm6bHzIM
         dah+999beBl4TnAgcr+E69CpeTr8zQJ1rjaDwb75r6PS01o/iZpI3NWhXWwQBk2pEloQ
         aaG8MWkd2v2iJ7U6k1duCWMfmmK4InQou+wMf6NCojtpL4rKMtOxFZO3h9YZvFfQ9w9V
         FIzw==
X-Gm-Message-State: AOAM531pEy5jXBSMoIZXhfG+m+yH+ZEHL/Zrch9wjlOv/coC0NaiFgOM
        vcxfbzMrErnNaLB79o5vSz5M1iwJ
X-Google-Smtp-Source: ABdhPJzncyvin+GU7rQY3UARi5T031REuM6EzzGIu7MMV5Z+JEaOrYJWoZvzs3uu4W96DVCkJnvlqA==
X-Received: by 2002:a17:90a:58f:: with SMTP id i15mr14697522pji.78.1593035599219;
        Wed, 24 Jun 2020 14:53:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y12sm21103149pfm.158.2020.06.24.14.53.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jun 2020 14:53:18 -0700 (PDT)
Date:   Wed, 24 Jun 2020 14:53:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v5 6/7] hwmon: pmbus: adm1266: debugfs for blackbox info
Message-ID: <20200624215318.GA75948@roeck-us.net>
References: <20200624151736.95785-1-alexandru.tachici@analog.com>
 <20200624151736.95785-7-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624151736.95785-7-alexandru.tachici@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 06:17:35PM +0300, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add a debugfs file to print information in the
> BLACKBOX_INFORMATION register. Contains information
> about the number of stored records, logic index and id
> of the latest record.

How is this different to the nvram method implemented in toe previous patch ?
Why do we need both ?

> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  drivers/hwmon/pmbus/adm1266.c | 56 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
> index b9e92ab1e39a..ea2dc481094b 100644
> --- a/drivers/hwmon/pmbus/adm1266.c
> +++ b/drivers/hwmon/pmbus/adm1266.c
> @@ -60,6 +60,7 @@ struct adm1266_data {
>  	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
>  	struct i2c_client *client;
>  	struct mutex ioctl_mutex; /* lock ioctl access */
> +	struct dentry *debugfs_dir;
>  	struct nvmem_config nvmem_config;
>  	struct nvmem_device *nvmem;
>  	u8 *dev_mem;
> @@ -406,6 +407,28 @@ static const struct proc_ops adm1266_proc_ops = {
>  	.proc_ioctl	= adm1266_ioctl,
>  };
>  
> +static int adm1266_blackbox_information_read(struct seq_file *s, void *pdata)
> +{
> +	struct device *dev = s->private;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	u8 read_buf[5];
> +	unsigned int latest_id;
> +	int ret;
> +
> +	ret = i2c_smbus_read_block_data(client, ADM1266_BLACKBOX_INFO,
> +					read_buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	seq_puts(s, "BLACKBOX_INFORMATION:\n");
> +	latest_id = read_buf[0] + (read_buf[1] << 8);
> +	seq_printf(s, "Black box ID: %u\n", latest_id);
> +	seq_printf(s, "Logic index: %u\n", read_buf[2]);
> +	seq_printf(s, "Record count: %u\n", read_buf[3]);
> +
> +	return 0;
> +}
> +
>  static int adm1266_init_procfs(struct adm1266_data *data)
>  {
>  	struct proc_dir_entry *proc_dir;
> @@ -423,6 +446,29 @@ static int adm1266_init_procfs(struct adm1266_data *data)
>  	return 0;
>  }
>  
> +static int adm1266_init_debugfs(struct adm1266_data *data)
> +{
> +	struct dentry *entry;
> +	struct dentry *root;
> +
> +	root = pmbus_get_debugfs_dir(data->client);
> +	if (!root)
> +		return -ENOENT;
> +
> +	data->debugfs_dir = debugfs_create_dir(data->client->name, root);
> +	if (!data->debugfs_dir)
> +		return -ENOENT;
> +
> +	entry = debugfs_create_devm_seqfile(&data->client->dev,
> +					    "blackbox_information",
> +					    data->debugfs_dir,
> +					    adm1266_blackbox_information_read);
> +	if (!entry)
> +		return -ENOENT;
> +
> +	return 0;
> +}
> +
>  static int adm1266_nvmem_read_blackbox(struct adm1266_data *data, u8 *buf)
>  {
>  	u8 read_buf[5];
> @@ -571,7 +617,15 @@ static int adm1266_probe(struct i2c_client *client,
>  	for (i = 0; i < info->pages; i++)
>  		info->func[i] = funcs;
>  
> -	return pmbus_do_probe(client, id, info);
> +	ret = pmbus_do_probe(client, id, info);
> +	if (ret)
> +		return ret;
> +
> +	ret = adm1266_init_debugfs(data);
> +	if (ret)
> +		dev_warn(&client->dev, "Failed to register debugfs: %d\n", ret);

debugfs functions are supposed to fail silently.

> +
> +	return 0;
>  }
>  
>  static const struct of_device_id adm1266_of_match[] = {
