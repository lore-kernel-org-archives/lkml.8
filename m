Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15F4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E9A207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Fq1gE7+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgHRO1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:27:06 -0400
Received: from mail-mw2nam10on2057.outbound.protection.outlook.com ([40.107.94.57]:21089
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726709AbgHRO1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:27:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZmL30mXc/GVZ2BQABpi+zKJYrcDj/kfA0o05922yChYCFVGtHNlzXiPwPq2rA/ONBYKGHHDJ0YiqlDbu1YABWNnOF3UrR5NBoRNdgqAozhb4TlmU2Ua0EWU74dxJMC1ty4c0CD0g5KJ2UzqI19+5/sggkhbIRr8mpD4Pts9/Ro9wxlyPGvXUuvJyFWyf6vptPIBjHV0pFtZk+MTmZCS5y15m2vH7Tr3lc5evF7ZKHuQYLiLTn1fpp50IJogwkoST+kUEixuVK/85G8Z5Y2ON2rJbBAVyqXgc9U5Pe3DdU97h5fBkX1x/lRS69hb6jZ8xUBspxq7X+ni/OP30pJMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPSlDzNz/FKxQ0XuhBRU/72hk/UvzkWxakoJfQNblys=;
 b=IYULa533bEwrweuU3ZiLMaUcMZPtl9IrTVay86jYjoEUNoLuVdesFnyp4D/g/h6ymVwprVs3CDLYwLGbkOawfG6EglO9XehpkD0VCBJZwk76LXL3+hFon3CSttSX1AZ5/uG5SVqka0vIcyr+W9RjIINSh+XJwrNw1AYYWp119WIk/v5hrlKiHKGoBE7nRLawCevQTUWm278WHPPDtoxWo4lQd/1KiLoaasVqQmJZCVk+dNHLQFfy79QHzXuupr2vyDdxCmF8v7ulh37BuhFLxrfBGaDW0mgATNvPS4p5nM1ifqGB39mjRjHg/8t+dJEn4wSSf5y1hUIMWojRqGniGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPSlDzNz/FKxQ0XuhBRU/72hk/UvzkWxakoJfQNblys=;
 b=Fq1gE7+FYUhwWLdnO7g1KJ7c5w0mCLRYNXCJLO7qUfhLhXHs2ACvz9zkPUGRKmPByrBgTfqQxbDhAKMy3X00HFy0gJAnezLsKaiXTDZeovoJ+gjLR9tx1VH38An+EJN4Xg681BgxRtiF0G6jjrOwqBzPzgN8BH+Mv4f8vLfuY/4=
Received: from BYAPR02MB4407.namprd02.prod.outlook.com (2603:10b6:a03:55::31)
 by BYAPR02MB4407.namprd02.prod.outlook.com (2603:10b6:a03:55::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 18 Aug
 2020 14:26:59 +0000
Received: from BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5]) by BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5%5]) with mapi id 15.20.3305.024; Tue, 18 Aug 2020
 14:26:59 +0000
From:   Ben Levinsky <BLEVINSK@xilinx.com>
To:     Stefano Stabellini <stefanos@xilinx.com>
CC:     Michal Simek <michals@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "Ed T. Mooring" <emooring@xilinx.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v8 3/5] firmware: xilinx: Add RPU configuration APIs
Thread-Topic: [PATCH v8 3/5] firmware: xilinx: Add RPU configuration APIs
Thread-Index: AQHWb5ALEfFcqjhk5Ee4v4TFWrhDL6k2g4GAgAdz7cA=
Date:   Tue, 18 Aug 2020 14:26:59 +0000
Message-ID: <BYAPR02MB4407301895064A660A4B6F1AB55C0@BYAPR02MB4407.namprd02.prod.outlook.com>
References: <20200811033213.20088-1-ben.levinsky@xilinx.com>
 <20200811033213.20088-4-ben.levinsky@xilinx.com>
 <alpine.DEB.2.21.2008131109090.15669@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2008131109090.15669@sstabellini-ThinkPad-T480s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [24.5.142.107]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 71e28dde-2ecd-4591-c477-08d84382c4ad
x-ms-traffictypediagnostic: BYAPR02MB4407:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4407EF9E9493768657E171FFB55C0@BYAPR02MB4407.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:398;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3CzvzeAukDPb3OrQ60EsauwiaEXzpnYTm6K9uxxQZbbyLyObmASH/b7uKZsIJEo7uidwZrCV/QguN6MyxaEQS/HlVX1Xcq/l8pkxOn87S2e8QmWP31HSdjL801SR1CQSYJtrKSvhiPtep0zsCbrV2P5ItsEy7eBttMS39w/v4S3D0vhw1xeo3S0SIQ+yJ5fiou+ToHQ37lRRR8b/SBskI2taUZWfUxGjG6nzdniVP38O2GTnplpjnFn1hlrIF2qBH173sd3OM3xLwffNu+VCEuRL4kOa3HTiqUCH7r3Yu+mp+j5cX2Bs2OZ1CfqbVU/2ix5bvrVmEo4mjyhWt4kXLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4407.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(366004)(346002)(136003)(7696005)(186003)(26005)(76116006)(66476007)(4326008)(66556008)(64756008)(66446008)(86362001)(66946007)(6862004)(71200400001)(5660300002)(52536014)(33656002)(478600001)(316002)(55016002)(9686003)(8676002)(2906002)(53546011)(6506007)(6636002)(83380400001)(54906003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /kids9QwLo8DppleRdxAlODvk1uZGlMZD6bUnNXAAIOslOSyR/KFCON1+y74Ov8g7aQ7cabivGOi5yNgy0T9cXpbQM/2Ib12uz9uqizYcfQVVQASS6npC5NNmpLgWKA5Zjm35/wTimHUX2o+8V2DH6fS7qw2AqTFD4JAbSuOxrgUn/4tmbaJ5SJAzBmic8ELxUTzDzS+gDeZ8JrXw3PAuufubj/J1CY4g0jgIZZKQ+44cYm7sMJhS881ObaoHo60N7HKXdTMmBC6Ecc85BT8q3OBsLvOcZKGVWXfL2HzPCWtdrKD59FE0aY978VAiY4kIZmb+H4J0cCy5U4G9SEaOc8Sb0yf6Q/TwU+by8l+M/Ji8SQxqvYcDCmRpxDvXUohl3EA/UbnhIZfR5Dah/a+xNxrvXp24xao1nBWWyj4ie89aY654W3vgrKXt6E5eBojYLvqufWA2BODGxyjZnnH+sLiwpFbHKW3Z+abPbFS5unPdvwVBkp6vU5FyKhiU9rAVT9TEAfMk81xUng85bDrpzaGI/rP2myhMi9l5jxaCRBl7X/YAx1bjezDZ/96DZlNZmSzocbUTu5JOQRLR22cPBYBzAVWF78FVLMB2TLS90YucHUT2LPzGk3ghG6pv2snTX9Uz5JU/9YPF0mmRD+pRA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4407.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e28dde-2ecd-4591-c477-08d84382c4ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 14:26:59.6447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ht7VhFbIRb6bhuYxbhp3XzS1P4Bctn3R8NRBihk8fUfXcB+YAMenXxxCkyVhGxEfdcERO+0xZIFzM4GEjAAILg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4407
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> Sent: Thursday, August 13, 2020 1:36 PM
> To: Ben Levinsky <BLEVINSK@xilinx.com>
> Cc: Stefano Stabellini <stefanos@xilinx.com>; Michal Simek
> <michals@xilinx.com>; devicetree@vger.kernel.org;
> mathieu.poirier@linaro.org; Ed T. Mooring <emooring@xilinx.com>; linux-
> remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org;
> robh+dt@kernel.org; Jiaying Liang <jliang@xilinx.com>; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v8 3/5] firmware: xilinx: Add RPU configuration APIs
>=20
> On Mon, 10 Aug 2020, Ben Levinsky wrote:
> > This patch adds APIs to provide access and a configuration interface
> > to the current power state of a sub-system on Zynqmp sub-system.
>=20
> This doesn't read correctly
>=20
[Ben Levinsky] ok will update commit message as follows in v9:
firmware: xilinx: Add RPU configuration APIs

    This patch adds APIs to access to configure RPU and its
    processor-specific memory.

    That is query the run-time mode of RPU as either split or lockstep as w=
ell
    as API to set this mode. In addition add APIs to access configuration o=
f
    the RPUs' tightly coupled memory (TCM).
>=20
> > Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> > ---
> > v3:
> > - add xilinx-related platform mgmt fn's instead of wrapping around
> >   function pointer in xilinx eemi ops struct
> > v4:
> > - add default values for enums
> > ---
> >  drivers/firmware/xilinx/zynqmp.c     | 99 ++++++++++++++++++++++++++++
> >  include/linux/firmware/xlnx-zynqmp.h | 34 ++++++++++
> >  2 files changed, 133 insertions(+)
> >
> > diff --git a/drivers/firmware/xilinx/zynqmp.c
> b/drivers/firmware/xilinx/zynqmp.c
> > index f1a0bd35deeb..fdd61d258e55 100644
> > --- a/drivers/firmware/xilinx/zynqmp.c
> > +++ b/drivers/firmware/xilinx/zynqmp.c
> > @@ -846,6 +846,61 @@ int zynqmp_pm_release_node(const u32 node)
> >  }
> >  EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
> >
> > +/**
> > + * zynqmp_pm_get_rpu_mode() - Get RPU mode
> > + * @node_id:	Node ID of the device
> > + * @arg1:	Argument 1 to requested IOCTL call
> > + * @arg2:	Argument 2 to requested IOCTL call
> > + * @out:	Returned output value
> > + *
> > + * Return: RPU mode
>=20
> What kind of output are we expecting? An enum? Which one?
>=20
[Ben Levinsky] will update the return comment. Return: RPU mode. This is en=
um rpu_oper_mode
>=20
> > + */
> > +int zynqmp_pm_get_rpu_mode(u32 node_id,
> > +			   u32 arg1, u32 arg2, u32 *out)
> > +{
> > +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> > +				   IOCTL_GET_RPU_OPER_MODE, 0, 0, out);
> > +}
> > +EXPORT_SYMBOL_GPL(zynqmp_pm_get_rpu_mode);
> > +
> > +/**
> > + * zynqmp_pm_set_rpu_mode() - Set RPU mode
> > + * @node_id:	Node ID of the device
> > + * @ioctl_id:	ID of the requested IOCTL
> > + * @arg2:	Argument 2 to requested IOCTL call
> > + * @out:	Returned output value
> > + *
> > + * This function is used to set RPU mode.
> > + *
> > + * Return: Returns status, either success or error+reason
> > + */
> > +int zynqmp_pm_set_rpu_mode(u32 node_id,
> > +			   u32 arg1, u32 arg2, u32 *out)
> > +{
> > +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> > +				   IOCTL_SET_RPU_OPER_MODE, 0, 0, out);
> > +}
> > +EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
> > +
> > +/**
> > + * zynqmp_pm_tcm_comb_config - configure TCM
> > + * @node_id:	Node ID of the device
> > + * @arg1:	Argument 1 to requested IOCTL call
> > + * @arg2:	Argument 2 to requested IOCTL call
> > + * @out:	Returned output value
>=20
> Same question on the type of the output value
>=20
[Ben Levinsky] will update in v9: Returns status: 0 for success, else failu=
re
>=20
> > + * This function is used to set RPU mode.
> > + *
> > + * Return: Returns status, either success or error+reason
> > + */
> > +int zynqmp_pm_set_tcm_config(u32 node_id,
> > +			     u32 arg1, u32 arg2, u32 *out)
> > +{
> > +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> > +				   IOCTL_TCM_COMB_CONFIG, 0, 0, out);
> > +}
> > +EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
> > +
> >  /**
> >   * zynqmp_pm_force_powerdown - PM call to request for another PU or
> subsystem to
> >   *             be powered down forcefully
> > @@ -881,6 +936,50 @@ int zynqmp_pm_request_wakeup(const u32 node,
> >  }
> >  EXPORT_SYMBOL_GPL(zynqmp_pm_request_wakeup);
> >
> > +/**
> > + * zynqmp_pm_get_node_status - PM call to request a node's current
> power state
> > + * @node:      ID of the component or sub-system in question
> > + * @status:        Current operating state of the requested node
> > + * @requirements:  Current requirements asserted on the node,
> > + *         used for slave nodes only.
> > + * @usage:     Usage information, used for slave nodes only:
> > + *         PM_USAGE_NO_MASTER  - No master is currently using
> > + *                       the node
> > + *         PM_USAGE_CURRENT_MASTER - Only requesting master is
> > + *                       currently using the node
> > + *         PM_USAGE_OTHER_MASTER   - Only other masters are
> > + *                       currently using the node
> > + *         PM_USAGE_BOTH_MASTERS   - Both the current and at least
> > + *                       one other master is currently
> > + *                       using the node
> > + *
> > + * Return: status, either success or error+reason
>=20
> Same question on status
>=20
[Ben Levinsky] this is now not called so I can remove this function in v9.
>=20
> > + */
> > +int zynqmp_pm_get_node_status(const u32 node,
> > +			      u32 *status, u32 *requirements,
> > +			      u32 *usage)
> > +
> > +{
> > +	u32 ret_payload[PAYLOAD_ARG_CNT];
> > +	int ret;
> > +
> > +	if (!status)
> > +		return -EINVAL;
> > +
> > +	ret =3D zynqmp_pm_invoke_fn(PM_GET_NODE_STATUS, node, 0, 0, 0,
> > +				  ret_payload);
> > +	if (ret_payload[0] =3D=3D XST_PM_SUCCESS) {
> > +		*status =3D ret_payload[1];
> > +		if (requirements)
> > +			*requirements =3D ret_payload[2];
> > +		if (usage)
> > +			*usage =3D ret_payload[3];
> > +	}
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(zynqmp_pm_get_node_status);
> > +
> >  /**
> >   * zynqmp_pm_set_requirement() - PM call to set requirement for PM
> slaves
> >   * @node:		Node ID of the slave
> > diff --git a/include/linux/firmware/xlnx-zynqmp.h
> b/include/linux/firmware/xlnx-zynqmp.h
> > index 4d83a7d69c4c..0caca9e2223a 100644
> > --- a/include/linux/firmware/xlnx-zynqmp.h
> > +++ b/include/linux/firmware/xlnx-zynqmp.h
> > @@ -64,6 +64,7 @@
> >
> >  enum pm_api_id {
> >  	PM_GET_API_VERSION =3D 1,
> > +	PM_GET_NODE_STATUS =3D 3,
> >  	PM_FORCE_POWERDOWN =3D 8,
> >  	PM_REQUEST_WAKEUP =3D 10,
> >  	PM_SYSTEM_SHUTDOWN =3D 12,
> > @@ -384,6 +385,14 @@ int zynqmp_pm_request_wakeup(const u32 node,
> >  			     const bool set_addr,
> >  			     const u64 address,
> >  			     const enum zynqmp_pm_request_ack ack);
> > +int zynqmp_pm_get_node_status(const u32 node, u32 *status,
> > +			      u32 *requirements, u32 *usage);
> > +int zynqmp_pm_get_rpu_mode(u32 node_id,
> > +			   u32 arg1, u32 arg2, u32 *out);
> > +int zynqmp_pm_set_rpu_mode(u32 node_id,
> > +			   u32 arg1, u32 arg2, u32 *out);
> > +int zynqmp_pm_set_tcm_config(u32 node_id,
> > +			     u32 arg1, u32 arg2, u32 *out);
> >  #else
> >  static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
> >  {
> > @@ -548,6 +557,31 @@ static inline int zynqmp_pm_request_wakeup(const
> u32 node,
> >  {
> >  	return -ENODEV;
> >  }
> > +
> > +static inline int zynqmp_pm_get_node_status(const u32 node,
> > +					    u32 *status, u32 *requirements,
> > +					    u32 *usage)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> > +static inline int zynqmp_pm_get_rpu_mode(u32 node_id,
> > +					 u32 arg1, u32 arg2, u32 *out)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> > +static inline int zynqmp_pm_set_rpu_mode(u32 node_id,
> > +					 u32 arg1, u32 arg2, u32 *out)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> > +static inline int zynqmp_pm_set_tcm_config(u32 node_id,
> > +					   u32 arg1, u32 arg2, u32 *out)
> > +{
> > +	return -ENODEV;
> > +}
> >  #endif
> >
> >  #endif /* __FIRMWARE_ZYNQMP_H__ */

