Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A716C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAAC820722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593586372;
	bh=nUsuZo1U+5IWpyY6zgXGZdn+isF4tS9s0ge0t3XL+LM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=DXA86O+OTtXGCr0EMiZ00qxsOmPsubEkWRYGxZjPb4FSa4yA8fAbvcyJxeSfBucsc
	 wyC5hRdOHXZNHb9H7o85jTXiJSKGiSymbTvqHILxnzNcqA7NlRTaXox9J4Uwy8zLCu
	 slpVzE2ejbCzRrv6wl5PZGWR0mTMfcvaWrRs7wRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgGAGwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGAGwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:52:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A931BC061755;
        Tue, 30 Jun 2020 23:52:50 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s9so25578861ljm.11;
        Tue, 30 Jun 2020 23:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=E759cuZY8R5maJqc3TDNvEPB2MZH/E6EL1vX9MBhyHs=;
        b=hhtnIQqZPD7xwnTRZshOTWoQT2XqHx1aUqCCaaMb6GUbN6SwngRoF0LiERFLMf/BZd
         /F2ctFDwNXAuRysceP2DInK8todKzqYtHri1NMUE4nCTvX3pb8hBftvB9ZmbbHSEpn/N
         KpXnW+M1rsewv4lJEtdmiDMU78cJDr2oxoiQiLCJv4CwC7EOTfsYfSJxb8kv3hh9MMGF
         P7jBOpIae8J+CjTLGGiJgJgF7u+JU9ktxkqPQBaCepJTGh/Y1LLoAYKgM+a5WpIb2b3l
         CH3poU3pSgLoicztgAQWrJO83xDI427b+nMurwz20bv2P9dVpZAHXWN9aJ9rHxM+xJP9
         xa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=E759cuZY8R5maJqc3TDNvEPB2MZH/E6EL1vX9MBhyHs=;
        b=gWh3IORquTY2tM74zuTPWuIlCKtBPubcuLO0ePO90yj3tMEOcr08nUYj9musyLb4/Z
         VG6jdZ5bJ465F6ycYwBySjOJ2/0Cnx7yw6lPCubt5wO7alX9efBNzAzAbTheWHKiNFlP
         VzGKf5+DNlhIa38vixtvFrhAiZ/E8vxfgTTAzDsxJL5kgSwqIIgSi/TQn7DlSUi3rPmm
         +kq+nts9FJPA5lwv5VkR4WnxhqdJ4rbAVKVhRhjZuPQLGJ7XL8l6z+GjHoVn6ec2cV99
         Fu04VrXzQ5G97git5N2QDUX8Zs7rnVFGRmPOvArFR5IVhfcgwFf0eD/53WAvKJBMO0rn
         AJdg==
X-Gm-Message-State: AOAM532TWni2dwDBE3SpOIIV2s+1dOFn2G1wjD1BOeHMQbGzcK1AofZR
        9Yk9GjdpkFjzA+AR7ib4/nj+3yG/
X-Google-Smtp-Source: ABdhPJz2UA+m3Rpjzy0tkNpNyGBPPi3iBj1bQoDwhFaZ2YThzp1KHk6twtTOecGOPTWDrr/i7xgfEw==
X-Received: by 2002:a2e:8216:: with SMTP id w22mr6028788ljg.2.1593586368770;
        Tue, 30 Jun 2020 23:52:48 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id v24sm1690263lfo.4.2020.06.30.23.52.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 23:52:48 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Peter Chen <peter.chen@nxp.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pawell\@cadence.com" <pawell@cadence.com>,
        "rogerq\@ti.com" <rogerq@ti.com>,
        "colin.king\@canonical.com" <colin.king@canonical.com>,
        "yuehaibing\@huawei.com" <yuehaibing@huawei.com>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: cdns3: fix possible buffer overflow caused by bad DMA value
In-Reply-To: <20200601041048.GB13752@b29397-desktop>
References: <20200530032400.12743-1-baijiaju1990@gmail.com> <20200601041048.GB13752@b29397-desktop>
Date:   Wed, 01 Jul 2020 09:52:43 +0300
Message-ID: <87366b916s.fsf@kernel.org>
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

Peter Chen <peter.chen@nxp.com> writes:

> On 20-05-30 11:24:00, Jia-Ju Bai wrote:
>> In cdns3_ep0_setup_phase():
>>   struct usb_ctrlrequest *ctrl =3D priv_dev->setup_buf;
>>=20
>> Because priv_dev->setup_buf (allocated in cdns3_gadget_start) is stored=
=20
>> in DMA memory, and thus ctrl is a DMA value.
>>=20
>> cdns3_ep0_setup_phase()
>>   cdns3_ep0_standard_request(priv_dev, ctrl)
>>     cdns3_req_ep0_get_status(priv_dev, ctrl)
>>       index =3D cdns3_ep_addr_to_index(ctrl->wIndex);
>>       priv_ep =3D priv_dev->eps[index];
>>=20
>> cdns3_ep0_setup_phase()
>>   cdns3_ep0_standard_request(priv_dev, ctrl)
>>     cdns3_req_ep0_handle_feature(priv_dev, ctrl_req, 0)
>>       cdns3_ep0_feature_handle_endpoint(priv_dev, ctrl, set)
>>         index =3D cdns3_ep_addr_to_index(ctrl->wIndex);
>>         priv_ep =3D priv_dev->eps[index];
>>=20
>> In these cases, ctrl->wIndex can be be modified at anytime by malicious
>> hardware, and thus a buffer overflow can occur when the code
>> "priv_dev->eps[index]" is executed.
>>=20
>
> Did you see the setup buffer is overwritten before the setup handling is
> finished?
>
>> To fix these possible bugs, index is checked before being used.
>
> I think the better fix is to use one additional buffer for struct
> usb_ctrlrequest, and copy the dma_buf to it after setup packet
> has received, then use the value stored in this buffer for later
> operation, it could avoid quitting the code which is useful in fact.

Why is this a better fix? If you don't have that endpoint index, you
shouldn't try to access it. However, I think the problem here is
slightly easier to solve :-)

>> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
>> index e71240b386b4..0a80c7ade613 100644
>> --- a/drivers/usb/cdns3/ep0.c
>> +++ b/drivers/usb/cdns3/ep0.c
>> @@ -265,6 +265,8 @@ static int cdns3_req_ep0_get_status(struct cdns3_dev=
ice *priv_dev,
>>  		return cdns3_ep0_delegate_req(priv_dev, ctrl);
>>  	case USB_RECIP_ENDPOINT:
>>  		index =3D cdns3_ep_addr_to_index(ctrl->wIndex);

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 5e24c2e57c0d..96ba3eec805c 100644
=2D-- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -107,7 +107,10 @@ void cdns3_set_register_bit(void __iomem *ptr, u32 mas=
k)
  */
 u8 cdns3_ep_addr_to_index(u8 ep_addr)
 {
=2D       return (((ep_addr & 0x7F)) + ((ep_addr & USB_DIR_IN) ? 16 : 0));
+       u8 num =3D ep_addr & USB_ENDPOINT_NUMBER_MASK;
+       u8 dir =3D ep_addr & USB_ENDPOINT_DIR_MASK;
+
+       return num + dir ? 16 : 0;
 }
=20
 static int cdns3_get_dma_pos(struct cdns3_device *priv_dev,

This will guarantee that the number is never over the limit.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl78MrsACgkQzL64meEa
mQZjSxAAjXPp6UT5McnCzjDtput+cJ0BrzbOr9wmnVmU10pd6VKGxFzuljOOdQTQ
LrXE6JPxgvBX+iS1i+6WEsbQrheEIKWht3lVzNuufZ5sFBsmXjU+Xv6bspsdctkv
llWLp95AZ3GVB0x7TQfeyqL1qGVZpuCU8dkI2LIeLdW9amT/WFE4af0kxp2bOzU0
5/mTAmXgv/cn5AjZj9WxljvedNwyr9dqTVxZt1rGzgLgSz1l5Ab3KnZqh6m5FJ5N
sXAQttuo+Yod0NP7SRNuZDBMyPE1f4cdak/j34qnHMP1WrFh8DJPk67xHd88+pj6
ubeJY93IdmX/uYov85v84Z26GnEI5gK+UVmmiO5HSyR5q72dI5L6sxMwzeUv8djQ
QvtMxLJqT4/JM6qUvYjIfK/OPTPPkzQRv+Jn93JfIavjdlNMkku+jT+8tADMWoyX
jCSmyIRssUXhotr2ZoiTbD32sqAYRIu2henWU6t9dsUus3Kp7o90daJ+bZsl3l4z
AKEYjXmgQDI34B4TR9vvtSPldKujG0bEm6XggwZXlxtuWMyTMobnWvUum71adDul
ZYOy6HnFJbZwbejM8/ekWeFLq1+8MPddlI2rlZS76SdCCXgSPvqCgCgtndSTkYVM
QDSxXd+WhUEoSVZUTWJ+tL7Yl3qvSBz7LOLfxz4Vz3Z9J+Gp+PI=
=K1QB
-----END PGP SIGNATURE-----
--=-=-=--
