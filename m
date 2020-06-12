Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E49C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C7CF2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="lspbOloZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgFLOLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:11:20 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:22797 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLOLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:11:20 -0400
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx01-sz.bfs.de (Postfix) with ESMTPS id 35DE4202F0;
        Fri, 12 Jun 2020 16:11:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1591971077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rCt+zPHuTM/eBgI+6Wbu3vlbltRttVGV2Uwnv+yEG1Y=;
        b=lspbOloZqL6u0qm35FR4cpXwIxvjaTbA9WeHGq1aJcyucsCvtNmBYhM2ofH3b2fgpZrget
        YVHzFyJtnVIewtpf3gXokjF4lsx6vcdAniwJvrijMp8AZmT/leUVdkUQB8BgJ1HMQXQ+Gs
        I2BVfj12UONhuU/JI8WKZxbjBPIGkusv1sjrra8HRy/00+9Jz4Un9K3Ss7rSbKNALDoPKA
        9CSeXAachkec1csCm8ljiKz4gQZY/qIzBZ0cdtCr2NTpbQcHXyX4hm0cXqWvJoIE1fXXtc
        QVddZfTSSOUaQJE04von+c3C6OWkjm2Vn7RjMmEfvfBbrfKnOmSa4k/HYedQEQ==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1913.5; Fri, 12 Jun
 2020 16:11:16 +0200
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%6]) with mapi id
 15.01.1913.005; Fri, 12 Jun 2020 16:11:16 +0200
From:   Walter Harms <wharms@bfs.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Leach <mike.leach@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: AW: [PATCH] coresight: cti: Fix error handling in probe
Thread-Topic: [PATCH] coresight: cti: Fix error handling in probe
Thread-Index: AQHWQL/uFacPuxfT5k+bfPO1tVl2Q6jVA0Va
Date:   Fri, 12 Jun 2020 14:11:16 +0000
Message-ID: <6c59bdbc15714b089d256ad50aee58cb@bfs.de>
References: <20200612121047.GF4282@kadam>,<20200612121133.GA1139533@mwanda>
In-Reply-To: <20200612121133.GA1139533@mwanda>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Authentication-Results: mx01-sz.bfs.de;
        none
X-Spamd-Result: default: False [-2.65 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         NEURAL_HAM(-0.00)[-1.034];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-2.65)[98.44%]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

nit picking in cti_pm_release()

IMHO this should be done in 2 steps:
      if (--nr_cti_cpu =3D=3D 0)
->
  --nr_cti_cpu ;
 if ( nr_cti_cpu =3D=3D 0)

the decrement is easy to miss (what i did first).

yes, i noticed that it is also in the original code and
it is not that important but while you are here ...

jm2c,
re,
 wh
________________________________________
Von: kernel-janitors-owner@vger.kernel.org <kernel-janitors-owner@vger.kern=
el.org> im Auftrag von Dan Carpenter <dan.carpenter@oracle.com>
Gesendet: Freitag, 12. Juni 2020 14:11:33
An: Mike Leach
Cc: Mathieu Poirier; Suzuki K Poulose; Alexander Shishkin; Greg Kroah-Hartm=
an; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; ker=
nel-janitors@vger.kernel.org
Betreff: [PATCH] coresight: cti: Fix error handling in probe

There were a couple problems with error handling in the probe function:
1)  If the "drvdata" allocation failed then it lead to a NULL
    dereference.
2)  On several error paths we decremented "nr_cti_cpu" before it was
    incremented which lead to a reference counting bug.

There were also some parts of the error handling which were not bugs but
were messy.  The error handling was confusing to read.  It printed some
unnecessary error messages.

The simplest way to fix these problems was to create a cti_pm_setup()
function that did all the power management setup in one go.  That way
when we call cti_pm_release() we don't have to deal with the
complications of a partially configured power management config.

I reversed the "if (drvdata->ctidev.cpu >=3D 0)" condition in cti_pm_releas=
e()
so that it mirros the new cti_pm_setup() function.

Fixes: 6a0953ce7de9 ("coresight: cti: Add CPU idle pm notifer to CTI device=
s")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Please note!!!  I cannot compile this patch.  Mike can you review it?

 drivers/hwtracing/coresight/coresight-cti.c | 96 ++++++++++++---------
 1 file changed, 54 insertions(+), 42 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracin=
g/coresight/coresight-cti.c
index 40387d58c8e7..d2da5bf9f552 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -747,17 +747,50 @@ static int cti_dying_cpu(unsigned int cpu)
        return 0;
 }

+static int cti_pm_setup(struct cti_drvdata *drvdata)
+{
+       int ret;
+
+       if (drvdata->ctidev.cpu =3D=3D -1)
+               return 0;
+
+       if (nr_cti_cpu)
+               goto done;
+
+       cpus_read_lock();
+       ret =3D cpuhp_setup_state_nocalls_cpuslocked(
+                       CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
+                       "arm/coresight_cti:starting",
+                       cti_starting_cpu, cti_dying_cpu);
+       if (ret) {
+               cpus_read_unlock();
+               return ret;
+       }
+
+       ret =3D cpu_pm_register_notifier(&cti_cpu_pm_nb);
+       cpus_read_unlock();
+       if (ret) {
+               cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_CTI_START=
ING);
+               return ret;
+       }
+
+done:
+       nr_cti_cpu++;
+       cti_cpu_drvdata[drvdata->ctidev.cpu] =3D drvdata;
+
+       return 0;
+}
+
 /* release PM registrations */
 static void cti_pm_release(struct cti_drvdata *drvdata)
 {
-       if (drvdata->ctidev.cpu >=3D 0) {
-               if (--nr_cti_cpu =3D=3D 0) {
-                       cpu_pm_unregister_notifier(&cti_cpu_pm_nb);
+       if (drvdata->ctidev.cpu =3D=3D -1)
+               return;

-                       cpuhp_remove_state_nocalls(
-                               CPUHP_AP_ARM_CORESIGHT_CTI_STARTING);
-               }
-               cti_cpu_drvdata[drvdata->ctidev.cpu] =3D NULL;
+       cti_cpu_drvdata[drvdata->ctidev.cpu] =3D drvdata;
+       if (--nr_cti_cpu =3D=3D 0) {
+               cpu_pm_unregister_notifier(&cti_cpu_pm_nb);
+               cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_CTI_START=
ING);
        }
 }

@@ -823,19 +856,14 @@ static int cti_probe(struct amba_device *adev, const =
struct amba_id *id)

        /* driver data*/
        drvdata =3D devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
-       if (!drvdata) {
-               ret =3D -ENOMEM;
-               dev_info(dev, "%s, mem err\n", __func__);
-               goto err_out;
-       }
+       if (!drvdata)
+               return -ENOMEM;

        /* Validity for the resource is already checked by the AMBA core */
        base =3D devm_ioremap_resource(dev, res);
-       if (IS_ERR(base)) {
-               ret =3D PTR_ERR(base);
-               dev_err(dev, "%s, remap err\n", __func__);
-               goto err_out;
-       }
+       if (IS_ERR(base))
+               return PTR_ERR(base);
+
        drvdata->base =3D base;

        dev_set_drvdata(dev, drvdata);
@@ -854,8 +882,7 @@ static int cti_probe(struct amba_device *adev, const st=
ruct amba_id *id)
        pdata =3D coresight_cti_get_platform_data(dev);
        if (IS_ERR(pdata)) {
                dev_err(dev, "coresight_cti_get_platform_data err\n");
-               ret =3D  PTR_ERR(pdata);
-               goto err_out;
+               return  PTR_ERR(pdata);
        }

        /* default to powered - could change on PM notifications */
@@ -867,35 +894,20 @@ static int cti_probe(struct amba_device *adev, const =
struct amba_id *id)
                                               drvdata->ctidev.cpu);
        else
                cti_desc.name =3D coresight_alloc_device_name(&cti_sys_devs=
, dev);
-       if (!cti_desc.name) {
-               ret =3D -ENOMEM;
-               goto err_out;
-       }
+       if (!cti_desc.name)
+               return -ENOMEM;

        /* setup CPU power management handling for CPU bound CTI devices. *=
/
-       if (drvdata->ctidev.cpu >=3D 0) {
-               cti_cpu_drvdata[drvdata->ctidev.cpu] =3D drvdata;
-               if (!nr_cti_cpu++) {
-                       cpus_read_lock();
-                       ret =3D cpuhp_setup_state_nocalls_cpuslocked(
-                               CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
-                               "arm/coresight_cti:starting",
-                               cti_starting_cpu, cti_dying_cpu);
-
-                       if (!ret)
-                               ret =3D cpu_pm_register_notifier(&cti_cpu_p=
m_nb);
-                       cpus_read_unlock();
-                       if (ret)
-                               goto err_out;
-               }
-       }
+       ret =3D cti_pm_setup(drvdata);
+       if (ret)
+               return ret;

        /* create dynamic attributes for connections */
        ret =3D cti_create_cons_sysfs(dev, drvdata);
        if (ret) {
                dev_err(dev, "%s: create dynamic sysfs entries failed\n",
                        cti_desc.name);
-               goto err_out;
+               goto pm_release;
        }

        /* set up coresight component description */
@@ -908,7 +920,7 @@ static int cti_probe(struct amba_device *adev, const st=
ruct amba_id *id)
        drvdata->csdev =3D coresight_register(&cti_desc);
        if (IS_ERR(drvdata->csdev)) {
                ret =3D PTR_ERR(drvdata->csdev);
-               goto err_out;
+               goto pm_release;
        }

        /* add to list of CTI devices */
@@ -927,7 +939,7 @@ static int cti_probe(struct amba_device *adev, const st=
ruct amba_id *id)
        dev_info(&drvdata->csdev->dev, "CTI initialized\n");
        return 0;

-err_out:
+pm_release:
        cti_pm_release(drvdata);
        return ret;
 }
--
2.27.0

