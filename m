Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA22DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0DC620792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ot3q0/kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgFLNqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:46:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35530 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgFLNqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:46:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CDkVNE169032;
        Fri, 12 Jun 2020 13:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=TbpRLcIe2pts02J27VUX7FcMhznmJbrnr/6sB5z7Ois=;
 b=Ot3q0/kdB54crxZyEhDVl/r4gbBerK4JgLApwDao7WaxhM//Y/xy2NhA+PyVlnrHmBrN
 nrpk7HHNWbvFVjCKNvvgPCS15AL6T+sF0OUQ89bD2pJ0NkftOetB9xL/Q/KLdDqyxe8q
 EWedGFc7BwcwTUPgC2mTRBZGhvCNLHzelGn2aKKih7+89IMynP7CE5NOmouB3p9hSM6i
 MMwlBIK14sGI1Enq3fUxSFBjNdAPHTBKt5ax2yiaMS4JTlNbDQ8muxisSQMyfE36l/Jj
 hCQei58gziZCwiMyKb2HkuxADBO2PRjM3izRCTsOLagLg4z0GnpYeQGeI1yNZ3UG0bAU DQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31g2jrn5wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 13:46:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CDebgZ089950;
        Fri, 12 Jun 2020 13:46:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31masr049h-177
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 13:46:31 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05CCBfU3014972;
        Fri, 12 Jun 2020 12:11:41 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 05:11:40 -0700
Date:   Fri, 12 Jun 2020 15:11:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] coresight: cti: Fix error handling in probe
Message-ID: <20200612121133.GA1139533@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612121047.GF4282@kadam>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

I reversed the "if (drvdata->ctidev.cpu >= 0)" condition in cti_pm_release()
so that it mirros the new cti_pm_setup() function.

Fixes: 6a0953ce7de9 ("coresight: cti: Add CPU idle pm notifer to CTI devices")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Please note!!!  I cannot compile this patch.  Mike can you review it?

 drivers/hwtracing/coresight/coresight-cti.c | 96 ++++++++++++---------
 1 file changed, 54 insertions(+), 42 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index 40387d58c8e7..d2da5bf9f552 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -747,17 +747,50 @@ static int cti_dying_cpu(unsigned int cpu)
 	return 0;
 }
 
+static int cti_pm_setup(struct cti_drvdata *drvdata)
+{
+	int ret;
+
+	if (drvdata->ctidev.cpu == -1)
+		return 0;
+
+	if (nr_cti_cpu)
+		goto done;
+
+	cpus_read_lock();
+	ret = cpuhp_setup_state_nocalls_cpuslocked(
+			CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
+			"arm/coresight_cti:starting",
+			cti_starting_cpu, cti_dying_cpu);
+	if (ret) {
+		cpus_read_unlock();
+		return ret;
+	}
+
+	ret = cpu_pm_register_notifier(&cti_cpu_pm_nb);
+	cpus_read_unlock();
+	if (ret) {
+		cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_CTI_STARTING);
+		return ret;
+	}
+
+done:
+	nr_cti_cpu++;
+	cti_cpu_drvdata[drvdata->ctidev.cpu] = drvdata;
+
+	return 0;
+}
+
 /* release PM registrations */
 static void cti_pm_release(struct cti_drvdata *drvdata)
 {
-	if (drvdata->ctidev.cpu >= 0) {
-		if (--nr_cti_cpu == 0) {
-			cpu_pm_unregister_notifier(&cti_cpu_pm_nb);
+	if (drvdata->ctidev.cpu == -1)
+		return;
 
-			cpuhp_remove_state_nocalls(
-				CPUHP_AP_ARM_CORESIGHT_CTI_STARTING);
-		}
-		cti_cpu_drvdata[drvdata->ctidev.cpu] = NULL;
+	cti_cpu_drvdata[drvdata->ctidev.cpu] = drvdata;
+	if (--nr_cti_cpu == 0) {
+		cpu_pm_unregister_notifier(&cti_cpu_pm_nb);
+		cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_CTI_STARTING);
 	}
 }
 
@@ -823,19 +856,14 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
 
 	/* driver data*/
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata) {
-		ret = -ENOMEM;
-		dev_info(dev, "%s, mem err\n", __func__);
-		goto err_out;
-	}
+	if (!drvdata)
+		return -ENOMEM;
 
 	/* Validity for the resource is already checked by the AMBA core */
 	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base)) {
-		ret = PTR_ERR(base);
-		dev_err(dev, "%s, remap err\n", __func__);
-		goto err_out;
-	}
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
 	drvdata->base = base;
 
 	dev_set_drvdata(dev, drvdata);
@@ -854,8 +882,7 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
 	pdata = coresight_cti_get_platform_data(dev);
 	if (IS_ERR(pdata)) {
 		dev_err(dev, "coresight_cti_get_platform_data err\n");
-		ret =  PTR_ERR(pdata);
-		goto err_out;
+		return  PTR_ERR(pdata);
 	}
 
 	/* default to powered - could change on PM notifications */
@@ -867,35 +894,20 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
 					       drvdata->ctidev.cpu);
 	else
 		cti_desc.name = coresight_alloc_device_name(&cti_sys_devs, dev);
-	if (!cti_desc.name) {
-		ret = -ENOMEM;
-		goto err_out;
-	}
+	if (!cti_desc.name)
+		return -ENOMEM;
 
 	/* setup CPU power management handling for CPU bound CTI devices. */
-	if (drvdata->ctidev.cpu >= 0) {
-		cti_cpu_drvdata[drvdata->ctidev.cpu] = drvdata;
-		if (!nr_cti_cpu++) {
-			cpus_read_lock();
-			ret = cpuhp_setup_state_nocalls_cpuslocked(
-				CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
-				"arm/coresight_cti:starting",
-				cti_starting_cpu, cti_dying_cpu);
-
-			if (!ret)
-				ret = cpu_pm_register_notifier(&cti_cpu_pm_nb);
-			cpus_read_unlock();
-			if (ret)
-				goto err_out;
-		}
-	}
+	ret = cti_pm_setup(drvdata);
+	if (ret)
+		return ret;
 
 	/* create dynamic attributes for connections */
 	ret = cti_create_cons_sysfs(dev, drvdata);
 	if (ret) {
 		dev_err(dev, "%s: create dynamic sysfs entries failed\n",
 			cti_desc.name);
-		goto err_out;
+		goto pm_release;
 	}
 
 	/* set up coresight component description */
@@ -908,7 +920,7 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
 	drvdata->csdev = coresight_register(&cti_desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);
-		goto err_out;
+		goto pm_release;
 	}
 
 	/* add to list of CTI devices */
@@ -927,7 +939,7 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
 	dev_info(&drvdata->csdev->dev, "CTI initialized\n");
 	return 0;
 
-err_out:
+pm_release:
 	cti_pm_release(drvdata);
 	return ret;
 }
-- 
2.27.0

