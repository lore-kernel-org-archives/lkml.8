Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEE2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E34F21739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plating.de header.i=@plating.de header.b="JF/m5q/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbgCDLh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:37:27 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:12496 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbgCDLh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:37:27 -0500
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Mar 2020 06:37:26 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1583321845;
        s=strato-dkim-0002; d=plating.de;
        h=Date:Message-ID:Cc:To:Subject:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=FGQ4rSzepB0EcVTj9BxbCbRMEHfRUYaLUDGhQumEvDc=;
        b=JF/m5q/h6hT0kTIMnAg7QU+guurAub4556bC8EyEnm2Z5jsah7orPTZEQi6sYXCVfr
        7BLIl3khqRlR8YpLTEVnsvuWE5TBu0PrSHX5af+gOTtOes7g8PQ616+qjpB4iY+59W7/
        CYdxa+Rm8a/g99aF4pEBj1606PhFDdlRJFh6qh7TWLxVUsTHqQppAmP13B94oTfW+xDz
        EimavDIYrAJddsB1HxaV0icHq4q1WK+f7OufqGqx2Rye3Z3EL+F7YopmT/t36EU3mjes
        29OWbPMZajc1F//NKmQX8E4ib1h9sGP6TqOV3bwaNF1OWIeQv8U6t28AOKhw7KtEM50V
        cFYQ==
X-RZG-AUTH: ":P2EQZVataeyI5jZ/YFVerR/NeEUpp/1ZEi4FSKT8sA3i0IzVhLiw6JgrUzaKN77axfKEX18="
X-RZG-CLASS-ID: mo00
Received: from mail.dl.plating.de
        by smtp.strato.de (RZmta 46.2.0 AUTH)
        with ESMTPSA id R06d1cw24BPJJAP
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Wed, 4 Mar 2020 12:25:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.dl.plating.de (Postfix) with ESMTP id 79E9A122A65;
        Wed,  4 Mar 2020 12:25:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at dl.plating.de
Received: from mail.dl.plating.de ([127.0.0.1])
        by localhost (mail.dl.plating.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WdCRduM3m4mk; Wed,  4 Mar 2020 12:25:13 +0100 (CET)
Received: from [172.16.4.186] (unknown [172.16.4.186])
        by mail.dl.plating.de (Postfix) with ESMTPSA id 7340012293F;
        Wed,  4 Mar 2020 12:25:12 +0100 (CET)
From:   =?UTF-8?Q?Lars_M=c3=b6llendorf?= <lars.moellendorf@plating.de>
Subject: Question about regmap_range_cfg and regmap_mmio
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Message-ID: <d2eb2248-0120-7b0f-9bcf-4f9c71954117@plating.de>
Date:   Wed, 4 Mar 2020 12:25:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this mail is copied from internal issue written in markdown - I hope
this is still readable as mail.

I am referring to kernel sources v4.9.87 but I think all my assumptions
do still apply to current kernel versions.

[regmap.h](https://elixir.bootlin.com/linux/v4.9.87/source/include/linux/regmap.h#L334)
contains:

```c
/**
 * Configuration for indirectly accessed or paged registers.
 * Registers, mapped to this virtual range, are accessed in two steps:
 *     1. page selector register update;
 *     2. access through data window registers.
 *
 * @name: Descriptive name for diagnostics
 *
 * @range_min: Address of the lowest register address in virtual range.
 * @range_max: Address of the highest register in virtual range.
 *
 * @page_sel_reg: Register with selector field.
 * @page_sel_mask: Bit shift for selector value.
 * @page_sel_shift: Bit mask for selector value.
 *
 * @window_start: Address of first (lowest) register in data window.
 * @window_len: Number of registers in data window.
 */
struct regmap_range_cfg {
	const char *name;

	/* Registers of virtual address range */
	unsigned int range_min;
	unsigned int range_max;

	/* Page selector for indirect addressing */
	unsigned int selector_reg;
	unsigned int selector_mask;
	int selector_shift;

	/* Data window (per each page) */
	unsigned int window_start;
	unsigned int window_len;
};
```

Unfortunately this seems not to work for MMIO devices.

In
[`__regmap_init()`](https://elixir.bootlin.com/linux/v4.9.87/source/drivers/base/regmap/regmap.c#L711)
[`_regmap_bus_reg_read()`](https://elixir.bootlin.com/linux/v4.9.87/source/drivers/base/regmap/regmap.c#L2330)
is assigned to
[`regmap.reg_read()`](https://elixir.bootlin.com/linux/v4.9.87/source/drivers/base/regmap/internal.h#L101)
if `!bus->read || !bus->write`, else
[`_regmap_bus_read()`](https://elixir.bootlin.com/linux/v4.9.87/source/drivers/base/regmap/regmap.c#L2338)
is assigned:

```c
	if (!bus) {
		map->reg_read  = config->reg_read;
		map->reg_write = config->reg_write;

		map->defer_caching = false;
		goto skip_format_initialization;
	} else if (!bus->read || !bus->write) {
		map->reg_read = _regmap_bus_reg_read;
		map->reg_write = _regmap_bus_reg_write;

		map->defer_caching = false;
		goto skip_format_initialization;
	} else {
		map->reg_read  = _regmap_bus_read;
		map->reg_update_bits = bus->reg_update_bits;
	}
```
[`_regmap_bus_reg_read()`](https://elixir.bootlin.com/linux/v4.9.87/source/drivers/base/regmap/regmap.c#L2330)
calls the `reg_read` function of the bus directly,
[`_regmap_bus_read()`](https://elixir.bootlin.com/linux/v4.9.87/source/drivers/base/regmap/regmap.c#L2338)
instead calls `_regmap_raw_read()`:

```c
static int _regmap_bus_reg_read(void *context, unsigned int reg,
				unsigned int *val)
{
	struct regmap *map = context;

	return map->bus->reg_read(map->bus_context, reg, val);
}

static int _regmap_bus_read(void *context, unsigned int reg,
			    unsigned int *val)
{
	int ret;
	struct regmap *map = context;

	if (!map->format.parse_val)
		return -EINVAL;

	ret = _regmap_raw_read(map, reg, map->work_buf, map->format.val_bytes);
	if (ret == 0)
		*val = map->format.parse_val(map->work_buf);

	return ret;
}
```

[`_regmap_raw_read()`](https://elixir.bootlin.com/linux/v4.9.87/source/drivers/base/regmap/regmap.c#L2297)
in turn calls
[`_regmap_range_lookup()`](https://elixir.bootlin.com/linux/v4.9.87/source/drivers/base/regmap/regmap-mmio.c#L479)
and
[`_regmap_select_page()`](https://elixir.bootlin.com/linux/v4.9.87/source/drivers/base/regmap/regmap-mmio.c#L1283)
which do the paging.

-
[`regmap_mmio`](https://elixir.bootlin.com/linux/v4.9.87/source/drivers/base/regmap/regmap-mmio.c#L212)
does neither contain `.read` nor `.write`.
-
[`regmap_i2c`](https://elixir.bootlin.com/linux/v4.9.87/source/drivers/base/regmap/regmap-i2c.c#L204)
does contain both.

My assumption is that paging is not a common use case for Memory-mapped
I/O and thus has not been implemented for this case.

- Are my assumptions correct?
- If so, what would you recommend me to do:
  - Continue using `regmap-mmio` and implement my custom paging
functions on top of that?
  - Enhance the current `regmap-mmio` implementation so it does paging
and submit a patch?
  - Write my own `better-regmap-mmio` implementation?

Thank you,
Lars

-- 

Lars Möllendorf, B. Eng.


Tel.:    +49 (0) 7641 93500-425
Fax:     +49 (0) 7641 93500-999
E-Mail:  lars.moellendorf@plating.de <mailto:lars.moellendorf@plating.de>
Website: www.plating.de <http://www.plating.de>

--------------------------------
plating electronic GmbH - Amtsgericht Freiburg - HRB Nr. 260 592 /
Geschäftsführer Karl Rieder / Rheinstraße 4 – 79350 Sexau – Tel.:+49 (0)
7641 – 93500-0

--------------------------------
Der Inhalt dieser E-Mail ist vertraulich und ausschließlich für den
bezeichneten Adressaten bestimmt. Wenn Sie nicht der vorgesehene
Adressat dieser E-Mail oder dessen Vertreter sein sollten, so beachten
Sie bitte, dass jede Form der Kenntnisnahme, Veröffentlichung,
Vervielfältigung oder Weitergabe des Inhalts dieser E-Mail unzulässig
ist. Wir bitten Sie, sich in diesem Fall mit dem Absender der E-Mail in
Verbindung zu setzen. Aussagen gegenüber  dem Adressaten unterliegen den
Regelungen des zugrundeliegenden Angebotes bzw. Auftrags, insbesondere
den Allgemeinen Geschäftsbedingungen und der individuellen
Haftungsvereinbarung. Der Inhalt der E-Mail ist nur rechtsverbindlich,
wenn er unsererseits durch einen Brief oder ein Telefax entsprechend
bestaetigt wird.

The information contained in this email is confidential. It is intended
solely for the addressee. Access to this email by anyone else is
unauthorized. If you are not the intended recipient, any form of
disclosure, reproduction, distribution or any action taken or refrained
from in reliance on it, is prohibited and may be unlawful. Please notify
the sender immediately. All statements of opinion or advice directed via
this email to our clients are subject to the terms and conditions
expressed in the governing client engagement letter. The content of this
email is not legally binding unless confirmed by letter or fax.

Although plating electronic GmbH attempts to sweep e-mail and
attachments for viruses, it does not guarantee that either are
virus-free and accepts no liability for any damage sustained as a result
of viruses.

