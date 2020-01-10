Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BC5C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1591A2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgAJG7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:59:05 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49496 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgAJG7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 01:59:04 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E8618293934;
        Fri, 10 Jan 2020 06:59:02 +0000 (GMT)
Date:   Fri, 10 Jan 2020 07:58:59 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: nand: spi: rework detect procedure for
 different read id op
Message-ID: <20200110075859.3edfae3a@collabora.com>
In-Reply-To: <20200110025218.1257809-1-gch981213@gmail.com>
References: <20200110025218.1257809-1-gch981213@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 10:51:14 +0800
Chuanhong Guo <gch981213@gmail.com> wrote:


> +static int spinand_manufacturer_detect(struct spinand_device *spinand)
> +{
> +	u8 *id = spinand->id.data;
> +	int ret;
> +
> +	ret = spinand_read_id_op(spinand, 0, 0, id);
> +	if (ret)
> +		return ret;
> +	ret = spinand_manufacturer_match(spinand, SPINAND_READID_METHOD_OPCODE);
> +	if (!ret)
> +		return 0;
> +
> +	ret = spinand_read_id_op(spinand, 1, 0, id);
> +	if (ret)
> +		return ret;
> +	ret = spinand_manufacturer_match(spinand,
> +					 SPINAND_READID_METHOD_OPCODE_ADDR);
> +	if (!ret)
> +		return 0;
> +
> +	ret = spinand_read_id_op(spinand, 0, 1, id);

Hm, we should probably do only one of each read_id and iterate over all
manufacturers/chips each time instead of doing 3 read_ids per
manufacturer.

> +	if (ret)
> +		return ret;
> +	ret = spinand_manufacturer_match(spinand,
> +					 SPINAND_READID_METHOD_OPCODE_DUMMY);
> +
> +	return ret;
> +}
> +

[...]

> +/**
> + * struct spinand_devid - SPI NAND device id structure
> + * @id: device id of current chip
> + * @len: number of bytes in device id
> + * @method: method to read chip id
> + *	    There are 3 possible variants:
> + *	    SPINAND_READID_METHOD_OPCODE: chip id is returned immediately
> + *	    after read_id opcode.
> + *	    SPINAND_READID_METHOD_OPCODE_ADDR: chip id is returned after
> + *	    read_id opcode + 1-byte address.
> + *	    SPINAND_READID_METHOD_OPCODE_DUMMY: chip id is returned after
> + *	    read_id opcode + 1 dummy byte.
> + */
> +struct spinand_devid {
> +	u16 id;

Can we make that field an array of u8?

	const u8 *id;

> +	u8 len;
> +	enum spinand_readid_method method;
> +};
> +
>  /**
>   * struct manufacurer_ops - SPI NAND manufacturer specific operations
> - * @detect: detect a SPI NAND device. Every time a SPI NAND device is probed
> - *	    the core calls the struct_manufacurer_ops->detect() hook of each
> - *	    registered manufacturer until one of them return 1. Note that
> - *	    the first thing to check in this hook is that the manufacturer ID
> - *	    in struct_spinand_device->id matches the manufacturer whose
> - *	    ->detect() hook has been called. Should return 1 if there's a
> - *	    match, 0 if the manufacturer ID does not match and a negative
> - *	    error code otherwise. When true is returned, the core assumes
> - *	    that properties of the NAND chip (spinand->base.memorg and
> - *	    spinand->base.eccreq) have been filled
>   * @init: initialize a SPI NAND device
>   * @cleanup: cleanup a SPI NAND device
>   *
>   * Each SPI NAND manufacturer driver should implement this interface so that
> - * NAND chips coming from this vendor can be detected and initialized properly.
> + * NAND chips coming from this vendor can be initialized properly.
>   */
>  struct spinand_manufacturer_ops {
> -	int (*detect)(struct spinand_device *spinand);
>  	int (*init)(struct spinand_device *spinand);
>  	void (*cleanup)(struct spinand_device *spinand);
>  };
> @@ -215,11 +224,16 @@ struct spinand_manufacturer_ops {
>   * struct spinand_manufacturer - SPI NAND manufacturer instance
>   * @id: manufacturer ID
>   * @name: manufacturer name
> + * @devid_len: number of bytes in device ID
> + * @chips: supported SPI NANDs under current manufacturer
> + * @nchips: number of SPI NANDs available in chips array
>   * @ops: manufacturer operations
>   */
>  struct spinand_manufacturer {
>  	u8 id;
>  	char *name;
> +	const struct spinand_info *chips;
> +	const size_t nchips;
>  	const struct spinand_manufacturer_ops *ops;
>  };
>  
> @@ -291,7 +305,7 @@ struct spinand_ecc_info {
>   */
>  struct spinand_info {
>  	const char *model;
> -	u16 devid;
> +	struct spinand_devid devid;
>  	u32 flags;
>  	struct nand_memory_organization memorg;
>  	struct nand_ecc_req eccreq;
> @@ -305,6 +319,13 @@ struct spinand_info {
>  			     unsigned int target);
>  };
>  
> +#define SPINAND_ID(__id, __len, __method)				\
> +	{								\
> +		.id = __id,						\
> +		.len = __len,						\
> +		.method = __method,					\
> +	}

That one can be turned into

#define SPINAND_ID(__method, ...)				\
	{							\
		.id = (const u8[]){ __VA_ARGS },		\
		.len = sizeof((u8[]){ __VA_ARGS }),		\
		.method = __method,				\
	}

> +
>  #define SPINAND_INFO_OP_VARIANTS(__read, __write, __update)		\
>  	{								\
>  		.read_cache = __read,					\
> @@ -451,9 +472,10 @@ static inline void spinand_set_of_node(struct spinand_device *spinand,
>  	nanddev_set_of_node(&spinand->base, np);
>  }
>  
> -int spinand_match_and_init(struct spinand_device *dev,
> +int spinand_match_and_init(struct spinand_device *spinand,
>  			   const struct spinand_info *table,
> -			   unsigned int table_size, u16 devid);
> +			   unsigned int table_size,
> +			   enum spinand_readid_method rdid_method);
>  
>  int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
>  int spinand_select_target(struct spinand_device *spinand, unsigned int target);

