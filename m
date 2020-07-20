Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FD6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AA12176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgGTRRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:17:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:34528 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbgGTRRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 13:17:43 -0400
IronPort-SDR: PICB47hsfuRLGoXxsfh/NPCE8vfQqM1L3WuqhGcVxZQw8XQEGEiizZK9fgaWkLa6YLvdVFEYas
 f/soLOED3wjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="147467377"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="147467377"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 10:14:41 -0700
IronPort-SDR: u70/UU2WZT/t5vgtRwNOeHsmXaAsVVPI7dkU1OV49/a/NLf+G3PYLt4OgE4TUTYQDZCI6j7Prd
 KwRuMVax4heQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="270192423"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jul 2020 10:14:38 -0700
Date:   Tue, 21 Jul 2020 01:11:31 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, lgoncalv@redhat.com, hao.wu@intel.com,
        yilun.xu@intel.com
Subject: Re: [PATCH v2 1/3] regmap: add Intel SPI Slave to AVMM Bus Bridge
  support
Message-ID: <20200720171131.GA18829@yilunxu-OptiPlex-7050>
References: <1594896174-18826-1-git-send-email-yilun.xu@intel.com>
 <1594896174-18826-2-git-send-email-yilun.xu@intel.com>
 <20200717181508.GA905@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717181508.GA905@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 07:15:08PM +0100, Mark Brown wrote:
> On Thu, Jul 16, 2020 at 06:42:52PM +0800, Xu Yilun wrote:
> 
> > This patch add support for regmap API that is intended to be used by
> > the drivers of some SPI slave chips which integrate the "SPI slave to
> > Avalon Master Bridge" (spi-avmm) IP.
> 
> At a very high level this looks far too complicated.  Some of that is
> due to the protocol it's implementing which looks awfully like you've
> got a microcontroller in there trying to proxy a bus of some kind but

Maybe I should introduce about the role of the spi-avmm in the system.
Usually it is used in a SPI slave chip which integrates an Avalon Memory
Mapped bus (Avmm bus) and several sub devices. Like the following
diagram:

 +-------------------------------------+
 |              Max10 BMC              |
 |                                     |
 | +---------+    |    |    +--------+ |
 | |subdev A |    |    |    |subdev B| |
 | |register |----|Avmm|----|register| |
 | |space    |    |bus |    |space   | |
 | |(Avmm    |    |    |    |(Avmm   | |    +---------+
 | | Slave)  |    |    |    | Slave) | |    |         |
 | +---------+    |    |    +--------+ |    | Host    |
 |                |    |               |    | system  |
 | +---------+    |    |      +--------|    |         |
 | |Embedded |----|    |------|spi-avmm|    |         |
 | |processor|    |    |      |bridge  |    |------+  |
 | | (Avmm   |    |    |      |(Avmm   |----|spi   |  |
 | |  Master)|                | Master)|    |master|  |
 | +---------+                +--------|    |------+  |
 |                                     |    |         |
 +-------------------------------------+    +---------+

In order for the host to access the sub device's register space, the
spi-avmm IP is needed to receive the formatted byte stream from host,
convert them to internal Avmm RW, and send back results to host. 

> there looks to be a lot of abstraction layers simply within the software
> here which make things hard to follow.  At the very least there doesn't

We need to follow the 3 layers protocol for register accessing. On SPI
slave side, spi-avmm HW finishes the whole protocol encoding/decoding
work. But on host side, no dedicated IP block is designed. So host need
to handle all the protocol work by SW. This introduces the complexity of
the driver.
We don't introduce any extra software layers, just follows the
definition of 3 layers in HW spec. But I know reviewing the detail of the
protocol is tedious. Maybe I should put more comments about what part of
SPEC should be referenced for some piece of code. Hope this makes the
review work easier.

> seem to be any interaction with this other than proxying stuff.  As
> things stand this would be the largest regmap bus implementation by an
> order of magnitude.
> 
> It is not clear to me that this is really a generic thing that will have
> multiple users and that it shouldn't be implemented as reg_read() and
> reg_write() operations in the driver that uses it.

This spi-avmm IP is not dedicated to the intel Max10 bmc. It is a soft IP
provided in Altera (now Intel) IP library. It could be implemented on
FPGA/CPLDs according to designers need. Actually Max10 is the CPLD chip which
is programed to have this IP on it.
I think it may be good to implement the regmap to support any SPI chips with
this IP.

Another thing is, the Max10 could integrate some sub devices (soft IPs) which
are already supported by platform drivers. Using the regmap could make
the sub devices supported by these drivers in a generic way, just like the way
we do in recent spi-altera patchset.

> 
> > +config REGMAP_SPI_AVMM
> > +	tristate
> > +	depends on SPI
> 
> Note that for selected symbols dependencies don't take effect.

I see. So should I change something here? I see the same case for other
regmap options.

> 
> > @@ -0,0 +1,932 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for Intel SPI Slave to AVMM Bus Bridge
> 
> Please make the entire comment a C++ one so things look omre
> intentional.

Yes I'll change it.

> 
> > + * Reference Documents could be found at:
> > + * https://www.intel.com/content/www/us/en/programmable/documentation/
> > + * sfo1400787952932.html
> 
> Please don't corrupt links like this, that makes them harder to use.

I see. No wrapper for the URL.

> 
> > + * The main function of the physical layer is the use of PHY_IDLE (4a). Host
> > + * issues SCLK to query data from slave, but if slave is not ready to submit
> > + * data yet, it will repeat PHY_IDLE until data is prepared.
> > + * Because of this special char, it also needs an ESCAPE char (4d), to help
> > + * represent data "4a". The escape rule is "4d first, following 4a ^ 20".
> > + * So "4d, 6a" for data "4a", and "4d, 6d" for data "4d".
> 
> > + * The packet layer defines the boundary of a whole packet. It defines the
> > + * Start Of Packet (SOP, 7a) char and End Of Packet (EOP, 7b) char. Please
> > + * note that the non-special byte after EOP is the last byte of the packet.
> > + * The packet layer also defines a Channel char (7c) + Channel number for
> > + * multiple channel transfer. This not currently supported by this driver. So
> > + * host will always send "7c, 00" when needed, and will drop the packet if
> > + * "7c, non-zero" is received.
> > + * Finally, a packet layer ESCAPE char (7d) is also needed to represent a
> > + * data value that is the same as the special chars. The escape rule is the
> > + * same. The escape rule should be used if the last byte requires it. So if a
> > + * packet ends up with data 7a, the last bytes should be "7b, 7d, 5a".
> 
> This comment is not particularly intelligable.  I assume all these
> number/letter combinations are references to something - it'd be good to
> say what.

Yes I'll add the table of definitions of these chars referenced in HW
spec.

> 
> > +/* slave's register addr is 32 bits */
> > +#define REG_SIZE		4UL
> > +/* slave's register value is 32 bits */
> > +#define VAL_SIZE		4UL
> 
> These and many of the other constants are liable to conflict with
> something, namespacing would be good.

Yes I'll add the prefix for naming.

> 
> > +struct trans_header {
> > +	u8 trans_code;
> > +	u8 rsvd;
> > +	__be16 size;
> > +	__be32 addr;
> > +};
> > +
> > +struct trans_response {
> > +	u8 r_trans_code;
> > +	u8 rsvd;
> > +	__be16 size;
> > +};
> 
> Do these need to be packed?

Yes.

> 
> > +/* No additional chars are in transaction layer RX, just read out data */
> > +#define TRANS_RX_MAX		(VAL_SIZE * MAX_RX_CNT)
> > +/*
> 
> Blank line before the comment.

Yes.

> 
> > +#define TRANS_BUF_SIZE		((TRANS_TX_MAX > TRANS_RX_MAX) ?	\
> > +				 TRANS_TX_MAX : TRANS_RX_MAX)
> 
> This could be more simply written using max() couldn't it (which IIRC
> can also be evaluated at compile time)?

I tried to use max(), but seems it can only be used within a function.
We intend to use the macro in struct definition:

  struct spi_avmm_bridge {
          ...
          char trans_buf[TRANS_BUF_SIZE];
          char phy_buf[PHY_BUF_SIZE];
  };

It will cause the compile error with max().

> 
> > +/* Format a transaction layer byte stream for tx_buf */
> > +static void trans_tx_prepare(bool is_read, u32 reg, u16 count, u32 *wr_val,
> > +			     char *tx_buf, unsigned int *tx_len)
> > +{
> > +	struct trans_header *header;
> > +	u8 trans_code;
> > +	__le32 *data;
> > +	int i;
> > +
> > +	trans_code = is_read ?
> > +			(count == 1 ? TRANS_CODE_READ : TRANS_CODE_SEQ_READ) :
> > +			(count == 1 ? TRANS_CODE_WRITE : TRANS_CODE_SEQ_WRITE);
> 
> Please write this using normal conditional statements for legibility.

Yes.

> 
> > +	header = (struct trans_header *)tx_buf;
> 
> No need to cast away from char *.

Yes.

> 
> > +/*
> > + * The input is a transaction layer byte stream in rx_buf, the output is read
> > + * out data.
> > + */
> > +static int trans_rx_parse(bool is_read, char *rx_buf, unsigned int rx_len,
> > +			  u16 expected_count, u32 *rd_val)
> > +{
> > +	unsigned int expected_len = expected_count * VAL_SIZE;
> > +
> > +	if (is_read) {
> > +		if (expected_len != rx_len)
> > +			return -EINVAL;
> > +
> > +		return rd_trans_rx_parse(rx_buf, rx_len, rd_val);
> > +	}
> > +
> > +	return wr_trans_rx_parse(rx_buf, rx_len, expected_len);
> > +}
> 
> Please write the is_read check as an if/else, it'd be clearer.

Yes.

> 
> > +/* Packet Layer & Physical Layer */
> > +/* The input is a trans stream in trans_buf, format a phy stream in phy_buf. */
> > +static void pkt_phy_tx_prepare(char *trans_buf, unsigned int trans_len,
> > +			       char *phy_buf, unsigned int *phy_len)
> > +{
> > +	unsigned int i;
> > +	char *b, *p;
> > +
> > +	b = trans_buf;
> > +	p = phy_buf;
> 
> I'm not seeing any bounds checking on the size of an operation in this
> function and I think I'd expect some, similarly for a lot of the other
> I/O operations.

I have caculated and allocated 2 buffers that are large enough to
contain any possible data stream for regmap_bus.max_raw_read/write. See
the definition of TRANS_BUF_SIZE & PHY_BUF_SIZE.

So maybe we don't have to check the length?

> 
> > +	poll_timeout = jiffies + SPI_AVMM_XFER_TIMEOUT;
> > +	for (;;) {
> 
> Please rewrite this loop so it's clear that it terminates, usually
> that'd mean a do { } while (!timeout) type construction.  The extra
> effort involved in doing one more check after timeout could just as well
> be a slightly longer timeout and it'd be clearer.
> 
> > +		/*
> > +		 * We timeout when rx is invalid for some time. But
> > +		 * it is possible we are scheduled out for long time
> > +		 * after a spi_read. So when we are scheduled in, a SW
> > +		 * timeout happens. But actually HW may have worked fine and
> > +		 * has been ready long time ago. So we need to do an extra
> > +		 * read, if we get a valid word we return a valid rx word,
> > +		 * otherwise real a HW issue happens.
> > +		 */
> > +		if (time_after(jiffies, poll_timeout))
> > +			last_try = true;
> 
> If the system is that heavily loaded I fear there's bigger problems, you
> could also express the timeout in terms of number of times you poll with
> a delay (at the minute this will busy wait which doesn't seem ideal
> either).

Actually this is to fix issue found on systems with Realtime kernel
patchset. In the system you may be scheduled out for enough long time as
long as the higher priority tasks keep running. In that case the slightly
longer timeout didn't work. The number of times delay is not a good
solution either. So I still want to keep the last_try machanism. But
I'll try my best to rewrite this to make it clear when it terminates.

> 
> > +static void br_tx_prepare(struct spi_avmm_bridge *br, bool is_read, u32 reg,
> > +			  u16 count, u32 *wr_val)
> > +{
> > +	unsigned int tx_len;
> > +
> > +	trans_tx_prepare(is_read, reg, count, wr_val,
> > +			 br->trans_buf, &tx_len);
> > +	pkt_phy_tx_prepare(br->trans_buf, tx_len,
> > +			   br->phy_buf, &tx_len);
> > +	phy_tx_pad(br->word_len, br->phy_buf, tx_len, &tx_len);
> > +
> > +	br->phy_len = tx_len;
> > +}
> 
> This is the sort of thing I'm looking at when I say this code has too
> many abstraction layers, this function and all of the functions it calls
> have exactly one caller spread out all over the code and I can't help
> but think that some of them could be usefully inlined.  As things stand
> it's really hard to tell what any individual bit of code is supposed to
> be doing or if it's doing it correctly.

OK. I'll try to refactor the code and remove unnecessary function calls,
only keep the functions that represents the steps clearly defined in HW
spec, and add some comments about what part of spec they are referenced.

> 
> > +	ret = ret ? : (eop ? 0 : -EINVAL);
> > +	if (ret) {
> > +		dev_err(&br->spi->dev, "%s br txrx err %d\n", __func__, ret);
> > +		print_hex_dump(KERN_DEBUG, "phy rx:", DUMP_PREFIX_OFFSET,
> > +			       16, 1, br->phy_buf, rx_len, true);
> > +	}
> 
> Please write normal conditional statements for legibility.

Yes.

> 
> > +
> > +#define do_reg_read(_ctx, _reg, _value, _count) \
> > +	do_reg_access(_ctx, true, _reg, _value, _count)
> > +#define do_reg_write(_ctx, _reg, _value, _count) \
> > +	do_reg_access(_ctx, false, _reg, _value, _count)
> 
> Please write these as proper functions so that the compiler can check
> things more thoroughly.

Yes

> 
> > +static int regmap_spi_avmm_gather_write(void *context,
> > +					const void *reg_buf, size_t reg_len,
> > +					const void *val_buf, size_t val_len)
> > +{
> > +	if (reg_len != REG_SIZE)
> > +		return -EINVAL;
> > +
> > +	return do_reg_write(context, *(u32 *)reg_buf, (u32 *)val_buf,
> > +			    (u16)(val_len / VAL_SIZE));
> > +}
> 
> The cast on the length looks worrying...  

OK, I'll reconsider the do_reg_access definition. Cast to u16 here seems
a little confusing.

> 
> > +	/* Only support BPW == 8 or 32 now */
> > +	if (spi->bits_per_word != 8 && spi->bits_per_word != 32)
> > +		return ERR_PTR(-EINVAL);
> 
> Most controllers support configurable bits per word (and modes) - you
> shouldn't be rejecting things based on whatever the default happens to
> be.

I'm not sure if it is good that the spi_avmm_regmap_init changes the
configuration of spi devices silently.
In my current implementation, the spi device driver should be aware and
choose the right spi setup before trying to init the regmap. Would it be
too hard for other drivers to use it?

> 
> > +static const struct regmap_bus regmap_spi_avmm_bus = {
> > +	.write = regmap_spi_avmm_write,
> > +	.gather_write = regmap_spi_avmm_gather_write,
> > +	.read = regmap_spi_avmm_read,
> > +	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
> > +	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
> > +	.max_raw_read = VAL_SIZE * MAX_RX_CNT,
> > +	.max_raw_write = VAL_SIZE * MAX_TX_CNT,
> > +
> > +	.reg_write = regmap_spi_avmm_reg_write,
> > +	.reg_read = regmap_spi_avmm_reg_read,
> > +
> > +	.free_context = spi_avmm_bridge_ctx_free,
> > +};
> 
> This seems confused, you shouldn't have both unformatted I/O operations
> and register I/O operations.  Either the hardware implements a byte
> stream and the core will handle formatting register operations into that
> byte stream or the hardware understands registers and values in which
> case there shouldn't be unformatted operations.  A combination of the
> two is not going to work well.

I see. We implemented the byte stream callbacks because we need to
support incremental register read/write mode. I'll remove the
reg_write/read callbacks.

Thanks,
Yilun
