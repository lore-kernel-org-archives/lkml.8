Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AED0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63BA820758
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgETL2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:28:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:47278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgETL2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:28:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8F94FAD78;
        Wed, 20 May 2020 11:28:38 +0000 (UTC)
Message-ID: <2aa6f276085319a5af7a96b3d7bdd0501641a7d7.camel@suse.de>
Subject: Re: [PATCH 09/15] device core: Add ability to handle multiple dma
 offsets
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>
Date:   Wed, 20 May 2020 13:28:32 +0200
In-Reply-To: <20200519203419.12369-10-james.quinlan@broadcom.com>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
         <20200519203419.12369-10-james.quinlan@broadcom.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Ttdr9J6hcKekh9mdkCgm"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ttdr9J6hcKekh9mdkCgm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jim,
thanks for having a go at this! My two cents.

On Tue, 2020-05-19 at 16:34 -0400, Jim Quinlan wrote:
> The device variable 'dma_pfn_offset' is used to do a single
> linear map between cpu addrs and dma addrs.  The variable
> 'dma_map' is added to struct device to point to an array
> of multiple offsets which is required for some devices.
>=20
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---

[...]

> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -493,6 +493,8 @@ struct dev_links_info {
>   * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a sm=
aller
>   *		DMA limit than the device itself supports.
>   * @dma_pfn_offset: offset of DMA memory range relatively of RAM
> + * @dma_map:	Like dma_pfn_offset but used when there are multiple
> + *		pfn offsets for multiple dma-ranges.
>   * @dma_parms:	A low level driver may set these to teach IOMMU code
> about
>   * 		segment limitations.
>   * @dma_pools:	Dma pools (if dma'ble device).
> @@ -578,7 +580,12 @@ struct device {
>  					     allocations such descriptors. */
>  	u64		bus_dma_limit;	/* upstream dma constraint */
>  	unsigned long	dma_pfn_offset;
> -
> +#ifdef CONFIG_DMA_PFN_OFFSET_MAP
> +	const void *dma_offset_map;	/* Like dma_pfn_offset, but for
> +					 * the unlikely case of multiple
> +					 * offsets. If non-null, dma_pfn_offset
> +					 * will be 0. */

I get a bad feeling about separating the DMA offset handling into two disti=
nct
variables. Albeit generally frowned upon, there is a fair amount of tricker=
y
around dev->dma_pfn_offset all over the kernel. usb_alloc_dev() comes to mi=
nd
for example. And this obviously doesn't play well with it. I feel a potenti=
al
solution to multiple DMA ranges should completely integrate with the curren=
t
device DMA handling code, without special cases, on top of that, be transpa=
rent
to the user.

In more concrete terms, I'd repackage dev->bus_dma_limit and
dev->dma_pfn_offset into a list/array of DMA range structures and adapt/cre=
ate
the relevant getter/setter functions so as for DMA users not to have to wor=
ry
about the specifics of a device's DMA constraints. For example, instead of
editing dev->dma_pfn_offset, you'd be passing a DMA range structure to the
device core, and let it take the relevant decisions on how to handle it
internally (overwrite, add a new entry, merge them, etc...).

Easier said than done. :)

Regards,
Nicolas


--=-Ttdr9J6hcKekh9mdkCgm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7FFGAACgkQlfZmHno8
x/62Gwf/ZcX0GjUG2kX8dOQj+DmylB81fPXdO67lCfYb36/3AaWub3SgdS6OElwx
EUkGWiXfQspc2tFLJ9QHVOvKZ4dn1axmHzBdSUxOS3Y7K/5Ui7G7hzbi22njfPOR
TjQzAlozY8g7HB3GWRHX6ptZwNsk2GgfywpFPTHQzZphJtsqhRkC+1NBVZJqcxUg
PP0lJ4op3lIusNEoZXTvss0CGvIqPZroj3V6gxMllerV0UGayKnZRijn+VnqKhM0
kJUKjAA7TXjaIHzJZYfVncgp2eZtNCpmP+WM7/YDKoNbbkJYHBelwCqCq42YEJhk
50yZpb9YqlD0TwGBilnlPIHc33lp8g==
=LCl4
-----END PGP SIGNATURE-----

--=-Ttdr9J6hcKekh9mdkCgm--

