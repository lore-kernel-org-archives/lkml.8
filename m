Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F26C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31EF9206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599498969;
	bh=43vQhSIdl0+3eXxBWtFTpn4oJEVlsfZOH+X1/8xm4zQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=pI/oyUPXS+nIxYe/cvV1MhLCdPpZ4FzQYvbUqh/zMsvXnid9UuGGyUH/JpIlw50C2
	 rs4LzFVMMwBRrH3uX03MZs+R46UWm1wdEPc8mTHMoNchq0pZyN/qWU357lSn3H9myE
	 LAsQleJ8rdJON6lA1frJPIdwx3ttwIDauU7liUKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgIGRQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729731AbgIGOFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:05:16 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B35A12064B;
        Mon,  7 Sep 2020 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599487481;
        bh=43vQhSIdl0+3eXxBWtFTpn4oJEVlsfZOH+X1/8xm4zQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=g8KKUImy+BP8HbHX3vY2vbd58JExwtSgOTzmtbPmx4VtaTqYadL3dfzH2A8U3jQlt
         xAu/ObxyPT56Ox/HLThXLuVuOxi9tyEZZfIOhombzJWIHBBDqAk5NByUjS4D3pUonU
         0Y1SAB/dT+5eClcuKvTVF+APb7HAhefzPRSjMqJE=
From:   Felipe Balbi <balbi@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yu Chen <chenyu56@huawei.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com, liuyu712@hisilicon.com,
        wanghu17@hisilicon.com, butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v6 04/13] usb: dwc3: Add splitdisable quirk for
 Hisilicon Kirin Soc
In-Reply-To: <20200907150631.70e1bce0@coco.lan>
References: <20190420064019.57522-1-chenyu56@huawei.com>
 <20190420064019.57522-5-chenyu56@huawei.com>
 <20200907150631.70e1bce0@coco.lan>
Date:   Mon, 07 Sep 2020 17:04:31 +0300
Message-ID: <874ko9of80.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Mauro,

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Felipe/Greg,
>
> What's the status of this patch?=20

to be frank, I don't think I have this in my inbox anymore.

> I tested here, together with the Hikey 970 phy RFC patches I sent
> last week.
>
> Without this patch, the USB HID driver receives -EPROTO from
> submitted URBs, causing it to enter into an endless reset cycle
> on every 500 ms, at the hid_io_error() logic.

> Tested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
> If you prefer, I can re-submit this one with my SOB.

Please do, but since you're changing device tree, I need Rob's acked-by.

> Thanks,
> Mauro
>
> Em Sat, 20 Apr 2019 14:40:10 +0800
> Yu Chen <chenyu56@huawei.com> escreveu:
>
>> SPLIT_BOUNDARY_DISABLE should be set for DesignWare USB3 DRD Core
>> of Hisilicon Kirin Soc when dwc3 core act as host.

is this Kirin-specific or is this something that we should do a revision
check? Why does it affect only Hikey kirin? What's the dwc3 revision on
that SoC (grep SNPSID /sys/kernel/debugfs/*dwc3/regdump)?

>> @@ -1825,10 +1834,27 @@ static int dwc3_resume(struct device *dev)
>>=20=20
>>  	return 0;
>>  }
>> +
>> +static void dwc3_complete(struct device *dev)
>> +{
>> +	struct dwc3	*dwc =3D dev_get_drvdata(dev);
>> +	u32		reg;
>> +
>> +	if (dwc->current_dr_role =3D=3D DWC3_GCTL_PRTCAP_HOST &&
>> +			dwc->dis_split_quirk) {
>> +		dev_dbg(dwc->dev, "set DWC3_GUCTL3_SPLITDISABLE\n");

no more dev_dbg() should be added. This driver relies exclusively on
tracepoints for debugging.

>> +		reg =3D dwc3_readl(dwc->regs, DWC3_GUCTL3);
>> +		reg |=3D DWC3_GUCTL3_SPLITDISABLE;
>> +		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
>> +	}
>> +}
>> +#else
>> +#define dwc3_complete NULL
>>  #endif /* CONFIG_PM_SLEEP */
>>=20=20
>>  static const struct dev_pm_ops dwc3_dev_pm_ops =3D {
>>  	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
>> +	.complete =3D dwc3_complete,

why is this done on complete? Why can't it be done at the end of
dwc3_resume()?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9WPe8RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZWyg/+LSkAFDUcHpgZ1Z3VDh+wv/KQkud9pmoE
VkCPKqYGL5kG9kAQaHpB03tenK4Y9rSA4UVdG5fODhcqrcHe/3irBZeJ+/TVxnDd
FD4aZmDNCmcHYBE09GqXTpGQAdBxApkNaFgLzIdNJq4ydCHd8Eb9qQeVskZQCtpi
emWTBKOTAJyl9WMlifucJqH9A/IKqb8oMrUxaBqRSAbKjLzki4HEZ3Z3MZ9ivHnY
w0bo69HybeVAMI2QqUAQ2JY26GpbnsdJhTL6fGwGPjnrHqoEY0d+7D0RTQinYcxG
LXeA2Ote9sOE02rGm0Vh+3isF8fsf+GJ1odDi7IsjJR//upPtoPBXtWBJd6w9vsI
M6clI4UaWrQoK2JZ7HqislIqqO1yms0BgUMx4NuuL+7GOzYCcO23/hFgC8Lb7/xm
936q25tJM91Ipgl62fa5XRAcxg8MkyDS5aRbRwQBr7Q+v3hABXIxSKoWtJP8L7TV
9OGcZoChy3uEz5NokYlp2qo0BoKmj8a0/CdkdCEr7RAIn7DMaOhg21T9zomgo6wM
/1zbJTeZlhLabPEUMEm2w38RH5A7D/ZyHkYAqZHuCKUwKfLK4AFTMlHyZKVJOVXd
uGsglmA1e4jWqojDI0SVdYTPiZrBRX44DX0qzvc0GNMxPOLs+dKL/R1/b1JY2iOR
rAZZ8gVV7BY=
=fXYk
-----END PGP SIGNATURE-----
--=-=-=--
