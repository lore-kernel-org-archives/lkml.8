Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A87BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B0E2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e271y1wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbgFWWVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387568AbgFWWVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:21:47 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E52C061573;
        Tue, 23 Jun 2020 15:21:47 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g13so149376qtv.8;
        Tue, 23 Jun 2020 15:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kXNdMH2aHtz1cKCLUKEwpUC3KvkAioSi57ODqs3OgVI=;
        b=e271y1wgb/AZJgBDYDmfwpTDMuoTV0T5hOfCBs5NYTEeYMUzw4F0rox85dnSpZJniD
         D+5MBTkSk1tu+Wk/GXnwaVzrbihvyJydBz+XnF/bO8zWlG1jnRD3BZCHOkcpkrhHcqTN
         BxN6x2qdwE0Qj7ihmxDlXWMOfPNO9tW5Blqy4UOE+dmIx7HIn3wnRyR++2WtnCfvffgw
         jWh13cdIh7iZpU3kNJFkVOctpAqLibQVR/3NHZ3Rq0ygjDUHGcNzWyz3QF8zXccT1vsz
         G6uXCLR85eFO5CG3X0/xSo/S6sCRk8uLATAyDt61uubVGqVXC25azmVNGviW14O39/nZ
         RWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kXNdMH2aHtz1cKCLUKEwpUC3KvkAioSi57ODqs3OgVI=;
        b=Z6ilFnekbLmYKDD2jicrZhBBxv2Yt0euhKvHL2IH3gZKMOeEOeGmSxEZxaG5LJri6j
         81px1/HH007TKxv4nJVaAloYM9Jw9jVm0Nv0iEhTj9mL3HmsNwLH+D500Oi6hx1Ivem3
         rgJ8XakcW1CDj7Pzhs9xAdrufNsz66L6/BjuxlgDSLiBpooWdSoW5IMGejFaRbvY1wCx
         ge4VWIUHBJzruE9ocQJEo9d/kKUAQoHLZyRr8m9VgmcZ3zXne7mfH4r6OUZxDC8kRMFB
         eQoicajNe2ZKZmprrx7QSvPprtppnfi5I19GeJkElesyWSKcjXQ7uyk3MGyNStP3ipVg
         fCrw==
X-Gm-Message-State: AOAM532gChyNpCwSsv+DVlQ/Y93CbG4DgEMaDq4TdKUFuThSbXi7KF67
        afhNIBixUAapXFaDmSj/0ow=
X-Google-Smtp-Source: ABdhPJxTFD4XxeL72+YUc91Cj7omrXA6jfpXKuMJbYFrm3mlTFfN3/1tBtA33gtsaMOfp7ctMiX64w==
X-Received: by 2002:ac8:27b6:: with SMTP id w51mr24573196qtw.124.1592950906164;
        Tue, 23 Jun 2020 15:21:46 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id x19sm1910603qtc.36.2020.06.23.15.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 15:21:45 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
To:     Lee Jones <lee.jones@linaro.org>, andy.shevchenko@gmail.com,
        michael@walle.cc, robh+dt@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        linux@roeck-us.net, andriy.shevchenko@linux.intel.com,
        robin.murphy@arm.com, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
References: <20200611191002.2256570-1-lee.jones@linaro.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <2a25af37-a9b8-e4f3-6092-06c1c907dc9f@gmail.com>
Date:   Tue, 23 Jun 2020 17:21:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611191002.2256570-1-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-11 14:10, Lee Jones wrote:
> Currently, when a child platform device (sometimes referred to as a
> sub-device) is registered via the Multi-Functional Device (MFD) API,
> the framework attempts to match the newly registered platform device
> with its associated Device Tree (OF) node.  Until now, the device has
> been allocated the first node found with an identical OF compatible
> string.  Unfortunately, if there are, say for example '3' devices
> which are to be handled by the same driver and therefore have the same
> compatible string, each of them will be allocated a pointer to the
> *first* node.
> 
> An example Device Tree entry might look like this:
> 
>   mfd_of_test {
>           compatible = "mfd,of-test-parent";
>           #address-cells = <0x02>;
>           #size-cells = <0x02>;
> 
>           child@aaaaaaaaaaaaaaaa {
>                   compatible = "mfd,of-test-child";
>                   reg = <0xaaaaaaaa 0xaaaaaaaa 0 0x11>,
>                         <0xbbbbbbbb 0xbbbbbbbb 0 0x22>;
>           };
> 
>           child@cccccccc {
>                   compatible = "mfd,of-test-child";
>                   reg = <0x00000000 0xcccccccc 0 0x33>;
>           };
> 
>           child@dddddddd00000000 {
>                   compatible = "mfd,of-test-child";
>                   reg = <0xdddddddd 0x00000000 0 0x44>;
>           };
>   };
> 
> When used with example sub-device registration like this:
> 
>   static const struct mfd_cell mfd_of_test_cell[] = {
>         OF_MFD_CELL("mfd-of-test-child", NULL, NULL, 0, 0, "mfd,of-test-child"),
>         OF_MFD_CELL("mfd-of-test-child", NULL, NULL, 0, 1, "mfd,of-test-child"),
>         OF_MFD_CELL("mfd-of-test-child", NULL, NULL, 0, 2, "mfd,of-test-child")
>   };
> 
> ... the current implementation will result in all devices being allocated
> the first OF node found containing a matching compatible string:
> 
>   [0.712511] mfd-of-test-child mfd-of-test-child.0: Probing platform device: 0
>   [0.712710] mfd-of-test-child mfd-of-test-child.0: Using OF node: child@aaaaaaaaaaaaaaaa
>   [0.713033] mfd-of-test-child mfd-of-test-child.1: Probing platform device: 1
>   [0.713381] mfd-of-test-child mfd-of-test-child.1: Using OF node: child@aaaaaaaaaaaaaaaa
>   [0.713691] mfd-of-test-child mfd-of-test-child.2: Probing platform device: 2
>   [0.713889] mfd-of-test-child mfd-of-test-child.2: Using OF node: child@aaaaaaaaaaaaaaaa
> 
> After this patch each device will be allocated a unique OF node:
> 
>   [0.712511] mfd-of-test-child mfd-of-test-child.0: Probing platform device: 0
>   [0.712710] mfd-of-test-child mfd-of-test-child.0: Using OF node: child@aaaaaaaaaaaaaaaa
>   [0.713033] mfd-of-test-child mfd-of-test-child.1: Probing platform device: 1
>   [0.713381] mfd-of-test-child mfd-of-test-child.1: Using OF node: child@cccccccc
>   [0.713691] mfd-of-test-child mfd-of-test-child.2: Probing platform device: 2
>   [0.713889] mfd-of-test-child mfd-of-test-child.2: Using OF node: child@dddddddd00000000
> 
> Which is fine if all OF nodes are identical.  However if we wish to
> apply an attribute to particular device, we really need to ensure the
> correct OF node will be associated with the device containing the
> correct address.  We accomplish this by matching the device's address
> expressed in DT with one provided during sub-device registration.
> Like this:
> 
>   static const struct mfd_cell mfd_of_test_cell[] = {
>         OF_MFD_CELL_REG("mfd-of-test-child", NULL, NULL, 0, 1, "mfd,of-test-child", 0xdddddddd00000000),
>         OF_MFD_CELL_REG("mfd-of-test-child", NULL, NULL, 0, 2, "mfd,of-test-child", 0xaaaaaaaaaaaaaaaa),
>         OF_MFD_CELL_REG("mfd-of-test-child", NULL, NULL, 0, 3, "mfd,of-test-child", 0x00000000cccccccc)
>   };
> 
> This will ensure a specific device (designated here using the
> platform_ids; 1, 2 and 3) is matched with a particular OF node:
> 
>   [0.712511] mfd-of-test-child mfd-of-test-child.0: Probing platform device: 0
>   [0.712710] mfd-of-test-child mfd-of-test-child.0: Using OF node: child@dddddddd00000000
>   [0.713033] mfd-of-test-child mfd-of-test-child.1: Probing platform device: 1
>   [0.713381] mfd-of-test-child mfd-of-test-child.1: Using OF node: child@aaaaaaaaaaaaaaaa
>   [0.713691] mfd-of-test-child mfd-of-test-child.2: Probing platform device: 2
>   [0.713889] mfd-of-test-child mfd-of-test-child.2: Using OF node: child@cccccccc
> 
> This implementation is still not infallible, hence the mention of
> "best effort" in the commit subject.  Since we have not *insisted* on
> the existence of 'reg' properties (in some scenarios they just do not
> make sense) and no device currently uses the new 'of_reg' attribute,
> we have to make an on-the-fly judgement call whether to associate the
> OF node anyway.  Which we do in cases where parent drivers haven't
> specified a particular OF node to match to.  So there is a *slight*
> possibility of the following result (note: the implementation here is
> convoluted, but it shows you one means by which this process can
> still break):
> 
>   /*
>    * First entry will match to the first OF node with matching compatible
>    * Second will fail, since the first took its OF node and is no longer available
>    * Third will succeed
>    */
>   static const struct mfd_cell mfd_of_test_cell[] = {
>         OF_MFD_CELL("mfd-of-test-child", NULL, NULL, 0, 1, "mfd,of-test-child"),
> 	OF_MFD_CELL_REG("mfd-of-test-child", NULL, NULL, 0, 2, "mfd,of-test-child", 0xaaaaaaaaaaaaaaaa),
>         OF_MFD_CELL_REG("mfd-of-test-child", NULL, NULL, 0, 3, "mfd,of-test-child", 0x00000000cccccccc)
>   };
> 
> The result:
> 
>   [0.753869] mfd-of-test-parent mfd_of_test: Registering 3 devices
>   [0.756597] mfd-of-test-child: Failed to locate of_node [id: 2]
>   [0.759999] mfd-of-test-child mfd-of-test-child.1: Probing platform device: 1
>   [0.760314] mfd-of-test-child mfd-of-test-child.1: Using OF node: child@aaaaaaaaaaaaaaaa
>   [0.760908] mfd-of-test-child mfd-of-test-child.2: Probing platform device: 2
>   [0.761183] mfd-of-test-child mfd-of-test-child.2: No OF node associated with this device
>   [0.761621] mfd-of-test-child mfd-of-test-child.3: Probing platform device: 3
>   [0.761899] mfd-of-test-child mfd-of-test-child.3: Using OF node: child@cccccccc
> 
> We could code around this with some pre-parsing semantics, but the
> added complexity required to cover each and every corner-case is not
> justified.  Merely patching the current failing (via this patch) is
> already working with some pretty small corner-cases.  Other issues
> should be patched in the parent drivers which can be achieved simply
> by implementing OF_MFD_CELL_REG().
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> Changelog:
> 
> v1 => v2:
>   * Simply return -EAGAIN if node is already in use
>   * Allow for valid of_reg=0 by introducing use_of_reg boolean flag
>   * Split helpers out into separate patch
> 
> drivers/mfd/mfd-core.c   | 99 +++++++++++++++++++++++++++++++++++-----
>  include/linux/mfd/core.h | 10 ++++
>  2 files changed, 97 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index e831e733b38cf..120803717b828 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <linux/acpi.h>
> +#include <linux/list.h>
>  #include <linux/property.h>
>  #include <linux/mfd/core.h>
>  #include <linux/pm_runtime.h>
> @@ -17,8 +18,17 @@
>  #include <linux/module.h>
>  #include <linux/irqdomain.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/regulator/consumer.h>
>  
> +static LIST_HEAD(mfd_of_node_list);
> +
> +struct mfd_of_node_entry {
> +	struct list_head list;
> +	struct device *dev;
> +	struct device_node *np;
> +};
> +
>  static struct device_type mfd_dev_type = {
>  	.name	= "mfd_device",
>  };
> @@ -107,6 +117,54 @@ static inline void mfd_acpi_add_device(const struct mfd_cell *cell,
>  }
>  #endif
>  
> +static int mfd_match_of_node_to_dev(struct platform_device *pdev,
> +				    struct device_node *np,
> +				    const struct mfd_cell *cell)
> +{
> +	struct mfd_of_node_entry *of_entry;
> +	const __be32 *reg;
> +	u64 of_node_addr;
> +
> +	/* Skip devices 'disabled' by Device Tree */
> +	if (!of_device_is_available(np))
> +		return -ENODEV;
> +
> +	/* Skip if OF node has previously been allocated to a device */
> +	list_for_each_entry(of_entry, &mfd_of_node_list, list)
> +		if (of_entry->np == np)
> +			return -EAGAIN;
> +
> +	if (!cell->use_of_reg)
> +		/* No of_reg defined - allocate first free compatible match */
> +		goto allocate_of_node;
> +
> +	/* We only care about each node's first defined address */
> +	reg = of_get_address(np, 0, NULL, NULL);
> +	if (!reg)
> +		/* OF node does not contatin a 'reg' property to match to */
> +		return -EAGAIN;
> +
> +	of_node_addr = of_read_number(reg, of_n_addr_cells(np));
> +
> +	if (cell->of_reg != of_node_addr)
> +		/* No match */
> +		return -EAGAIN;
> +
> +allocate_of_node:
> +	of_entry = kzalloc(sizeof(*of_entry), GFP_KERNEL);
> +	if (!of_entry)
> +		return -ENOMEM;
> +
> +	of_entry->dev = &pdev->dev;
> +	of_entry->np = np;
> +	list_add_tail(&of_entry->list, &mfd_of_node_list);
> +
> +	pdev->dev.of_node = np;
> +	pdev->dev.fwnode = &np->fwnode;
> +
> +	return 0;
> +}
> +
>  static int mfd_add_device(struct device *parent, int id,
>  			  const struct mfd_cell *cell,
>  			  struct resource *mem_base,
> @@ -115,6 +173,7 @@ static int mfd_add_device(struct device *parent, int id,
>  	struct resource *res;
>  	struct platform_device *pdev;
>  	struct device_node *np = NULL;
> +	struct mfd_of_node_entry *of_entry, *tmp;
>  	int ret = -ENOMEM;
>  	int platform_id;
>  	int r;
> @@ -149,19 +208,22 @@ static int mfd_add_device(struct device *parent, int id,
>  	if (ret < 0)
>  		goto fail_res;
>  
> -	if (parent->of_node && cell->of_compatible) {
> +	if (IS_ENABLED(CONFIG_OF) && parent->of_node && cell->of_compatible) {
>  		for_each_child_of_node(parent->of_node, np) {
>  			if (of_device_is_compatible(np, cell->of_compatible)) {
> -				if (!of_device_is_available(np)) {
> -					/* Ignore disabled devices error free */
> -					ret = 0;
> +				ret = mfd_match_of_node_to_dev(pdev, np, cell);
> +				if (ret == -EAGAIN)
> +					continue;
> +				if (ret)
>  					goto fail_alias;
> -				}
> -				pdev->dev.of_node = np;
> -				pdev->dev.fwnode = &np->fwnode;
> +
>  				break;
>  			}
>  		}
> +
> +		if (!pdev->dev.of_node)
> +			pr_warn("%s: Failed to locate of_node [id: %d]\n",
> +				cell->name, platform_id);
>  	}
>  
>  	mfd_acpi_add_device(cell, pdev);
> @@ -170,13 +232,13 @@ static int mfd_add_device(struct device *parent, int id,
>  		ret = platform_device_add_data(pdev,
>  					cell->platform_data, cell->pdata_size);
>  		if (ret)
> -			goto fail_alias;
> +			goto fail_of_entry;
>  	}
>  
>  	if (cell->properties) {
>  		ret = platform_device_add_properties(pdev, cell->properties);
>  		if (ret)
> -			goto fail_alias;
> +			goto fail_of_entry;
>  	}
>  
>  	for (r = 0; r < cell->num_resources; r++) {
> @@ -213,18 +275,18 @@ static int mfd_add_device(struct device *parent, int id,
>  			if (has_acpi_companion(&pdev->dev)) {
>  				ret = acpi_check_resource_conflict(&res[r]);
>  				if (ret)
> -					goto fail_alias;
> +					goto fail_of_entry;
>  			}
>  		}
>  	}
>  
>  	ret = platform_device_add_resources(pdev, res, cell->num_resources);
>  	if (ret)
> -		goto fail_alias;
> +		goto fail_of_entry;
>  
>  	ret = platform_device_add(pdev);
>  	if (ret)
> -		goto fail_alias;
> +		goto fail_of_entry;
>  
>  	if (cell->pm_runtime_no_callbacks)
>  		pm_runtime_no_callbacks(&pdev->dev);
> @@ -233,6 +295,12 @@ static int mfd_add_device(struct device *parent, int id,
>  
>  	return 0;
>  
> +fail_of_entry:
> +	list_for_each_entry_safe(of_entry, tmp, &mfd_of_node_list, list)
> +		if (of_entry->dev == &pdev->dev) {
> +			list_del(&of_entry->list);
> +			kfree(of_entry);
> +		}
>  fail_alias:
>  	regulator_bulk_unregister_supply_alias(&pdev->dev,
>  					       cell->parent_supplies,
> @@ -287,6 +355,7 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
>  {
>  	struct platform_device *pdev;
>  	const struct mfd_cell *cell;
> +	struct mfd_of_node_entry *of_entry, *tmp;
>  
>  	if (dev->type != &mfd_dev_type)
>  		return 0;
> @@ -297,6 +366,12 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
>  	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
>  					       cell->num_parent_supplies);
>  
> +	list_for_each_entry_safe(of_entry, tmp, &mfd_of_node_list, list)
> +		if (of_entry->dev == dev) {
> +			list_del(&of_entry->list);
> +			kfree(of_entry);
> +		}
> +
>  	kfree(cell);
>  
>  	platform_device_unregister(pdev);
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index d01d1299e49dc..a148b907bb7f1 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -78,6 +78,16 @@ struct mfd_cell {
>  	 */
>  	const char		*of_compatible;
>  
> +	/*
> +	 * Address as defined in Device Tree.  Used to compement 'of_compatible'
> +	 * (above) when matching OF nodes with devices that have identical
> +	 * compatible strings
> +	 */

Instead of the above comment, suggest something like instead (I have not properly
line wrapped, to make it easier to see the difference):

   > +	/*
   > +	 * Address as defined in Device Tree mfd child node "reg" property.  Used in combination with 'of_compatible'
   > +	 * (above) when matching OF nodes with devices that have identical
   > +	 * compatible strings
   > +	 */
   
> +	const u64 of_reg;
> +
> +	/* Set to 'true' to use 'of_reg' (above) - allows for of_reg=0 */
> +	bool use_of_reg;
> +
>  	/* Matches ACPI */
>  	const struct mfd_cell_acpi_match	*acpi_match;
>  
> 

