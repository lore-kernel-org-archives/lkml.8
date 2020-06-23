Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCD7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F7B20776
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="t5ZkyFZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732917AbgFWOl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:41:28 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:48854 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732738AbgFWOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:41:28 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NEZFed025327;
        Tue, 23 Jun 2020 10:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=E0FBL4R3eH/7ZSGYrJ0eEsuJ5bRdq3ru0ZSDBWytvsQ=;
 b=t5ZkyFZQQVy8JoSixrd4hMI37TOHLK9BvJZX3SnElTyti5vg9xkk0AXSOe8MZF2ZIXbI
 84r7+KKRvoD7eIPgO83rk4ci33L8nh9ERLVDGe3tnHmjV5ifnmGbIjvdW3CiThMSkSd9
 J6sAH0WjzD8vexhO2FtcC/32td4ANNVkYs+YoqeEwMkcXSggGnjEQXeQeQIQUn+o5kaB
 /2Kx/pJAb6myncpsylL5XZgFc/x1PeGOvozKCpIs8DZyLFbJJfwbWEiPlLMPeQgL22sj
 vKyLjJcGdglSUhk4ASaGDO6WxhoST4aO9+bpx2NpGVir7WQEG9ORydE9u9O7ZdCsyxS5 9g== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 31uk4485ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 10:41:27 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NEePT2102125;
        Tue, 23 Jun 2020 10:41:27 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 31uk4qrm0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 10:41:26 -0400
X-LoopCount0: from 10.166.132.127
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="514072910"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>
CC:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <YehezkelShB@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] thunderbolt: Add support for separating the flush
 to SPI and authenticate
Thread-Topic: [PATCH v2 1/2] thunderbolt: Add support for separating the flush
 to SPI and authenticate
Thread-Index: AQHWSMcSmkoxF+bDRkqAhTjZP4eBtKjmmJ0A//+sa+A=
Date:   Tue, 23 Jun 2020 14:41:17 +0000
Message-ID: <29e94ea61aa44ff995c317d32afd019d@AUSX13MPC105.AMER.DELL.COM>
References: <20200622185758.28145-1-mario.limonciello@dell.com>
 <20200622185758.28145-2-mario.limonciello@dell.com>
 <20200623143252.GD2795@lahna.fi.intel.com>
In-Reply-To: <20200623143252.GD2795@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-23T14:41:16.8252679Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=aed65a35-af8f-45d2-a77a-4b2f84f1d642;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_07:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230115
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Tuesday, June 23, 2020 9:33 AM
> To: Limonciello, Mario
> Cc: Andreas Noever; Michael Jamet; Yehezkel Bernat; linux-usb@vger.kernel=
.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] thunderbolt: Add support for separating the f=
lush
> to SPI and authenticate
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Mon, Jun 22, 2020 at 01:57:57PM -0500, Mario Limonciello wrote:
> > This allows userspace to have a shorter period of time that the device
> > is unusable and to call it at a more convenient time.
> >
> > For example flushing the image may happen while the user is using the
> > machine and authenticating/rebooting may happen while logging out.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > ---
> >  .../ABI/testing/sysfs-bus-thunderbolt         | 11 ++++-
> >  drivers/thunderbolt/nvm.c                     |  1 +
> >  drivers/thunderbolt/switch.c                  | 42 ++++++++++++-------
> >  drivers/thunderbolt/tb.h                      |  2 +
> >  4 files changed, 39 insertions(+), 17 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt
> b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> > index bd504ed323e8..7d0500b4d58a 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
> > +++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> > @@ -178,11 +178,18 @@ KernelVersion:	4.13
> >  Contact:	thunderbolt-software@lists.01.org
> >  Description:	When new NVM image is written to the non-active NVM
> >  		area (through non_activeX NVMem device), the
> > -		authentication procedure is started by writing 1 to
> > -		this file. If everything goes well, the device is
> > +		authentication procedure is started by writing to
> > +		this file.
> > +		If everything goes well, the device is
> >  		restarted with the new NVM firmware. If the image
> >  		verification fails an error code is returned instead.
> >
> > +		This file will accept writing values "1" or "2"
> > +		- Writing "1" will flush the image to the storage
> > +		area and authenticate the image in one action.
> > +		- Writing "2" will run some basic validation on the image
> > +		and flush it to the storage area.
> > +
> >  		When read holds status of the last authentication
> >  		operation if an error occurred during the process. This
> >  		is directly the status value from the DMA configuration
> > diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
> > index 4c6aa06ab3d5..29de6d95c6e7 100644
> > --- a/drivers/thunderbolt/nvm.c
> > +++ b/drivers/thunderbolt/nvm.c
> > @@ -100,6 +100,7 @@ int tb_nvm_write_buf(struct tb_nvm *nvm, unsigned i=
nt
> offset, void *val,
> >  			return -ENOMEM;
> >  	}
> >
> > +	nvm->flushed =3D false;
>=20
> This means every write invalidates the "flushed" state, right?

Correct.

>=20
> >  	nvm->buf_data_size =3D offset + bytes;
> >  	memcpy(nvm->buf + offset, val, bytes);
> >  	return 0;
> > diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.=
c
> > index 817c66c7adcf..bbfbfebeee7f 100644
> > --- a/drivers/thunderbolt/switch.c
> > +++ b/drivers/thunderbolt/switch.c
> > @@ -26,6 +26,11 @@ struct nvm_auth_status {
> >  	u32 status;
> >  };
> >
> > +enum nvm_write_ops {
> > +	WRITE_AND_AUTHENTICATE =3D 1,
> > +	WRITE_ONLY =3D 2,
> > +};
> > +
> >  /*
> >   * Hold NVM authentication failure status per switch This information
> >   * needs to stay around even when the switch gets power cycled so we
> > @@ -155,8 +160,12 @@ static int nvm_validate_and_write(struct tb_switch=
 *sw)
> >  	}
> >
> >  	if (tb_switch_is_usb4(sw))
> > -		return usb4_switch_nvm_write(sw, 0, buf, image_size);
> > -	return dma_port_flash_write(sw->dma_port, 0, buf, image_size);
> > +		ret =3D usb4_switch_nvm_write(sw, 0, buf, image_size);
> > +	else
> > +		ret =3D dma_port_flash_write(sw->dma_port, 0, buf, image_size);
> > +	if (!ret)
> > +		sw->nvm->flushed =3D true;
> > +	return ret;
> >  }
> >
> >  static int nvm_authenticate_host_dma_port(struct tb_switch *sw)
> > @@ -1488,7 +1497,7 @@ static ssize_t nvm_authenticate_store(struct devi=
ce
> *dev,
> >  	struct device_attribute *attr, const char *buf, size_t count)
> >  {
> >  	struct tb_switch *sw =3D tb_to_switch(dev);
> > -	bool val;
> > +	int val;
> >  	int ret;
> >
> >  	pm_runtime_get_sync(&sw->dev);
> > @@ -1504,25 +1513,28 @@ static ssize_t nvm_authenticate_store(struct de=
vice
> *dev,
> >  		goto exit_unlock;
> >  	}
> >
> > -	ret =3D kstrtobool(buf, &val);
> > +	ret =3D kstrtoint(buf, 10, &val);
> >  	if (ret)
> >  		goto exit_unlock;
> >
> >  	/* Always clear the authentication status */
> >  	nvm_clear_auth_status(sw);
> >
> > -	if (val) {
> > -		if (!sw->nvm->buf) {
> > -			ret =3D -EINVAL;
> > -			goto exit_unlock;
> > -		}
> > -
> > -		ret =3D nvm_validate_and_write(sw);
> > -		if (ret)
> > -			goto exit_unlock;
> > +	if (val > 0) {
> > +		if (!sw->nvm->flushed) {
> > +			if (!sw->nvm->buf) {
> > +				ret =3D -EINVAL;
> > +				goto exit_unlock;
> > +			}
> >
> > -		sw->nvm->authenticating =3D true;
> > -		ret =3D nvm_authenticate(sw);
> > +			ret =3D nvm_validate_and_write(sw);
> > +			if (ret || val =3D=3D WRITE_ONLY)
> > +				goto exit_unlock;
> > +		}
> > +		if (val =3D=3D WRITE_AND_AUTHENTICATE) {
> > +			sw->nvm->authenticating =3D true;
> > +			ret =3D nvm_authenticate(sw);
> > +		}
> >  	}
> >
> >  exit_unlock:
> > diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> > index 736d1589c31e..43a8ca2eb3d8 100644
> > --- a/drivers/thunderbolt/tb.h
> > +++ b/drivers/thunderbolt/tb.h
> > @@ -42,6 +42,7 @@
> >   *
> >   * The user of this structure needs to handle serialization of possibl=
e
> >   * concurrent access.
> > + * @flushed: The image has been flushed to the storage area
>=20
> This should go below the @authenticating description.

Oh thanks, I obviously didn't read the actual comments in the merge conflic=
t
when I rebased.  Will fix in a v3.

>=20
> >   */
> >  struct tb_nvm {
> >  	struct device *dev;
> > @@ -53,6 +54,7 @@ struct tb_nvm {
> >  	void *buf;
> >  	size_t buf_data_size;
> >  	bool authenticating;
> > +	bool flushed;
> >  };
> >
> >  #define TB_SWITCH_KEY_SIZE		32
> > --
> > 2.25.1
