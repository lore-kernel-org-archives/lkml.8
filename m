Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D501C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F3AA2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HqG1QYAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgGAIcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:32:01 -0400
Received: from mail-vi1eur05on2042.outbound.protection.outlook.com ([40.107.21.42]:25312
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728911AbgGAIb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUkd8kdZ/CLyNpUcuIKB7z4+wed82rTGgULtnlbQga/giTm9c+CBwJy/Mu3ioxi8IuOXJV1BKLz37v+elrTz5oGFZ2UNksGtcf+AeUGKIkZ9u0ELVsuhrJua9roC6krZ5K2Hb3/Fg9CKMkZ0NToPQjhG5L+x2vbztoONpugw92G2L7QBp3Xb3KOTvUaU+so7m7Z5WypHRXRxKSab4UzrrJNPF7zUrq3/+Sn8OlonQ+IkzkIe9dJJ7R+QPJcXFQkVY7cM6nAs+IZIjVcxskXt+p+Kj/gNFG8q3CFXSLyp9qlJTdSh7XHB87qkRZHtM+QMBEo03SHHEWrWKmvfC01oHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY62pLQE/YYaigFS4TdTj9K5Le+mfCwWvTkIoipvG1s=;
 b=g3OS4k59gsok/KozPswNCaPuc4AALD4uDWr0qNmohfUtil6c4XDBfeRQMHJG5zkDk4zXxiMl4AGfzAA1hQzXuaZZxpvxLGU7O4s5MKngD4lIXZxgWYgk/pJ7dt24dgSULAUMB6xKABgwX6kAqDjaT9sC9AtkFC2BD9PW90YoccdnfylNGJC2ttMX1yx+MRIr5QqTHrVdezdKxkZNoho14p7DPUZvXJ+sI4qYYsIGHQ0XSrqq5qed3kRwNoq55mH3Xz1E2TpjV9nla1T9ONY3be8jwA25nxOQnRDypBtNwKr+y7A9b5qRSPCUyvlo9v6M/vzJGSgmXZRMCRNDbWcIdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY62pLQE/YYaigFS4TdTj9K5Le+mfCwWvTkIoipvG1s=;
 b=HqG1QYAJyDVAhP8chmLsKjDe3ec877EkildUyCSV1RSX5MsahD6bxkmlmsvPvJ58PXMfAuPyjxJxUOjJp7q+xrgmmgKkhrnTQ53L2+tha3kC9eX1F6KhPITXwXMH89FYHz5qvQsVGbRWGAH/OAx2NRpNqax7IklCdWsmMJwDciE=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB4856.eurprd04.prod.outlook.com (2603:10a6:20b:b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Wed, 1 Jul
 2020 08:31:51 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3153.023; Wed, 1 Jul 2020
 08:31:51 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: cdns3: fix possible buffer overflow caused by bad
 DMA value
Thread-Topic: [PATCH] usb: cdns3: fix possible buffer overflow caused by bad
 DMA value
Thread-Index: AQHWNjHPz6qvJgpZ+karMYRZFy9ss6jDKN4AgC9TLoCAABvOAA==
Date:   Wed, 1 Jul 2020 08:31:51 +0000
Message-ID: <20200701083214.GA22478@b29397-desktop>
References: <20200530032400.12743-1-baijiaju1990@gmail.com>
 <20200601041048.GB13752@b29397-desktop> <87366b916s.fsf@kernel.org>
In-Reply-To: <87366b916s.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0326c165-9d79-4618-59db-08d81d993413
x-ms-traffictypediagnostic: AM6PR04MB4856:
x-microsoft-antispam-prvs: <AM6PR04MB4856DAA621F3984B46A0946E8B6C0@AM6PR04MB4856.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fTgCnJs/XbuwUYPv4nVibwD1AmKSVJBIv8AyX8wu5gJn6FtNNAN4wXakEW8JhWeK7HkiI6CvjTluLyfX586TluqkXBatFMtJZvupor2jHZDdpiEMODzuCP06nFCaK2AggZpHmkH9T8xiPm4si2RQqymqF76vbNGUbW+2GZi0b27mSC4xxAeGuOjCxXFAv3q3w3vntPg9yiuqo4U2hlrlBAWFgG8PmLeRC+thtKEewSikFO69/6PmXwTxymAzwHEMSbbQcOifHxt3ZOnmxSuzqY0oQvqVwc+eNSpB0ijnb0h+u3ofvJSKecyFOh4Z7svCI5QhhQxJeIimvHI6RO2e5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(4326008)(91956017)(2906002)(316002)(26005)(76116006)(54906003)(8936002)(1076003)(33716001)(6512007)(9686003)(71200400001)(478600001)(83380400001)(6486002)(53546011)(33656002)(8676002)(186003)(6506007)(5660300002)(6916009)(64756008)(66946007)(44832011)(66476007)(66556008)(86362001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1oNOTDVneA+4k3RXQSplFHc+DyqAgotWRZGGB4svTm3txUm9c5umCSsPE0Bf3uROZ+lyaYmKVHw5TFSHQkNK5n66W5/sXdKbgd8T5qE7VEELx744AmrNctEYomRpylDCHVtFiR2bxuGcI6HQASrlJIo5BrzUwHXkyDkh6OJlUUHP6FF3hw/6cuadtUUYYg/yCFFVjArkySqWq67CcY0dQUhtgYyq+S6n1++qZLH9HQ556gJbOdlk4VN8kp5Jh85prWgTwT/opZMvhvHIPJ5BSZHDf3aA3Om9DPp0h8ojcNaS12mkzDucj/x4Nr/t+J2AXFyOhg0mbkA64415l6hSXBC2LhfULFYFAxNyCn/BMI6xKdp901srWjcTYn4YI6EuNPCWFMlkOQu46lJLmOOiVpmFueevYHvb0fZ2mlUb7qRIn4qB1zPnYM13IbYdO5dmZ4jzZjEIrya85p0hRVkwlw3o5j502Mbu9S4rAJIfPHU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <06751ABC84F89F4EA306AC8035D399D0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0326c165-9d79-4618-59db-08d81d993413
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 08:31:51.2745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZNOSTJ/BoefWj9euf8mSaxOXNFyOQnEFD4B7hTzMD9dyxOuL1SDvuHLharemZog0SnmjC4jEwDMm9YsyWGo0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-01 09:52:43, Felipe Balbi wrote:
> Peter Chen <peter.chen@nxp.com> writes:
>=20
> > On 20-05-30 11:24:00, Jia-Ju Bai wrote:
> >> In cdns3_ep0_setup_phase():
> >>   struct usb_ctrlrequest *ctrl =3D priv_dev->setup_buf;
> >>=20
> >> Because priv_dev->setup_buf (allocated in cdns3_gadget_start) is store=
d=20
> >> in DMA memory, and thus ctrl is a DMA value.
> >>=20
> >> cdns3_ep0_setup_phase()
> >>   cdns3_ep0_standard_request(priv_dev, ctrl)
> >>     cdns3_req_ep0_get_status(priv_dev, ctrl)
> >>       index =3D cdns3_ep_addr_to_index(ctrl->wIndex);
> >>       priv_ep =3D priv_dev->eps[index];
> >>=20
> >> cdns3_ep0_setup_phase()
> >>   cdns3_ep0_standard_request(priv_dev, ctrl)
> >>     cdns3_req_ep0_handle_feature(priv_dev, ctrl_req, 0)
> >>       cdns3_ep0_feature_handle_endpoint(priv_dev, ctrl, set)
> >>         index =3D cdns3_ep_addr_to_index(ctrl->wIndex);
> >>         priv_ep =3D priv_dev->eps[index];
> >>=20
> >> In these cases, ctrl->wIndex can be be modified at anytime by maliciou=
s
> >> hardware, and thus a buffer overflow can occur when the code
> >> "priv_dev->eps[index]" is executed.
> >>=20
> >
> > Did you see the setup buffer is overwritten before the setup handling i=
s
> > finished?
> >
> >> To fix these possible bugs, index is checked before being used.
> >
> > I think the better fix is to use one additional buffer for struct
> > usb_ctrlrequest, and copy the dma_buf to it after setup packet
> > has received, then use the value stored in this buffer for later
> > operation, it could avoid quitting the code which is useful in fact.
>=20
> Why is this a better fix? If you don't have that endpoint index, you
> shouldn't try to access it. However, I think the problem here is
> slightly easier to solve :-)

The possible problem here is: it is a correct setup packet, the memory
it uses may be modified by controller wrongly (eg, try to get next setup
packet) before it finishes using. So, I suggest adding a setup buf for
struct cdns3 to store every setup packet after it receives to avoid
the original setup buffer corrupted.

Peter

>=20
> >> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
> >> index e71240b386b4..0a80c7ade613 100644
> >> --- a/drivers/usb/cdns3/ep0.c
> >> +++ b/drivers/usb/cdns3/ep0.c
> >> @@ -265,6 +265,8 @@ static int cdns3_req_ep0_get_status(struct cdns3_d=
evice *priv_dev,
> >>  		return cdns3_ep0_delegate_req(priv_dev, ctrl);
> >>  	case USB_RECIP_ENDPOINT:
> >>  		index =3D cdns3_ep_addr_to_index(ctrl->wIndex);
>=20
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 5e24c2e57c0d..96ba3eec805c 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -107,7 +107,10 @@ void cdns3_set_register_bit(void __iomem *ptr, u32 m=
ask)
>   */
>  u8 cdns3_ep_addr_to_index(u8 ep_addr)
>  {
> -       return (((ep_addr & 0x7F)) + ((ep_addr & USB_DIR_IN) ? 16 : 0));
> +       u8 num =3D ep_addr & USB_ENDPOINT_NUMBER_MASK;
> +       u8 dir =3D ep_addr & USB_ENDPOINT_DIR_MASK;
> +
> +       return num + dir ? 16 : 0;
>  }
> =20
>  static int cdns3_get_dma_pos(struct cdns3_device *priv_dev,
>=20
> This will guarantee that the number is never over the limit.
>=20
> --=20
> balbi



--=20

Thanks,
Peter Chen=
