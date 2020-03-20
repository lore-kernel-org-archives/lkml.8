Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AC9C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70C92072C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhtEJLzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgCTPKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:10:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42263 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgCTPKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:10:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id v11so7883025wrm.9;
        Fri, 20 Mar 2020 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p/MB3ibnOodVPSLRbcvPaSw5k5yXbH6/dCVbJLHXoKk=;
        b=IhtEJLzSI4ZiarlZnescWMp9HDEWc8bL/A4CHFauDJgQmKTh9mZovDAyg/tIxlRsQ4
         8NTiF9Oa6hq7bgfE+uYXzuo8IGcRJwc0j/LmMC5KepZOLTBa5nOw5zFa9vUC9IHYEg2n
         TB4mTELVM+fAbLOQ709UNJCldPcadGK6Avx6pS1YejO6LGM2iW8VU8WJFx9ESZ02BY8+
         PxXpS22i89kv3OpKE1qiDaj4IOlzKYF7w6ktZL3FnH6tCN8/AFYO9uzqC2J9A6IzaKGV
         7iUhykQG2kMq2R+jg0YjO7KfZIZJnJ7B9mby0iSEZrbazQw0Uej/ZzX2VeV46YXeOR6Z
         6fDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p/MB3ibnOodVPSLRbcvPaSw5k5yXbH6/dCVbJLHXoKk=;
        b=NyZzDkvbMN5hTWOBicUj6Kq0svFbDrwLLB/Gkxs8v1/ozUulX596MNpw+kAUjKBcvk
         OesZrEFuxKriOlo2+mIMq+RL21YXs1wfKZxwjjc1rrXxPyNG02tZO+pvrbOGfWXkuz5V
         L/J8c8RvtDuAR9Xnst7lQIGYrnWyUaHFknClOd/SkSCD3U47XguD6C07esoYG7scFhPv
         mRsSYpW+497L+Da7WnNo7t2URaUCROv1CBa+h/XFIVzB9u/ksb4znsnALXxiUch43d5b
         K2gTo+0QPQzqLF2l/O7twSWUJ5nYvIMsm2im0FiF8iOgQamTNipw6yIpQGFvOhc7GvsK
         be2A==
X-Gm-Message-State: ANhLgQ3o9gm3OKMmSSs/jwPuTxv+e0PsapMbuXnY8LIt4T+WSh2bd9qA
        OY5uezjX7ccbf5lksFD/o9WZsKUl
X-Google-Smtp-Source: ADFU+vvUSNZuXVLldZhRlKLWnbseGh277sutn59QMZys5POUIiF8H4yXaAV3vR8+R1kH1EB0M6A4Wg==
X-Received: by 2002:adf:afcb:: with SMTP id y11mr11015452wrd.141.1584717037465;
        Fri, 20 Mar 2020 08:10:37 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id b187sm8795993wmc.14.2020.03.20.08.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 08:10:36 -0700 (PDT)
Date:   Fri, 20 Mar 2020 16:10:35 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: fuse: Add custom SoC attributes
Message-ID: <20200320151035.GB3706404@ulmo>
References: <20200320113716.6105-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20200320113716.6105-1-jonathanh@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2020 at 11:37:16AM +0000, Jon Hunter wrote:
> Add a custom SoC attribute for Tegra to expose the HIDREV register
> contents to userspace via the sysfs. This register provides additional
> details about the fabrication and versioning of the device. Exposing
> this information is useful for identifying the exact device revision and
> device type.
>=20
> Please note that the fields in this register vary depending on the Tegra
> generation and so instead of exposing the individual fields, just expose
> the entire contents of the register. Details of the register fields can
> be found in the Technical Reference Manual for each Tegra device.

That seems a little suboptimal to me. It's pretty trivial for the kernel
to distinguish between different SoC generations in order to know what
the fields are. It's a lot more difficult for userspace to do so. Is the
register completely different between SoC generations or just slightly?

Having individual fields exposed as individual attributes seems like it
would make it a lot easier for userspace to get at the needed bits.

Thierry

>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/fuse/fuse-tegra.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse=
/fuse-tegra.c
> index 802717b9f6a3..217e326da232 100644
> --- a/drivers/soc/tegra/fuse/fuse-tegra.c
> +++ b/drivers/soc/tegra/fuse/fuse-tegra.c
> @@ -300,6 +300,24 @@ static void tegra_enable_fuse_clk(void __iomem *base)
>  	writel(reg, base + 0x14);
>  }
> =20
> +static ssize_t tegra_soc_hidrev_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	return sprintf(buf, "%d\n", tegra_read_chipid());

Would it be better to print this as hexadecimal?

> +}
> +
> +static DEVICE_ATTR(hidrev, S_IRUGO, tegra_soc_hidrev_show,  NULL);
> +
> +static struct attribute *tegra_soc_attr[] =3D {
> +	&dev_attr_hidrev.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group tegra_soc_attr_group =3D {
> +	.attrs =3D tegra_soc_attr,
> +};
> +
>  struct device * __init tegra_soc_device_register(void)
>  {
>  	struct soc_device_attribute *attr;
> @@ -312,6 +330,7 @@ struct device * __init tegra_soc_device_register(void)
>  	attr->family =3D kasprintf(GFP_KERNEL, "Tegra");
>  	attr->revision =3D kasprintf(GFP_KERNEL, "%d", tegra_sku_info.revision);
>  	attr->soc_id =3D kasprintf(GFP_KERNEL, "%u", tegra_get_chip_id());

I guess we print all of these as decimal, so hidrev should probably be
the same, so never mind the previous comment.

Thierry

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl503OsACgkQ3SOs138+
s6HEwQ/+O9SCRbBqNXYN9nux8BzE8Ipn8+xWykZAptrwS9KAHbiT69ijOt10NCMp
cOisPIp+xylrpVBsItNmVr5LUdhY6tG74J8thr5ad/8YduzBPGIR9IxDqS7E4Btu
106OsngzZjFHEcN65/6mey7WnAn20h510IYTxInMBeSuY0ZuhZj7WJd8LkoPURYu
wfTQnRwKPCYORz+E492TVr/rFeAi9svq8Q7fB63c/CXvG3yQd+4h24b6hdC+/cC6
MepbgXOe2RwaVU5d+VBSMa+Xd2hbxqw07AAuxlaEvsbSHQfCnkCwn++Ew3wqox+g
pTOEzEziwSyjXUim9Fbhrd7Ihei2q/RKyWLx+PxjzdB9IGwKbN9MXaMX8skDVOTf
h55hTSIhdREE5fJdXb3kP+OYGidzW09etaKBxDwIZj/tiTHND/l2oUDqsC6r5753
MaWX8Kc4zWsEYW/3SQyWfWsWzO80zOOHSoV6nJIOLlr4OgiWBeDcl0gnerN2ZHBE
US06/1Apu7wb/toICZR+t/u+ml6BZ4fR/Ddp4u8sGIKKDzKkAdFuAMJZKFQj2KMw
KPi3RwQBIbwSyoFF3+i3Rinq84qKSbm1oe5NLUb0ld1nVHKBV+8o6M3AXqFYNX0Z
3j2qb3qI5Jgk1bJF8F1zOOM/BI71WfxCDnKYvAuR+x4vRMQNq6o=
=Nf1c
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
