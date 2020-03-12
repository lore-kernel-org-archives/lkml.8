Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B8BC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283C520650
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="n2Ns6GKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgCLIMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:12:41 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:11920 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbgCLIMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:12:40 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02C7rCGI031103;
        Thu, 12 Mar 2020 09:12:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=RwEJBp8wHCul5X0rCg/SvUcmZaexxdJBwvrno11VP9w=;
 b=n2Ns6GKJ/MPlczw8pswUq5NEBuk9m7/5pJHgZnNsYPm56MZAa9szNHhd3m69q12o855S
 FIBr75IItjNH+Wg5KvGSXic2afygEua6bb0nBSQKBbVvNWu0bPhVoc0u1ZEnA11f+2tz
 YA3a84Ofn7/MNuC9GfHM+sYIBDkEpc9GIbCd/kvc4rh2DplvypE/NFLfKZawS9uPcJZD
 2c2IouNQKxJRLzGGFDqGZH0/49r0+nWYtHQFX/F8mztOQlIUW9qtQSlrEnGs3ldOcQdo
 +LQjd9C/i9ypJcvPqITAzhEsAeLgQbNrNJFTMQhodr8LlRd98EkUpdvVOqQdZKICUeog VQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ym1y70eyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 09:12:33 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4050410002A;
        Thu, 12 Mar 2020 09:12:33 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2E38C21046A;
        Thu, 12 Mar 2020 09:12:33 +0100 (CET)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Mar
 2020 09:12:32 +0100
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1473.003; Thu, 12 Mar 2020 09:12:32 +0100
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "Fabien DESSENNE" <fabien.dessenne@st.com>,
        "s-anna@ti.com" <s-anna@ti.com>
Subject: RE: [RFC 1/2] remoteproc: sysfs: authorize rproc shutdown when rproc
 is crashed
Thread-Topic: [RFC 1/2] remoteproc: sysfs: authorize rproc shutdown when rproc
 is crashed
Thread-Index: AQHV95N1/mW6m1ZqkUyhqMT4RCAmr6hD+T6AgACgTkA=
Date:   Thu, 12 Mar 2020 08:12:32 +0000
Message-ID: <1161f034ddc64d6aa782f06c3c4996cd@SFHDAG7NODE2.st.com>
References: <1583924072-20648-1-git-send-email-loic.pallardy@st.com>
 <1583924072-20648-2-git-send-email-loic.pallardy@st.com>
 <20200311232707.GA1214176@minitux>
In-Reply-To: <20200311232707.GA1214176@minitux>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_15:2020-03-11,2020-03-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> Sent: jeudi 12 mars 2020 00:27
> To: Loic PALLARDY <loic.pallardy@st.com>
> Cc: ohad@wizery.com; mathieu.poirier@linaro.org; linux-
> remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; Arnaud
> POULIQUEN <arnaud.pouliquen@st.com>; benjamin.gaignard@linaro.org;
> Fabien DESSENNE <fabien.dessenne@st.com>; s-anna@ti.com
> Subject: Re: [RFC 1/2] remoteproc: sysfs: authorize rproc shutdown when
> rproc is crashed
>=20
> On Wed 11 Mar 03:54 PDT 2020, Loic Pallardy wrote:
>=20
> > When remoteproc recovery is disabled and rproc crashed, user space
> > client has no way to reboot co-processor except by a complete platform
> > reboot.
> > Indeed rproc_shutdown() is called by sysfs state_store() only is rproc
> > state is RPROC_RUNNING.
> >
> > This patch offers the possibility to shutdown the co-processor if
> > it is in RPROC_CRASHED state and so to restart properly co-processor
> > from sysfs interface.
> >
>=20
> I did recently run into a similar problem when I fed my remoteproc
> faulty firmware, which lead to it recovering immediately upon boot. The
> amount of time spent in !CRASHED state was minimal, so I didn't have any
> way to stop the remoteproc.
>=20
> > Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> > ---
> >  drivers/remoteproc/remoteproc_core.c  | 2 +-
> >  drivers/remoteproc/remoteproc_sysfs.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c
> b/drivers/remoteproc/remoteproc_core.c
> > index 097f33e4f1f3..7ac87a75cd1b 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1812,7 +1812,7 @@ void rproc_shutdown(struct rproc *rproc)
> >  	if (!atomic_dec_and_test(&rproc->power))
> >  		goto out;
> >
> > -	ret =3D rproc_stop(rproc, false);
> > +	ret =3D rproc_stop(rproc, rproc->state =3D=3D RPROC_CRASHED);
>=20
> Afaict this is unrelated to the problem you're describing in the commit
> message.
Right, it is because now rproc_shudown could be could in a context where rp=
roc is in RPROC_CRASHED state and so false is no more the default value.
Could be split in another patch.

>=20
> >  	if (ret) {
> >  		atomic_inc(&rproc->power);
> >  		goto out;
> > diff --git a/drivers/remoteproc/remoteproc_sysfs.c
> b/drivers/remoteproc/remoteproc_sysfs.c
> > index 7f8536b73295..1029458a4678 100644
> > --- a/drivers/remoteproc/remoteproc_sysfs.c
> > +++ b/drivers/remoteproc/remoteproc_sysfs.c
> > @@ -101,7 +101,7 @@ static ssize_t state_store(struct device *dev,
> >  		if (ret)
> >  			dev_err(&rproc->dev, "Boot failed: %d\n", ret);
> >  	} else if (sysfs_streq(buf, "stop")) {
> > -		if (rproc->state !=3D RPROC_RUNNING)
> > +		if (rproc->state !=3D RPROC_RUNNING && rproc->state !=3D
> RPROC_CRASHED)
>=20
> Analogous to the problem reported by Alex here
> https://patchwork.kernel.org/patch/11413161/ the handling of stop seems
> racy.
>=20
> In particular, I believe you're failing to protect against a race
> with a just scheduled rproc_crash_handler_work() being executed after
> the mutex_unlock() in rproc_shutdown()...
>=20
> With Alex fix that should be less of a problem though...
Thanks for pointing me Alex's patch. But I don't think it is exactly the sa=
me issue as it concerns the recovery procedure itself.
In my case, the recovery is disabled. On a crash detection, rproc->state is=
 simply set to RPROC_CRASHED
and recovery is not  triggered.
Without client action, rproc will stay forever in RPROC_CRASHED test.
Today without this modification, it is not possible to shutdown rproc prope=
rly, putting coprocessor under reset,  disabling clocks...

Regards,
Loic

>=20
> Regards,
> Bjorn
>=20
> >  			return -EINVAL;
> >
> >  		rproc_shutdown(rproc);
> > --
> > 2.7.4
> >
