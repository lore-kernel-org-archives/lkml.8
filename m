Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF5BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E5A2137B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="bNNgieeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgDQHy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:54:58 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28632 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728330AbgDQHy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:54:58 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03H7qKjj000371;
        Fri, 17 Apr 2020 09:54:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=dfRpc0tITeW0hG9RGgB46LagoTB/43a/frM+AEK3Vfs=;
 b=bNNgieebmOqNreSIGdoQQcnNA0tM+ahFm47Ckau1yO6VIQrwaDs1x+GiGD/ac0WTmWU5
 cbRv/iK4jg/zjYeUS4GTU36XzJBMEPO2V40u6fWnHfv/Us/31JmtR9kG5Stx2hAsxasF
 9BLgwfQ0RjuibtaAO3hrewWUpYuS+iPN/en4MQXt1T5ZWShw4L87s7tPez1ZefQlq5hp
 x3R84uOB3aAFhX4Hmb/nGIbYeGZayX2MO/a0TqHzK3tvQkiv42K0sqHtL03BHSjwbEQ9
 5Z8GcBPVBJF1hGukN30IOlsT+4IquhEQSczm1+Jj7PSs00CHLf0mi0ngHcF8c4D7WVIy Mg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn94qwjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 09:54:51 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BD2E0100034;
        Fri, 17 Apr 2020 09:54:50 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AB2472A67BF;
        Fri, 17 Apr 2020 09:54:50 +0200 (CEST)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG7NODE2.st.com
 (10.75.127.20) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr
 2020 09:54:50 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1473.003; Fri, 17 Apr 2020 09:54:50 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "tsoni@codeaurora.org" <tsoni@codeaurora.org>,
        "psodagud@codeaurora.org" <psodagud@codeaurora.org>,
        "sidgup@codeaurora.org" <sidgup@codeaurora.org>
Subject: RE: [PATCH 3/3] remoteproc: Add coredump sysfs attribute
Thread-Topic: [PATCH 3/3] remoteproc: Add coredump sysfs attribute
Thread-Index: AQHWFB5cv6Y89kZY+ki5NMf+gyIkiah88jow
Date:   Fri, 17 Apr 2020 07:54:50 +0000
Message-ID: <8b807eab057e4dfabbc48d31cbf0b4cc@SFHDAG7NODE2.st.com>
References: <1587062312-4939-1-git-send-email-rishabhb@codeaurora.org>
 <1587062312-4939-3-git-send-email-rishabhb@codeaurora.org>
In-Reply-To: <1587062312-4939-3-git-send-email-rishabhb@codeaurora.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_02:2020-04-14,2020-04-17 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rishabh,

> -----Original Message-----
> From: linux-remoteproc-owner@vger.kernel.org <linux-remoteproc-
> owner@vger.kernel.org> On Behalf Of Rishabh Bhatnagar
> Sent: jeudi 16 avril 2020 20:39
> To: linux-remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: bjorn.andersson@linaro.org; ohad@wizery.com;
> mathieu.poirier@linaro.org; tsoni@codeaurora.org;
> psodagud@codeaurora.org; sidgup@codeaurora.org; Rishabh Bhatnagar
> <rishabhb@codeaurora.org>
> Subject: [PATCH 3/3] remoteproc: Add coredump sysfs attribute
>=20
> Add coredump sysfs attribute to configure the type of memory dump.
> User can select between default or inline coredump functionality.
> Also coredump collection can be disabled through this interface.
> This functionality can be configured differently for different
> remote processors.
> This provides an option to dynamically configure the dump type
> based on userpsace capability.
I think this should be under debugfs as it is not link to remoteproc contro=
l but only
to its debug capability. Moreover other fields related to coredump are alre=
ady un debugfs control.

Regards,
Loic
>=20
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/remoteproc_sysfs.c | 57
> +++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>=20
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c
> b/drivers/remoteproc/remoteproc_sysfs.c
> index 7f8536b..d112664 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -9,6 +9,62 @@
>=20
>  #define to_rproc(d) container_of(d, struct rproc, dev)
>=20
> +/*
> + * A coredump-configuration-to-string lookup table, for exposing a
> + * human readable configuration via sysfs. Always keep in sync with
> + * enum rproc_coredump_conf
> + */
> +static const char * const rproc_coredump_str[] =3D {
> +	[COREDUMP_DEFAULT]	=3D "default",
> +	[COREDUMP_INLINE]	=3D "inline",
> +	[COREDUMP_DISABLED]	=3D "disabled",
> +};
> +
> +/* Expose the current coredump configuration via sysfs */
> +static ssize_t coredump_show(struct device *dev, struct device_attribute
> *attr,
> +			      char *buf)
> +{
> +	struct rproc *rproc =3D to_rproc(dev);
> +
> +	return sprintf(buf, "%s\n", rproc_coredump_str[rproc-
> >coredump_conf]);
> +}
> +
> +/* Change the coredump configuration via sysfs */
> +static ssize_t coredump_store(struct device *dev, struct device_attribut=
e
> *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct rproc *rproc =3D to_rproc(dev);
> +	int err;
> +
> +	err =3D mutex_lock_interruptible(&rproc->lock);
> +	if (err) {
> +		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, err);
> +		return -EINVAL;
> +	}
> +
> +	if (rproc->state =3D=3D RPROC_CRASHED) {
> +		dev_err(dev, "can't change coredump configuration\n");
> +		err =3D -EBUSY;
> +		goto out;
> +	}
> +
> +	if (sysfs_streq(buf, "disable"))
> +		rproc->coredump_conf =3D COREDUMP_DISABLED;
> +	else if (sysfs_streq(buf, "inline"))
> +		rproc->coredump_conf =3D COREDUMP_INLINE;
> +	else if (sysfs_streq(buf, "default"))
> +		rproc->coredump_conf =3D COREDUMP_DEFAULT;
> +	else {
> +		dev_err(dev, "Invalid coredump configuration\n");
> +		err =3D -EINVAL;
> +	}
> +out:
> +	mutex_unlock(&rproc->lock);
> +
> +	return err ? err : count;
> +}
> +static DEVICE_ATTR_RW(coredump);
> +
>  /* Expose the loaded / running firmware name via sysfs */
>  static ssize_t firmware_show(struct device *dev, struct device_attribute
> *attr,
>  			  char *buf)
> @@ -127,6 +183,7 @@ static ssize_t name_show(struct device *dev, struct
> device_attribute *attr,
>  	&dev_attr_firmware.attr,
>  	&dev_attr_state.attr,
>  	&dev_attr_name.attr,
> +	&dev_attr_coredump.attr,
>  	NULL
>  };
>=20
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum,
> a Linux Foundation Collaborative Project
