Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32644C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0191620789
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="JvzCXlBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgCYSai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:30:38 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55300 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727027AbgCYSai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 14:30:38 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02PINxeb028143;
        Wed, 25 Mar 2020 19:30:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=zpllj8praaLPPLYV2yYmSw2+242E3/2OF9GtQEZE5YY=;
 b=JvzCXlBsGQXc4SSlLAxkL6bmmKQgc47b9xbhwwYS7zZYoVjhDILewgVOMfuYKyzQqjTf
 LsYh1pBE8IhBna3CmKExxoEs5UHXN7H1fmy5cbiPkDUugk4V4faR+xBiVrCiqAUeqsYh
 8jWvEOnFAqYHc3dBEJNRkcALkLPF+DpGl1RnJsDt5yf7ByGaSLovJALaT/KWr5PFr6wr
 8/O5jmoaHCGd2PHktFdLsEUYMhYaKXBkCmFay1K0mg+U3MlAbFSXyTEjX0UNlnzk/1d6
 jYVVpz0NMsoMPChB1kEo7fEo/GRplxZdY3ng8fmvgtyWfUBMY9kRV0GHB+jMX1oNL3Su QA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ywapp71y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 19:30:29 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 586D610002A;
        Wed, 25 Mar 2020 19:30:29 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4971E2ABE3A;
        Wed, 25 Mar 2020 19:30:29 +0100 (CET)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Mar
 2020 19:30:28 +0100
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1473.003; Wed, 25 Mar 2020 19:30:28 +0100
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
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
Thread-Index: AQHV95N1/mW6m1ZqkUyhqMT4RCAmr6hZndwAgAATJNA=
Date:   Wed, 25 Mar 2020 18:30:28 +0000
Message-ID: <9a089cba07f7454ea0fc0f2d09bd9bf0@SFHDAG7NODE2.st.com>
References: <1583924072-20648-1-git-send-email-loic.pallardy@st.com>
 <1583924072-20648-2-git-send-email-loic.pallardy@st.com>
 <20200325175746.GA6227@xps15>
In-Reply-To: <20200325175746.GA6227@xps15>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_09:2020-03-24,2020-03-25 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

> -----Original Message-----
> From: Mathieu Poirier <mathieu.poirier@linaro.org>
> Sent: mercredi 25 mars 2020 18:58
> To: Loic PALLARDY <loic.pallardy@st.com>
> Cc: bjorn.andersson@linaro.org; ohad@wizery.com; linux-
> remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; Arnaud
> POULIQUEN <arnaud.pouliquen@st.com>; benjamin.gaignard@linaro.org;
> Fabien DESSENNE <fabien.dessenne@st.com>; s-anna@ti.com
> Subject: Re: [RFC 1/2] remoteproc: sysfs: authorize rproc shutdown when
> rproc is crashed
>=20
> Hi Loic,
>=20
> On Wed, Mar 11, 2020 at 11:54:31AM +0100, Loic Pallardy wrote:
> > When remoteproc recovery is disabled and rproc crashed, user space
> > client has no way to reboot co-processor except by a complete platform
> > reboot.
> > Indeed rproc_shutdown() is called by sysfs state_store() only is rproc
> > state is RPROC_RUNNING.
> >
> > This patch offers the possibility to shutdown the co-processor if
> > it is in RPROC_CRASHED state and so to restart properly co-processor
> > from sysfs interface.
>=20
> If recovery is disabled on an rproc the platform likely intended to have =
a hard
> reboot and as such we should not be concerned about this case.
I disagree with your view. In fact, we can have a configuration for which
we don't want a silent recovery. Application layer can be involved to stop =
and
restart some services because it is the simplest way to resync with the cop=
rocessor.
What's missing today is an event to notify user space application that copr=
ocessor state
has changed. (even if we can rely on rpmsg services closure)

>=20
> Where I think we have a problem, something that is asserted by looking at
> your 2
> patches, is cases where rproc_trigger_recovery() fails.  That leaves the
> system
> in a state where it can't be recovered, something the remoteproc core
> should not
> allow.
>=20
Right this is a second use case we faced when user space application which =
provided
firmware file crashed before coprocessor. In that case firmware file may be=
 removed
from /lib/firmware directory and coprocessor recovery failed.
Application, when restarting, can't anymore control coprocessor.

Regards,
Loic

> >
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
> Please add a comment that explains how we can be in rproc_shutdown()
> when the
> processor has crashed and point to rproc_trigger_recovery().  See below f=
or
> more
> details.
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
> >  			return -EINVAL;
>=20
> Wouldn't it be better to just prevent the MCU to stay in a crashed state
> (when
> recovery is not disabled)?
>=20
> I like what you did in the next patch where the state of the MCU is set t=
o
> RPROC_CRASHED in case of failure, so that we keep.  I also think the hunk
> above is correct.  All that is left is to call rproc_shutdown() directly =
in
> rproc_trigger_recovery() when something goes wrong.  I would also add a
> dev_err() so that users have a clue of what happened.
>=20
> That would leave the system in a stable state without having to add
> intelligence
> to state_store().
It is a solution we debate internally. Should rproc_shutdown() called direc=
tly in
rproc_trigger_recovery() or not? If we go in such direction, that clearly s=
implify=20
coprocessor control as it will always be in a "stable" state. But that mean=
s user
will lost information that coprocessor crashed (mainly when recovery is dis=
abled).
We just know that coprocessor is stopped but not why? Crashed or client act=
ion?=20
For debug purpose, it could be an issue from my pov.

Regards,
Loic
>=20
> Let me know that you think...
>=20
> Mathieu
>=20
> >
> >  		rproc_shutdown(rproc);
> > --
> > 2.7.4
> >
