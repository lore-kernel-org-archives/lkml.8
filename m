Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920A6C2BABC
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69223207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/mZwB/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403959AbgDCNoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:44:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37276 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403873AbgDCNns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:43:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so8631912wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+9/VFpcuuaToh+4qGU4mj26axEdCma4WNB3UK4TkrNA=;
        b=g/mZwB/fo4aQxMwmv66PcSsEaYUNxmA19x4fTHS7A8YBUGJprw4JCOq4mqfbZh1PWK
         f4LzDdU3SRmLVHiYnnTS9IPWkVnWbtPz2QTddTS+lRCCIw6gnmNYJ6vNSezA/oG6BWva
         rfX4opq47IChCVx+Qa+yka2im7/sbRJ5e7zQx2pyMoCIx/G4u014DHmEwM/uzHYBsJ9J
         31UXlC+tDfmgipEMkCI2yKK/ed7NDbrmfWCjUa7EOzKjUya3UeyYcSv1I8CoPv7b1FuI
         71XZcx30MCl+qOhdA3wCtm5yECT4N0NlWQic6BMZdYZrm0VfgKZJKL1a4Rr53fr1D482
         o0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+9/VFpcuuaToh+4qGU4mj26axEdCma4WNB3UK4TkrNA=;
        b=DDQ09/IKuI1xMXSCC9FeYkWm3a8ks8e3d4qMPdbcvHaxzT57ftUX/KrUtdGvxUo1LP
         6CtabBMvRLElAzgU5J6sfSCTOJrSr08JRviNHTMjhlN/wNYl7Gm4M8kyeT9Lm99BWosV
         44JBTS0i8cdf1rcBk9WVudvZymwUqlhknkM8yPgK5OFC00qDXWW4qT7IukiGhiY0izuF
         eSY7OMRooxchNplnnfhN2T8fICreR51pdPsCDnTMwnzAPzs13vCrLoduoi5dA6fk1BeR
         Y0D7fzzCurvCrQhc6VLqX2oFmi9Y9Dx/8MFrOZmJnx21D7NYv3D8gq7vKcdF0ORfVE6B
         iDzw==
X-Gm-Message-State: AGi0PubE68awkHs6RdGaUATBBNpI6Cd2fxSLri+X/hXh1ic4vGm7H80w
        wGrT5lkRMLV48ExWEgOG83M=
X-Google-Smtp-Source: APiQypI/PjD4FxEQcJYmOwgISprFFuYT9pGjVNHHcHPesKdPpak2qVTQP64fdW6saPsA8s9EPAQwHg==
X-Received: by 2002:a5d:4305:: with SMTP id h5mr8815025wrq.69.1585921425890;
        Fri, 03 Apr 2020 06:43:45 -0700 (PDT)
Received: from debian.lan (host-84-13-17-86.opaltelecom.net. [84.13.17.86])
        by smtp.gmail.com with ESMTPSA id f12sm12081232wrm.94.2020.04.03.06.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 06:43:44 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 11/11] parport: remove use of devmodel
Date:   Fri,  3 Apr 2020 14:43:25 +0100
Message-Id: <20200403134325.11523-11-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403134325.11523-1-sudipm.mukherjee@gmail.com>
References: <20200403134325.11523-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the drivers using parallel port has been converted to use
device model, there is no driver left which has devmodel as false.
Remove the part of the code which expects devmodel can be false.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/share.c | 81 +++++++++++++++++--------------------------------
 1 file changed, 28 insertions(+), 53 deletions(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 661f623b3129..7fec4fefe151 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -278,46 +278,32 @@ static int port_detect(struct device *dev, void *dev_drv)
 int __parport_register_driver(struct parport_driver *drv, struct module *owner,
 			      const char *mod_name)
 {
-	if (drv->devmodel) {
-		/* using device model */
-		int ret;
-
-		/* initialize common driver fields */
-		drv->driver.name = drv->name;
-		drv->driver.bus = &parport_bus_type;
-		drv->driver.owner = owner;
-		drv->driver.mod_name = mod_name;
-		ret = driver_register(&drv->driver);
-		if (ret)
-			return ret;
+	/* using device model */
+	int ret;
 
-		/*
-		 * check if bus has any parallel port registered, if
-		 * none is found then load the lowlevel driver.
-		 */
-		ret = bus_for_each_dev(&parport_bus_type, NULL, NULL,
-				       port_detect);
-		if (!ret)
-			get_lowlevel_driver();
-
-		mutex_lock(&registration_lock);
-		if (drv->match_port)
-			bus_for_each_dev(&parport_bus_type, NULL, drv,
-					 port_check);
-		mutex_unlock(&registration_lock);
-	} else {
-		struct parport *port;
-
-		drv->devmodel = false;
-
-		if (list_empty(&portlist))
-			get_lowlevel_driver();
-		mutex_lock(&registration_lock);
-		list_for_each_entry(port, &portlist, list)
-			drv->attach(port);
-		list_add(&drv->list, &drivers);
-		mutex_unlock(&registration_lock);
-	}
+	/* initialize common driver fields */
+	drv->driver.name = drv->name;
+	drv->driver.bus = &parport_bus_type;
+	drv->driver.owner = owner;
+	drv->driver.mod_name = mod_name;
+	ret = driver_register(&drv->driver);
+	if (ret)
+		return ret;
+
+	/*
+	 * check if bus has any parallel port registered, if
+	 * none is found then load the lowlevel driver.
+	 */
+	ret = bus_for_each_dev(&parport_bus_type, NULL, NULL,
+			       port_detect);
+	if (!ret)
+		get_lowlevel_driver();
+
+	mutex_lock(&registration_lock);
+	if (drv->match_port)
+		bus_for_each_dev(&parport_bus_type, NULL, drv,
+				 port_check);
+	mutex_unlock(&registration_lock);
 
 	return 0;
 }
@@ -352,17 +338,9 @@ static int port_detach(struct device *dev, void *_drv)
 
 void parport_unregister_driver(struct parport_driver *drv)
 {
-	struct parport *port;
-
 	mutex_lock(&registration_lock);
-	if (drv->devmodel) {
-		bus_for_each_dev(&parport_bus_type, NULL, drv, port_detach);
-		driver_unregister(&drv->driver);
-	} else {
-		list_del_init(&drv->list);
-		list_for_each_entry(port, &portlist, list)
-			drv->detach(port);
-	}
+	bus_for_each_dev(&parport_bus_type, NULL, drv, port_detach);
+	driver_unregister(&drv->driver);
 	mutex_unlock(&registration_lock);
 }
 EXPORT_SYMBOL(parport_unregister_driver);
@@ -915,10 +893,7 @@ void parport_unregister_device(struct pardevice *dev)
 	spin_unlock_irq(&port->waitlist_lock);
 
 	kfree(dev->state);
-	if (dev->devmodel)
-		device_unregister(&dev->dev);
-	else
-		kfree(dev);
+	device_unregister(&dev->dev);
 
 	module_put(port->ops->owner);
 	parport_put_port(port);
-- 
2.11.0

