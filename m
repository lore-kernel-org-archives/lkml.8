Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E88C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEE120650
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Lne50YTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388146AbgCLIAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:00:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50828 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387869AbgCLIAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:00:09 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02C7qxMI028487;
        Thu, 12 Mar 2020 09:00:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=yfAjiskuApnI7ltsE6KidUCesqH67sfSRCasBTHc9pE=;
 b=Lne50YTzS6lz8OYhd9F/XWSrt2snNGYTq7agdjSLizjH5doLKDoh2MS9HjDUQ6emwRRB
 4U9FylMaG0pi5wpgKCAuzXpu7uYaTQyJW7w+sjmWH9b0O2ilHYxAYNnG0/pMhdJh9rRm
 yHb7qePTII1cSZWWTPmA8Qxgb785a82jQE19N30kWvG/F+USh/8qHMKJpdSR47aPK2w5
 5qqnZGkUL4MoQVNBKaUDV4cbOuO7XzJK/HkuGvWDEk2LQqo84dovoOu9Qr42gg1W8VMd
 aC6Tpa1jxB6PInAHySMoCwN4GvCafsWpcN89AxbhO0CKpKJy4jT/1LK1hFMMwaJgxYe7 lQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ynecdpw2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 09:00:02 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1FBEA100034;
        Thu, 12 Mar 2020 09:00:02 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 11844210453;
        Thu, 12 Mar 2020 09:00:02 +0100 (CET)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Mar
 2020 09:00:01 +0100
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1473.003; Thu, 12 Mar 2020 09:00:01 +0100
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
Thread-Index: AQHV95N1/mW6m1ZqkUyhqMT4RCAmr6hD3LsAgAC7ffA=
Date:   Thu, 12 Mar 2020 08:00:01 +0000
Message-ID: <991a1e4bce844103a7e93960750944c1@SFHDAG7NODE2.st.com>
References: <1583924072-20648-1-git-send-email-loic.pallardy@st.com>
 <1583924072-20648-2-git-send-email-loic.pallardy@st.com>
 <20200311214504.GA32471@xps15>
In-Reply-To: <20200311214504.GA32471@xps15>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_15:2020-03-11,2020-03-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

> -----Original Message-----
> From: Mathieu Poirier <mathieu.poirier@linaro.org>
> Sent: mercredi 11 mars 2020 22:45
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
> And it is not possible to use the debugfs interface [1] to restart the MC=
U?
>=20
> [1]. https://elixir.bootlin.com/linux/v5.6-
> rc2/source/drivers/remoteproc/remoteproc_debugfs.c#L147

Debugfs interface is optional and on final product it is often disabled.
The used control interfaces are in kernel API and sysfs one.

Regards,
Loic
>=20
>=20
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
> >
> >  		rproc_shutdown(rproc);
> > --
> > 2.7.4
> >
