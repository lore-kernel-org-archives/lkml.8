Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21538C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF662084E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EfUTAI1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgCBT36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:29:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:43717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbgCBT35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583177381;
        bh=qyDhj0kJ8ZIHfnidgzR/12jmyFaqhF0mSW+bGJs816w=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EfUTAI1zTvnUk3zRgd7XHtBvg5kgYlKdVpouDRHJTrSiUcGbVCfvMVJvuPDutez/i
         ml//K4lLTt45RwSAoFjeJbtrb9OsUpk/kB3DqgAvELuTVunZKWis29Wf7f9AqlNn2s
         EvyL+lj3PagFMi6+a+Jd/R76sFPv0lOFsZspyD7o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.130.108]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72sJ-1j1OVm28jf-008cFa; Mon, 02
 Mar 2020 20:29:41 +0100
Subject: Re: [PATCH 2/7] parport: Use more comon logging styles
To:     Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1582878393.git.joe@perches.com>
 <1da80f696e3602cc2533988b20f9a47cd42db1c4.1582878394.git.joe@perches.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <b4a4f5a8-9ff0-e3d3-93c9-260a11cdb439@gmx.de>
Date:   Mon, 2 Mar 2020 20:29:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1da80f696e3602cc2533988b20f9a47cd42db1c4.1582878394.git.joe@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eZCpXSXRAuAvoXF3q0hVhwAcT7FphkcVRJcX1ZtuvY0FboWkf4w
 OlEHUf3B/BiKSxKJYmmgqKiBeBiqVww5CkcovdXSxefFeBV/DmIc19K+LewKIaOkLxiNlUX
 /qY4KMNvmiTLE/rpREZ5aZR8a8PBPGUXMpzOiHv9Q61tnI3KHcyyTNU/ZS9pCZUpDVD2gBw
 PP/IPQWzaPcu/uE35zrsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VvFuAY2brmk=:RJF1WaKtdj7DfyPiXxFwl0
 x7dskef4PT9zRP0OGaSbCybbpqvOd2QNhmf9sS6/O2XC5EjMQhu6rFKqsD35sp1t3fjhzjp9Y
 UWgj6VwLP5JDWM4bcWJ7QC0fwpmf/dKdpwcrfEUTpaGHCeC5B4MAE9Ei7/gT7Vz74S2w+kuH5
 odlzOsQSCW3xrOoAIA6CbARq2n9eZCyWfkVCEagbfbVkEFbCc10Nolqe+qnHN+VW9Jc1O7rnr
 E3p+MethnJkeyBwBHwe+3B2EnEXJDS45TfoT10iWaBnEY6zw1cVtDXMLsfgZRppBPvGP+GKhs
 AIGXLa2CK+IstX9Ccn4GoJ/6BxZN+B5N2q+z7JsClidSWoktB9kgng/DJonqbLn/n/wKkfj+F
 0n1g9Z81GED+/KmmGXtm/77ZQaw5dEIkgOCvQDkiJ+GUDb5iJE1EWi0RgT0QWMY9P/kpt68hp
 g2EbEsTggPcE89sKKb1Cz8aJ6HgyZK3GrViwQcK9cup3L06Jf4b4lbKMhseXseXz43dUwBoN6
 obw3duqQxm6z3lozXIU2ic7ksl9GFLv6bm3MHceUwBP4IDIdESydHAdRbkQ3NmxBouoR+vTQW
 VC4x9VanYhEFZHY9ka7IMl+0SoQqVVDAs+EeNmBognaYbXl3D77Pi+KotUbNVt3NaWPCTs8uP
 p3PhpyE7nkT41YZZZTzFij6fegRT7Eu9DmcgUR6766FjiU4nzf4a0fABG4G3xwvczjB3w7ZDJ
 u9QBT9i1dpo5W1LX9ibgwCqQHrtTAVAL3ZRv7mzIY1JzWBpAzXehror+zl4YKp8gBrnmI3eNw
 VrwTb5TKqd+CsGDZLmvoNcL7CmmmJ5qN4lWdHLqkfGRIk3FkgLDBS87wZTevrMQyq+Ew4kKEl
 6jrC5tT5qrGsvfYljnETkFzuGCHsBK5hiMTp72eCwrkhfGwnyHeYXPMWlD501SWVIdR0wwIX/
 I7Ex5TN2dHvNhmSF2o75TW7e09I/PgYemO21bNAHUa/lxu188AtjY25dLkl73PVVRH8kR0YOs
 y0ciootvqACNj5wSN9qdgXL6ttzymOP6mQgn2cPGCtolEAuRI/+HJA/6E7w2HsTn+q1wv19jA
 S4MHnGCQnXvSLbQj/ucOBfJKllZo+J/vlvz6T9mv/1ZxuaMLo+M9iQA96zIM7beFscwbHXxFz
 9OpVBa422kuspljJLWPAry8+qGv0Ojy+jihFgsJ2Hy3c5GqY+nxnEW/ur0sUDJJWec7kl8OUw
 ObarhdVgM3GBJ7avf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.02.20 09:32, Joe Perches wrote:
> Some of the logging can be poorly formatted because of unexpected
> line breaks given printks without KERN_CONT that should be pr_cont.
>
> Miscellanea:
>
> o Remove unnecessary spaces between function name and open parenthesis
> o Convert bare printks to pr_<level> where appropriate
> o Convert embedded function names to use %s, __func__
> o Coalesce formats
> o Realign arguments
> o Use do {} while (0) in a macro and not a bare if
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/parport/parport_gsc.c  | 10 ++--
>  drivers/parport/parport_gsc.h  | 21 ++++----
>  drivers/parport/parport_ip32.c | 92 ++++++++++++++++++----------------
>  drivers/parport/parport_pc.c   | 62 +++++++++++------------
>  drivers/parport/probe.c        | 27 ++++------
>  drivers/parport/share.c        | 13 +++--
>  6 files changed, 108 insertions(+), 117 deletions(-)
>
> diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_gsc=
.c
> index 81082d..cb6a08 100644
> --- a/drivers/parport/parport_gsc.c
> +++ b/drivers/parport/parport_gsc.c
> @@ -238,14 +238,14 @@ struct parport *parport_gsc_probe_port(unsigned lo=
ng base,
>
>  	priv =3D kzalloc (sizeof (struct parport_gsc_private), GFP_KERNEL);
>  	if (!priv) {
> -		printk (KERN_DEBUG "parport (0x%lx): no memory!\n", base);
> +		printk(KERN_DEBUG "parport (0x%lx): no memory!\n", base);

pr_warn() instead?

>  		return NULL;
>  	}
>  	ops =3D kmemdup(&parport_gsc_ops, sizeof(struct parport_operations),
>  		      GFP_KERNEL);
>  	if (!ops) {
> -		printk (KERN_DEBUG "parport (0x%lx): no memory for ops!\n",
> -			base);
> +		printk(KERN_DEBUG "parport (0x%lx): no memory for ops!\n",
> +		       base);

pr_warn() instead too ?

>  		kfree (priv);
>  		return NULL;
>  	}
> @@ -359,11 +359,11 @@ static int __init parport_init_chip(struct parisc_=
device *dev)
>  	if (boot_cpu_data.cpu_type > pcxt && !pdc_add_valid(port+4)) {
>
>  		/* Initialize bidirectional-mode (0x10) & data-tranfer-mode #1 (0x20)=
 */
> -		printk("%s: initialize bidirectional-mode.\n", __func__);
> +		pr_info("%s: initialize bidirectional-mode\n", __func__);
>  		parport_writeb ( (0x10 + 0x20), port + 4);
>
>  	} else {
> -		printk("%s: enhanced parport-modes not supported.\n", __func__);
> +		pr_info("%s: enhanced parport-modes not supported\n", __func__);
>  	}
>
>  	p =3D parport_gsc_probe_port(port, 0, dev->irq,
> diff --git a/drivers/parport/parport_gsc.h b/drivers/parport/parport_gsc=
.h
> index 4c4d3c..9301217 100644
> --- a/drivers/parport/parport_gsc.h
> +++ b/drivers/parport/parport_gsc.h
> @@ -71,7 +71,7 @@ struct parport_gsc_private {
>  static inline void parport_gsc_write_data(struct parport *p, unsigned c=
har d)
>  {
>  #ifdef DEBUG_PARPORT
> -	printk (KERN_DEBUG "parport_gsc_write_data(%p,0x%02x)\n", p, d);
> +	printk(KERN_DEBUG "%s(%p,0x%02x)\n", __func__, p, d);

pr_debug() ?

>  #endif
>  	parport_writeb(d, DATA(p));
>  }
> @@ -80,8 +80,7 @@ static inline unsigned char parport_gsc_read_data(stru=
ct parport *p)
>  {
>  	unsigned char val =3D parport_readb (DATA (p));
>  #ifdef DEBUG_PARPORT
> -	printk (KERN_DEBUG "parport_gsc_read_data(%p) =3D 0x%02x\n",
> -		p, val);
> +	printk(KERN_DEBUG "%s(%p) =3D 0x%02x\n", __func__, p, val);

pr_debug() ?

>  #endif
>  	return val;
>  }
> @@ -95,9 +94,9 @@ static inline unsigned char __parport_gsc_frob_control=
(struct parport *p,
>  	struct parport_gsc_private *priv =3D p->physport->private_data;
>  	unsigned char ctr =3D priv->ctr;
>  #ifdef DEBUG_PARPORT
> -	printk (KERN_DEBUG
> -		"__parport_gsc_frob_control(%02x,%02x): %02x -> %02x\n",
> -		mask, val, ctr, ((ctr & ~mask) ^ val) & priv->ctr_writable);
> +	printk(KERN_DEBUG "%s(%02x,%02x): %02x -> %02x\n",

pr_debug() ?

> +	       __func__, mask, val,
> +	       ctr, ((ctr & ~mask) ^ val) & priv->ctr_writable);
>  #endif
>  	ctr =3D (ctr & ~mask) ^ val;
>  	ctr &=3D priv->ctr_writable; /* only write writable bits. */
> @@ -126,8 +125,8 @@ static inline void parport_gsc_write_control(struct =
parport *p,
>
>  	/* Take this out when drivers have adapted to newer interface. */
>  	if (d & 0x20) {
> -		printk (KERN_DEBUG "%s (%s): use data_reverse for this!\n",
> -			p->name, p->cad->name);
> +		printk(KERN_DEBUG "%s (%s): use data_reverse for this!\n",
> +		       p->name, p->cad->name);

here too?

>  		parport_gsc_data_reverse (p);
>  	}
>
> @@ -155,9 +154,9 @@ static inline unsigned char parport_gsc_frob_control=
(struct parport *p,
>
>  	/* Take this out when drivers have adapted to newer interface. */
>  	if (mask & 0x20) {
> -		printk (KERN_DEBUG "%s (%s): use data_%s for this!\n",
> -			p->name, p->cad->name,
> -			(val & 0x20) ? "reverse" : "forward");
> +		printk(KERN_DEBUG "%s (%s): use data_%s for this!\n",

and here?

> +		       p->name, p->cad->name,
> +		       (val & 0x20) ? "reverse" : "forward");
>  		if (val & 0x20)
>  			parport_gsc_data_reverse (p);
>  		else
> diff --git a/drivers/parport/parport_ip32.c b/drivers/parport/parport_ip=
32.c
> index 4f76e4..48b084 100644
> --- a/drivers/parport/parport_ip32.c
> +++ b/drivers/parport/parport_ip32.c
> @@ -328,19 +328,19 @@ static void parport_ip32_dump_state(struct parport=
 *p, char *str,
>  						     "TST", "CFG"};
>  		unsigned int ecr =3D readb(priv->regs.ecr);
>  		printk(KERN_DEBUG PPIP32 "    ecr=3D0x%02x", ecr);
> -		printk(" %s",
> -		       ecr_modes[(ecr & ECR_MODE_MASK) >> ECR_MODE_SHIFT]);
> +		pr_cont(" %s",
> +			ecr_modes[(ecr & ECR_MODE_MASK) >> ECR_MODE_SHIFT]);
>  		if (ecr & ECR_nERRINTR)
> -			printk(",nErrIntrEn");
> +			pr_cont(",nErrIntrEn");
>  		if (ecr & ECR_DMAEN)
> -			printk(",dmaEn");
> +			pr_cont(",dmaEn");
>  		if (ecr & ECR_SERVINTR)
> -			printk(",serviceIntr");
> +			pr_cont(",serviceIntr");
>  		if (ecr & ECR_F_FULL)
> -			printk(",f_full");
> +			pr_cont(",f_full");
>  		if (ecr & ECR_F_EMPTY)
> -			printk(",f_empty");
> -		printk("\n");
> +			pr_cont(",f_empty");
> +		pr_cont("\n");
>  	}
>  	if (show_ecp_config) {
>  		unsigned int oecr, cnfgA, cnfgB;
> @@ -352,52 +352,53 @@ static void parport_ip32_dump_state(struct parport=
 *p, char *str,
>  		writeb(ECR_MODE_PS2, priv->regs.ecr);
>  		writeb(oecr, priv->regs.ecr);
>  		printk(KERN_DEBUG PPIP32 "    cnfgA=3D0x%02x", cnfgA);
> -		printk(" ISA-%s", (cnfgA & CNFGA_IRQ) ? "Level" : "Pulses");
> +		pr_cont(" ISA-%s", (cnfgA & CNFGA_IRQ) ? "Level" : "Pulses");
>  		switch (cnfgA & CNFGA_ID_MASK) {
>  		case CNFGA_ID_8:
> -			printk(",8 bits");
> +			pr_cont(",8 bits");
>  			break;
>  		case CNFGA_ID_16:
> -			printk(",16 bits");
> +			pr_cont(",16 bits");
>  			break;
>  		case CNFGA_ID_32:
> -			printk(",32 bits");
> +			pr_cont(",32 bits");
>  			break;
>  		default:
> -			printk(",unknown ID");
> +			pr_cont(",unknown ID");
>  			break;
>  		}
>  		if (!(cnfgA & CNFGA_nBYTEINTRANS))
> -			printk(",ByteInTrans");
> +			pr_cont(",ByteInTrans");
>  		if ((cnfgA & CNFGA_ID_MASK) !=3D CNFGA_ID_8)
> -			printk(",%d byte%s left", cnfgA & CNFGA_PWORDLEFT,
> -			       ((cnfgA & CNFGA_PWORDLEFT) > 1) ? "s" : "");
> -		printk("\n");
> +			pr_cont(",%d byte%s left",
> +				cnfgA & CNFGA_PWORDLEFT,
> +				((cnfgA & CNFGA_PWORDLEFT) > 1) ? "s" : "");
> +		pr_cont("\n");
>  		printk(KERN_DEBUG PPIP32 "    cnfgB=3D0x%02x", cnfgB);
> -		printk(" irq=3D%u,dma=3D%u",
> -		       (cnfgB & CNFGB_IRQ_MASK) >> CNFGB_IRQ_SHIFT,
> -		       (cnfgB & CNFGB_DMA_MASK) >> CNFGB_DMA_SHIFT);
> -		printk(",intrValue=3D%d", !!(cnfgB & CNFGB_INTRVAL));
> +		pr_cont(" irq=3D%u,dma=3D%u",
> +			(cnfgB & CNFGB_IRQ_MASK) >> CNFGB_IRQ_SHIFT,
> +			(cnfgB & CNFGB_DMA_MASK) >> CNFGB_DMA_SHIFT);
> +		pr_cont(",intrValue=3D%d", !!(cnfgB & CNFGB_INTRVAL));
>  		if (cnfgB & CNFGB_COMPRESS)
> -			printk(",compress");
> -		printk("\n");
> +			pr_cont(",compress");
> +		pr_cont("\n");
>  	}
>  	for (i =3D 0; i < 2; i++) {
>  		unsigned int dcr =3D i ? priv->dcr_cache : readb(priv->regs.dcr);
>  		printk(KERN_DEBUG PPIP32 "    dcr(%s)=3D0x%02x",
>  		       i ? "soft" : "hard", dcr);
> -		printk(" %s", (dcr & DCR_DIR) ? "rev" : "fwd");
> +		pr_cont(" %s", (dcr & DCR_DIR) ? "rev" : "fwd");
>  		if (dcr & DCR_IRQ)
> -			printk(",ackIntEn");
> +			pr_cont(",ackIntEn");
>  		if (!(dcr & DCR_SELECT))
> -			printk(",nSelectIn");
> +			pr_cont(",nSelectIn");
>  		if (dcr & DCR_nINIT)
> -			printk(",nInit");
> +			pr_cont(",nInit");
>  		if (!(dcr & DCR_AUTOFD))
> -			printk(",nAutoFD");
> +			pr_cont(",nAutoFD");
>  		if (!(dcr & DCR_STROBE))
> -			printk(",nStrobe");
> -		printk("\n");
> +			pr_cont(",nStrobe");
> +		pr_cont("\n");
>  	}
>  #define sep (f++ ? ',' : ' ')
>  	{
> @@ -405,20 +406,20 @@ static void parport_ip32_dump_state(struct parport=
 *p, char *str,
>  		unsigned int dsr =3D readb(priv->regs.dsr);
>  		printk(KERN_DEBUG PPIP32 "    dsr=3D0x%02x", dsr);
>  		if (!(dsr & DSR_nBUSY))
> -			printk("%cBusy", sep);
> +			pr_cont("%cBusy", sep);
>  		if (dsr & DSR_nACK)
> -			printk("%cnAck", sep);
> +			pr_cont("%cnAck", sep);
>  		if (dsr & DSR_PERROR)
> -			printk("%cPError", sep);
> +			pr_cont("%cPError", sep);
>  		if (dsr & DSR_SELECT)
> -			printk("%cSelect", sep);
> +			pr_cont("%cSelect", sep);
>  		if (dsr & DSR_nFAULT)
> -			printk("%cnFault", sep);
> +			pr_cont("%cnFault", sep);
>  		if (!(dsr & DSR_nPRINT))
> -			printk("%c(Print)", sep);
> +			pr_cont("%c(Print)", sep);
>  		if (dsr & DSR_TIMEOUT)
> -			printk("%cTimeout", sep);
> -		printk("\n");
> +			pr_cont("%cTimeout", sep);
> +		pr_cont("\n");
>  	}
>  #undef sep
>  }
> @@ -1703,7 +1704,7 @@ static size_t parport_ip32_ecp_write_data(struct p=
arport *p,
>
>  		/* Event 49: PError goes high. */
>  		if (parport_wait_peripheral(p, DSR_PERROR, DSR_PERROR)) {
> -			printk(KERN_DEBUG PPIP32 "%s: PError timeout in %s",
> +			printk(KERN_DEBUG PPIP32 "%s: PError timeout in %s\n",

and here?

>  			       p->name, __func__);
>  			physport->ieee1284.phase =3D IEEE1284_PH_ECP_DIR_UNKNOWN;
>  			return 0;
> @@ -2132,10 +2133,13 @@ static __init struct parport *parport_ip32_probe=
_port(void)
>  	/* Print out what we found */
>  	pr_info("%s: SGI IP32 at 0x%lx (0x%lx)", p->name, p->base, p->base_hi)=
;
>  	if (p->irq !=3D PARPORT_IRQ_NONE)
> -		printk(", irq %d", p->irq);
> -	printk(" [");
> -#define printmode(x)	if (p->modes & PARPORT_MODE_##x)		\
> -				printk("%s%s", f++ ? "," : "", #x)
> +		pr_cont(", irq %d", p->irq);
> +	pr_cont(" [");
> +#define printmode(x)							\
> +do {									\
> +	if (p->modes & PARPORT_MODE_##x)				\
> +		pr_cont("%s%s", f++ ? "," : "", #x);			\
> +} while (0)
>  	{
>  		unsigned int f =3D 0;
>  		printmode(PCSPP);
> @@ -2146,7 +2150,7 @@ static __init struct parport *parport_ip32_probe_p=
ort(void)
>  		printmode(DMA);
>  	}
>  #undef printmode
> -	printk("]\n");
> +	pr_cont("]\n");
>
>  	parport_announce_port(p);
>  	return p;
> diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
> index 2872c67..ab3b04f 100644
> --- a/drivers/parport/parport_pc.c
> +++ b/drivers/parport/parport_pc.c
> @@ -298,8 +298,8 @@ static size_t parport_pc_epp_read_data(struct parpor=
t *port, void *buf,
>  			status =3D inb(STATUS(port));
>  			if (status & 0x01) {
>  				/* EPP timeout should never occur... */
> -				printk(KERN_DEBUG
> -"%s: EPP timeout occurred while talking to w91284pic (should not have d=
one)\n", port->name);
> +				printk(KERN_DEBUG "%s: EPP timeout occurred while talking to w91284=
pic (should not have done)\n",


here.

> +				       port->name);
>  				clear_epp_timeout(port);
>  			}
>  		}
> @@ -727,7 +727,7 @@ static size_t parport_pc_compat_write_block_pio(stru=
ct parport *port,
>  	r =3D change_mode(port, ECR_PPF); /* Parallel port FIFO */
>  	if (r)
>  		printk(KERN_DEBUG "%s: Warning change_mode ECR_PPF failed\n",

and here?


There are more such below...

Helge



> -								port->name);
> +		       port->name);
>
>  	port->physport->ieee1284.phase =3D IEEE1284_PH_FWD_DATA;
>
> @@ -770,9 +770,8 @@ static size_t parport_pc_compat_write_block_pio(stru=
ct parport *port,
>  				     PARPORT_STATUS_BUSY,
>  				     PARPORT_STATUS_BUSY);
>  	if (r)
> -		printk(KERN_DEBUG
> -			"%s: BUSY timeout (%d) in compat_write_block_pio\n",
> -			port->name, r);
> +		printk(KERN_DEBUG "%s: BUSY timeout (%d) in compat_write_block_pio\n"=
,
> +		       port->name, r);
>
>  	port->physport->ieee1284.phase =3D IEEE1284_PH_FWD_IDLE;
>
> @@ -810,8 +809,8 @@ static size_t parport_pc_ecp_write_block_pio(struct =
parport *port,
>  					     PARPORT_STATUS_PAPEROUT,
>  					     PARPORT_STATUS_PAPEROUT);
>  		if (r) {
> -			printk(KERN_DEBUG "%s: PError timeout (%d) "
> -				"in ecp_write_block_pio\n", port->name, r);
> +			printk(KERN_DEBUG "%s: PError timeout (%d) in ecp_write_block_pio\n"=
,
> +			       port->name, r);
>  		}
>  	}
>
> @@ -824,7 +823,7 @@ static size_t parport_pc_ecp_write_block_pio(struct =
parport *port,
>  	r =3D change_mode(port, ECR_ECP); /* ECP FIFO */
>  	if (r)
>  		printk(KERN_DEBUG "%s: Warning change_mode ECR_ECP failed\n",
> -								port->name);
> +		       port->name);
>  	port->physport->ieee1284.phase =3D IEEE1284_PH_FWD_DATA;
>
>  	/* Write the data to the FIFO. */
> @@ -867,8 +866,8 @@ static size_t parport_pc_ecp_write_block_pio(struct =
parport *port,
>  		parport_frob_control(port, PARPORT_CONTROL_INIT, 0);
>  		r =3D parport_wait_peripheral(port, PARPORT_STATUS_PAPEROUT, 0);
>  		if (r)
> -			printk(KERN_DEBUG "%s: PE,1 timeout (%d) "
> -				"in ecp_write_block_pio\n", port->name, r);
> +			printk(KERN_DEBUG "%s: PE,1 timeout (%d) in ecp_write_block_pio\n",
> +			       port->name, r);
>
>  		parport_frob_control(port,
>  				      PARPORT_CONTROL_INIT,
> @@ -877,17 +876,16 @@ static size_t parport_pc_ecp_write_block_pio(struc=
t parport *port,
>  					     PARPORT_STATUS_PAPEROUT,
>  					     PARPORT_STATUS_PAPEROUT);
>  		if (r)
> -			printk(KERN_DEBUG "%s: PE,2 timeout (%d) "
> -				"in ecp_write_block_pio\n", port->name, r);
> +			printk(KERN_DEBUG "%s: PE,2 timeout (%d) in ecp_write_block_pio\n",
> +			       port->name, r);
>  	}
>
>  	r =3D parport_wait_peripheral(port,
>  				     PARPORT_STATUS_BUSY,
>  				     PARPORT_STATUS_BUSY);
>  	if (r)
> -		printk(KERN_DEBUG
> -			"%s: BUSY timeout (%d) in ecp_write_block_pio\n",
> -			port->name, r);
> +		printk(KERN_DEBUG "%s: BUSY timeout (%d) in ecp_write_block_pio\n",
> +		       port->name, r);
>
>  	port->physport->ieee1284.phase =3D IEEE1284_PH_FWD_IDLE;
>
> @@ -1611,7 +1609,7 @@ static int parport_ECP_supported(struct parport *p=
b)
>  	if (i <=3D priv->fifo_depth) {
>  		if (verbose_probing)
>  			printk(KERN_DEBUG "0x%lx: writeIntrThreshold is %d\n",
> -				pb->base, i);
> +			       pb->base, i);
>  	} else
>  		/* Number of bytes we know we can write if we get an
>  		   interrupt. */
> @@ -1664,14 +1662,14 @@ static int parport_ECP_supported(struct parport =
*pb)
>
>  	if (verbose_probing) {
>  		printk(KERN_DEBUG "0x%lx: PWord is %d bits\n",
> -			pb->base, 8 * pword);
> +		       pb->base, 8 * pword);
>
> -		printk(KERN_DEBUG "0x%lx: Interrupts are ISA-%s\n", pb->base,
> -			config & 0x80 ? "Level" : "Pulses");
> +		printk(KERN_DEBUG "0x%lx: Interrupts are ISA-%s\n",
> +		       pb->base, config & 0x80 ? "Level" : "Pulses");
>
>  		configb =3D inb(CONFIGB(pb));
>  		printk(KERN_DEBUG "0x%lx: ECP port cfgA=3D0x%02x cfgB=3D0x%02x\n",
> -			pb->base, config, configb);
> +		       pb->base, config, configb);
>  		printk(KERN_DEBUG "0x%lx: ECP settings irq=3D", pb->base);
>  		if ((configb >> 3) & 0x07)
>  			pr_cont("%d", intrline[(configb >> 3) & 0x07]);
> @@ -2453,8 +2451,7 @@ static int sio_via_probe(struct pci_dev *pdev, int=
 autoirq, int autodma,
>  		have_epp =3D 1;
>  		break;
>  	default:
> -		printk(KERN_DEBUG
> -			"parport_pc: probing current configuration\n");
> +		printk(KERN_DEBUG "parport_pc: probing current configuration\n");
>  		siofunc =3D VIA_FUNCTION_PROBE;
>  		break;
>  	}
> @@ -2490,12 +2487,11 @@ static int sio_via_probe(struct pci_dev *pdev, i=
nt autoirq, int autodma,
>  	port1 =3D inb(VIA_CONFIG_DATA) << 2;
>
>  	printk(KERN_DEBUG "parport_pc: Current parallel port base: 0x%X\n",
> -									port1);
> +	       port1);
>  	if (port1 =3D=3D 0x3BC && have_epp) {
>  		outb(via->viacfg_parport_base, VIA_CONFIG_INDEX);
>  		outb((0x378 >> 2), VIA_CONFIG_DATA);
> -		printk(KERN_DEBUG
> -			"parport_pc: Parallel port base changed to 0x378\n");
> +		printk(KERN_DEBUG "parport_pc: Parallel port base changed to 0x378\n"=
);
>  		port1 =3D 0x378;
>  	}
>
> @@ -2834,14 +2830,12 @@ static int parport_pc_pci_probe(struct pci_dev *=
dev,
>  		/* TODO: test if sharing interrupts works */
>  		irq =3D dev->irq;
>  		if (irq =3D=3D IRQ_NONE) {
> -			printk(KERN_DEBUG
> -	"PCI parallel port detected: %04x:%04x, I/O at %#lx(%#lx)\n",
> -				id->vendor, id->device, io_lo, io_hi);
> +			printk(KERN_DEBUG "PCI parallel port detected: %04x:%04x, I/O at %#l=
x(%#lx)\n",
> +			       id->vendor, id->device, io_lo, io_hi);
>  			irq =3D PARPORT_IRQ_NONE;
>  		} else {
> -			printk(KERN_DEBUG
> -	"PCI parallel port detected: %04x:%04x, I/O at %#lx(%#lx), IRQ %d\n",
> -				id->vendor, id->device, io_lo, io_hi, irq);
> +			printk(KERN_DEBUG "PCI parallel port detected: %04x:%04x, I/O at %#l=
x(%#lx), IRQ %d\n",
> +			       id->vendor, id->device, io_lo, io_hi, irq);
>  		}
>  		data->ports[count] =3D
>  			parport_pc_probe_port(io_lo, io_hi, irq,
> @@ -3113,8 +3107,8 @@ static int __init parport_parse_dma(const char *dm=
astr, int *val)
>  #ifdef CONFIG_PCI
>  static int __init parport_init_mode_setup(char *str)
>  {
> -	printk(KERN_DEBUG
> -	     "parport_pc.c: Specified parameter parport_init_mode=3D%s\n", str=
);
> +	printk(KERN_DEBUG "parport_pc.c: Specified parameter parport_init_mode=
=3D%s\n",
> +	       str);
>
>  	if (!strcmp(str, "spp"))
>  		parport_init_mode =3D 1;
> diff --git a/drivers/parport/probe.c b/drivers/parport/probe.c
> index 10ed0d1..7e6d71 100644
> --- a/drivers/parport/probe.c
> +++ b/drivers/parport/probe.c
> @@ -41,13 +41,13 @@ static void pretty_print(struct parport *port, int d=
evice)
>  	pr_info("%s", port->name);
>
>  	if (device >=3D 0)
> -		printk (" (addr %d)", device);
> +		pr_cont(" (addr %d)", device);
>
> -	printk (": %s", classes[info->class].descr);
> +	pr_cont(": %s", classes[info->class].descr);
>  	if (info->class)
> -		printk(", %s %s", info->mfr, info->model);
> +		pr_cont(", %s %s", info->mfr, info->model);
>
> -	printk("\n");
> +	pr_cont("\n");
>  }
>
>  static void parse_data(struct parport *port, int device, char *str)
> @@ -178,9 +178,8 @@ static ssize_t parport_read_device_id (struct parpor=
t *port, char *buffer,
>  		 * just return constant nibble forever. This catches
>  		 * also those cases. */
>  		if (idlens[0] =3D=3D 0 || idlens[0] > 0xFFF) {
> -			printk (KERN_DEBUG "%s: reported broken Device ID"
> -				" length of %#zX bytes\n",
> -				port->name, idlens[0]);
> +			printk(KERN_DEBUG "%s: reported broken Device ID length of %#zX byte=
s\n",
> +			       port->name, idlens[0]);
>  			return -EIO;
>  		}
>  		numidlens =3D 2;
> @@ -202,10 +201,8 @@ static ssize_t parport_read_device_id (struct parpo=
rt *port, char *buffer,
>
>  		if (port->physport->ieee1284.phase !=3D IEEE1284_PH_HBUSY_DAVAIL) {
>  			if (belen !=3D len) {
> -				printk (KERN_DEBUG "%s: Device ID was %zd bytes"
> -					" while device told it would be %d"
> -					" bytes\n",
> -					port->name, len, belen);
> +				printk(KERN_DEBUG "%s: Device ID was %zd bytes while device told it=
 would be %d bytes\n",
> +				       port->name, len, belen);
>  			}
>  			goto done;
>  		}
> @@ -215,11 +212,9 @@ static ssize_t parport_read_device_id (struct parpo=
rt *port, char *buffer,
>  		 * the first 256 bytes or so that we must have read so
>  		 * far. */
>  		if (buffer[len-1] =3D=3D ';') {
> - 			printk (KERN_DEBUG "%s: Device ID reading stopped"
> -				" before device told data not available. "
> -				"Current idlen %u of %u, len bytes %02X %02X\n",
> -				port->name, current_idlen, numidlens,
> -				length[0], length[1]);
> +			printk(KERN_DEBUG "%s: Device ID reading stopped before device told =
data not available. Current idlen %u of %u, len bytes %02X %02X\n",
> +			       port->name, current_idlen, numidlens,
> +			       length[0], length[1]);
>  			goto done;
>  		}
>  	}
> diff --git a/drivers/parport/share.c b/drivers/parport/share.c
> index b0f451..3169fee 100644
> --- a/drivers/parport/share.c
> +++ b/drivers/parport/share.c
> @@ -720,8 +720,7 @@ parport_register_device(struct parport *port, const =
char *name,
>
>  	if (port->physport->flags & PARPORT_FLAG_EXCL) {
>  		/* An exclusive device is registered. */
> -		printk(KERN_DEBUG "%s: no more devices allowed\n",
> -			port->name);
> +		printk(KERN_DEBUG "%s: no more devices allowed\n", port->name);
>  		return NULL;
>  	}
>
> @@ -789,9 +788,8 @@ parport_register_device(struct parport *port, const =
char *name,
>  	if (flags & PARPORT_DEV_EXCL) {
>  		if (port->physport->devices) {
>  			spin_unlock(&port->physport->pardevice_lock);
> -			printk(KERN_DEBUG
> -				"%s: cannot grant exclusive access for device %s\n",
> -				port->name, name);
> +			printk(KERN_DEBUG "%s: cannot grant exclusive access for device %s\n=
",
> +			       port->name, name);
>  			goto out_free_all;
>  		}
>  		port->flags |=3D PARPORT_FLAG_EXCL;
> @@ -1259,7 +1257,8 @@ int parport_claim_or_block(struct pardevice *dev)
>  	r =3D parport_claim(dev);
>  	if (r =3D=3D -EAGAIN) {
>  #ifdef PARPORT_DEBUG_SHARING
> -		printk(KERN_DEBUG "%s: parport_claim() returned -EAGAIN\n", dev->name=
);
> +		printk(KERN_DEBUG "%s: parport_claim() returned -EAGAIN\n",
> +		       dev->name);
>  #endif
>  		/*
>  		 * FIXME!!! Use the proper locking for dev->waiting,
> @@ -1292,7 +1291,7 @@ int parport_claim_or_block(struct pardevice *dev)
>  		if (dev->port->physport->cad !=3D dev)
>  			printk(KERN_DEBUG "%s: exiting parport_claim_or_block but %s owns po=
rt!\n",
>  			       dev->name, dev->port->physport->cad ?
> -			       dev->port->physport->cad->name:"nobody");
> +			       dev->port->physport->cad->name : "nobody");
>  #endif
>  	}
>  	dev->waiting =3D 0;
>

