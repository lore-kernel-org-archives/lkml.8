Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB08AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2432075B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="xVA4Ktes";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="kn5ejahn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbgHXJWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:22:05 -0400
Received: from smtp73.iad3a.emailsrvr.com ([173.203.187.73]:47919 "EHLO
        smtp73.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728634AbgHXJVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:21:50 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Aug 2020 05:21:48 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1598260560;
        bh=uNN8RH7yD1tX56e4Kxpu5Me0wrJfDcdmUMAuerB8/Ik=;
        h=Subject:To:From:Date:From;
        b=xVA4KtesSPRHbx4Zmp1oT2kJsLYbtmYhBzmL2gmH245/S0dOupAxHQbSWKbqQuMim
         PNxhjhdpJkjrhYHRMMdi24Ucy4WYpJ1YzL9YsuqWw34wXxkJyuUmJDwF/6tNzO461j
         9e1g1mV8TMaxTvmNaiB2XMKDebAjwP45LJxSDhR4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1598260560;
        bh=uNN8RH7yD1tX56e4Kxpu5Me0wrJfDcdmUMAuerB8/Ik=;
        h=Subject:To:From:Date:From;
        b=kn5ejahn1loWVmHP9ZxdMhiJB3U5V3F5ejOE/ui337q4NWpfKPWR64GSGkdC6wZrj
         8v2RzdtCqHKJEp058oo+HuaWuWShoFzQFCId9xSGRwldgFTz2aUxFPcq19n74feQ8s
         iJ/qUzhyQwg/KxcIDoBxBv7hLofCq9PzmnQKTZTA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp34.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id AA51D22A40;
        Mon, 24 Aug 2020 05:15:59 -0400 (EDT)
Subject: Re: [PATCH] drivers: staging: comedi: fixed duplicate words from
 checkpatch
To:     Ethan Edwards <ethancarteredwards@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, hsweeten@visionengravers.com,
        devel@driverdev.osuosl.org
References: <20200822202131.53kpj2gg35af6vud@archlaptop.localdomain>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <5ede8454-31d8-25d7-c01a-7b2c94fc499e@mev.co.uk>
Date:   Mon, 24 Aug 2020 10:15:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200822202131.53kpj2gg35af6vud@archlaptop.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: 3ebe9e8a-bc3c-4e53-b469-784198286fc4-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2020 21:21, Ethan Edwards wrote:
> Fixed various different checkpatch duplicate word warnings, the TODO
> file said to fix checkpatch warnings.
> 
> My old email didn't CC the mailing lists, ignore the old one, sorry.

Everything above the '---' line ends up in the git commit message 
(unless edited out manually, and Greg hates that).  The comment about 
CC'ing email lists doesn't belong in the commit message.  Could you send 
a '[PATCH v2]' with that line edited out and place a description of the 
v2 changes just below the '---' line?

Thanks.

> 
> Signed-off-by: Ethan Edwards <ethancarteredwards@gmail.com>
> ---
>   drivers/staging/comedi/comedi.h                  | 4 ++--
>   drivers/staging/comedi/comedidev.h               | 2 +-
>   drivers/staging/comedi/drivers/addi_apci_1564.c  | 4 ++--
>   drivers/staging/comedi/drivers/comedi_8255.c     | 2 +-
>   drivers/staging/comedi/drivers/ni_tiocmd.c       | 2 +-
>   drivers/staging/comedi/drivers/pcmuio.c          | 2 +-
>   drivers/staging/comedi/drivers/quatech_daqp_cs.c | 2 +-
>   7 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/comedi/comedi.h b/drivers/staging/comedi/comedi.h
> index 09a940066c0e..b5d00a006dbb 100644
> --- a/drivers/staging/comedi/comedi.h
> +++ b/drivers/staging/comedi/comedi.h
> @@ -680,7 +680,7 @@ struct comedi_rangeinfo {
>    * value of 1 volt.
>    *
>    * The only defined flag value is %RF_EXTERNAL (%0x100), indicating that the
> - * the range needs to be multiplied by an external reference.
> + * range needs to be multiplied by an external reference.
>    */
>   struct comedi_krange {
>   	int min;
> @@ -970,7 +970,7 @@ enum i8254_mode {
>    *   major reasons exist why this caused major confusion for users:
>    *   1) The register values are _NOT_ in user documentation, but rather in
>    *     arcane locations, such as a few register programming manuals that are
> - *     increasingly hard to find and the NI MHDDK (comments in in example code).
> + *     increasingly hard to find and the NI MHDDK (comments in example code).
>    *     There is no one place to find the various valid values of the registers.
>    *   2) The register values are _NOT_ completely consistent.  There is no way to
>    *     gain any sense of intuition of which values, or even enums one should use
> diff --git a/drivers/staging/comedi/comedidev.h b/drivers/staging/comedi/comedidev.h
> index 0dff1ac057cd..0e1b95ef9a4d 100644
> --- a/drivers/staging/comedi/comedidev.h
> +++ b/drivers/staging/comedi/comedidev.h
> @@ -627,7 +627,7 @@ extern const struct comedi_lrange range_unknown;
>    * @range: Array of &struct comedi_krange, one for each range.
>    *
>    * Each element of @range[] describes the minimum and maximum physical range
> - * range and the type of units.  Typically, the type of unit is %UNIT_volt
> + * and the type of units.  Typically, the type of unit is %UNIT_volt
>    * (i.e. volts) and the minimum and maximum are in millionths of a volt.
>    * There may also be a flag that indicates the minimum and maximum are merely
>    * scale factors for an unknown, external reference.
> diff --git a/drivers/staging/comedi/drivers/addi_apci_1564.c b/drivers/staging/comedi/drivers/addi_apci_1564.c
> index fadefcb5c237..06fc7ed96200 100644
> --- a/drivers/staging/comedi/drivers/addi_apci_1564.c
> +++ b/drivers/staging/comedi/drivers/addi_apci_1564.c
> @@ -544,7 +544,7 @@ static int apci1564_timer_insn_write(struct comedi_device *dev,
>   {
>   	struct apci1564_private *devpriv = dev->private;
>   
> -	/* just write the last last to the reload register */
> +	/* just write the last to the reload register */
>   	if (insn->n) {
>   		unsigned int val = data[insn->n - 1];
>   
> @@ -628,7 +628,7 @@ static int apci1564_counter_insn_write(struct comedi_device *dev,
>   	unsigned int chan = CR_CHAN(insn->chanspec);
>   	unsigned long iobase = devpriv->counters + APCI1564_COUNTER(chan);
>   
> -	/* just write the last last to the reload register */
> +	/* just write the last to the reload register */
>   	if (insn->n) {
>   		unsigned int val = data[insn->n - 1];
>   
> diff --git a/drivers/staging/comedi/drivers/comedi_8255.c b/drivers/staging/comedi/drivers/comedi_8255.c
> index 3298725b9ba5..b7ca465933ee 100644
> --- a/drivers/staging/comedi/drivers/comedi_8255.c
> +++ b/drivers/staging/comedi/drivers/comedi_8255.c
> @@ -248,7 +248,7 @@ EXPORT_SYMBOL_GPL(subdev_8255_mm_init);
>    * subdev_8255_regbase - get offset of 8255 registers or call-back context
>    * @s: comedi subdevice
>    *
> - * Returns the 'regbase' parameter that was previously passed to to
> + * Returns the 'regbase' parameter that was previously passed to
>    * subdev_8255_init() or subdev_8255_mm_init() to set up the subdevice.
>    * Only valid if the subdevice was set up successfully.
>    */
> diff --git a/drivers/staging/comedi/drivers/ni_tiocmd.c b/drivers/staging/comedi/drivers/ni_tiocmd.c
> index 2a9f7e9821a7..ab6d9e8269f3 100644
> --- a/drivers/staging/comedi/drivers/ni_tiocmd.c
> +++ b/drivers/staging/comedi/drivers/ni_tiocmd.c
> @@ -286,7 +286,7 @@ int ni_tio_cmdtest(struct comedi_device *dev,
>   		 * This should be done, but we don't yet know the actual
>   		 * register values.  These should be tested and then documented
>   		 * in the ni_route_values/ni_*.csv files, with indication of
> -		 * who/when/which/how these these were tested.
> +		 * who/when/which/how these were tested.
>   		 * When at least a e/m/660x series have been tested, this code
>   		 * should be uncommented:
>   		 *
> diff --git a/drivers/staging/comedi/drivers/pcmuio.c b/drivers/staging/comedi/drivers/pcmuio.c
> index 7e1fc6ffb48c..b299d648a0eb 100644
> --- a/drivers/staging/comedi/drivers/pcmuio.c
> +++ b/drivers/staging/comedi/drivers/pcmuio.c
> @@ -48,7 +48,7 @@
>    *
>    * In the 48-channel version:
>    *
> - * On subdev 0, the first 24 channels channels are edge-detect channels.
> + * On subdev 0, the first 24 channels are edge-detect channels.
>    *
>    * In the 96-channel board you have the following channels that can do edge
>    * detection:
> diff --git a/drivers/staging/comedi/drivers/quatech_daqp_cs.c b/drivers/staging/comedi/drivers/quatech_daqp_cs.c
> index 1b1efa4d31f6..fe4408ebf6b3 100644
> --- a/drivers/staging/comedi/drivers/quatech_daqp_cs.c
> +++ b/drivers/staging/comedi/drivers/quatech_daqp_cs.c
> @@ -164,7 +164,7 @@ static int daqp_clear_events(struct comedi_device *dev, int loops)
>   
>   	/*
>   	 * Reset any pending interrupts (my card has a tendency to require
> -	 * require multiple reads on the status register to achieve this).
> +	 * multiple reads on the status register to achieve this).
>   	 */
>   	while (--loops) {
>   		status = inb(dev->iobase + DAQP_STATUS_REG);
> 


-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
